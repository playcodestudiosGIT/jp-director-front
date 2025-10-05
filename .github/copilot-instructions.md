# JP Director - Instrucciones para Agentes de IA

## PRIORITARIO

Al detectar un problema o error:
1. Analiza y determina el origen del error
2. Explica brevemente el problema y su causa
3. Proporciona una recomendación concisa sobre cómo corregirlo
4. NUNCA EDITES CÓDIGO sin una petición explícita del usuario

## Directrices de Interacción

IMPORTANTE: 
- NUNCA edites código deliberadamente sin autorización explícita del usuario.
- Antes de sugerir ediciones en el código, proporciona primero una explicación clara del problema y las soluciones posibles.
- Espera la confirmación del usuario antes de aplicar cualquier cambio en archivos del proyecto.
- Cuando expliques un problema, hazlo con respuestas precisas y sin editar código hasta recibir confirmación.
- Cuando sugieras soluciones, explica qué archivo se editará, qué líneas de código se cambiarán y por qué es necesario.

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

### 1. Manejo de API y Timeouts

El proyecto utiliza `JpApi` (lib/api/jp_api.dart) como cliente HTTP principal, con las siguientes características:

#### Métodos API Principales:
- `httpGet()`: Peticiones GET estándar
- `post()`: Peticiones POST con `FormData`
- `put()`: Peticiones PUT con `FormData`
- `putJson()`: Peticiones PUT con datos JSON directos
- `editUserImg()`, `editBlogImage()`, etc.: Métodos especializados para manejo de archivos

#### Configuración Global de Timeouts en Dio:

```dart
// En JpApi.configureDio():
_dio.options.connectTimeout = const Duration(seconds: 5); // Tiempo de conexión
_dio.options.receiveTimeout = const Duration(seconds: 8); // Tiempo para recibir datos
_dio.options.sendTimeout = const Duration(seconds: 5);    // Tiempo para enviar datos
```

#### Manejo de Errores con Interceptor:

```dart
// Interceptor personalizado para manejar errores en todas las peticiones
_dio.interceptors.add(
  InterceptorsWrapper(
    onError: (DioException e, ErrorInterceptorHandler handler) {
      String mensaje = 'Error de conexión desconocido';
      
      // Mensajes específicos según tipo de error
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          mensaje = 'El servidor está tardando demasiado en responder...';
          break;
        // otros casos...
      }
      
      // Devolver respuesta estructurada en lugar de lanzar excepción
      return handler.resolve(
        Response(
          requestOptions: e.requestOptions,
          data: {
            'error': true,
            'mensaje': mensaje,
            // otros campos...
          },
          statusCode: e.response?.statusCode ?? 500,
        )
      );
    },
  ),
);
```

#### Método Alternativo de Timeout (Para Código Legacy):

```dart
// Ejemplo de timeout con Future.any
await Future.any([
  // Petición normal
  blogProvider.getBlogById(id),
  // Timeout después de 8 segundos
  Future.delayed(const Duration(seconds: 8), () {
    throw TimeoutException("La conexión al servidor tardó demasiado");
  })
]);
```

### 2. Manejo de Errores y Logging

El proyecto utiliza servicios especializados para depuración y manejo de errores:

#### Logger Service:

```dart
// PREFERIR ESTO:
Logger.log('Blogs cargados: ${blogs.length}');
Logger.error('Error al cargar blogs', e, stackTrace);

// EN LUGAR DE:
print('Blogs cargados: ${blogs.length}');
print('Error: $e');
```

Características principales:
- Respeta el entorno de producción (se deshabilita automáticamente)
- Proporciona niveles de log: `log()`, `error()`, `warning()`, `debug()`
- Incluye información detallada en errores (mensaje, excepción, stack trace)

#### Notification Service:

Para mostrar errores al usuario, se usa `NotifServ`:

```dart
NotifServ.showSnackbarError(
  "No se pudo conectar al servidor",
  Colors.red
);
```

Características:
- Muestra mensajes de error al usuario de forma unificada
- Trunca mensajes largos para mejor visualización
- Gestiona el ciclo de vida de las notificaciones

### 3. Patrón de Notificaciones Selectivas en Providers

El proyecto sigue un patrón especial para optimizar el rendimiento con `notifyListeners()`:

#### Notificación Silenciosa (SN):
- Sufijo "SN" en métodos: Indica que no notifican cambios de estado (Sin Notificar)
- Comentarios `// notifyListeners()`: Indican que la notificación fue desactivada deliberadamente
- Uso: Para operaciones en segundo plano o cambios que no requieren actualización inmediata de UI

```dart
// Ejemplo de método con notificación silenciosa
Future getAllBlogsSN() async {
  // Operaciones que modifican el estado...
  // No se llama a notifyListeners() para evitar reconstruir widgets
}

// En los setters, notifyListeners() está comentado intencionalmente
set blog(Blog value) {
  _blog = value;
  // notifyListeners();  // Comentado para control manual de notificaciones
}
```

### 4. Internacionalización

Implementa soporte multilingüe (ES/EN) mediante:
- Archivos ARB en `lib/l10n/`
- Uso de `AppLocalizations.of(context)?.nombreCampo` para textos traducidos
- `AuthProvider` almacena y gestiona configuración de idioma actual

### 5. Modelos de Datos

Los modelos incluyen:
- Constructores desde/hacia JSON
- Gestión segura de datos nulos o malformados
- Manejo de propiedades legacy (ej: `img` vs `imagen` en Blog)
- Métodos helper para idiomas (`getTitulo(idioma)`, `getContenido(idioma)`)

```dart
// Ejemplo de acceso a datos multilingües
blog.getTitulo(currentLocale)
```

### 6. Estados de UI y Manejo de Carga

Patrón recomendado para vistas que cargan datos:
- Variables de estado: `isLoading`, `hasError` para controlar el flujo de UI
- Widgets condicionales para mostrar: pantalla de carga, error o contenido
- Botones de reintento y navegación alternativa en caso de error

```dart
// Patrón típico para manejo de estados de UI
Widget build(BuildContext context) {
  return isLoading 
    ? const LoadingWidget()
    : hasError
      ? ErrorViewWithRetry(onRetry: loadData)
      : ContentWidget();
}
```

## Flujos de Trabajo Importantes

### Desarrollo y Ejecución

```bash
# Actualizar dependencias
flutter pub get

# Generar archivos de localización
flutter gen-l10n

# Ejecutar en modo desarrollo
flutter run -d chrome  # Para web
flutter run            # Para dispositivo conectado
```

## Convenciones de Código

1. **Propiedades de Modelos**: Los modelos usan propiedades consistentes (ej: `img` no `imagen`)
2. **Providers**: 
   - Implementan `ChangeNotifier` con patrón getter/setter para propiedades observables
   - Usan sufijo "SN" para métodos sin notificación
   - Comentan `notifyListeners()` para controlar manualmente las notificaciones
3. **Widgets Visuales**: Preferir crear componentes reutilizables en `lib/ui/widgets/` 
4. **Peticiones API**: 
   - Usar métodos adecuados según formato de datos (`put()` vs `putJson()`)
   - Verificar estructura de respuestas para manejar diferentes formatos
   - Estructura de manejo de errores consistente: `if (json['error'] == true)`
5. **Logging**: 
   - Usar `Logger` en lugar de `print` para respetar entornos de producción
   - Incluir detalles específicos en mensajes de error
6. **Manejo de Errores**: 
   - Preferir errores estructurados sobre excepciones
   - Implementar timeouts y mostrar UI de error con opciones de reintento
   - Capturar errores en múltiples niveles (try/catch anidados)

## Puntos de Integración Críticos

1. **JpApi**: 
   - Centraliza toda comunicación con backend
   - Gestiona timeouts, errores y formatos de respuesta
   - Proporciona métodos especializados para diferentes tipos de datos
2. **LocalStorage**: Maneja persistencia de datos y token de autenticación
3. **NavigatorService**: Sistema de navegación centralizado
4. **AuthProvider**: Gestiona autenticación y preferencias de usuario
5. **Logger**: Sistema centralizado para registros de depuración

## Errores Comunes y Soluciones

1. **Problema**: Errores con URLs de imágenes en blogs
   **Solución**: Verificar que se use consistentemente `blog.img` y no `blog.imagen`

2. **Problema**: Inconsistencias en peticiones al servidor
   **Solución**: Usar `putJson()` para enviar datos JSON y `put()` para FormData

3. **Problema**: Aplicación colgada cuando el backend está caído
   **Solución**: 
   - Verificar que el interceptor de Dio esté configurado correctamente
   - Asegurar que todos los métodos API verifiquen estructura `json['error']`
   - Implementar timeouts en peticiones críticas:
   ```dart
   Future.any([
     apiCall(),
     Future.delayed(const Duration(seconds: 8), () => throw TimeoutException("...")),
   ]);
   ```

4. **Problema**: Actualizaciones de UI innecesarias o faltantes
   **Solución**:
   - Revisar uso adecuado de `notifyListeners()`
   - Usar métodos con sufijo SN sólo cuando no se requiera actualizar la UI
   - Asegurar que el método final de una cadena de operaciones llame a `notifyListeners()`