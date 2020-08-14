Future<T> tryCatch<T>(Function func, {Function errorCallback}) async {
  try {
    return await func();
  } catch (e) {

    if (errorCallback != null) {
      errorCallback(e is Error ? Exception(e.toString()) : e);
    }
  }
  return null;
}