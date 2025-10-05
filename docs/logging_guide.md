# JP Director - Guía de Logging

## Uso de Logger en vez de print()

En este proyecto, hemos implementado un sistema centralizado de logging para reemplazar el uso de `print()` en toda la aplicación. Esto asegura que el código en producción no contenga mensajes de depuración innecesarios.

### ¿Por qué no usar print()?

- Los mensajes `print()` aparecen en los logs de producción y pueden exponer información sensible
- Afectan ligeramente al rendimiento de la aplicación
- No se pueden filtrar o desactivar fácilmente
- No ofrecen niveles de severidad para categorizar los mensajes

## Cómo usar Logger

Primero, importa el Logger:

```dart
import 'package:jp_director/services/logger_service.dart';
```

### Tipos de logs disponibles

```dart
// Para información general
Logger.log('Mensaje informativo');

// Para advertencias
Logger.warning('Este es un mensaje de advertencia');

// Para errores
Logger.error('Ha ocurrido un error', excepcionObjeto);

// Para depuración detallada
Logger.debug('Valor de variable x: $x');
```

### Comportamiento en desarrollo vs producción

- En **modo desarrollo**: Todos los mensajes se muestran en la consola
- En **modo producción**: Los mensajes están completamente desactivados

## Herramientas para eliminar print()

En el directorio `scripts/` encontrarás:

1. **remove_prints.ps1**: Script de PowerShell para eliminar todos los `print()` del código
2. **prepare_for_release.sh**: Script más completo que reemplaza `print()` por las llamadas apropiadas a `Logger`

## Buenas prácticas

- Usa `Logger.log()` para información general
- Usa `Logger.warning()` para advertencias que no interrumpen el flujo
- Usa `Logger.error()` para errores recuperables, incluyendo el objeto de error si está disponible
- Usa `Logger.debug()` para información detallada útil solo durante el desarrollo

## Configuración de análisis

En el archivo `analysis_options.yaml` hemos configurado la regla `avoid_print: true` para que el linter marque todos los usos de `print()` como errores y nos ayude a evitar su uso accidental.

## Personalización

Si necesitas personalizar el comportamiento del Logger, puedes modificar la clase en `lib/services/logger_service.dart`.

---

Recuerda ejecutar `flutter analyze` regularmente para detectar cualquier uso accidental de `print()` en el código.