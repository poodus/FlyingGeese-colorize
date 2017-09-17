/* 

 Quilt Generator
 
 A generative quilt generator which uses triangles
 to create a traditional "flying geese" quilt pattern using random variables
 and a pre-defined color pallete.
 
 Colors need to be manually entered in this version.
 
 Hit 's' while running to save a vector PDF of the design.
 
 Hit 'n' while running to get a new batch of colors by offseting the hue
 
 @author Shane Reetz
 
 */

import processing.pdf.*;
boolean savePDF = false;

int squareWidth = 50; // How wide each element will be
int squareOffset;
int colorCount = 7; // Number of colors to use
color[] pallete = new color[colorCount]; // array of colors for palette
boolean oddRow = false; 

void setup() {
  beginRecord(PDF, "QUILT_" + year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + "_###.pdf");
  colorMode(HSB, 360, 100, 100, 100);
  size(500, 500);
  noStroke();
  makeColors(true); // fill color pallete with values
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
      // Retrieve first color from pallete
      color firstColor = getRandomColorFromPallete();
      fill(firstColor, firstAlphaVal);

      // Draw top triangle
      triangle(w+squareOffset, h, w+squareWidth+squareOffset, h+squareWidth, w+squareOffset+squareWidth*2, h);

      // 60% of the time, use a random fill value
      if (random(0, 10) > 4)
      {
        fill(getRandomColorFromPallete(), random(0, 255));
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
  if (key == 's' || key == 'S') savePDF = true;
  if (key == 'n' || key == 'N') makeColors(true);
}

/* 
 void makeColors()
 
 Changes the colors held in pallete[]
 */
void makeColors(boolean random) {
  // If the user wants new colors, apply a hue offset to the colors
  int hueOffset = 0;
  if(random) {
    hueOffset = (int)random(0, 256);
  }
  pallete[0] = color(93 + hueOffset, 19, 78);
  pallete[1] = color(40 + hueOffset, 18, 40);
  pallete[2] = color(18 + hueOffset, 92, 77);
  pallete[3] = color(11 + hueOffset, 5, 31);
  pallete[4] = color(31 + hueOffset, 36, 20);
  pallete[5] = color(0 + hueOffset, 0, 0);
  pallete[6] = color(0 + hueOffset, 0, 0);
}

/* 
 color getRandomColorFromPallete()
 
 Returns a random color from the pallete
 
 @return color
 */
color getRandomColorFromPallete() {
  return pallete[(int)random(0, colorCount)];
}