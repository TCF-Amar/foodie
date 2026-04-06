import 'dart:io';

void main() {
  final dir = Directory('.');
  final List<FileSystemEntity> entities = dir.listSync(recursive: true);

  // Update file contents
  for (var entity in entities) {
    if (entity is File) {
      // Skip certain directories
      if (entity.path.contains('.git') ||
          entity.path.contains('.dart_tool') ||
          entity.path.contains('build\\') ||
          entity.path.contains('build/') ||
          entity.path.contains('.idea') ||
          entity.path.contains('rename_script.dart')) {
        continue;
      }

      try {
        final content = entity.readAsStringSync();
        if (content.contains('calling_app')) {
          final newContent = content.replaceAll('calling_app', 'foodie');
          entity.writeAsStringSync(newContent);
          print('Updated ${entity.path}');
        }
      } catch (e) {
        // ignore binary files
      }
    }
  }

  // Rename directories
  final dirs = dir.listSync(recursive: true).whereType<Directory>().toList();
  dirs.sort(
    (a, b) => b.path.length.compareTo(a.path.length),
  ); // Longest paths first
  for (var d in dirs) {
    if (d.path.contains('.git') ||
        d.path.contains('.dart_tool') ||
        d.path.contains('build\\') ||
        d.path.contains('build/')) {
      continue;
    }
    final name = d.path.split(Platform.pathSeparator).last;
    if (name == 'calling_app') {
      final newPath =
          d.path.substring(0, d.path.length - 'calling_app'.length) + 'foodie';
      d.renameSync(newPath);
      print('Renamed dir ${d.path} to $newPath');
    }
  }
}
