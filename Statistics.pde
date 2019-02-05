public class Statistics extends UseProc {
  
  
  public Statistics(){
    super();
    
  }
  
  
  public void render(){
    background(255);
  }
  
  public void tickButtons(){
    // TODO how much time till activated
    nextScreen(new Menu());
  }
  
  
}