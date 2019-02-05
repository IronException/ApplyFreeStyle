public class Menu extends UseProc{
  
  public Menu(){
    super();
    /*
      apply
      setTime
      ?
      
    */
    
    buts = new Button[5];
    float ySize = height / (buts.length - 1.0);
    
    buts[0] = new Button();
    buts[0].setPosSize(0, 0 * ySize, width, ySize);
    buts[0].setTxt("apply");
    
    buts[1] = new Button();
    buts[1].setPosSize(0, 1.0 * ySize, width, ySize);
    buts[1].setTxt("setTime");
    
    // could be an event
    buts[2] = new Button();
    buts[2].setPosSize(0, 2.0 * ySize, width, ySize);
    buts[2].setTxt("activate");
    
    buts[3] = new Button();
    buts[3].setPosSize(0, 3.0 * ySize, width, ySize);
    buts[3].setTxt("removeSensor");
    
    buts[4] = new Button();
    buts[4].setPosSize(0, 0, 0, 0);
    
    
    setTimeLeft();
    //println(curCount + " " + curCount.isCounting());
    onBackScreen();
    
  }
  
  Button[] buts;
  
  public void render(){
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
  }
  
  
  public void tickButtons(){
    
    if(buts[0].tickButton()){
      nextScreen(new Times());
      
    } else if(buts[1].tickButton()){
      nextScreen(new Wait());
      // TODO
      
      
    } else if(buts[3].tickButton()){
      //nextScreen(new Times());
      // TODO move curSensor ... act how do I do that?
      // maybe looks wether content is in an extra file and depending on that its movin?
      
      
      nextScreen(new Remove());
      
    } else if(buts[2].tickButton()){
      
      nextScreen(new Activate());
    }
    
    
  }
  
  public void tick(){
    if(curCount != null){
      curCount.tick();
    }
  }
  
  
  public void onBackScreen(){
    super.onBackScreen();
    
    
    
    float ySize = height / (buts.length - 1.0);
    if(curCount != null && curCount.isCounting()){
      
      
      
      buts[4] = curCount;
      
      ySize = height / buts.length;
    }
    
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].setPosSize(0, i * ySize, width, ySize);
    }
    
    
  }
  
  
  
}