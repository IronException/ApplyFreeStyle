




public class ComTag extends UseProc {
  
  public ComTag(){
    super();
    
    xSize = width / 2;
    
    tagSize = width / 3;
    
    ySaveSize = height / 6;
    ySavePos = height - ySaveSize;
    
    saveTxt = new TextPanel[2];
    saveTxt[0] = new TextPanel("<", 0, ySavePos, xSize, ySaveSize);
    saveTxt[1] = new TextPanel("save", xSize, ySavePos, xSize, ySaveSize);
    
    String[] info = new FileManager(new String[]{"Tags", "information.txt"}).getStrings();
    //loadStrings(getTagInfo());
    
    tags = new Tag[info.length];
    for(int i = 0; i < tags.length; i ++){
      tags[i] = new Tag(info[i]);
    }
    
    tagInd = 0;
  }
  
  float tagSize;
  
  float xSize;
  
  float ySavePos;
  float ySaveSize;
  TextPanel[] saveTxt;
  
  
  float xTagPos;
  int tagInd;
  Tag[] tags;
  
  float xMousePos;
  
  public void render(){
    background(225);
    renderTags();
    
    renderSave();
  }
  
  public void renderTags(){
    for(int y = 0; y < 3; y ++){
      for(int x = 0; x < 4; x ++){
        fill(255);
        rect(xTagPos + x * tagSize, y * tagSize, tagSize, tagSize);
        //new TextPanel((tagInd * 3 + x * 3 + y) + "", xTagPos + x * tagSize, y * tagSize, tagSize, tagSize).render();
        
        try{
          tags[tagInd * 3 + x * 3 + y].render(xTagPos + x * tagSize, y * tagSize, tagSize);
        } catch(Exception e){
          
        }
      }
    }
    
  }
  
  public void renderSave(){
    fill(225);
    rect(0, ySavePos, xSize, ySaveSize);
    rect(xSize, ySavePos, xSize, ySaveSize);
    
    saveTxt[0].render();
    saveTxt[1].render();
  }
  
  public void tickButtons(){
    if(mouseY < width){
      int x = 3 * mouseX / width;
      int y = 3 * mouseY / width;
      try{
        tags[tagInd * 3 + x * 3 + y].tick();
        
        coolActivate();
      }catch(Exception e){}
      
    }
    
    if(mouseY > ySavePos){
      if(mouseX < xSize){
        back();
      } else {
        sace();
      }
    }
  }
  
  public void tickPress(){
    if(mouseX < 3 * tagSize){
      //float change = 
      xTagPos += mouseX - xMousePos;
      if(xTagPos > 0){
        xTagPos -= tagSize;
        tagInd --;
        if(tagInd < 0){
          tagInd ++;
          xTagPos = 0;
        }
      } else if(xTagPos < -tagSize){
        xTagPos += tagSize;
        tagInd ++;
        if(tagInd + 3 > (tags.length - 1) / 3){
          tagInd --;
          xTagPos = -tagSize;
        }
      }
      setDoRender(true);
    
    }
    
    xMousePos = mouseX;
  }
  
  
  public void tickPressStart(){
    xMousePos = mouseX;
  }
  
  public String getTags(){
  String rV = "";
  for(int i = 0; i < tags.length; i ++){
    rV += tags[i].getNameIf(", ");
  }
  return rV;
}
  
  
  
}

public class Tag{
  
  
  public Tag(String info){
    // name:3:2
    //name:disNums:actNums
    //int rand;
    
    sp = info.split(":");
    //println(sp.length);
    //int left = sp.length;
    folder = null;
    try{
    name = sp[0];
    
    show = false;
    //try{
    if(sp[1].equals("2")){
      show = true;
      folder = sp[4];
    } else if(sp[2].equals("1")){
      show = true;
    }
    
    d = Integer.parseInt(sp[2]);
    a = Integer.parseInt(sp[3]);
    refreshImg();
    
    
    } catch(Exception e){
      
      switch(sp.length){
        case 0:
          name = "";
        case 1:
          show = true;
        case 2:
          d = 1;
        case 3:
          a = 1;
        
      }
      
    }
    
    
  }
  
  //int disNum;
  //int actNum;
  String[] sp;
  
  String name;
  
  String folder;
  
  int d, a;
  PImage dis;
  PImage act;
  
  boolean active;
  
  boolean show;
  
  public void refreshImg(){
    int rand;
    name = sp[0];
    if(sp[1].length() == 0){
      dis = createImage(2, 2, RGB);
    } else {
      rand = (int) random(d);
      //rand = (int) random(Integer.parseInt(sp[1]));
      rand ++;
      dis = new FileManager(new String[]{"Tags", name + rand + ".png"}).getImg();
      //loadImage(getTags() + name + rand + ".png");
      //println(dis);
      if(dis == null){
        dis = createImage(2, 2, RGB);
      }
    }
    
    if(sp[2].length() == 0){
      act = createImage(2, 2, RGB);
    } else {
      rand = (int) random(a);
      //rand = (int) random(Integer.parseInt(sp[2]));
      rand ++;
      act = new FileManager(new String[]{"Tags", name + "-" + rand + ".png"}).getImg();
      //loadImage(getTags() + name + "-" + rand + ".png");
      if(act == null){
        act = createImage(2, 2, RGB);
      }
    }
    
  }
  
  public void render(float xPos, float yPos, float size){
    //fill(255);
    //rect(xPos, yPos, size, size);
    
    if(active){
      image(act, xPos, yPos, size, size);
    } else{
      image(dis, xPos, yPos, size, size);
    }
    
    if(show){
      float halfS = size /2;
      if(folder != null){
        halfS = size;
      }
      new TextPanel(name, xPos, yPos + halfS, size, halfS).render();
    }
    
  }
  
  public void tick(){
    active = !active;
    refreshImg();
  }
  
  public String getNameIf(String betw){
    String rV = "";
    if(active){
      rV = name + betw;
    }
    return rV;
  }
  
  
}

public void back(){
  backScreen();
}


// hdhdhdhdhdhdhdhdhdhdhd

public void saceOld(){
  FileManager file = new FileManager(
  new String[]{// to set:...
    "ApplyFreeStyle",
    "log",
    "appliedSensors.txt"
  });//.getStrings();
  
  // will be:
  /*new String[]{
    "Dia",
    "baseValues",
    "Sensors",
    "cur.txt" // ???
  };*/
  
  // old gets moved to old.txt
  // + this is act a variable not a whole file
  
  
  /*
  String[] info = values.getStrings();
  //String[] info = loadStrings(getValues());
  String[] nev = new String[info.length + 1];
  for(int i = 0; i < info.length; i ++){
    nev[i + 1] = info[i];
  }
  nev[0] = getData();
  */
  String data = getData();
  file.addString(data, true);
  delAutoSave();
  // normalSave
  
  file = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "nev", "info.txt"});
  // TODO: 
  // 1.done remove sensor from list there
  // 4.done + copy values and add this getData() to cur
  // 2.done + make backup of cur
  // 3. + CODE: H83 ? button?
  // + num: ? automatic...
  
  
  // nev:
  // 1.done remove sensor from list there
  // 4.done copy values and add this getData() to cur
  // 2.done make backup of cur
  // 3.done add CODE: H83 (button to enter) + num (auto) + ...
  
  
  
  file.setStrings(remove(file.getStrings(), sensorName));
  
  /*
  file = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "old.txt"});
  new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "nev", "old" + new Time().toDate() + ".txt"}).setStrings(file.getStrings());
  // do that in case sth goes wrong
  */
  
  // file = cur.txt
  file = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});
  String sN = file.getVal("SN"); // is it name or SN or sth else?
  // used/name.txt setStrings(file)
  new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "used", sN + ".txt"}).setStrings(file.getStrings());
  
  // used/info.txt add the sensor
  int sensorNum = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "used", "info.txt"}).addString(sN, false);
  
  // cur.txt set nev/name.txt
  file.setStrings(new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "nev", sensorName + ".txt"}).getStrings());
  // delete that then
  
  
  //int sensorNum = 1;
  
  file.loadValues();
  file.setVal("apply", data);
  file.setVal("CODE", "H83"); // while we dont have a button
  file.setVal("num", sensorNum + "");
  file.saveValues(); // no need to do this
  
  
  // 
  
  //saveStrings(getValues(), nev);
  //println("atEnd");
  nextScreen(new Statistics());
}


public String getData(){
  String bar = ":";
  String rV = "";
  rV += new Time().toDate();
  
  rV += bar;
  rV += "times" + events.getData();
  
  for(int i = 0; i < alkSwab.length; i ++){
    rV += bar;
    rV += "alkSwab" + i + alkSwab[i].getData();
  
  }
  /*
  rV += bar;
  rV += "alkSwab1" + alkSwab[0].getData();
  
  rV += bar;
  rV += "alkSwab2" + alkSwab[1].getData();
  */
  
  rV += bar;
  rV += "apply" + apply.getData();
  
  rV += bar;
  rV += "painLvlGraph[";
  for(int i = 0; i < painLvlGraph.length; i ++){
    
    rV += painLvlGraph[i];
    if(i < painLvlGraph.length - 1){
      rV += ", ";
    } else {
      //rV += "]"; // cant do this cuz of size 0
    }
  
  }
  rV += "]";
  
  /*rV += bar;
  if(resumed){
    rV += "resumed ";
  } else{
    rV += "open ";
  }
  rV += open.toDate(true, true, true);*/
  if(setApply){
    rV += bar;
    rV += "applyPos " + applyPosX + " " + applyPosY;
  }
  
  rV += bar;
  rV += ((ComTag) useProc).getTags();
  
  return rV;
}

public void sace(){
  FileManager file = new FileManager(
  new String[]{// to set:...
    "ApplyFreeStyle",
    "log",
    "appliedSensors.txt"
  });
  
  String data = getData();
  file.addString(data, true);
  delAutoSave();
  // normalSave
  
  // here starts the madness:
  
  file = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "nev", "info.txt"});
  file.setStrings(remove(file.getStrings(), sensorName));
  
  // TODO:
  // 1.done ^ remove sensor from list there
  // 4.done copy values and add this getData() to cur
  // 2.done make backup of cur
  // 3.done add CODE: H83 (button to enter) + num (auto) + ...
  
  
  // bring cur.txt to used
  // file = cur.txt
  file = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});
  String sN = file.getVal("SN"); // is it name or SN or sth else?
  
  // set cur in used
  // used/name.txt setStrings(file)
  new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "used", sN + ".txt"}).setStrings(file.getStrings());
  
  // used/info.txt add the sensor
  int sensorNum = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "used", "info.txt"}).addString(sN, false);
  
  // cur.txt set nev/name.txt
  file = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "nev", sensorName + ".txt"});
  FileManager cur = new FileManager(new String[]{"Dia", "baseValues", "freeStyle", "cur.txt"});
  
  cur.setStrings(file.getStrings());
  file.delete();
  // delete that then
  
  
  // to reload it
  // maybe remove
  //file.loadValues();
  cur.setVal("appliedLog", data);
  cur.setVal("CODE", "H91"); // while we dont have a button
  cur.setVal("num", sensorNum + "");
  cur.setVal("applyPos", applyPosX + " " + applyPosY);
  
  //Time t = 
  if(activated != null){
    cur.setVal("activated", activated.toTime());
    println("setActivated");
    
  }
  //file.saveValues(); // no need to do this
  
  
  
  nextScreen(new Statistics());
}

