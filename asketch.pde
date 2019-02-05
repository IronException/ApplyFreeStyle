



/*
public String getThing(){
  return getPath() + "/path";
}*/


// appName is in acceleration tab... wtf? where? I cant find it..
String appName;

void setup(){
  fullScreen();
  //accSetup();
  //frameRate(24);
  appName = this + "";
  appName = "ApplyFreeStyle4";
  init();
  nextScreen(new Menu());
  
 // new Event().loadAutoSave("getStuff(after 1848.30)");
  
  thread("loadAutoSave");
}

/*
FAQ
doRender();
backScreen();

*/

public void autoSave(){
  thread("actAutoSave");
}

public void actAutoSave(){
  String rV = "";
  String bar = ":";
  
  rV += events.autoSave();
  rV += bar;
  for(int i = 0; i < alkSwab.length; i ++){
    rV += alkSwab[i].autoSave();
    rV += bar;
  }
  
  rV += apply.autoSave();
  rV += bar;
  
  for(int i = 0; i < painLvlGraph.length; i ++){
    rV += painLvlGraph[i];
    if(i < painLvlGraph.length - 1){
      rV += ", ";
    }
  }
  rV += bar;
  
  rV += sensorName;
  
  rV += bar;
  rV += applyPosX + "";
  rV += bar;
  rV += applyPosY + "";
  
  
  new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).setStrings(new String[]{rV});
}

public void loadAutoSave(){
  String[] info = new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).getStrings();
  if(info.length != 1){
    // WARNING: RETURNS IF !1
    return;
  }
  
  // how is it saved?
  try{
    String[] sp = info[0].split(":");
    int ind = 0;
    events.loadAutoSave(sp[ind]);
    ind ++;
    for(int i = 0; i < alkSwab.length; i ++){
      alkSwab[i].loadAutoSave(sp[ind]);
      ind ++;
    }
    
    apply.loadAutoSave(sp[ind]);
    ind ++;
    
    //println("maybe in graph");
    String[] graph = sp[ind].split(", ");
    if(graph.length == 1 && graph[0].equals("")){
      //println("jump");
      graph = new String[0];
    }
   // println("graph: " + graph.length);
    float[] zw = new float[graph.length];
    for(int i = 0; i < zw.length; i ++){
      zw[i] = Float.parseFloat(graph[i]);
    }
    painLvlGraph = zw;
    ind ++;
    
    
    
    
    sensorName = sp[ind];
    ind ++;
    
    applyPosX = Float.parseFloat(sp[ind]);
    ind ++;
    
    applyPosY = Float.parseFloat(sp[ind]);
    ind ++;
    
    // font do a autoSave for activated for now 
  
  } catch(Exception e){
    println("loadAutoSaveException: " + e);
  }
  useProc.doRender();
  //autoSave();
}

EventManager events;
EventManager[] alkSwab;
EventManager apply;

TimeCounter[] countdowns;
TimeCounter curCount;

float[] painLvlGraph;
String sensorName;

float applyPosX, applyPosY;
boolean setApply;

Time activated;

public void init(){
  
  painLvlGraph = new float[0];
  sensorName = "setSensor";
  
  events = new EventManager();
  
  alkSwab = new EventManager[]{
    new EventManager(),
    new EventManager()
  };
  
  //countdown = new TimeCounter();
  
  
  countdowns = new TimeCounter[alkSwab.length];
  for(int i = 0; i < countdowns.length; i ++){
    countdowns[i] = new TimeCounter();
  }
  
  apply = new EventManager();
  
}








