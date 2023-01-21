
extension StringCaseConverter on String?{

  String firstLetterUppercase(){

    if(this == null){
      return '';
    } else {

      if(this!.isEmpty){
        return '';
      }

      final firstLetter = this!.substring(0, 1);
      final rest = this!.substring(1, this!.length);

      return firstLetter.toUpperCase() + rest.toLowerCase();
    }

  }
}