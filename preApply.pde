public class Activate extends UseProc{
  
  public Activate(){
    
    events = new EventManager();
    
    FileManager f = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});
    String inf = f.getVal("restActive");
    
    events.loadAutoSave(inf);
    
    
    setTimeLeft();
    
    
    buts = new Button[]{
      curCount, // ?
      events.get("activatePhone"),
      events.get("applyTape").setSaveDate(true),
      new Button().setTxt("<"),
      new Button().setTxt("save")
      
    };
    /*
      counter
      activPhone
      applyTape
      
    */
    
    float ySize = height / (buts.length - 1.0);
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].setPosSize(0, i * ySize, width, ySize);
    }
    
    float xSize = width / 2.0;
    int len = buts.length - 2;
    buts[len].setPosSize(0, len * ySize, xSize, ySize);
    buts[len + 1].setPosSize(xSize, len * ySize, xSize, ySize);
    
    
  }
  
  EventManager events;
  Button[] buts;
  
  
  public void render(){
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
  }
  
  
  public void tickButtons(){
    for(int i = 1; i < buts.length; i ++){
      if(buts[i].tickButton()){
        if(buts[i].getTxt().equals("save")){
          // well
          String data = events.autoSave();
          FileManager f = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});
          f.setVal("restActive", data);
          
          
          backScreen();
        } else if(buts[i].getTxt().equals("<")){
          backScreen();
        }
        
      }
    }
    
  }
  
  
  
  public void tick(){
   // if(curCount != null){ // should work without if
      curCount.tick();
   // }
  }
  
}


public void setTimeLeft(){
  FileManager f = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});
  setTimeLeft(new Time().setStringTime(f.getVar("activated", new Time().toTime())));
}


public void setTimeLeft(Time when){
  
  if(curCount == null || !curCount.getTxt().equals("timeLeft")){
      curCount = new TimeCounter();
      curCount.setTxt("timeLeft");
      
      curCount.setToWait(new Time(0, 55, 0, 0));
      curCount.setStart(when);
      
      curCount.tick();
    }
    
    
  
  
}
