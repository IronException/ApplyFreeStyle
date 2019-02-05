public class Wait extends NumPad{
  
  
  public Wait(){
    super();
    
    FileManager f = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});
    
    Time activated = new Time().setStringTime(f.getVar("activated", new Time().toTime()));
    //println(activated.toDate());
    int offset = Integer.parseInt(f.getVar("offset", "0"));
    
    
    /*
      activated
        
      eingabe
        
      now
        writeValue
      
      
      timeEingegeben - (eingabe - now).mins ?
      
      
      do it:
      now - activated + offset
    */
    
    Time waitTime = activated.addTime(new Time(1, 0, 0, 0)).subTime(new Time());//.subTime(activated.subTime(new Time(0, 0, 0, 1, 0, 0)));
    int waitTimeMin = waitTime.min + waitTime.hour * 60;
    forWaitOffset = waitTimeMin + offset;
    
    writeValue = forWaitOffset + "";
    
   // writeValue = "30";
    
    name = new String[]{"toWait"}; // set
    unit = new String[]{"mins"}; // set
    //length = new int[]{2}; // set
    komma = new int[]{0}; // sey
    
    //doRender();
    refreshType();
    refreshValText();
    
  }
  
  int forWaitOffset;
  
  public void keyBack(){
    backScreen();
  }
  
  public void keyEnter(){
    
    FileManager f = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});//.setVal("removed", new Time().toDate());
    String v = f.getVar("timeToWait", "");
    
    if(v.length() > 0){
      v += ", ";
    }
    
    //int gOff = Integer.parseInt(f.getVar("offset", "0")) + forWaitOffset - Integer.parseInt(writeValue);
    
    int gOff = Integer.parseInt(f.getVar("offset", "0")) + Integer.parseInt(writeValue) - forWaitOffset;
    f.setVal("offset", gOff + "");
    
    v += new Time().toTime() + " " + writeValue;
    
    f.setVal("timeToWait", v);
    
    backScreen();
  }
  
  
  
}