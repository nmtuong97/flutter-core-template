import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utilities/logger.dart';
import '../../models/preferences_model.dart';

/// Local data source for managing SharedPreferences operations
abstract class LocalDataSource {
  /// Save preferences to local storage
  Future<void> savePreferences(PreferencesModel preferences);

  /// Load preferences from local storage
  Future<PreferencesModel?> loadPreferences();

  /// Save string value
  Future<void> saveString(String key, String value);

  /// Load string value
  Future<String?> loadString(String key);

  /// Save double value
  Future<void> saveDouble(String key, double value);

  /// Load double value
  Future<double?> loadDouble(String key);

  /// Save boolean value
  Future<void> saveBool(String key, {required bool value});

  /// Load boolean value
  Future<bool?> loadBool(String key);

  /// Remove value by key
  Future<void> removeValue(String key);

  /// Clear all stored data
  Future<void> clearAll();

  /// Check if key exists
  Future<bool> containsKey(String key);
}

/// Implementation of LocalDataSource using SharedPreferences
class LocalDataSourceImpl implements LocalDataSource {
  const LocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<void> savePreferences(PreferencesModel preferences) async {
    try {
      final json = preferences.toJson();
      final jsonString = jsonEncode(json);

      final success = await sharedPreferences.setString(
        'user_preferences',
        jsonString,
      );

      if (!success) {
        throw const StorageException(
          message: 'Failed to save preferences to local storage',
        );
      }

      AppLogger.debug('Preferences saved successfully');
    } catch (e) {
      AppLogger.error('Failed to save preferences', error: e);
      if (e is StorageException) rethrow;

      throw StorageException(
        message: 'Failed to save preferences: $e',
      );
    }
  }

  @override
  Future<PreferencesModel?> loadPreferences() async {
    try {
      final jsonString = sharedPreferences.getString('user_preferences');

      if (jsonString == null) {
        AppLogger.debug('No preferences found in local storage');
        return null;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final preferences = PreferencesModel.fromJson(json);

      AppLogger.debug('Preferences loaded successfully');
      return preferences;
    } catch (e) {
      AppLogger.error('Failed to load preferences', error: e);

      throw StorageException(
        message: 'Failed to load preferences: $e',
      );
    }
  }

  @override
  Future<void> saveString(String key, String value) async {
    try {
      final success = await sharedPreferences.setString(key, value);

      if (!success) {
        throw StorageException(
          message: 'Failed to save string value for key: $key',
        );
      }

      AppLogger.debug('String value saved', data: {'key': key});
    } catch (e) {
      AppLogger.error('Failed to save string value', error: e);
      if (e is StorageException) rethrow;

      throw StorageException(
        message: 'Failed to save string value: $e',
      );
    }
  }

  @override
  Future<String?> loadString(String key) async {
    try {
      final value = sharedPreferences.getString(key);
      AppLogger.debug(
        'String value loaded',
        data: {'key': key, 'found': value != null},
      );
      return value;
    } catch (e) {
      AppLogger.error('Failed to load string value', error: e);

      throw StorageException(
        message: 'Failed to load string value: $e',
      );
    }
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    try {
      final success = await sharedPreferences.setDouble(key, value);

      if (!success) {
        throw StorageException(
          message: 'Failed to save double value for key: $key',
        );
      }

      AppLogger.debug('Double value saved', data: {'key': key, 'value': value});
    } catch (e) {
      AppLogger.error('Failed to save double value', error: e);
      if (e is StorageException) rethrow;

      throw StorageException(
        message: 'Failed to save double value: $e',
      );
    }
  }

  @override
  Future<double?> loadDouble(String key) async {
    try {
      final value = sharedPreferences.getDouble(key);
      AppLogger.debug(
        'Double value loaded',
        data: {'key': key, 'found': value != null},
      );
      return value;
    } catch (e) {
      AppLogger.error('Failed to load double value', error: e);

      throw StorageException(
        message: 'Failed to load double value: $e',
      );
    }
  }

  @override
  Future<void> saveBool(String key, {required bool value}) async {
    try {
      final success = await sharedPreferences.setBool(key, value);

      if (!success) {
        throw StorageException(
          message: 'Failed to save boolean value for key: $key',
        );
      }

      AppLogger.debug(
        'Boolean value saved',
        data: {'key': key, 'value': value},
      );
    } catch (e) {
      AppLogger.error('Failed to save boolean value', error: e);
      if (e is StorageException) rethrow;

      throw StorageException(
        message: 'Failed to save boolean value: $e',
      );
    }
  }

  @override
  Future<bool?> loadBool(String key) async {
    try {
      final value = sharedPreferences.getBool(key);
      AppLogger.debug(
        'Boolean value loaded',
        data: {'key': key, 'found': value != null},
      );
      return value;
    } catch (e) {
      AppLogger.error('Failed to load boolean value', error: e);

      throw StorageException(
        message: 'Failed to load boolean value: $e',
      );
    }
  }

  @override
  Future<void> removeValue(String key) async {
    try {
      final success = await sharedPreferences.remove(key);

      if (!success) {
        throw StorageException(
          message: 'Failed to remove value for key: $key',
        );
      }

      AppLogger.debug('Value removed', data: {'key': key});
    } catch (e) {
      AppLogger.error('Failed to remove value', error: e);
      if (e is StorageException) rethrow;

      throw StorageException(
        message: 'Failed to remove value: $e',
      );
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      final success = await sharedPreferences.clear();

      if (!success) {
        throw const StorageException(
          message: 'Failed to clear all stored data',
        );
      }

      AppLogger.debug('All stored data cleared');
    } catch (e) {
      AppLogger.error('Failed to clear stored data', error: e);
      if (e is StorageException) rethrow;

      throw StorageException(
        message: 'Failed to clear stored data: $e',
      );
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      final contains = sharedPreferences.containsKey(key);
      AppLogger.debug(
        'Key existence checked',
        data: {'key': key, 'exists': contains},
      );
      return contains;
    } catch (e) {
      AppLogger.error('Failed to check key existence', error: e);

      throw StorageException(
        message: 'Failed to check key existence: $e',
      );
    }
  }
}
