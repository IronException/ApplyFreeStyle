public class RecPp extends UseProc{
  
  public RecPp(){
    super();
    
    float ySize = height / 6.0;
    yPos = height - ySize;
    
    but = new Button();
    but.setPosSize(0, yPos, width, ySize);
    but.setTxt("<");
    
    
    arms = new FileManager(new String[]{"ApplyFreeStyle", "res", "arms.png"}).getImg();
    
    
    setApply = true;
    
  }
  
  float yPos;
  Button but;
  
  PImage arms;
  
  public void render(){
    //background(255);
    image(arms, 0, 0, width, yPos);
    
    but.render();
    
    // cross
    float spriS = width / 24.0;
    float x = applyPosX * width;
    float y = applyPosY * yPos;
    stroke(255, 0, 0);
    line(x - spriS, y - spriS, x + spriS, y + spriS);
    line(x - spriS, y + spriS, x + spriS, y - spriS);
    
    stroke(0);
    
    
  }
  
  
  public void tickPress(){
    if(but.tickButton()){
      // nothing
    } else {
      applyPosX = (float) mouseX / width;
      applyPosY = mouseY / yPos;
      doRender();
      
      
    }
  }
  
  public void tickButtons(){
    
    if(but.tickButton()){
      backScreen();
    } else {
      // nothing
      
    }
    
  }
  
  
  
}