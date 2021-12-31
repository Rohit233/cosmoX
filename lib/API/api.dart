import 'package:flutter_dotenv/flutter_dotenv.dart';
class Api {
  static String astronomyPictureOfDayApi = dotenv.get('astronomyPictureOfDayApi');
  static String spacexLaunchesApi = dotenv.get('spacexLaunchesApi');
  static String spaceXLaunchPadApi = dotenv.get('spaceXLaunchPadApi');
  static String spaceXRocketApi = dotenv.get('spaceXRocketApi');
  static String spaceXPayloadApi = dotenv.get('spaceXPayloadApi');
  static String issLocationApi = dotenv.get('issLocationApi');
  static String reportApi = dotenv.get('reportApi');
  static String articleApi = dotenv.get('articleApi');
  static String blogApi = dotenv.get('blogApi');
}
