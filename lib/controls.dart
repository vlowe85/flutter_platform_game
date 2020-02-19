enum KeyboardPress {
  LEFT_ARROW, RIGHT_ARROW, SPACE
}

final keyValues = EnumValues({
  4295426128: KeyboardPress.LEFT_ARROW,
  4295426127: KeyboardPress.RIGHT_ARROW,
  32: KeyboardPress.SPACE
});

class EnumValues<T> {
  Map<int, T> map;
  Map<T, int> reverseMap;

  EnumValues(this.map);

  Map<T, int> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}