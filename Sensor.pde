public class Sensor extends List {
  
  
  public Sensor(){
    
    String[] info = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "nev", "info.txt"}).getStrings();
    info = append(info, "<");
    //println(info.length);
    setNames(info);
  }
  
  
  public void tickButtons(){
    super.tickButtons();
    String but = super.getButton();
    
    if(tickButton()){
      //println(but);
      if(!but.equals("<")){
       //backScreen();
       sensorName = but;
       autoSave();
      }
      
      backScreen();
    }
    
  }
  
  // todo add in Normal ApI: ScrollPanel; + Countdown(GraphPanel) + maybe Events?, Time (but Idk about the first 2 functions), U
  //  ^ done (also did asketch + useProc + Panels)
  
  
  
}