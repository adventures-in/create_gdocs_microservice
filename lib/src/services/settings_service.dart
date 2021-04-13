import 'dart:convert';
import 'dart:io';

/// We retrieve the [defaultUserId] and [rootFolderId] from config.json
/// [defaultUserId] is the id used when the request indicates using the default
class SettingsService {
  SettingsService._(
      {required String defaultUserId, required String rootFolderId})
      : _defaultUserId = defaultUserId,
        _rootFolderId = rootFolderId;

  final String _defaultUserId;
  final String _rootFolderId;

  String get defaultUserId => _defaultUserId;
  String get rootFolderId => _rootFolderId;

  static Future<SettingsService> fromFile() async {
    final jsonString = await File('config.json').readAsString();
    final config = json.decode(jsonString);

    final service = SettingsService._(
        defaultUserId: config['defaultUserId'],
        rootFolderId: config['rootFolderId']);

    service.log();

    return service;
  }

  void log() {
    print('Default User ID: $_defaultUserId');
    print('Root Folder ID: $_rootFolderId');
  }
}
