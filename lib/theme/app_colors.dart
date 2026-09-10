import 'package:flutter/material.dart';

/// Colores personalizados de la app Tareas Uniandes.
class AppColors {
  static const Color uniandesBlue = Color(0xFF003865);
  static const Color uniandesYellow = Color(0xFFFFC72C);

  static const Map<int, Color> _priorityColors = {
    1: Color(0xFF4CAF50), // verde: prioridad baja
    2: Color(0xFF8BC34A), // verde claro
    3: Color(0xFFFFC107), // amarillo: prioridad media
    4: Color(0xFFFF9800), // naranja
    5: Color(0xFFF44336), // rojo: prioridad alta
  };

  static Color priorityColor(int priority) =>
      _priorityColors[priority] ?? uniandesBlue;
}
