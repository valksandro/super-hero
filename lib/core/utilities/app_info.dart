import 'package:flutter_dotenv/flutter_dotenv.dart';


String getUrl()=> DotEnv().env['BASE_URL'];

