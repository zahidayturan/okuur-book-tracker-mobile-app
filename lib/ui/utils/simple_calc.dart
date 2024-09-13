class OkuurCalc {

  static String calcPercentage(int max, int min){
    if(max == 0 || min == 0){
      return "0";
    }else if(min>max) {
      return "100";
    }
    return (min/max).toStringAsFixed(1);
  }

}