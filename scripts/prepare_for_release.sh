#!/bin/bash
# Ejecutar este script antes de compilar para producción
# Reemplaza todas las llamadas a print() con Logger equivalentes

# Colores para mensajes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}Preparando JP Director para compilación de producción...${NC}"
echo

# 1. Verificar la configuración de lint
echo -e "${CYAN}1. Verificando reglas de lint...${NC}"
if grep -q "avoid_print: true" analysis_options.yaml; then
  echo -e "${GREEN}✓ Regla avoid_print está activada${NC}"
else
  echo -e "${YELLOW}! Agregando regla avoid_print a analysis_options.yaml${NC}"
  # Agregar regla si no existe
  sed -i '/rules:/a \    avoid_print: true  # Marca todos los print() como errores de lint' analysis_options.yaml
fi

# 2. Ejecutar flutter analyze para detectar prints
echo -e "\n${CYAN}2. Buscando print() en el código...${NC}"
PRINT_COUNT=$(grep -r "print(" --include="*.dart" lib/ | wc -l)
echo -e "${YELLOW}Se encontraron $PRINT_COUNT llamadas a print()${NC}"

# 3. Reemplazar prints por Logger
echo -e "\n${CYAN}3. ¿Desea reemplazar automáticamente los print() con Logger?${NC}"
read -p "Esto intentará reemplazar print() con Logger.log() [s/N]: " response
if [[ "$response" =~ ^[Ss]$ ]]; then
  # Crear backup
  echo -e "${YELLOW}Creando backup de archivos...${NC}"
  BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
  mkdir -p $BACKUP_DIR
  cp -r lib $BACKUP_DIR/
  
  echo -e "${YELLOW}Reemplazando print() con Logger...${NC}"
  
  # Asegurar que Logger está importado en archivos con print()
  FILES_WITH_PRINT=$(grep -l "print(" --include="*.dart" lib/)
  
  for file in $FILES_WITH_PRINT; do
    # Solo agregar import si no existe ya
    if ! grep -q "import.*logger_service.dart" "$file"; then
      # Determinar nivel de importación (../ basado en profundidad)
      DEPTH=$(echo "$file" | sed 's/[^\/]//g' | wc -c)
      DEPTH=$((DEPTH - 2)) # Ajustar por lib/
      PREFIX=""
      for ((i=0; i<DEPTH; i++)); do
        PREFIX="../$PREFIX"
      done
      
      # Insertar import después del último import
      sed -i "/^import/a import '$PREFIX"services/logger_service.dart';" "$file"
      echo -e "${GREEN}✓ Agregado import de Logger a $file${NC}"
    fi
    
    # Reemplazar diferentes patrones de print()
    sed -i 's/print(\([^)]*\));/Logger.log(\1);/g' "$file"
    sed -i 's/print(\([^)]*\)) \/\//Logger.log(\1) \/\//g' "$file"
    
    # Para prints de error
    sed -i 's/print("Error.*\([^)]*\));/Logger.error(\1);/g' "$file"
    sed -i 's/print("ERROR.*\([^)]*\));/Logger.error(\1);/g' "$file"
    
    echo -e "${GREEN}✓ Reemplazados print() en $file${NC}"
  done
  
  echo -e "\n${GREEN}¡Proceso completado! Revisa los archivos para asegurarte que las sustituciones son correctas.${NC}"
  echo -e "${YELLOW}Se creó un backup en el directorio $BACKUP_DIR${NC}"
else
  echo -e "${YELLOW}Operación cancelada. Considera reemplazar los print() manualmente.${NC}"
fi

# 4. Ejecutar flutter analyze para verificar problemas
echo -e "\n${CYAN}4. Ejecutando flutter analyze para verificar problemas...${NC}"
flutter analyze

echo -e "\n${CYAN}5. Recomendaciones finales:${NC}"
echo -e "${YELLOW}- Revisa el código generado manualmente para asegurar su corrección${NC}"
echo -e "${YELLOW}- Considera usar Logger.debug() para mensajes de depuración${NC}"
echo -e "${YELLOW}- Usa Logger.error() para mensajes de error${NC}"
echo -e "${YELLOW}- Ejecuta 'flutter clean' antes de compilar para producción${NC}"

echo -e "\n${GREEN}¡Preparación para compilación completada!${NC}"