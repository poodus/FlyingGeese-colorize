/* Quilt Generator
 
 A generative quilt generator which uses triangles (or rotated squares)
 to create a traditional quilt pattern using random variables.
 
 constrain size changes
 Features to add: interpolator?
 
 */

import processing.pdf.*;
boolean savePDF = false;

int squareWidth = 50; // How wide each element will be
int squareOffset;
int colorCount = 7; // Number of colors to use
color[] pallete = new color[colorCount]; // array of colors for palette
boolean oddRow = false; 

void setup() {
  beginRecord(PDF, "###.pdf");
  colorMode(HSB, 360, 100, 100, 100);
  size(500, 500);
  noStroke();
  makeColors(); // fill color pallete with values
  frameRate(2);
}

void draw() { 
  background(0);

  for (int h = 0; h < height+squareWidth; h+=squareWidth)
  {
    if (oddRow)
    {
      squareOffset=-squareWidth;
      oddRow = false;
    } else
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

      // Draw a triangle
      triangle(w+squareOffset, h, w+squareWidth+squareOffset, h+squareWidth, w+squareOffset+squareWidth*2, h);

      // 60% of the time, use a random fill value
      if (random(0, 10) > 4)
      {
        fill(getRandomColorFromPallete(), random(0, 255));
      }

      // The other 40% of the time, fill with the last alpha value
      // to create an identical pair
      else
      {
        fill(firstColor, firstAlphaVal);
        triangle(w+squareOffset, h, w+squareWidth+squareOffset, h-squareWidth, w+squareOffset+squareWidth*2, h);
      }

      // DRAW BOTTOM TRIANGLE
      triangle(w+squareOffset, h, w+squareWidth+squareOffset, h-squareWidth, w+squareOffset+squareWidth*2, h);
    }
  }
  if (savePDF) {
    endRecord();
    beginRecord(PDF, "###.pdf");
    savePDF = false;
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') savePDF = true;
  else makeColors();
}

/* 
 void makeColors()
 
 Changes the colors held in pallete[]
 */
void makeColors() {
  pallete[0] = color(93, 19, 78);
  pallete[1] = color(40, 18, 40);
  pallete[2] = color(18, 92, 77);
  pallete[3] = color(11, 5, 31);
  pallete[4] = color(31, 36, 20);
  pallete[5] = color(0, 0, 0);
  pallete[6] = color(0, 0, 0);
}

/* 
 color getRandomColorFromPallete()
 
 Returns a random color from the pallete
 */
color getRandomColorFromPallete() {
  return pallete[(int)random(0, colorCount)];
}