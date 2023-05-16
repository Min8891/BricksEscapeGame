class Brick{

  public int xCor;
  public int yCor;
  public int w;
  public int h;

 Brick(int xVal, int yVal, int wVal, int hVal){
    xCor = xVal;
    yCor = yVal;
    w = wVal;
    h = hVal;
    
  } 
  
  public void drop(float speed){
    yCor += speed;
  }
  
  public void display(){
    fill(0, 45, 102);
    rect(xCor, yCor,w,h,5);
  }
}
