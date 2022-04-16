class GlobalFile {
  int? id;
  final FileType fileType;
  final String hash;

  final DateTime dateTime;
  IsFavorite? isFav;

  GlobalFile({
    this.id,
    required this.fileType,
    required this.hash,
    required this.dateTime,
    this.isFav = IsFavorite.no,
  });
}

enum IsFavorite {
  yes, // 0
  no, // 1
}

enum FileType {
  image, // 0
  voice, // 1
  video, // 2
  file, // 3
}
