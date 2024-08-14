extension MapExtension on Map {
  removeNullValues({bool deep = true}) {
    removeWhere((key, value) {
      if (value == null) {
        return true;
      }
      if (deep && value is Map) {
        value.removeNullValues(deep: deep);
      }
      return false;
    });
  }
}
