public class AlkSwab extends UseProc{
  
  
  public AlkSwab(int num){
    this.num = num;
    
    
    
    toWait = new Time(0, 2, (int) random(60), 0);
    
    
    eve = new Event[2];
    buts = new Button[2];
    
    // 1 extra for countdown
    float ySize = height / (1 + eve.length + buts.length);
    
    
    buts[0] = new Button();
    buts[0].setTxt("alkSwab(" + num + ")");
    buts[0].setCol(180);
    buts[0].setPosSize(0, 0, width, ySize);
    
    //println(num);
    
    eve[0] = alkSwab[num].get("open up");
    eve[0].setPosSize(0, ySize, width, ySize);
    
    eve[1] = alkSwab[num].get("apply");
    eve[1].setPosSize(0, 2 * ySize, width, ySize);
    
    
    countdown = countdowns[num];
    countdown.setPosSize(0, 3 * ySize, width, ySize);
    countdown.setToWait(toWait);
    //countdown.setMax(toWait.getSecs() * 2);
    
    
    buts[1] = new Button();
    buts[1].setTxt("<");
    buts[1].setCol(225);
    buts[1].setPosSize(0, height - ySize, width, ySize);
    
    
    
  }
  
  
  Time toWait;
  
  //int startCountdown;
  //int increaseCount;
  int num;
  
  Event[] eve;
  Button[] buts;
  
  TimeCounter countdown;
  
  public void render(){
    for(int i = 0; i < eve.length; i ++){
      eve[i].render();
    }
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    
    countdown.render();
    
  }
  
  
  public void tick(){
    countdown.tick();
    if(curCount == countdown && !countdown.isCounting()){
      curCount = null;
    }
  }
  
  public void tickButtons(){
    boolean ticked = false;
    for(int i = 0; i < eve.length; i ++){
      ticked = eve[i].tickButton();
      if(ticked){
        if(eve[i].getTxt().equals("apply")){
          if(eve[i].getE("start").isTimeSet() || eve[i].getE("rn").isTimeSet()){
            countdown.setMax(toWait.getSecs() * 2);
            
            //countdown.start();
            ifNotStarted();
            //curCount = countdown;
          }
          if(eve[i].getE("end").isTimeSet() || eve[i].getE("after").isTimeSet()){
            countdown.setMax(toWait.getSecs());
            
            ifNotStarted();
            
          }
          
        }
        
      }
    }
    
    
    if(buts[1].tickButton()){
      backScreen();
    }
    
    //countdown.tickButton();
  }
  
  public void ifNotStarted(){
    if(!countdown.isCounting()){
      countdown.start();
      curCount = countdown;
    }
  }
  
  
  
  
}