
const _defaultSize = 8.0;

extension type DesignSystemSpacing._(double effectiveSize) {
  DesignSystemSpacing(double quantity) : this._(quantity * _defaultSize);

  double getSize() => effectiveSize;
}