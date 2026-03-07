import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/localization_entity.dart';

/// Data model for localization with JSON serialization
class LocalizationModel extends Equatable {
  const LocalizationModel({
    required this.languageCode,
    required this.countryCode,
    required this.languageName,
    required this.countryName,
    this.isDefault = false,
    this.isRtl = false,
  });

  /// Convert from domain entity
  factory LocalizationModel.fromEntity(LocalizationEntity entity) {
    return LocalizationModel(
      languageCode: entity.languageCode,
      countryCode: entity.countryCode,
      languageName: entity.languageName,
      countryName: entity.countryName,
      isDefault: entity.isDefault,
      isRtl: entity.isRtl,
    );
  }

  /// JSON serialization
  factory LocalizationModel.fromJson(Map<String, dynamic> json) {
    return LocalizationModel(
      languageCode: json['languageCode'] as String,
      countryCode: json['countryCode'] as String?,
      languageName: json['languageName'] as String,
      countryName: json['countryName'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
      isRtl: json['isRtl'] as bool? ?? false,
    );
  }

  final String languageCode;
  final String? countryCode;
  final String languageName;
  final String countryName;
  final bool isDefault;
  final bool isRtl;

  /// Convert to domain entity
  LocalizationEntity toEntity() {
    return LocalizationEntity(
      locale: countryCode != null
          ? Locale(languageCode, countryCode)
          : Locale(languageCode),
      languageName: languageName,
      countryName: countryName,
      isDefault: isDefault,
      isRtl: isRtl,
    );
  }

  /// Get locale string representation
  String get localeString {
    return countryCode != null ? '${languageCode}_$countryCode' : languageCode;
  }

  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
      if (countryCode != null) 'countryCode': countryCode,
      'languageName': languageName,
      'countryName': countryName,
      'isDefault': isDefault,
      'isRtl': isRtl,
    };
  }

  @override
  List<Object?> get props => [
    languageCode,
    countryCode,
    languageName,
    countryName,
    isDefault,
    isRtl,
  ];
}
