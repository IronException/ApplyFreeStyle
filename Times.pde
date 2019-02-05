public class Times extends UseProc {
  
  public Times(){
    
    // test wether there r auto savings.
    // if file says length 0 it inits everything like normal
    
    
    
    int pos = 0;
    
    otherButsNum = 5;
    
    eve = new Event[5];
    buts = new Button[alkSwab.length + otherButsNum];
    
    float ySize = height / (eve.length + buts.length - 1);
    
    
    buts[0] = new Button();
    //buts[0].setTxt(sensorName);
    
    buts[0].setPosSize(0, pos * ySize, width, ySize);
    buts[0].setCol(180);
    pos ++;
    
    eve[0] = events.get("getStuff");
    eve[0].setPosSize(0, pos + ySize, width, ySize);
    pos ++;
    
    eve[1] = events.get("openPackage");
    eve[1].setPosSize(0, pos * ySize, width, ySize);
    pos ++;
    
    for(int i = 0; i < alkSwab.length; i ++){
      buts[i + otherButsNum] = new Button();
      buts[i + otherButsNum].setTxt("alkSwab(" + i + ")");
      buts[i + otherButsNum].setPosSize(0, pos * ySize, width, ySize);
      buts[i + otherButsNum].setCol(200);
      pos ++;
    
    }
  /*
    buts[0] = new Button();
    buts[0].setTxt("alkSwab1");
    buts[0].setPosSize(0, 2 * ySize, width, ySize);
    
    buts[1] = new Button();
    buts[1].setTxt("alkSwab2");
    buts[1].setPosSize(0, 3 * ySize, width, ySize);
    */
    
    
    buts[1] = new Button();
    buts[1].setTxt("apply");
    buts[1].setPosSize(0, pos * ySize, width, ySize);
    buts[1].setCol(200);
    pos ++;
    
    
     recPpBut = new Button();
    recPpBut.setTxt("recPp");
    recPpBut.setPosSize(0, pos * ySize, width, ySize);
    recPpBut.setCol(255);
    recPpPos = 2;
    buts[recPpPos] = recPpBut;
    pos ++;
    
    eve[2] = events.get("startFreeStyle");
    eve[2].setPosSize(0, pos * ySize, width, ySize);
    pos ++;
    
    eve[3] = events.get("startPhone");
    eve[3].setPoint(false);
    eve[3].setPosSize(0, pos * ySize, width, ySize);
    pos ++;
    
    eve[4] = events.get("applyTape");
    eve[4].setPosSize(0, pos * ySize, width, ySize);
    pos ++;
    
    
    
    float xSize = width / 2.0;
    
    buts[3] = new Button();
    buts[3].setTxt("<");
    buts[3].setPosSize(0, pos * ySize, xSize, ySize);
    buts[3].setCol(225);
   // pos ++;
    
    buts[4] = new Button();
    buts[4].setTxt("save");
    buts[4].setPosSize(xSize, pos * ySize, xSize, ySize);
    buts[4].setCol(225);
    pos ++;
    
    
    /*
      
      2x alkSwab
      
      apply(
        openSensorThing()
        
        apply
        done | results
      )
      
      startFreeStyle
      startPhone
    */
    
    
    onBackScreen();
    
  }
  
  int recPpPos;
  Button recPpBut;
  
  public void tickFirst(){
    
    String[] info = new FileManager(new String[]{"autoSave.txt"}).getStrings();
    if(info.length != 1){
      // WARNING: RETURNS IF !1
      return;
    }
    
    // how is it saved?
    
    
    
  }
  
  
  int otherButsNum;
  
  Event[] eve;
  Button[] buts;
  
  
  String forActivate = "startFreeStyle";
  
  public void render(){
    stroke(0);
    for(int i = 0; i < eve.length; i ++){
      eve[i].render();
    }
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    
    
    
  }
  
  
  
  
  
  public void tickButtons(){
    for(int i = 0; i < eve.length; i ++){
      if(eve[i].tickButton() && eve[i].txt.equals(forActivate)){
        activated = new Time();
        
        setTimeLeft(activated);
      }
      
    }
    
    for(int i = 0; i < alkSwab.length; i ++){
      if(buts[i + otherButsNum].tickButton()){
        nextScreen(new AlkSwab(i));
      }
    }
    
    
    if(buts[0].tickButton()){
      nextScreen(new Sensor());
    } else if(curCount == null && buts[2].tickButton()){
      nextScreen(new RecPp());
    } else if(buts[1].tickButton()){
      nextScreen(new Apply());
    } else if(buts[4].tickButton()){
      
      nextScreen(new ComTag());
    } else if(buts[3].tickButton()){
      backScreen();
    }/*else if(buts[3].tickButton()){
      nextScreen(new ComTag());
    }*/
    
    
    
    
  }
  
  public void tick(){
    if(curCount != null){
      curCount.tick();
    }
  }
  
  
  public void onBackScreen(){
    super.onBackScreen();
    buts[0].setTxt(sensorName);
    
    //curCount.tick();
    if(curCount != null){
      curCount.tick();
      
      if(curCount.isCounting()){
      
        curCount.setPosSize(recPpBut.xPos,
          recPpBut.yPos,
          recPpBut.xSize,
          recPpBut.ySize);
        buts[recPpPos] = curCount;
      } else {
        buts[recPpPos] = recPpBut;
      }
      
    } else {
      buts[recPpPos] = recPpBut;
      
    }
    
    
    if(setApply){
      recPpBut.setCol(200);
    }
  }
  
}