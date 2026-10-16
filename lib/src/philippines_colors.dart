import 'package:flutter/widgets.dart';

/// Modal colour of a region of the Commons artwork the article shows for each
/// category. The artwork is flat vector fills, so these are the drawn values;
/// the LTO publishes none.
abstract final class PhilippinesColors {
  static const Color white = Color(0xFFFFFFFF);

  /// Private plates' ink and rim.
  static const Color black = Color(0xFF000000);

  /// The public utility field: a deep yellow, not the article's "yellow".
  static const Color puvYellow = Color(0xFFF6C60D);

  /// Government ink and rim.
  static const Color governmentRed = Color(0xFFFA0000);

  /// Electric and hybrid ink and rim: a dark forest green.
  static const Color electricGreen = Color(0xFF046A38);

  /// Diplomatic ink and rim: a navy, far darker than the prose's "blue".
  static const Color diplomaticBlue = Color(0xFF062964);

  // Motorcycle region strips. The article names eight colours; two of its
  // names hide surprises — its "green" is a teal and its "purple" an indigo.

  static const Color stripPink = Color(0xFFC964CE);
  static const Color stripGreen = Color(0xFF007B5F);
  static const Color stripGray = Color(0xFF776F67);
  static const Color stripBlue = Color(0xFF6AB3E6);
  static const Color stripPurple = Color(0xFF2F008C);
  static const Color stripOrange = Color(0xFFE35205);
  static const Color stripRed = Color(0xFFC8102E);
  static const Color stripBrown = Color(0xFF8B381A);

  /// Placeholder ink for an empty slot on a light field.
  static const Color inactive = Color(0xFFB0B0B0);
}
