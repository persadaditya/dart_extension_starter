extension SeparedList<T> on List<T>{
  List<T> separated(T separator){
    final newList = <T>[];

    for(var i =0;i<length ;i++){
      if(i==0) {
        newList.add(this[i]);
      } else {
        newList.add(separator);
        newList.add(this[i]);
      }
    }
    return newList;
  }
}