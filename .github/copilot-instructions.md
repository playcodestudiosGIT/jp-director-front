# JP Director - Instrucciones para Agentes de IA

## Arquitectura General

JP Director es una aplicación Flutter multilingüe (ES/EN) para web, móvil y escritorio. El proyecto sigue una arquitectura basada en:

- **Providers**: Maneja el estado de la aplicación usando `provider` como patrón de gestión de estado
- **Modelos**: Define estructuras de datos para la información del negocio
- **Servicios**: Implementa funcionalidades reutilizables 
- **API**: Servicios para comunicación con backend

### Componentes Principales

- `lib/providers/`: Gestión de estado por dominio (autenticación, blogs, cursos, etc.)
- `lib/models/`: Clases de datos con parseo JSON
- `lib/services/`: Funciones de utilidad como navegación, notificaciones, almacenamiento local
- `lib/api/`: Cliente HTTP para comunicación con backend (usa Dio)
- `lib/ui/`: Widgets, vistas y componentes de interfaz

## Patrones Específicos del Proyecto

### 1. Manejo de API

El proyecto utiliza `JpApi` (lib/api/jp_api.dart) como cliente HTTP principal:
- `httpGet()`: Peticiones GET estándar
- `post()`: Peticiones POST con `FormData`
- `put()`: Peticiones PUT con `FormData`
- `putJson()`: Peticiones PUT con datos JSON directos
- `editUserImg()`, `editBlogImage()`, etc.: Métodos especializados para manejo de archivos

Ejemplo:
```dart
final response = await JpApi.putJson('/blogs/related/$blogId', {'relacionados': idsRelacionados});
```

### 2. Internacionalización

Implementa soporte multilingüe (ES/EN) mediante:
- Archivos ARB en `lib/l10n/`
- Uso de `AppLocalizations.of(context)?.nombreCampo` para textos traducidos
- `AuthProvider` almacena y gestiona configuración de idioma actual

### 3. Modelos de Datos

Los modelos incluyen:
- Constructores desde/hacia JSON
- Gestión segura de datos nulos o malformados
- Manejo de propiedades legacy (ej: `img` vs `imagen` en Blog)
- Métodos helper para idiomas (`getTitulo(idioma)`, `getContenido(idioma)`)

```dart
// Ejemplo de acceso a datos multilingües
blog.getTitulo(currentLocale)
```

### 4. Componentización de UI

Se favorece la creación de widgets reutilizables:
- Componentes como `BlogCard` están en `lib/ui/widgets/`
- Evitar duplicación de código con widgets compartidos

## Flujos de Trabajo Importantes

### Desarrollo y Ejecución

```bash
# Actualizar dependencias
flutter pub get

# Ejecutar en modo desarrollo
flutter run -d chrome  # Para web
flutter run            # Para dispositivo conectado
```

### Generación de Archivos de Localización

```bash
flutter gen-l10n
```

## Convenciones de Código

1. **Propiedades de Modelos**: Los modelos usan propiedades consistentes (ej: `img` no `imagen`)
2. **Providers**: Implementan `ChangeNotifier` con patrón getter/setter para propiedades observables
3. **Widgets Visuales**: Preferir crear componentes reutilizables en `lib/ui/widgets/` 
4. **Peticiones API**: Usar métodos adecuados según formato de datos:
   - `JpApi.put()` para FormData
   - `JpApi.putJson()` para datos JSON puros

## Puntos de Integración Críticos

1. **JpApi**: Toda comunicación con backend pasa por esta clase
2. **LocalStorage**: Maneja persistencia de datos y token de autenticación
3. **NavigatorService**: Sistema de navegación centralizado
4. **AuthProvider**: Gestiona autenticación y preferencias de usuario

## Errores Comunes y Soluciones

1. **Problema**: Errores con URLs de imágenes en blogs
   **Solución**: Verificar que se use consistentemente `blog.img` y no `blog.imagen`

2. **Problema**: Inconsistencias en peticiones al servidor
   **Solución**: Usar `putJson()` para enviar datos JSON y `put()` para FormData