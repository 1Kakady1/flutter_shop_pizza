enum MediaSizeEnum { ssm, sm, md, lg, xl, xxl }
Map<String, dynamic>? getMediaQueryStyles(
    double width,
    MediaSizeEnum mediaDefault,
    Map<MediaSizeEnum, Map<String, dynamic>> Function() styles) {
  MediaSizeEnum media = mediaDefault;
  if (width < 578) {
    media = MediaSizeEnum.ssm;
  }
  if (width >= 578 && width < 768) {
    media = MediaSizeEnum.sm;
  }

  if (width >= 768 && width < 992) {
    media = MediaSizeEnum.md;
  }

  if (width >= 992 && width < 1200) {
    media = MediaSizeEnum.lg;
  }

  if (width >= 1200 && width < 1400) {
    media = MediaSizeEnum.xl;
  }

  if (width > 1400) {
    media = MediaSizeEnum.xxl;
  }

  if (styles()[media] == null) {
    return styles()[mediaDefault];
  } else {
    return styles()[media];
  }
}
