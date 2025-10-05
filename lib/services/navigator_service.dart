import 'package:flutter/material.dart';
import 'dart:async';

/// Servicio de navegación con protección contra errores de Flutter Web
class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'nav');
      
  /// Control de bloqueo para evitar múltiples navegaciones simultáneas
  static bool _isNavigating = false;
  
  /// Temporizador para limpiar el bloqueo en caso de problemas
  static Timer? _navigationLockTimer;
  
  /// Navegar a una ruta con nombre
  static Future<void> navigateTo(String routeName) async {
    // Evitar navegaciones rápidas consecutivas que pueden causar problemas en Flutter Web
    if (_isNavigating) {
      
      return;
    }
    
    try {
      _isNavigating = true;
      
      // Establecer un temporizador para liberar el bloqueo si algo sale mal
      _navigationLockTimer = Timer(const Duration(milliseconds: 1000), () {
        _isNavigating = false;
      });
      
      // Verificar si el estado del navegador está disponible
      if (navigatorKey.currentState != null) {
        // Pequeña pausa antes de la navegación para evitar errores de renderizado
        await Future.delayed(const Duration(milliseconds: 50));
        
        if (navigatorKey.currentState != null) {
          await navigatorKey.currentState!.pushNamed(routeName);
        }
      }
    } catch (e) {
      
    } finally {
      // Cancelar temporizador y liberar bloqueo
      _navigationLockTimer?.cancel();
      _isNavigating = false;
    }
  }

  /// Reemplazar la ruta actual con una nueva
  static Future<void> replaceTo(String routeName) async {
    try {
      if (navigatorKey.currentState != null) {
        await navigatorKey.currentState!.pushReplacementNamed(routeName);
      }
    } catch (e) {
      
    }
  }
}
