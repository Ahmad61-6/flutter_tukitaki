class SqfliteService {
  static final SqfliteService _instance = SqfliteService._internal();

  static SqfliteService get instance => _instance;

  SqfliteService._internal();
}
