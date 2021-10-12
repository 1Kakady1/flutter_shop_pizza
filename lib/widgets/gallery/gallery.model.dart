class GalleryItem {
  GalleryItem({
    required this.id,
    required this.resource,
    this.isSvg = false,
  });

  final String id;
  final String resource;
  final bool isSvg;
}
