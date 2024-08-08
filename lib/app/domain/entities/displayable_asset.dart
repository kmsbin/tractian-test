abstract interface class HasId {
  String get id;
}

abstract interface class HasName {
  String get name;
}

abstract interface class HasParent {
  String? getParent();
}

abstract interface class HasDeepLevel {
  int get deepLevel;
  set deepLevel(int value);
}

abstract interface class HasChildren {
  bool get hasChildren;
  set hasChildren(bool value);
}

abstract interface class DisplayableEntity implements HasId, HasDeepLevel, HasName, HasParent, HasChildren {}