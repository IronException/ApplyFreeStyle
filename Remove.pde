
public class Remove extends List {
  
  
  public Remove(){
    
    String[] info = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "used", "info.txt"}).getStrings();
    String[] old = info.clone();
    for(int i = 0; i < info.length; i ++){
      
      info[i] = old[info.length - 1 - i];
    }
    
    info = append(info, "");
    info = append(info, "");
    //println(info.length);
    
    // TODO search for unremoved ones?
    // act to lazy for that...
    
    // TODO sort it better ?
    for(int i = 2; i < info.length; i ++){
      info[i] = info[i - 2];
    }
    
    String xur = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"}).getVar("SN", "rn");
    int ind = info.length - 2;
    ind = 0; // remove this if it should be saved at end + rem for loop
    
    info[ind] = "cur: " + xur;
    ind ++;
    info[ind] = "<";
    
    setNames(info);
  }
  
  
  public void tickButtons(){
    super.tickButtons();
    String but = super.getButton();
    
    if(tickButton()){
      //println(but);
      if(but.split(": ")[0].equals("cur")){
        
       // FileManager file = 
       // new FileManager(
        String[] path = new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"};//).setVal("removed", new Time().toDate());
        //println("should be set");
        //new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"}).getVar("SN", "rn");
        // just saved the time..
        nextScreen(new RemTimes(path));
        
      } else if(!but.equals("<")){
       
        String[] path = new String[]{"Dia", "baseValues", "freeStyle", "used", but + ".txt"};//).setVal(
        //String keyy = "removed";
        //String val = new Time().toDate());
       
        nextScreen(new RemTimes(path));
       
      } else {
        
        backScreen();
      }
    }
    
  }
  
}