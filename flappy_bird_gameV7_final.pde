PImage bg, pink, toppinkpipe, botpinkpipe;
int bgx, bgy, pinkx, pinky,ky,kx, gamestate,g, Vky;
int[] pinkpipeX, pinkpipeY;
int gameState, score, highscore;

void setup()
{
size(700,600);
  bg = loadImage("C:/Users/Basma/Pictures/image/purplesky.png");   
  pink = loadImage("C:/Users/Basma/Pictures/image/pink.png");
botpinkpipe = loadImage("C:/Users/Basma/Pictures/image/pinkpipe.png");
toppinkpipe = loadImage("C:/Users/Basma/Pictures/image/pinkpipe (2).png");
pinkx = 100;
pinky = 50;
g = 1;
pinkpipeX = new int [4];
pinkpipeY = new int [pinkpipeX.length];
for (int i = 0; i < pinkpipeX.length; i++)
{
  pinkpipeX[i] = width + 200*i;
  pinkpipeY[i] = (int)random(-350,-400);
  } 
  gameState = -1;
}

//MAIN GAME LOOP
void draw()
{
  if(gameState == -1)
  {
    startScreen();  
  }
  else if(gameState==0)
  {
    setBg();
    setpinkpipes();
    pink(); 
    displayScore();
  }
  else
  {
    endScreen();
    restart();
  }
}

void endScreen()
{
    fill(150, 150, 250, 100);
    if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290)
    {
      fill(150, 250, 150, 100);
    }
    rect(90, 150, 505, 140, 5);
    fill(0);
    textSize(40);
    text(" pink died  : (", 200,200);
    text("Click HERE to play again." , 100, 270);  
}

void restart()
{
   //CHECK TO MAKE SURE THE MOUSE IS IN THE 'BOX'
   if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290)
   {
     //RESET AND RESTART 
     if(mousePressed)
     {
        ky = height/2;
        for(int i = 0; i < pinkpipeX.length; i++)
        {
          pinkpipeX[i] = width + 200*i;
          pinkpipeY[i] = (int)random(-350, 0);
        }      
        score = 0;
        gameState = 0;  
     } 
   }
}
void displayScore()
{
  if(score>highscore)
  {
    highscore = score;
  }
  //Background for ScoreBoard
  fill(160,160,160, 200); //Last# is opacity (Clearness)
  rect(width-175, 10, 155, 80, 5);
  fill(0);
  textSize(32);
  text("Score: " + score, width - 170, 40);  
  text("High:  " + highscore, width - 170, 80);   
}

void startScreen()
{
  image(bg, 0,0);
  textSize(30);
  text("Welcome to Pink Skies!", 30, 80);
  text("Click the mouse to begin...", 40, 200);
  if(mousePressed)
  {
    ky = height/2;
    gameState = 0;
  }
}
void setpinkpipes()
{
  for(int i = 0; i < pinkpipeX.length; i++)
  {

   image(toppinkpipe, pinkpipeX[i], pinkpipeY[i]);
   image(botpinkpipe, pinkpipeX[i], pinkpipeY[i] + 640);
   pinkpipeX[i]-= 3;
   if(score > 10)
   {
     pinkpipeX[i]--;  //Speed up when they reach 10 points
   }
   if(score > 20)
   {
     pinkpipeX[i]--;  //Speed up again at 20 points  
   }
   if(pinkpipeX[i] < -200)
   {
     pinkpipeX[i] = width;  
   }
   if(kx > (pinkpipeX[i]-54) && kx < pinkpipeX[i] + 100)
   {
     //End Game is not in SAFE ZONE
     if(!(ky > pinkpipeY[i] + 400 && ky < pinkpipeY[i] + (400 + 241 - 54)))
     {
       gameState = 1;
     }
     //Score if pass through pipe
     else if (kx==pinkpipeX[i] || kx == pinkpipeX[i] + 1)
     {
       score++;  
     }
   }
  }  
} //<>//

void fail()
{
 fill(255, 0, 0, 200);
 textSize(25);
 rect(20, height - 223, 455, 32);
 fill(0);
 text("OH NO!!!! PINK RAN INTO A PIPE...", 20, height - 200);       
}

void pink()
{
   image(pink, kx, ky);
   ky = ky + Vky;
   Vky = Vky + g;  
   if(ky > height || ky < 0)
   {
     fill(255, 0, 0, 140);
     textSize(24);
     text("OH NO! PINK FELL OFF THE SCREEN...", 40, 34);
     gameState=1;
   }
}

void mousePressed()
{
   Vky = -15;  
}

void setBg()
{
  image(bg, bgx, bgy);
  image(bg, bgx + bg.width, bgy);
  bgx--;
  if(bgx < -bg.width)
  {
     bgx = 0; 
  }  
}
