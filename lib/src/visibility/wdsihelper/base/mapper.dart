import 'dart:core';

abstract class Mapper<I,O> {
  O transform(I inner);

  I reverse(O outer);

  List<O> transformList(List<I> inList) {
    List<O> outList = new List();
    if (inList != null)
      for (var input in inList) {
        outList.add(transform(input));
      }
    return outList;
  }
  List<I> reverseList(List<O> inList) {
    List<I> outList = new List();
    if (inList != null)
      for (var Output in inList) {
        outList.add(reverse(Output));
      }
    return outList;
  }


}