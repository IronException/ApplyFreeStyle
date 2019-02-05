public class Apply extends UseProc{
  
  
  public Apply(){
    
    eve = new Event[5];
    buts = new Button[2];
    
    //  extra is for graphButton(painLvl)
    float ySize = height / (eve.length + buts.length + 2);
    
    
    buts[0] = new Button();
    buts[0].setTxt("apply");
    buts[0].setCol(180);
    buts[0].setPosSize(0, 0, width, ySize);
    
    
    
    eve[0] = apply.get("openApplier");
    eve[0].setPosSize(0, ySize, width, ySize);
    
    eve[1] = apply.get("openSensorThing");
    eve[1].setPosSize(0, 2 * ySize, width, ySize);
    
    eve[2] = apply.get("stickTogether");
    eve[2].setPosSize(0, 3 * ySize, width, ySize);
    
    // apply, done, results
    
    eve[3] = apply.get("apply");
    eve[3].setPosSize(0, 4 * ySize, width, ySize);
    
    eve[4] = apply.get("done");
    eve[4].setPosSize(0, 5 * ySize, width, ySize);
    
    radioBut = new GraphButton();
    radioBut.setPosSize(0, 6 * ySize, width, 2 * ySize);
    radioBut.setTxt("painLvl");
    if(painLvlGraph.length < 1){
      radioBut.setGraph(new float[]{25, 10, 5, 10, 25});
    } else {
      radioBut.setGraph(painLvlGraph);
    }
    radioBut.setPointSize(ySize / 32);
    
    
    buts[1] = new Button();
    buts[1].setTxt("<");
    buts[1].setCol(225);
    buts[1].setPosSize(0, height - ySize, width, ySize);
    
    
    
  }
  
  Event[] eve;
  GraphButton radioBut;
  Button[] buts;
  
  public void render(){
    for(int i = 0; i < eve.length; i ++){
      eve[i].render();
    }
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    radioBut.render();
    
    
  }
  
  
  public void tickPress(){
    radioBut.tickPress();
    
  }
  
  public void tickButtons(){
    for(int i = 0; i < eve.length; i ++){
      eve[i].tickButton();
    }
    
    
    if(buts[1].tickButton()){
      
      painLvlGraph = radioBut.getGraph();
      autoSave();
      backScreen();
    }
  }
}
  
  
  
  
