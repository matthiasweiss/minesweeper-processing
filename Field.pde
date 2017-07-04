class Field {  
  boolean mine, shown = false;
  
  int index, x, y;
  
  Field(boolean mine) {
    this.mine = mine;  
  }
  
  int calcNeighbours() {
    if (this.mine) { return 0; }
    int n = 0;
    int cols = width/grid;
    int[] indices = new int[]{this.index - cols - 1, this.index - cols, this.index - cols + 1,
                            this.index - 1, this.index + 1, 
                            this.index + cols - 1, this.index + cols, this.index + cols + 1};
    for (int i: indices) {
      if (i >= 0 && i < fields.length && fields[i].mine == true) {
        n++;
      }
    }
    return n;
  }
  
  void show(int i) {
    this.index = i;
    
    this.x = grid * (this.index % (width / grid));
    this.y = grid * (this.index / (width / grid));
    
    // hidden
    if (! this.shown) {
      fill(189, 195, 199);
      rect(this.x, this.y, grid, grid); 
      return;
    }
    
    // shown but no mine
    if (! this.mine) {
      fill(236, 240, 241);
      rect(this.x, this.y, grid, grid); 
      fill(41, 128, 185);
      textSize(grid/2);
      String s = this.calcNeighbours() == 0 ? "" : "" + this.calcNeighbours();
      text(s, this.x + grid/2-5, this.y + grid/1.5);
      return;
    }
    
    // mine
    fill(192, 57, 43);
    rect(this.x, this.y, grid, grid);
  }
  
  void click() {
    if (! this.mine) {
      this.shown = true;
      int upper = this.index - width/grid;
      int left = this.index - 1;
      int right = this.index + 1;
      int lower = this.index + width/grid;
      int[] neighbours = new int[]{left, right, upper, lower};
      
      for (int i: neighbours) {
        // if it isnt a valid field continue
        if (i < 0 || i >= numFields) continue;
        
        // if it finds a mine then stop showing neighbours
        if (fields[i].mine) return;
        
        // otherwise show all neighbours recusively
        if (! fields[i].shown) {
          fields[i].click();
        }
      }
    } else {
      for (Field f: fields) { f.shown = true; }
    }  
  }
}