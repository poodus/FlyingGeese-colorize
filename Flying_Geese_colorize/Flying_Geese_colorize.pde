/* 

 Quilt Generator
 
 A generative quilt generator which uses triangles
 to create a traditional "flying geese" quilt pattern using random variables
 and a pre-defined color palette.
  
 Instructions:
 Hit ENTER while running to save a vector PDF of the design.
 
 GET A NEW BATCH OF COLORS
 Hit 'h' to offset hue
 Hit 's' to offset saturation
 Hit 'b' to offset brightness
 Hit 'r' to get new, random colors
 
 @author Shane Reetz
 
 */

import processing.pdf.*;
boolean savePDF = false;

int squareWidth = 50; // How wide each element will be
int squareOffset;
int colorCount = 7; // Number of colors to use
color[] palette = new color[colorCount]; // array of colors for palette
boolean oddRow = false; 

void setup() {
  beginRecord(PDF, "QUILT_" + year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + "_###.pdf");
  colorMode(HSB, 360, 100, 100, 100);
  size(500, 500);
  noStroke();
  makeColors(0); // fill color palette with values
  frameRate(2);
}

/*
  void draw()
 
 Main drawing loop.
 
 @param none
 @return none
 */
void draw() { 
  background(0);

  for (int h = 0; h < height+squareWidth; h+=squareWidth)
  {
    if (oddRow)
    {
      squareOffset=-squareWidth;
      oddRow = false;
    } 
    
    else
    {
      squareOffset=0;
      oddRow = true;
    }
    
    for (int w = 0; w < width+squareWidth; w+=squareWidth*2)
    {
      // Get random alpha value
      int firstAlphaVal = 100;
      // Retrieve first color from palette
      color firstColor = getRandomColorFrompalette();
      fill(firstColor, firstAlphaVal);

      // Draw top triangle
      triangle(w+squareOffset, h, w+squareWidth+squareOffset, h+squareWidth, w+squareOffset+squareWidth*2, h);

      // 60% of the time, use a random fill value
      if (random(0, 10) > 4)
      {
        fill(getRandomColorFrompalette(), random(0, 255));
      }

      // 40% of the time, fill with the last alpha value
      // to create an matching top and bottom pair
      else
      {
        fill(firstColor, firstAlphaVal);
      }

      // Draw bottom triangle
      triangle(w+squareOffset, h, w+squareWidth+squareOffset, h-squareWidth, w+squareOffset+squareWidth*2, h);
    }
  }
  if (savePDF) {
    endRecord();
    beginRecord(PDF, "QUILT_" + year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + "_###.pdf");
    savePDF = false;
  }
}

/* 
 void keyPressed()
 
 Runs when a key is pressed. This is being used to save a PDF of sample patterns.

 */
void keyPressed() {
  if (key == ENTER) savePDF = true;
  if (key == 'h' || key == 'H') makeColors(1); // modify hue
  if (key == 's' || key == 'S') makeColors(2); // modify saturation
  if (key == 'b' || key == 'B') makeColors(3); // modify brightness
  if (key == 'r' || key == 'R') makeColors(0); // random
}

/* 
 void makeColors()
 
 Changes the colors held in palette[]
 */
void makeColors(int mode) {
  int hueOffset = 0;
  int saturationOffset = 0;
  int brightnessOffset = 0;
  
  switch(mode) {
    case 0:
      for(int i = 0; i < palette.length; i++) 
      {
         palette[i] = color(random(0, 360), random(0, 100), random(0, 100));
      }
      return;
    case 1:
      hueOffset = (int)random(0, 360);
      break;
    case 2:
      saturationOffset = (int)random(0, 100);
      break;
    case 3:
      brightnessOffset = (int)random(0, 100);
      break;       
  }

  // Add offsets to our last values. Use modulus operator to wrap values back into expected range (360, 100, 100)
  palette[0] = color((hue(palette[0]) + hueOffset) % 360, (hue(palette[0]) + saturationOffset) % 100, (hue(palette[0]) + brightnessOffset) % 100);
  palette[1] = color((hue(palette[1]) + hueOffset) % 360, (hue(palette[1]) + saturationOffset) % 100, (hue(palette[1]) + brightnessOffset) % 100);
  palette[2] = color((hue(palette[2]) + hueOffset) % 360, (hue(palette[2]) + saturationOffset) % 100, (hue(palette[2]) + brightnessOffset) % 100);
  palette[3] = color((hue(palette[3]) + hueOffset) % 360, (hue(palette[3]) + saturationOffset) % 100, (hue(palette[3]) + brightnessOffset) % 100);
  palette[4] = color((hue(palette[4]) + hueOffset) % 360, (hue(palette[4]) + saturationOffset) % 100, (hue(palette[4]) + brightnessOffset) % 100);
  palette[5] = color((hue(palette[5]) + hueOffset) % 360, (hue(palette[5]) + saturationOffset) % 100, (hue(palette[5]) + brightnessOffset) % 100);
  palette[6] = color((hue(palette[6]) + hueOffset) % 360, (hue(palette[6]) + saturationOffset) % 100, (hue(palette[6]) + brightnessOffset) % 100);
}

/* 
 color getRandomColorFrompalette()
 
 Returns a random color from the palette
 
 @return color
 */
color getRandomColorFrompalette() {
  return palette[(int)random(0, colorCount)];
}