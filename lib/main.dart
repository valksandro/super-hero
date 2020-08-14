import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart' as app;


Future<void> main() async{
  await DotEnv().load('env/.env');
  app.main();
}
