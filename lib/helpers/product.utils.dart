/*
* price int or Map<string, dooble> // {"sm": 20, "xl": 10}
*/

double getPrice(
    {required dynamic price, List<String?>? filtersSize, String? size}) {
  if (price is int || price is double) {
    return price.toDouble();
  }
  if (filtersSize != null && size != null) {
    final int findSizeIndex = filtersSize.indexWhere((x) => x == size);
    final String? index =
        findSizeIndex != -1 ? filtersSize[findSizeIndex] : filtersSize[0];
    return index == null ? 999.98 : price[index].toDouble();
  }

  return 999.99;
}
