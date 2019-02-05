public class RemTimes extends UseProc{
  
  public RemTimes(String[] path){
    super();
    
    this.path = path;
    
    eve = new EventManager();
    
    FileManager f = new FileManager(path);
    String inf = f.getVal("removed");
    eve.loadAutoSave(inf);
    
    
    eves = new Event[2];
    buts = new Button[2];
    
    float ySize = height / (eves.length + 1.0);
    
    eves[0] = eve.get("remTape");
    eves[0].setPoint(false);
    eves[0].setPosSize(0, 0 * ySize, width, ySize);
    eves[0].setSaveDate(true);
    
    eves[1] = eve.get("remSensor");
    //eves[1].setPoint(false);
    eves[1].setPosSize(0, 1.0 * ySize, width, ySize);
    eves[1].setSaveDate(true);
    
    float xSize = width / 2.0;
    
    buts[0] = new Button();
    buts[0].setPosSize(0, 2.0 * ySize, xSize, ySize);
    buts[0].setTxt("<");
    
    buts[1] = new Button();
    buts[1].setPosSize(xSize, 2.0 * ySize, xSize, ySize);
    buts[1].setTxt("save");
    
    
    
    
  }
  
  String[] path;
  
  EventManager eve;
  Event[] eves;
  Button[] buts;
  
  
  public void render(){
    
    for(int i = 0; i < eves.length; i ++){
      eves[i].render();
    }
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
  }
  
  public void tickButtons(){
    for(int i = 0; i < eves.length; i ++){
      eves[i].tickButton();
    }
    
    if(buts[0].tickButton()){
      backScreen();
    } else if(buts[1].tickButton()){
      
      new FileManager(path).setVal("removed", eve.autoSave());
      // save
      
      
      nextScreen(new Menu());
    }
    
  }
  
  
  
  
}


