class Time 
{
  int count = 0;
  int max;
  int UDcount = 0;
  boolean goingUp = true;

  Time () {
    max = 100;
  }
  Time(int max) {
    this.max = max;
  }

  void update() {
    count++;
    if (goingUp) {
      UDcount++;
    } else {
      UDcount--; 
    }
    if (count >= max) {
      count = 0;
      UDcount =0;
    }
    if (UDcount >= max/2) {
      goingUp =false;
    }
    if (UDcount == 0) {
      goingUp = true;
    }
  }
  int getCount() {
    return count;
  }
  int upDownCount() {
    if (count > (max/2)) {
      return max - count;
  }
    return count;
  }
  float upDownRel(float amount) {
    return (float)upDownCount()*2 / (float)max * amount;
  }
  void maxUp(){
    max++;
  }
  void maxDown(){
    max--;
    if (max < 10) {
      max =10;
    }
  }
  void setMax(int newM) {
    max = newM;
    if (max < 10) {
      max =10;
    }
    
    
  }
  
  
}