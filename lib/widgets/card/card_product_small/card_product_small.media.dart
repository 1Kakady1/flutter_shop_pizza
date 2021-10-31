import 'package:pizza_time/helpers/media_query.dart';

class CardProductSmallMedia {
  final double media;

  CardProductSmallMedia(this.media);
  static Map<MediaSizeEnum, Map<String, dynamic>> mapMedia() {
    return {
      MediaSizeEnum.sm: {
        "container_height": 200.0,
        "size_img": 200.0,
        "title_width": 260.0,
        "title_font_size": 30.0,
        "bookmark": {
          "size": 22.0,
          'top': 20.0,
          'width': 80.0,
          'heigt': 96.0,
          'right': 36.0,
        },
        "price": {
          "size": 30.0,
          "size_unit": 20.0,
          "contianer": {"width": 120.0}
        }
      },
      MediaSizeEnum.ssm: {
        "container_height": 140.0,
        "size_img": 140.0,
        "title_width": 110.0,
        "title_font_size": 18.0,
        "bookmark": {
          "size": 10.0,
          'top': 18.0,
          'width': 48.0,
          'heigt': 60.0,
          'right': 26.0,
        },
        "price": {
          "size": 20.0,
          "size_unit": 10.0,
          "contianer": {"width": 80.0}
        }
      }
    };
  }
}
