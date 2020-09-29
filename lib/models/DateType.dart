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

  void setFromDateTime(DateTime dateTime){
    this.set(dateTime.day, dateTime.month, dateTime.year);
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
    if (this.isEmptyDate()) return 99999999;
    return (((year * 100) + this.month) * 100 + this.date);
  }

  static getNumDateOfWeek(DayOfWeek type){
    for(int i = 0; i < DayOfWeek.values.length; i++){
      if (type == DayOfWeek.values[i]) return i;
    }
  }

  int getDayOfWeek(){             //0->Sun
    var deltaMonth = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];
    year -= (month < 3) ? 1 : 0;
    return (year + year~/4 - year~/100 + year~/400 + deltaMonth[month-1] + date) % 7;
  }

  int getDaysOfMonth(){
    var days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (this.isLeapYear()) days[1] = 29;
    return days[month-1];
  }

  bool isLeapYear(){
    return  ((this.year%4==0 && this.year%100!=0) || this.year%400==0);
  }

  void goToTheNextMonth(){
    this.month++;
    if (this.month > 12){
      this.month = 1;
      this.year++;
    }
  }

  void goToTheNextDay(){
    this.date++;
    if (this.date > getDaysOfMonth()){
      this.date = 1;
      goToTheNextMonth();
    }
  }

}