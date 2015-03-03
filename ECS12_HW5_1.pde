//All the images that are used to create the background and sprite
PImage spriteSrc;
PImage sprite;
PImage spriteBck;
PImage background;
PImage outImg;



void setup() 
{
  size(1600, 1200);
  spriteSrc = loadImage("HorseOrange.jpg");
  spriteBck = loadImage("BackgroundOrange.jpg");
  sprite = createImage(spriteSrc.width, spriteSrc.height, ARGB);
  background = loadImage("Arches-National-Park.jpg");
  outImg =  loadImage("Arches-National-Park.jpg");

  CreateSprite(spriteSrc, spriteBck, sprite);
  
 
}

//A sprite is an image that you can move around the screen on top of a background.
//This function takes as input spriteSrc and spriteBck.  spriteSrc is an image
//that contains whatever you want to turn into a sprite.  spriteBck is the same image,
//but with the thing you want to turn into a sprite missing.  i.e. it is just the background
//The method returns an image sprite that has all the pixels for the desired sprite set
//to their color values from the image and all the other pixels set to be transparent.
//The sprite is returned through the "sprite" argument (which is passed by reference
//since it is an object).
//The method should compare each pixel in spriteSrc and spriteBck to determine which
//pixels are background and should be made transparent.  This is similart to background
//subtraction.
//Make sure all three images are the same size (simplifying assumption)
void CreateSprite(PImage spriteSrc, PImage spriteBck, PImage sprite)
{
  //add your code here
}

//Add your animation code here.  Be sure to draw both your background image
//and your sprite.
void draw() 
{
  //add your code here


}

//This function should create some "disruption" of the image, centred at location
//(x,y) and of dimensions size x size.  You can use this to leave a trail with your sprite
//src is the unchanged, input image
//out is modified by this method to include the disruption.  It should be displayed as
// the background.
//Disruptions could include blurring the section of the image, making it brighter or darker,
//shifting the color, etc.  The disruption should modify the pixel values.
void LeaveTrail(PImage src, PImage out, int x, int y, int size)
{
  //add your code here
}

void mousePressed()
{
  save("sampleOut.jpg");
}


