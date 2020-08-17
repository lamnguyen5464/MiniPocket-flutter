enum DayOfWeek{
  sun, mon, tue, wed, thu, fri, sat
}

class DateType{
  int date;
  int month;
  int year;

  DateType(){
    DateTime tmp = DateTime.now();
    this.set(tmp.day, tmp.month, tmp.year);
  }

  DateType.fromDetail(int date, int month, int year){
    this.set(date, month, year);
  }

  void set(int date, int month, int year){
    this.date = date;
    this.month = month;
    this.year = year;
  }

  void clear(){
    this.date = this.month = this.year = 0;
  }

  bool isEmptyDate(){
    return (this.date == 0);
  }

  void setFromDateCode(int dateCode){
    this.date = dateCode % 100;
    dateCode ~/= 100;
    this.month = dateCode %100;
    dateCode ~/= 100;
    this.year = dateCode;
  }

  int getDateCode(){
    return (((year * 100) + this.month) * 100 + this.date);
  }

  static getNumDateOfWeek(DayOfWeek type){
    for(int i = 0; i < DayOfWeek.values.length; i++){
      if (type == DayOfWeek.values[i]) return i;
    }
  }

}