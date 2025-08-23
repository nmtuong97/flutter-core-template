import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/localization_entity.dart';

part 'localization_model.g.dart';

/// Data model for localization with JSON serialization
@JsonSerializable()
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
  factory LocalizationModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizationModelFromJson(json);

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

  Map<String, dynamic> toJson() => _$LocalizationModelToJson(this);

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
