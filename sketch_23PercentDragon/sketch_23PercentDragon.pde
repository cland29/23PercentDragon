
PImage image, image2;
ArrayList<MovingPixel> pixelList = new ArrayList<MovingPixel>();
ArrayList<MovingPixel> removeList = new ArrayList<MovingPixel>();


void setup(){
  size(387, 1000);
  image = loadImage("SinglePersonStanding387by1000.jpg");

  image2 = loadImage("SinglePersonStanding387by1000.jpg");
}




void draw() {
  for(int i = 0; i < image.width * image.height; i++){
    image2.pixels[i] = image.pixels[i];
  }

  for (MovingPixel pixel:pixelList){
    pixel.shiftPixel((int) ((Math.random() - 0.5) * 3), (int) (Math.random() * 3 * -1 + 1));
    //pixel.shiftPixel(0, 1);
    pixel.tintPixelOnImage(image2, 0.5);
    if (pixel.isOffImage(image2)){
      removeList.add(pixel);
    }
  }
  
  for(int i = 0; i < (int) (Math.random() * 5 + 5); i++){
    pixelList.add(new MovingPixel(230, 420, color(211 + (int) (Math.random() * 50), 78 + (int) (Math.random() * 20), 24 + (int) (Math.random() * 20))));
  }
  
  for(int i = 0; i < (int) (Math.random() * 5); i++){
    pixelList.add(new MovingPixel((int) (image.width * Math.random()), image.height - 10, color(211 + (int) (Math.random() * 50), 78 + (int) (Math.random() * 20), 24 + (int) (Math.random() * 20))));
  }
  
  for (MovingPixel pixelToRemove:removeList){
    pixelList.remove(pixelToRemove);
    
  }
  removeList.clear();

  
  image2.updatePixels();
  image(image2, 0, 0);
}

public class MovingPixel{
  int locX, locY;
  color col;
  public MovingPixel(){
    locX = 100;
    locY = 200;
    col = color(0, 0, 0);
    
  }
  
  public MovingPixel(int locX, int locY, color col){
    this.locX = locX;
    this.locY = locY;
    this.col = col;
    
  }
  
  public void shiftPixel(int shiftX, int shiftY){
    locX += shiftX;
    locY += shiftY;
  }
  
  public void tintPixelOnImage(PImage image, double tintPercent){//As a decimal
      int pos = (locX + image.width * locY);
      if (pos >= 0 && pos < image.width*image.height){
        int red = (int) (red(col) * tintPercent + red(image.pixels[pos]) * (1 - tintPercent));
        int green = (int) (green(col) * tintPercent + green(image.pixels[pos]) * (1 - tintPercent));
        int blue = (int) (blue(col) * tintPercent + blue(image.pixels[pos]) * (1 - tintPercent));
        image.pixels[pos] = color(red, green, blue);
      }
  }
  
  public void drawPixelOnImage(PImage image){
      int pos = (locX + image.width * locY);
      if (pos >= 0 && pos < image.width*image.height){
        image.pixels[pos] = col;
      }
  }
  
  public boolean isOffImage(PImage image){
    int pos = (locX + image.width * locY);
    return !(pos >= 0 && pos < image.width*image.height);
  }
  
}
