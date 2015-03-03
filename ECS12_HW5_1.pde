//Michael Figueroa
//All the images that are used to create the background and sprite
PImage spriteSrc;
PImage sprite;
PImage spriteBck;
PImage background;
PImage outImg;
float scale = .35;
int threshold = 75;
float time; // For movement
color[] verticalColor; // Empty Array
float x = 0;
float y = 0;
void setup() 
{
  size(1600, 1200);
  spriteSrc = loadImage("HorseOrange.jpg");
  spriteBck = loadImage("BackgroundOrange.jpg");
  sprite = createImage(spriteSrc.width, spriteSrc.height, ARGB);
  background = loadImage("Arches-National-Park.jpg");
  outImg =  loadImage("Arches-National-Park.jpg");

  verticalColor = new color[background.width]; // Initialize array to hold colors

  for (int x = 0; x < background.width; x ++ ) {
    noiseDetail(3, 18);
    noiseSeed(1); //A seed for red
    float col1 = noise(x/1000.0); // Random red with seed 1 using current x value divided by 1000
    noiseSeed(2); //A seed for green
    float col2 = noise(x/1000.0); // Random green with seed 2 using current x value divided by 1000
    noiseSeed(3); //A seed for blue
    float col3 = noise(x/1000.0); // Random blue with seed 3 using current x value divided by 1000
    verticalColor[x] = color(col1, col2, col3); // Put together the r, g, and b values into a color and store it into the array
  }
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
  spriteSrc.loadPixels();
  spriteBck.loadPixels();
  sprite.loadPixels();
  for (int x = 0; x < spriteSrc.width; x ++ ) {
    for (int y = 0; y < spriteSrc.height; y ++ ) {
      int index = y * spriteSrc.width + x; //Index of array
      color spriteColor = spriteSrc.pixels[index]; //The current color of the sprite
      color bgColor = spriteBck.pixels[index]; //The current color of the background
      float r1 = red(spriteColor); //The red value of the sprite
      float g1 = green(spriteColor); //The green value of the sprite
      float b1 = blue(spriteColor); //The blue value of the sprite
      float r2 = red(bgColor); //The red value of the sprite
      float g2 = green(bgColor); //The green value of the sprite
      float b2 = blue(bgColor); //The blue value of the sprite
      float diff = dist(r1, g1, b1, r2, g2, b2); //Comparing the two current pixel colors
      if (diff < threshold) sprite.pixels[index] = color (0, 0); //If the threshold isnt met, the color of the sprite is transparent
      else sprite.pixels[index] = spriteColor; //If the threshold is met, the color of the sprite remains
      sprite.updatePixels(); //Update the pixels of the sprite
    }
  }
}
//Add your animation code here.  Be sure to draw both your background image
//and your sprite.
void draw() 
{
  //background.loadPixels(); Given, but unnecessary
  //image(background, 0, 0); // From part 1, Unnecessary after adding the trail function
  if ((time*100) <= 3500) { 
    x = (time*100);
  } // X coordinate for the sprite after scaling
  y = 1000 + sin(time)*800; // Y coordinate for the sprite after scaling
  LeaveTrail(background, outImg, scale * x, scale * y); //Call the function with unscaled values
  scale(scale); // Scale for the sprite
  image(sprite, x, y); // Draw the sprite

  time+=.05;
}

//This function should create some "disruption" of the image, centred at location
//(x,y) and of dimensions size x size.  You can use this to leave a trail with your sprite
//src is the unchanged, input image
//out is modified by this method to include the disruption.  It should be displayed as
// the background.
//Disruptions could include blurring the section of the image, making it brighter or darker,
//shifting the color, etc.  The disruption should modify the pixel values.
void LeaveTrail(PImage src, PImage out, float xin, float yin)
{
  src.loadPixels();
  out.loadPixels();
  for (int x = 0; x < src.width; x ++ ) {
    for (int y = 0; y < src.height; y ++ ) {
      //The following if just checks to see if we are in the area of where we want the streak, I added some sin functions to make it wavy.
      //if (x <= 20 * -sin( y / 20.0 )+( xin + scale * sprite.width / 2) && y <=  15 * sin( x / 15.0 )+( yin + scale * sprite.height ) && y >= 25 * sin( x / 25.0 )+( yin + ( scale * sprite.height) / 2 ) ){
      if ( x >= (xin) && x <= (xin + 100) && y >= 10 * sin(x/10.0) + (yin + 100) && y <= 10 * sin(x/10.0) + (yin + 200) ) {
        int index = y * src.width + x; //Index of array
        color srcColor = src.pixels[index]; //The current color of the image
        float r = red(srcColor); //The red value of the image
        float g = green(srcColor); //The green value of the image
        float b = blue(srcColor); //The blue value of the image
        color streak = color(r + red(verticalColor[x]), g + green(verticalColor[x]), b + blue(verticalColor[x])); // Adding together the background color and the color in the array
        out.pixels[index] = streak; // Change the stored pixel with the new color
      }
    }
  }
  out.updatePixels(); // Update out's pixel array
  image(out, 0, 0); // Display the new background
}

void mousePressed()
{
  save("sampleOut.jpg");
}

