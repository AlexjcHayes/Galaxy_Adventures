/****************************************************\
 
 GameEngineBase
 (your main class - save as a new name!)
 
 // Last Updated 4/5/17
 
 \****************************************************/
//                  Agenda
/////////////////////////////////////////////////////////////////////////////////////////////////////
//----------left off
//**************Audio****************\\
import ddf.minim.*;
Minim audio;
AudioPlayer music;
////////////////////////////////////////
Particle fire;
ArrayList<AudioPlayer> sfx;
ArrayList<Boom> booms;
ArrayList<Particle> firework;
int fireworkTimer;
int fireworkDeleteTimer;
int numPart=(int)random(1, 10);
//boolean isAlive;
ArrayList<GameObject> objects;
ArrayList<CompanionPower> CompPower;
ArrayList<Companion> multiComp;
RedShot redSt;
PImage imageB;//boss images
float x=width/2;
float y=height - 200;
float moveX;
float moveX2;
float moveY;
float moveY2;
boolean flashState;
int flash;
int moveSpeed=5;
float planetY;
float planetX;
int time=20;//sets fire rate speed
int cTime=40;
int time2=40;//missle firerate speed
int cTime2=20;
int fireRate=time;//fire rate when shooting
int fireRate2=cTime;// companion fire rate
int missleRate=time2;
int cMissleRate=cTime2;//companion missle firerate
int pSize=70;//player Size
int eSize=150;//Enemy Size
int numLives;//number of player lives
int cNumLives;//number of companion lives
int numCredits;//player credits
int cNumCredits;//companion credits
int numWorld;
int Level;
int tCounter=72;
int tCounter2=72;
boolean CoolState=false;
int companionTimer=0;
int companionTimer2=0;
int leveldispTimer=500;
int leveldispTimer2=500;
int GOtimer=100;
int Btimer=1000;
int Btimer2=100;
float DAMAGE;
float STC=1;
int shopTimer=20;
boolean companionDisplay=false;
boolean fade=false;
boolean unfade=false;
int coolState=1;
int infoState=0;
int glideCounter=0;
int gCSize=0;//gameClear Logo Size
int tYSize=0;//thank you Logo Size
int logoTimer=150;
int tint=0;//tint of the fade out in the gameClear
int fadeTint=0;//tint of fade transitions
int fadeTintState=0;
int instructionTimer=900;//instruction timer
int instructionTimer2=1200;//instruction timer
int enemyRoll;//spawns random enemies
int enemyRandomAmount;//random enemy amount in survival mode
int enemyRandomMax=3;//variable that increases as you survive longer (greater chance of spawning more enemies at once)
int enemyRollSpawn=1;//the amount of times enemyRandomSpawn is called
int enemyRollMax=9;//variable that sets the max for the random enemy spawner
int bossRandomAmount=1;//max number of each boss spawned
//////////////////////////////////SHOP\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
int shopLogoWidth=400;
int shopLogoHeight=100;
/////////////////////////////////////////////
boolean homingLock=true;
boolean QuadLock=true;
boolean fireRateLock=true;
boolean damageLock=true;
boolean shieldLock=true;
boolean shieldRegenLock=true;
boolean shieldRegen2Lock=true;//faster shield Regen
boolean companionLock=true;
////////////////////////////////////////////
boolean homingLock2=true;
boolean QuadLock2=true;
boolean fireRateLock2=true;
boolean damageLock2=true;
boolean shieldLock2=true;
boolean shieldRegenLock2=true;
boolean shieldRegen2Lock2=true;//faster shield Regen                                              Finish companion Shop (replace the upgrades)
boolean companionLock2=true;
/////////////////////////////////////////////////////
int balanceState=1;
int regenState=1;//player regenstate in shop
int regenState2=1;//companion regenstate in shop
float planetSize;
int infoTint;
int textTint;
int infoNum=0;//number variable in the mainInfo array
//Space Travel\\
float sTSpeed=.01;
float sTS=5000;
//*************\\
//boolean isAlive;
RedShot redS;
Player p;
Enemy e;
final int starNum=1000;
Star[] stars = new Star[starNum];
Star s;
int lTimer=20;
ArrayList<Enemy> Enemies;
String gamestate;
String playerGameState;
String companionGameState;
String Information;
/////////////////////////////////////////////////Single Player\\\\\\\\\\\\\\\\\\\
String info1="Use wasd to move";
String info2="Press spacebar to shoot";
String info3="Press P to Pause and buy upgrades";
//////////////////////////////////////////////MultiPlayer\\\\\\\\\\\\\\\\\\\\\\\\\
String info4="Use wasd and ijkl to move";
String info5="Press c and . to shoot";
String info6="Press R (player 1) and P (player 2) \n to Pause and buy upgrades";
String info7="Now Survive!!!";
String[] mainInfo=new String[4];
int switchTimer=0;//Switch timer between gameClear and endTransition (make it line up with the music
String gameMode;
int pTimer=20;//pause timer
boolean gameOver=false;
boolean multiplayer=false;
boolean survivalMode=false;
void settings()
{
   fullScreen(P3D);
   //size(1000, 1000, P3D);
   PJOGL.setIcon("Galaxy_Adventures_Icon.png");
}
void setup()
{
  //if(multiplayer==false)
  //{
  //  companionLock=true;
  //}
  cHealthBarX=width-healthBarWidth-10;
  gameSetup();
  loadImages();
  //////////////////////
  numWorld=1;
  Level=0;
  gamestate="spaceTravel";
  numCredits=0;
  cNumCredits=0;
  numLives=5;
  cNumLives=5;
  //////////////////////
  audio= new Minim(this);
  sfx= new ArrayList<AudioPlayer>();
  gameMusic();
  noCursor();
  objects = new ArrayList<GameObject>();
  Enemies= new ArrayList<Enemy>();
  CompPower= new ArrayList<CompanionPower>();
  multiComp= new ArrayList<Companion>();
  booms= new ArrayList<Boom>();
  objects.add(new Player(width/2, height - 200));
  if (multiplayer==true)
  {
    objects.add(new Companion(width/2, height - 200));
  }
  //fire=new Particle(width,height);
  firework=new ArrayList<Particle>();
  s=new Star();
  for (int i=0; i<stars.length; i++)
  {
    stars[i] = new Star();
  }

  ///////////////////////////Boss Animation\\\\\\\\\\\\\\\\\\\\\\
  moveX=180;
  moveX2=width-200;
  moveY=-100;
  moveY2=height+50;
  flash=0;
  flashState=false;
  ///////////////////////////////////////////////////////Rotating Planets\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  noStroke();
  fill(255);
  sphereDetail(40);

  sun = createShape(SPHERE, 100);
  sun.setTexture(suntex);
  num3Planet= createShape(SPHERE, width);
  num3Planet.setTexture(lavaTexture);
  planetSize=100;
  transitionPlanet=createShape(SPHERE, planetSize);
  transitionPlanet.setTexture(lavaTexture);
}
void draw()
{
  //println(width-healthBarWidth, cHealthBarX);
  //println(glideCounter);
  //println(fireRate,fireRate2);
  if (gamestate=="InfoScreen2")
  {
    drawInfoScreen2();
  }
  if (gamestate=="survival")
  {
    drawSurvival();
  }
  if (cMissleRate>0)
  {
    cMissleRate--;
  }
  if (cMissleRate==0)
  {
    cMissleRate=0;
  }
  if (gamestate=="endTransition")
  {
    drawEndTransition();
  }
  if (gamestate=="gameClear")
  {
    drawGameClear();
  }
  if (gamestate=="bossAnimation")
  {
    drawBossAnimation();
  }
  if (fireRate2>0)
  {
    fireRate2--;
  }
  if (companionLock==false&&damageLock==true&&balanceState==1)
  {
    damageCost+=150;
    balanceState=2;
  }
  if (companionLock==true&&damageLock==false&&balanceState==1)
  {
    companionCost+=150;
    balanceState=2;
  }
  if (companionTimer>0)
  {
    companionTimer--;
  }

  if (companionTimer==0)
  {
    companionTimer=0;
  }
  if (companionTimer2>0)
  {
    companionTimer2--;
  }
  if (companionTimer2==0)
  {
    companionTimer2=0;
  }
  if (shopTimer>0)
  {
    shopTimer--;
  }
  if (gamestate=="gameplay")
  {
    drawGameplay();
  }
  if (gamestate=="pause")
  {
    drawPause();
    imageMode(CENTER);
    imageMode(CORNER);
    image(shopBackground, 0, 0, width, height);
    imageMode(CENTER);
    image(Shop, width/2, 100, 200, 200);
    image(Pause, width-255, 50);
    image(pauseInfo, width-250, 200, 300, 100);
    image(hoverMouse, width-200, height-220, 400, 200);
    if (fireRateLock==true)
    {
      image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (QuadLock==true)
    {
      image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (damageLock==true)
    {
      image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (homingLock==true)
    {
      image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (shieldLock==true)
    {
      image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (shieldLock==true)
    {
      image(Locked, 200, 650, shopLogoWidth, shopLogoHeight);
    }
    if (shieldLock==false)//makes it so that it doesn't show unless you buy shields
    {
      if (shieldRegenLock==true&&regenState==1)
      {
        image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
      } else if (shieldRegenLock==false&&regenState==2)
      {
        tint(28, 174, 229);
        image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
        tint(255);
      } else if (shieldRegen2Lock==false&&regenState==3)
      {
        tint(0, 150, 0);
        image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
    }
    if (multiplayer==false)
    {
      if (companionLock==true)
      {
        image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
    }
    image(Credits, 110, 60, 120, 50);
    fill(255);
    textSize(40);
    text(numCredits, 180, 70);
    fill(255);
    text("Cost", 320, 110);
    fill(255);
    text(fireRateCost, 330, 160);
    text("Press 1 to buy", 400, 160);
    text(quadShotCost, 305, 260);
    text("Press 2 to buy", 390, 260);
    text(homingCost, 310, 360);
    text("Press 3 to buy", 390, 360);
    text(damageCost, 325, 460);
    text("Press 4 to buy", 395, 460);
    text(shieldsCost, 300, 560);
    text("Press 5 to buy", 400, 560);
    if (multiplayer==false)
    {
      text(companionCost, 310, 760);
      text("Press 7 to buy", 400, 760);
    }
    if (shieldLock==false)//makes it so that it doesn't show unless you buy shields
    {
      if (shieldRegenLock==false)
      {
        text(shieldRegen2Cost, 320, 660);
      } else
      {
        text(shieldRegenCost, 320, 660);
      }
      text("Press 6 to buy", 400, 660);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    if (mouseY>=150&&mouseY<=90+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//fire Rate
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(numCredits, 180, 70);
      if (fireRateLock==true)
      {
        image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(fireRateCost, 330, 160);
      text("Press 1 to buy", 400, 160);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Double your firerate", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=250&&mouseY<=190+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//Quad Shot
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(numCredits, 180, 70);
      if (QuadLock==true)
      {
        image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(quadShotCost, 305, 260);
      text("Press 2 to buy", 390, 260);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Fire 4 bullets at once", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=350&&mouseY<=290+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//homing ball
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(numCredits, 180, 70);
      if (homingLock==true)
      {
        image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(homingCost, 310, 360);
      text("Press 3 to buy", 390, 360);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      if (multiplayer==true)
      {
        text("Launch homing balls to hunt \n down your enemeies \n (Press V to use)", width/2, height/2);
      } else
      {
        text("Launch homing balls to hunt \n down your enemeies \n (Press M to use)", width/2, height/2);
      }
      textAlign(CORNER);
    }
    if (mouseY>=450&&mouseY<=390+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//damage increase
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(numCredits, 180, 70);
      if (damageLock==true)
      {
        image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(damageCost, 325, 460);
      text("Press 4 to buy", 395, 460);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Increase the amount of damage \n you deal", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=550&&mouseY<=490+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//shields
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(numCredits, 180, 70);
      if (shieldLock==true)
      {
        image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(shieldsCost, 300, 560);
      text("Press 5 to buy", 400, 560);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Gain an extra layer of health", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=650&&mouseY<=590+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//shield regen
    {
      if (shieldLock==true)//display Locked in the description (hidden of shields are locked)
      {
        imageMode(CORNER);
        image(shopBackground, 0, 0, width, height);
        imageMode(CENTER);
        image(Shop, width/2, 100, 200, 200);
        image(Pause, width-255, 50);
        image(pauseInfo, width-250, 200, 300, 100);
        image(Credits, 110, 60, 120, 50);
        fill(255);
        textSize(40);
        text(numCredits, 180, 70);
        image(Locked, 200, 650, shopLogoWidth, shopLogoHeight);
        noFill();
        noStroke();

        fill(44, 133, 155, 128);
        rectMode(CENTER);
        rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
        image(Locked, width/2, height/2, shopLogoWidth, shopLogoHeight);
        image(buyShields, width/2, height/2+100, shopLogoWidth+150, shopLogoHeight);
      } else
      {
        imageMode(CORNER);
        image(shopBackground, 0, 0, width, height);
        imageMode(CENTER);
        image(Shop, width/2, 100, 200, 200);
        image(Pause, width-255, 50);
        image(pauseInfo, width-250, 200, 300, 100);
        image(Credits, 110, 60, 120, 50);
        fill(255);
        text("Cost", 320, 110);
        fill(255);
        textSize(40);
        text(numCredits, 180, 70);
        if (shieldRegenLock==true&&regenState==1)
        {
          image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
        } else if (shieldRegenLock==false&&regenState==2)
        {
          tint(28, 174, 229);
          image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
          tint(255);
        } else if (shieldRegen2Lock==false&&regenState==3)
        {
          tint(0, 150, 0);
          image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
          tint(255);
        }
        if (shieldRegenLock==false)
        {
          text(shieldRegen2Cost, 320, 660);
        } else
        {
          text(shieldRegenCost, 320, 660);
        }
        text("Press 6 to buy", 400, 660);
        noFill();
        noStroke();

        fill(44, 133, 155, 128);
        rectMode(CENTER);
        rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
        ////////////////////////////////////////////////////////
        textSize(70);
        textAlign(CENTER, CENTER);
        fill(255);
        text("Regerate your shields \n (upgradable twice)", width/2, height/2);
        textAlign(CORNER);
      }
    }
    if (multiplayer==false)
    {
      if (mouseY>=750&&mouseY<=690+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//Companion power
      {
        imageMode(CORNER);
        image(shopBackground, 0, 0, width, height);
        imageMode(CENTER);
        image(Shop, width/2, 100, 200, 200);
        image(Pause, width-255, 50);
        image(pauseInfo, width-250, 200, 300, 100);
        image(Credits, 110, 60, 120, 50);
        fill(255);
        text("Cost", 320, 110);
        fill(255);
        textSize(40);
        text(numCredits, 180, 70);
        if (companionLock==true)
        {
          image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
        } else
        {
          tint(0, 150, 0);
          image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
          tint(255);
        }
        text(companionCost, 310, 760);
        text("Press 7 to buy", 400, 760);
        noFill();
        noStroke();

        fill(44, 133, 155, 128);
        rectMode(CENTER);
        rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
        ////////////////////////////////////////////////////////
        textSize(65);
        textAlign(CENTER, BOTTOM);
        fill(255);
        if (multiplayer==false)
        {
          text("Have a companion fight along  \n side you (press j to use)", width/2, height/2);
        } else
        {
          text("Have a companion fight along  \n side you (press G to use)", width/2, height/2);
        }
        textAlign(CENTER, CENTER);
        fill(255, 0, 0);
        text("\n \n (WARNING) \n It will cost 100 credits per activation!!", width/2, height/2);
        textAlign(CORNER);
      }
    }
    rectMode(CORNER);
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    strokeWeight(1);
    image(Cursor, mouseX, mouseY);
  }
  if (gamestate=="pause2")
  {
    drawPause();
    imageMode(CORNER);
    image(shopBackground, 0, 0, width, height);
    imageMode(CENTER);
    image(Shop, width/2, 100, 200, 200);
    image(Pause, width-255, 50);
    image(pauseInfo, width-250, 200, 300, 100);
    image(hoverMouse, width-200, height-220, 400, 200);
    if (fireRateLock2==true)
    {
      image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (QuadLock2==true)
    {
      image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (damageLock2==true)
    {
      image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (homingLock2==true)
    {
      image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (shieldLock2==true)
    {
      image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
    } else
    {
      tint(0, 150, 0);
      image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
      tint(255);
    }
    if (shieldLock2==true)
    {
      image(Locked, 200, 650, shopLogoWidth, shopLogoHeight);
    }
    if (shieldLock2==false)//makes it so that it doesn't show unless you buy shields
    {
      if (shieldRegenLock2==true&&regenState2==1)
      {
        image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
      } else if (shieldRegenLock2==false&&regenState2==2)
      {
        tint(28, 174, 229);
        image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
        tint(255);
      } else if (shieldRegen2Lock2==false&&regenState2==3)
      {
        tint(0, 150, 0);
        image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
    }
    if (multiplayer==false)
    {
      if (companionLock2==true)
      {
        image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
    }
    image(Credits, 110, 60, 120, 50);
    fill(255);
    textSize(40);
    text(cNumCredits, 180, 70);
    fill(255);
    text("Cost", 320, 110);
    fill(255);
    text(fireRateCost, 330, 160);
    text("Press 1 to buy", 400, 160);
    text(quadShotCost, 305, 260);
    text("Press 2 to buy", 390, 260);
    text(homingCost, 310, 360);
    text("Press 3 to buy", 390, 360);
    text(damageCost, 325, 460);
    text("Press 4 to buy", 395, 460);
    text(shieldsCost, 300, 560);
    text("Press 5 to buy", 400, 560);
    if (multiplayer==false)
    {
      text(companionCost, 310, 760);
      text("Press 7 to buy", 400, 760);
    }
    if (shieldLock2==false)//makes it so that it doesn't show unless you buy shields
    {
      if (shieldRegenLock==false)
      {
        text(shieldRegen2Cost, 320, 660);
      } else
      {
        text(shieldRegenCost, 320, 660);
      }
      text("Press 6 to buy", 400, 660);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    if (mouseY>=150&&mouseY<=90+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//fire Rate
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(cNumCredits, 180, 70);
      if (fireRateLock2==true)
      {
        image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(fireRateIncrease, 200, 150, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(fireRateCost, 330, 160);
      text("Press 1 to buy", 400, 160);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Double your firerate", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=250&&mouseY<=190+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//Quad Shot
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(cNumCredits, 180, 70);
      if (QuadLock2==true)
      {
        image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(quadShot, 200, 250, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(quadShotCost, 305, 260);
      text("Press 2 to buy", 390, 260);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Fire 4 bullets at once", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=350&&mouseY<=290+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//homing ball
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(cNumCredits, 180, 70);
      if (homingLock2==true)
      {
        image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(homingOrbs, 200, 350, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(homingCost, 310, 360);
      text("Press 3 to buy   (Press M to use)", 390, 360);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Launch homing balls to hunt \n down your enemeies \n (Press / to use)", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=450&&mouseY<=390+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//damage increase
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(cNumCredits, 180, 70);
      if (damageLock2==true)
      {
        image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(damageIncrease, 200, 450, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(damageCost, 325, 460);
      text("Press 4 to buy", 395, 460);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Increase the amount of damage \n you deal", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=550&&mouseY<=490+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//shields
    {
      imageMode(CORNER);
      image(shopBackground, 0, 0, width, height);
      imageMode(CENTER);
      image(Shop, width/2, 100, 200, 200);
      image(Pause, width-255, 50);
      image(pauseInfo, width-250, 200, 300, 100);
      image(Credits, 110, 60, 120, 50);
      fill(255);
      text("Cost", 320, 110);
      fill(255);
      textSize(40);
      text(cNumCredits, 180, 70);
      if (shieldLock2==true)
      {
        image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
      } else
      {
        tint(0, 150, 0);
        image(shields, 200, 550, shopLogoWidth, shopLogoHeight);
        tint(255);
      }
      text(shieldsCost, 300, 560);
      text("Press 5 to buy", 400, 560);
      noFill();
      noStroke();

      fill(44, 133, 155, 128);
      rectMode(CENTER);
      rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
      ////////////////////////////////////////////////////////
      textSize(70);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Gain an extra layer of health", width/2, height/2);
      textAlign(CORNER);
    }
    if (mouseY>=650&&mouseY<=590+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//shield regen
    {
      if (shieldLock2==true)//display Locked in the description (hidden of shields are locked)
      {
        imageMode(CORNER);
        image(shopBackground, 0, 0, width, height);
        imageMode(CENTER);
        image(Shop, width/2, 100, 200, 200);
        image(Pause, width-255, 50);
        image(pauseInfo, width-250, 200, 300, 100);
        image(Credits, 110, 60, 120, 50);
        fill(255);
        textSize(40);
        text(cNumCredits, 180, 70);
        image(Locked, 200, 650, shopLogoWidth, shopLogoHeight);
        noFill();
        noStroke();

        fill(44, 133, 155, 128);
        rectMode(CENTER);
        rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
        image(Locked, width/2, height/2, shopLogoWidth, shopLogoHeight);
        image(buyShields, width/2, height/2+100, shopLogoWidth+150, shopLogoHeight);
      } else
      {
        imageMode(CORNER);
        image(shopBackground, 0, 0, width, height);
        imageMode(CENTER);
        image(Shop, width/2, 100, 200, 200);
        image(Pause, width-255, 50);
        image(pauseInfo, width-250, 200, 300, 100);
        image(Credits, 110, 60, 120, 50);
        fill(255);
        text("Cost", 320, 110);
        fill(255);
        textSize(40);
        text(cNumCredits, 180, 70);
        if (shieldRegenLock2==true&&regenState2==1)
        {
          image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
        } else if (shieldRegenLock2==false&&regenState2==2)
        {
          tint(28, 174, 229);
          image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
          tint(255);
        } else if (shieldRegen2Lock2==false&&regenState2==3)
        {
          tint(0, 150, 0);
          image(shieldRegen, 200, 650, shopLogoWidth, shopLogoHeight);
          tint(255);
        }
        if (shieldRegenLock==false)
        {
          text(shieldRegen2Cost, 320, 660);
        } else
        {
          text(shieldRegenCost, 320, 660);
        }
        text("Press 6 to buy", 400, 660);
        noFill();
        noStroke();

        fill(44, 133, 155, 128);
        rectMode(CENTER);
        rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
        ////////////////////////////////////////////////////////
        textSize(70);
        textAlign(CENTER, CENTER);
        fill(255);
        text("Regerate your shields \n (upgradable twice)", width/2, height/2);
        textAlign(CORNER);
      }
    }
    if (multiplayer==false)
    {
      if (mouseY>=750&&mouseY<=690+shopLogoHeight&&mouseX>=10&&mouseX<=shopLogoWidth+10)//Companion power
      {
        imageMode(CORNER);
        image(shopBackground, 0, 0, width, height);
        imageMode(CENTER);
        image(Shop, width/2, 100, 200, 200);
        image(Pause, width-255, 50);
        image(pauseInfo, width-250, 200, 300, 100);
        image(Credits, 110, 60, 120, 50);
        fill(255);
        text("Cost", 320, 110);
        fill(255);
        textSize(40);
        text(cNumCredits, 180, 70);
        if (companionLock2==true)
        {
          image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
        } else
        {
          tint(0, 150, 0);
          image(CompanionShop, 200, 750, shopLogoWidth, shopLogoHeight);
          tint(255);
        }
        text(companionCost, 310, 760);
        text("Press 7 to buy", 400, 760);
        noFill();
        noStroke();

        fill(44, 133, 155, 128);
        rectMode(CENTER);
        rect(width/2, height/2, 1000, 500, 50, 50, 50, 50);
        ////////////////////////////////////////////////////////
        textSize(65);
        textAlign(CENTER, BOTTOM);
        fill(255);
        text("Have a companion fight along  \n side you (Press ' to use)", width/2, height/2);
        textAlign(CENTER, CENTER);
        fill(255, 0, 0);
        text("\n \n (WARNING) \n It will cost 100 credits per activation!!", width/2, height/2);
        textAlign(CORNER);
      }
    }
    rectMode(CORNER);
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    strokeWeight(1);
    image(Cursor, mouseX, mouseY);
  }
  if (gamestate=="title")
  {
    drawTitle();
  }
  if (gamestate=="endTitle")
  {
    drawEndTitle();
  }
  if (gamestate=="spaceTravel")
  {
    drawSpaceTravel();
  }
  if (gamestate=="InfoScreen")
  {
    drawInfoScreen();
  }
  drawGameOver();
  if (sTS<0&&gamestate=="endTransition")
  {
    gamestate="endTitle";
    sTS=5000;
  }
  if (sTS<0&&(!(gamestate=="spaceTransition"))&&(!(gamestate=="planetTransition"))&&(!(gamestate=="gameClear"))&&(!(gamestate=="endTransition")))
  {
    gamestate="title";
    sTS=5000;
  }
  if (sTS<0&&gamestate=="planetTransition")
  {
    gamestate="gameplay";
    gameMusic();
    sTS=5000;
  }
  if (sTS<0&&gamestate=="spaceTransition"&&(!(Level==0&&numWorld==4)))
  {
    gamestate="gameplay";
    gameMusic();
    sTS=5000;
  }
  if ((sTS<0&&gamestate=="spaceTransition"&&Level==0&&numWorld==4))
  {
    gamestate="gameClear";
    gameMusic();
    sTS=5000;
  }
  //if (keyPressed &&gamestate=="title")
  //{
  //  //keyPressed=false;
  //  if(fadeTint==255)                                      REPLACED IN THE DRAWTITLE METHOD (fade in and out)
  //  {
  //  gamestate="InfoScreen";
  //  }
  //}
  if (getKey('1')&&gamestate=="InfoScreen"&&infoState==0)
  {
    multiplayer=false;
    gameMusic();
    infoState=1;
  }
  if (getKey('2')&&gamestate=="InfoScreen"&&infoState==0)
  {
    multiplayer=true;
    gameMusic();
    infoState=2;
    objects.add(new Companion(width/2, height - 200));
  }
  if (getKey('3')&&gamestate=="InfoScreen"&&infoState==0)
  {

    playSound("evilLaugh.wav");
    if (fadeTint!=255)
    {
      fadeTintState=1;
      fade=true;
    }
  }
  if (getKey('1')&&gamestate=="InfoScreen2"&&infoState==3)
  {
    multiplayer=false;
    gameMusic();
    infoState=4;
  }
  if (getKey('2')&&gamestate=="InfoScreen2"&&infoState==3)
  {
    multiplayer=true;
    gameMusic();
    infoState=5;
    objects.add(new Companion(width/2, height - 200));
  }
  if (gamestate=="InfoScreen2"&&(!getKey('m')||!getKey('M'))&&(infoState==4))
  {
    gamestate="instruction3";
  }  
  if (keyPressed&&gamestate=="InfoScreen2"&&(!getKey('m')||!getKey('M'))&&(infoState==5))
  {
    gamestate="instruction4";
  }
  if (keyPressed&&gamestate=="InfoScreen"&&(!getKey('m')||!getKey('M'))&&(infoState==1))
  {
    gamestate="instruction1";
  }  
  if (keyPressed&&gamestate=="InfoScreen"&&(!getKey('m')||!getKey('M'))&&(infoState==2))
  {
    gamestate="instruction2";
  }
  if (gamestate=="InfoScreen"&&(!getKey('m')||!getKey('M'))&&(infoState==3))
  {
    unfade=true;
    survivalMode=true;
    gamestate="InfoScreen2";
  }
  if (gamestate=="instruction2")
  {
    drawInstruction2();
  }
  if (gamestate=="instruction1")
  {
    drawInstruction1();
  }
  if (gamestate=="instruction4")
  {
    drawInstruction4();
  }
  if (gamestate=="instruction3")
  {
    drawInstruction3();
  }
  if (gamestate=="spaceTransition")
  {
    drawSpaceTravel();
  }
  if (gamestate=="planetTransition")
  {
    drawPlanetTransition();
  }
  /////////////////////////////////
  for (int x = 0; x < sfx.size(); x++)     // Loop through sounds
  {
    AudioPlayer a = sfx.get(x);

    if (!a.isPlaying())                   // If it hasn’t started yet...                  
    {
      a.play();                               // ...play it now
    }

    if (a.length() <= a.position())       // If it’s reached the end...
    {
      a.close();                             // ...close the file
      sfx.remove(a);                         // ...remove the AudioPlayer
    }
  }
  boom();
  //println(CompPower.size());
  //println(DAMAGE);
}
void drawSurvival()
{
  background(0);
  fill(255, 0, 0, 28);
  rect(0, 0, width, height);
  for (int i=0; i<stars.length; i++)
  {    
    stars[i].fall();
    stars[i].display();
  }
  render();
  update();
  advanceLevel();
  if (multiplayer==true)
  {
    if ((getKey('r')||getKey('R'))&&gamestate=="survival")
    {
      playMusic("Elevator_Music.mp3");
      gamestate="pause";
    }
    if ((getKey('p')||getKey('P'))&&gamestate=="survival")
    {
      playMusic("Elevator_Music.mp3");
      gamestate="pause2";
    }
  } else
  {
    if ((getKey('p')||getKey('P'))&&gamestate=="survival")
    {
      playMusic("Elevator_Music.mp3");
      gamestate="pause";
    }
  }
}
void drawEndTitle()
{
  if (tCounter>0)
  {
    tCounter2=72;
    tCounter--;
  }
  imageMode(CENTER);
  image(titleBackground, width/2, height/2, width, height);
  image(title, width/2, height/2-300, width+50, 300);
  image(subtitle, width/2, height/2-200, 1000, 150);
  image(madeBy, 210, height-100, 400, 150);
  image(specialThanks, width-215, height-100, 420, 150);
  if (tCounter==0)
  {
    image(thankYou, width/2, height-50, width-920, 100);
    if (tCounter2>0)
    {
      tCounter2--;
    }
    if (tCounter2==0)
    {
      tCounter=72;
    }
  }
  imageMode(CORNER);//So it doesn't interfear with the other objects and images
}
void drawEndTransition()
{
  float sTx=0;
  float sTy=0;
  STC+=5;
  if (sTS>0)
  {
    sTS-=5;
  }
  if (sTS<3640)
  {
    sTS-=50;
  }
  tStar[] tstars= new tStar[400];
  for (int i=0; i< tstars.length; i++)
  {
    tstars[i] = new tStar();
  }
  //////////////////////////////////////////////    
  float x2=width/2;
  float y2=height/2;
  sTSpeed=20;//map(mouseX,0,width,0,20);
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(STC));
  imageMode(CENTER);
  image(travelBackground, 0, 0, 800, 900);
  imageMode(CORNER);
  popMatrix();
  translate(x2, y2);
  for (int i=0; i< tstars.length; i++)
  {
    tstars[i].update();
    tstars[i].show();
  }
  if (sTS>0)
  {
    imageMode(CENTER);
    image(backShip, sTx, sTy, sTS, sTS);
    //image(WORLDCLEAR,width/2,height-200,1000,1000);
  }
}
void drawInstruction4()
{

  mainInfo[0]=info4;
  mainInfo[1]=info5;
  mainInfo[2]=info6;
  mainInfo[3]=info7;
  if (instructionTimer2>0)
  {
    instructionTimer2--;
  }
  if (instructionTimer2==0)
  {
    instructionTimer2=0;
    gamestate="survival";
  }
  InfoSet();
  background(0);
  fill(255, 0, 0, 28);
  rect(0, 0, width, height);
  for (int i=0; i<stars.length; i++)
  {    
    stars[i].fall();
    stars[i].display();
  }
  render();
  update();
  //////////////////////////////////////
  if ((instructionTimer2/60)%5==0&&textTint==0)
  {
    if ((instructionTimer2/60)<=15&&(instructionTimer2/60)>=10&&textTint==0)
    {
      infoNum=1;
    }
    if ((instructionTimer2/60)<=10&&(instructionTimer2/60)>=5&&textTint==0)
    {
      infoNum=2;
    }
    if ((instructionTimer2/60)<=5&&(instructionTimer2/60)>=0&&textTint==0)
    {
      infoNum=3;
    }
  }
  if ((((instructionTimer2/60)%5==4)||(instructionTimer2/60)%5==3)||((instructionTimer2/60)%5==2)||((instructionTimer2/60)%5==1))
  {
    if (infoTint!=128)
    {
      infoTint+=2;
    }
    if (infoTint==128)
    {
      infoTint=128;
    }
    fill(27, 159, 219, infoTint);
    if (infoNum!=2)
    {
      rect(0, height-180, width, 85);
      noFill();
      stroke(33, 129, 173, infoTint);
      rect(0, height-180, width, 85);
      noStroke();
    } else
    {
      rect(0, height-230, width, 185);
      noFill();
      stroke(33, 129, 173, infoTint);
      rect(0, height-230, width, 185);
      noStroke();
    }
  } else
  {
    if (infoTint!=0)
    {
      infoTint-=4;
    }
    fill(27, 159, 219, infoTint);
    rect(0, height-180, width, 85);
    noFill();
    stroke(33, 129, 173, infoTint);
    rect(0, height-180, width, 85);
    noStroke();
  }
  if ((((instructionTimer2/60)%5==4)||(instructionTimer2/60)%5==3)||((instructionTimer2/60)%5==2)||((instructionTimer2/60)%5==1))
  {
    if (textTint!=255)
    {
      textTint+=5;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  } else 
  {
    if (textTint!=0)
    {
      textTint-=15;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  }
  if (unfade)
  {
    if (fadeTint!=0)
    {
      fadeTint-=5;
    }
    fill(0, 0, 0, fadeTint);
    rect(0, 0, width, height);
    if (fadeTint==0)
    {
      unfade=false;
    }
  }
}
void drawInstruction3()
{

  mainInfo[0]=info1;
  mainInfo[1]=info2;
  mainInfo[2]=info3;
  mainInfo[3]=info7;
  if (instructionTimer2>0)
  {
    instructionTimer2--;
  }
  if (instructionTimer2==0)
  {
    instructionTimer2=0;
    gamestate="survival";
  }
  InfoSet();
  background(0);
  fill(255, 0, 0, 28);
  rect(0, 0, width, height);
  for (int i=0; i<stars.length; i++)
  {    
    stars[i].fall();
    stars[i].display();
  }
  render();
  update();
  //////////////////////////////////////
  if ((instructionTimer2/60)%5==0&&textTint==0)
  {
    if ((instructionTimer2/60)<=15&&(instructionTimer2/60)>=10&&textTint==0)
    {
      infoNum=1;
    }
    if ((instructionTimer2/60)<=10&&(instructionTimer2/60)>=5&&textTint==0)
    {
      infoNum=2;
    }
    if ((instructionTimer2/60)<=5&&(instructionTimer2/60)>=0&&textTint==0)
    {
      infoNum=3;
    }
  }
  if ((((instructionTimer2/60)%5==4)||(instructionTimer2/60)%5==3)||((instructionTimer2/60)%5==2)||((instructionTimer2/60)%5==1))
  {
    if (infoTint!=128)
    {
      infoTint+=2;
    }
    if (infoTint==128)
    {
      infoTint=128;
    }
    fill(27, 159, 219, infoTint);
    rect(0, height-180, width, 85);
    noFill();
    stroke(33, 129, 173, infoTint);
    rect(0, height-180, width, 85);
    noStroke();
  } else
  {
    if (infoTint!=0)
    {
      infoTint-=4;
    }
    fill(27, 159, 219, infoTint);
    rect(0, height-180, width, 85);
    noFill();
    stroke(33, 129, 173, infoTint);
    rect(0, height-180, width, 85);
    noStroke();
  }
  if ((((instructionTimer2/60)%5==4)||(instructionTimer2/60)%5==3)||((instructionTimer2/60)%5==2)||((instructionTimer2/60)%5==1))
  {
    if (textTint!=255)
    {
      textTint+=5;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  } else 
  {
    if (textTint!=0)
    {
      textTint-=15;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  }
  if (unfade)
  {
    if (fadeTint!=0)
    {
      fadeTint-=5;
    }
    fill(0, 0, 0, fadeTint);
    rect(0, 0, width, height);
    if (fadeTint==0)
    {
      unfade=false;
    }
  }
}
void drawInstruction1()
{

  mainInfo[0]=info1;
  mainInfo[1]=info2;
  mainInfo[2]=info3;
  if (instructionTimer>0)
  {
    instructionTimer--;
  }
  if (instructionTimer==0)
  {
    instructionTimer=0;
    gamestate="gameplay";
  }
  InfoSet();
  background(0);
  for (int i=0; i<stars.length; i++)
  {    
    stars[i].fall();
    stars[i].display();
  }
  render();
  update();
  //////////////////////////////////////
  if ((instructionTimer/60)%5==0&&textTint==0)
  {
    if ((instructionTimer/60)<=10&&(instructionTimer/60)>=5&&textTint==0)
    {
      infoNum=1;
    }
    if ((instructionTimer/60)<=5&&(instructionTimer/60)>=0&&textTint==0)
    {
      infoNum=2;
    }
  }
  if ((((instructionTimer/60)%5==4)||(instructionTimer/60)%5==3)||((instructionTimer/60)%5==2)||((instructionTimer/60)%5==1))
  {
    if (infoTint!=128)
    {
      infoTint+=2;
    }
    if (infoTint==128)
    {
      infoTint=128;
    }
    fill(27, 159, 219, infoTint);
    rect(0, height-180, width, 85);
    noFill();
    stroke(33, 129, 173, infoTint);
    rect(0, height-180, width, 85);
  } else
  {
    if (infoTint!=0)
    {
      infoTint-=4;
    }
    fill(27, 159, 219, infoTint);
    rect(0, height-180, width, 85);
    noFill();
    stroke(33, 129, 173, infoTint);
    rect(0, height-180, width, 85);
  }
  if ((((instructionTimer/60)%5==4)||(instructionTimer/60)%5==3)||((instructionTimer/60)%5==2)||((instructionTimer/60)%5==1))
  {
    if (textTint!=255)
    {
      textTint+=5;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  } else 
  {
    if (textTint!=0)
    {
      textTint-=15;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  }
}
void drawInstruction2()
{
  mainInfo[0]=info4;
  mainInfo[1]=info5;
  mainInfo[2]=info6;
  if (instructionTimer>0)
  {
    instructionTimer--;
  }
  if (instructionTimer==0)
  {
    instructionTimer=0;
    gamestate="gameplay";
  }
  background(0);
  for (int i=0; i<stars.length; i++)
  {    
    stars[i].fall();
    stars[i].display();
  }
  render();
  update();
  //////////////////////////////////////
  if ((instructionTimer/60)%5==0&&textTint==0)
  {
    if ((instructionTimer/60)<=10&&(instructionTimer/60)>=5&&textTint==0)
    {
      infoNum=1;
    }
    if ((instructionTimer/60)<=5&&(instructionTimer/60)>=0&&textTint==0)
    {
      infoNum=2;
    }
  }
  if ((((instructionTimer/60)%5==4)||(instructionTimer/60)%5==3)||((instructionTimer/60)%5==2)||((instructionTimer/60)%5==1))
  {
    if (infoTint!=128)
    {
      infoTint+=2;
    }
    if (infoTint==128)
    {
      infoTint=128;
    }
    fill(27, 159, 219, infoTint);
    if (infoNum!=2)
    {
      rect(0, height-180, width, 85);
      noFill();
      stroke(33, 129, 173, infoTint);
      rect(0, height-180, width, 85);
    } else
    {
      rect(0, height-230, width, 185);
      noFill();
      stroke(33, 129, 173, infoTint);
      rect(0, height-230, width, 185);
    }
  } else
  {
    if (infoTint!=0)
    {
      infoTint-=4;
    }
    fill(27, 159, 219, infoTint);
    if (infoNum!=2)
    {
      rect(0, height-180, width, 85);
      noFill();
      stroke(33, 129, 173, infoTint);
      rect(0, height-180, width, 85);
    } else
    {
      rect(0, height-230, width, 185);
      noFill();
      stroke(33, 129, 173, infoTint);
      rect(0, height-230, width, 185);
    }
  }
  if ((((instructionTimer/60)%5==4)||(instructionTimer/60)%5==3)||((instructionTimer/60)%5==2)||((instructionTimer/60)%5==1))
  {
    if (textTint!=255)
    {
      textTint+=5;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  } else 
  {
    if (textTint!=0)
    {
      textTint-=15;
    }
    textAlign(CENTER, CENTER);
    textSize(75);
    fill(255, 255, 255, textTint);
    text(mainInfo[infoNum], width/2, height-150);
    textAlign(CORNER, CORNER);
  }
}
void drawGameClear()
{
  background(0);
  float x;
  x=width/2;
  float y;
  y=height/2;
  if (tYSize>=450)
  {
    tYSize=450;
  }
  gCSize+=4;
  if (gCSize>=750)
  {
    gCSize=750;
    if (logoTimer>0)
    {
      logoTimer--;
    }
    if (logoTimer==0)
    {
      logoTimer=0;
    }
    if (logoTimer==0)
    {
      tYSize+=4;
    }
  }
  for (int i=0; i<stars.length; i++)
  {    
    stars[i].fall();
    stars[i].display();
  }
  if (firework.size()>0)
  {
    for (Particle fire : firework)
    {
      fire.display();
      fire.fall();
    }
  }
  if (fireworkTimer>0)
  {
    fireworkTimer--;
  }
  if (fireworkDeleteTimer>0)
  {
    fireworkDeleteTimer--;
  }
  if (fireworkTimer==0)
  {
    numPart=(int)random(20, 50);
    float xPos=random(width);
    float yPos=random(height);
    for (int i=0; i<numPart; i++)
    {
      firework.add(new Particle(xPos, yPos));
    }

    fireworkTimer=20;
    //fireworkDeleteTimer=10;
  }
  if (firework.size()>150)
  {
    for (int i=0; i<firework.size(); i++)
    {
      firework.remove(0);
    }
    fireworkTimer=5;
  }
  tint(255);
  fill(255);
  imageMode(CENTER);
  image(gameClear, x, y, gCSize, gCSize/2);
  image(congrats, x, y+150, tYSize, tYSize/3);
  if (tYSize>=450)
  {
    if (tint!=255)
    {
      tint+=1;
    }
    fill(0, 0, 0, tint);
    rect(0, 0, width, height);
  }
  //textSize(40);
  //fill(255);
  //text(switchTimer/60, 100, 100);
  if (switchTimer>=0)
  {
    switchTimer++;
  }
  if ((switchTimer/60)==12)
  {
    gamestate="endTransition";
  }
}
void drawBossAnimation()
{
  moveX+=moveSpeed;
  moveY+=moveSpeed;
  moveY2+=-moveSpeed;
  moveX2+=-moveSpeed;
  ////////////////////////////////////////////////////////
  float planetSpeed=.25;
  pushMatrix();
  hint(DISABLE_DEPTH_MASK);
  background(0);
  imageMode(CORNER);
  //image(lostInSpaceBackground, 0, 0, width, height);
  hint(ENABLE_DEPTH_MASK);

  pushMatrix();
  planetY+=planetSpeed;
  translate(width/2, height/2, -300);  //Position of the Planet
  if (planetY>height+150)
  {
    planetY=random(-100, -50);
    planetX=random(100, width-100);
  }
  pushMatrix();
  rotateY(PI * frameCount / 16500);//Speed of the rotation of the Planet
  rotateX(radians(20));
  shape(num3Planet);
  popMatrix();

  rotateY(PI * frameCount / 300);
  translate(0, 0, 300);
  popMatrix();
  translate(0.75 * width, 0.6 * height, 50);
  popMatrix();
  tint(255);
  ////////////////////////////////////////////////////////////////////////////////////

  if (flash==0)
  {
    image(Lvl1_boss, width/2, moveY, 100, 100);
    image(Lvl2_boss, moveX2, height/2, 100, 100);
    image(Reaper2, width/2, moveY2, 100, 100);
    image(DeathSeeker, moveX, height/2, 100, 100);
  }

  if (moveX==width/2||moveX2==width/2||moveY==height/2||moveY2==height/2)
  {
    moveSpeed=0;
    flash=255;
    gamestate="gameplay";
  }
}
void boom()
{
  for (int i=0; i<booms.size(); i++)
  {
    booms.get(i).update();
  }
  for (Boom b : booms)
  {
    b.render();
  }
  for (int i=0; i<booms.size(); i++)
  {
    if (booms.get(i).getSize()==0)
    {
      booms.remove(i);
    }
  }
  noStroke();
}
void playSound(String filename)
{
  sfx.add(audio.loadFile(filename, 2048));
}
void DAMAGE()
{
  DAMAGE=PLAYER_SHOT_DAMAGE;
  DAMAGE=playerMissleDamage;
}
void playMusic(String filename)
{
  if (music != null) music.close();    
  music = audio.loadFile(filename, 2048); 
  music.play();                    
  music.loop();
}
void gameMusic()
{
  if (numWorld==1&&(!(gamestate=="gameClear"))&&(!(gamestate=="title")))
  {
    playMusic("gameMusic.mp3");
  }
  if (numWorld==2&&(!(gamestate=="gameClear")))
  {
    playMusic("Come_and_Find_Me-Eric_Skiff.mp3");
  }
  if (Level==4&&numWorld==2&&(!(gamestate=="gameClear")))
  {
    playMusic("Komiku-First_Dance.mp3");
  }
  if (numWorld==3&&(!(gamestate=="gameClear")))
  {
    playMusic("Super Meat Boy The Battle of Lil Slugger.mp3");
  }
  if (gamestate=="title")
  {
    playMusic("Chibi_Ninja-Eric_Skiff.mp3");
  }
  if (gamestate=="gameClear")
  {
    playMusic("UpInMyJam.mp3");
  }
  if (gamestate=="spaceTravel")
  {
    playMusic("Chibi_Ninja-Eric_Skiff.mp3");
  }
}
void drawGameplay()
{
  if (numWorld==2)
  {
    pushMatrix();
    hint(DISABLE_DEPTH_MASK);
    imageMode(CORNER);
    image(lostInSpaceBackground, 0, 0, width, height);
    hint(ENABLE_DEPTH_MASK);

    pushMatrix();
    translate(width/2+150, height/2-500, -300);  //Position of the Planet

    pushMatrix();
    rotateY(PI * frameCount / 3500);//Speed of the rotation of the Planet
    rotateX(radians(20));
    shape(sun);
    popMatrix();

    rotateY(PI * frameCount / 300);
    translate(0, 0, 300);
    popMatrix();
    translate(0.75 * width, 0.6 * height, 50);
    popMatrix();
    tint(255);
  } else if (numWorld==3)
  {
    float planetSpeed=.25;
    pushMatrix();
    hint(DISABLE_DEPTH_MASK);
    background(0);
    imageMode(CORNER);
    //image(lostInSpaceBackground, 0, 0, width, height);
    hint(ENABLE_DEPTH_MASK);

    pushMatrix();
    planetY+=planetSpeed;
    translate(width/2, height/2, -300);  //Position of the Planet
    if (planetY>height+150)
    {
      planetY=random(-100, -50);
      planetX=random(100, width-100);
    }
    pushMatrix();
    rotateY(PI * frameCount / 16500);//Speed of the rotation of the Planet
    rotateX(radians(20));
    shape(num3Planet);
    popMatrix();

    rotateY(PI * frameCount / 300);
    translate(0, 0, 300);
    popMatrix();
    translate(0.75 * width, 0.6 * height, 50);
    popMatrix();
    tint(255);
  } else
  {
    background(0);//replaced it from being in the render method in the GameEngineBase to have the player and enemies show infront of the stars
  }
  if (numWorld==1)
  {
    for (int i=0; i<stars.length; i++)
    {    
      stars[i].fall();
      stars[i].display();
    }
  }
  render();
  update();
  advanceLevel();
  if (multiplayer==true)
  {
    if ((getKey('r')||getKey('R'))&&gamestate=="gameplay")
    {
      playMusic("Elevator_Music.mp3");
      gamestate="pause";
    }
    if ((getKey('p')||getKey('P'))&&gamestate=="gameplay")
    {
      playMusic("Elevator_Music.mp3");
      gamestate="pause2";
    }
  } else
  {
    if ((getKey('p')||getKey('P'))&&gamestate=="gameplay")
    {
      playMusic("Elevator_Music.mp3");
      gamestate="pause";
    }
  }
  if (Level==6)
  {
    advanceWorld();
  }
}
void drawTitle()
{
  if (gamestate=="title")
  {
    if (tCounter>0)
    {
      tCounter2=72;
      tCounter--;
    }
    imageMode(CENTER);
    image(titleBackground, width/2, height/2, width, height);
    image(title, width/2, height/2-300, width+50, 300);
    image(subtitle, width/2, height/2-200, 1000, 150);
    if (tCounter==0)
    {
      image(titleinstruction, width/2, height-50, width-920, 100);
      if (tCounter2>0)
      {
        tCounter2--;
      }
      if (tCounter2==0)
      {
        tCounter=72;
      }
    }
    if (fade&&fadeTint==255)
    {
      gamestate="InfoScreen";
      unfade=true;
      fade=false;
    }
    if (fade)
    {
      if (fadeTint!=255)
      {
        fadeTint+=5;
      }
      fill(0, 0, 0, fadeTint);
      noStroke();
      rect(0, 0, width, height);
    }
    imageMode(CORNER);//So it doesn't interfear with the other objects and images
    if (keyPressed)
    {
      fade=true;
    }
  }
}
void drawPlanetTransition()
{
  float sTx=0;
  float sTy=0;
  STC+=5;
  planetSize+=1;
  if (sTS%10==0)
  {
    transitionPlanet.scale(1.005);
  }
  if (sTS>0)
  {
    sTS-=5;
  }
  if (sTS<3640)
  {
    sTS-=50;
  }
  tStar[] tstars= new tStar[400];
  for (int i=0; i< tstars.length; i++)
  {
    tstars[i] = new tStar();
  }
  //////////////////////////////////////////////    
  float x2=width/2;
  float y2=height/2;
  sTSpeed=20;//map(mouseX,0,width,0,20);
  //background(0);
  ///////////////////////////////////////////////////////Planet\\\\\\\\\\\\\\\\\\\\\\\\\
  float planetSpeed=.25;
  pushMatrix();
  hint(DISABLE_DEPTH_MASK);
  background(0);
  imageMode(CORNER);
  //image(lostInSpaceBackground, 0, 0, width, height);
  hint(ENABLE_DEPTH_MASK);

  pushMatrix();
  planetY+=planetSpeed;
  translate(width/2, height/2, -300);  //Position of the Planet
  if (planetY>height+150)
  {
    planetY=random(-100, -50);
    planetX=random(100, width-100);
  }
  pushMatrix();
  rotateY(PI * frameCount / 1650);//Speed of the rotation of the Planet
  rotateX(radians(20));
  shape(transitionPlanet);
  popMatrix();

  rotateY(PI * frameCount / 300);
  translate(0, 0, 300);
  popMatrix();
  translate(0.75 * width, 0.6 * height, 50);
  popMatrix();
  tint(255);







  ///////////////////////////////////////////////////////////////////////////////////////
  translate(x2, y2);
  for (int i=0; i< tstars.length; i++)
  {
    tstars[i].update();
    tstars[i].show();
  }
  if (sTS>0)
  {
    imageMode(CENTER);
    image(backShip, sTx, sTy, sTS, sTS);
    //image(WORLDCLEAR,width/2,height-200,1000,1000);
  }
  //fill(255,0,0);
  //textSize(80);                                ///DEBUG\\
  //text(numWorld,100,50);
  //text(Level,100,150);
}
void drawSpaceTravel()
{
  if (gamestate=="spaceTravel"||gamestate=="spaceTransition"||gamestate=="gameClear")
  {
    float sTx=0;
    float sTy=0;
    STC+=5;
    if (sTS>0)
    {
      sTS-=5;
    }
    if (sTS<3640)
    {
      sTS-=50;
    }
    tStar[] tstars= new tStar[400];
    for (int i=0; i< tstars.length; i++)
    {
      tstars[i] = new tStar();
    }
    //////////////////////////////////////////////    
    float x2=width/2;
    float y2=height/2;
    sTSpeed=20;//map(mouseX,0,width,0,20);
    background(0);
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(STC));
    imageMode(CENTER);
    image(travelBackground, 0, 0, 800, 900);
    imageMode(CORNER);
    popMatrix();
    translate(x2, y2);
    for (int i=0; i< tstars.length; i++)
    {
      tstars[i].update();
      tstars[i].show();
    }
    if (sTS>0)
    {
      imageMode(CENTER);
      image(backShip, sTx, sTy, sTS, sTS);
      //image(WORLDCLEAR,width/2,height-200,1000,1000);
    }
    //fill(255, 0, 0);
    //textSize(80);                                ///DEBUG\\
    //text(numWorld, 100, 50);
    //text(Level, 100, 150);
  }
}
void drawPause()
{
  if ((keyCode==8)&&(gamestate=="pause"||gamestate=="pause2"))
  {
    if (survivalMode==false)
    {
      gamestate="gameplay";
    } else
    {
      gamestate="survival";
    }
    gameMusic();
    pTimer=20;
    noCursor();
  }
  buyUpgrades();
}
void buyUpgrades()
{//ADD A TIMER FOR PURCHASING UPGRADES
  if (gamestate=="pause2")
  {
    if (getKey('1')&&cNumCredits>=fireRateCost&&fireRateLock2==true)
    {
      fireRateLock2=false;
      if (shopTimer==0)
      {
        cNumCredits-=fireRateCost;
        shopTimer=10;
      }
    }
    if (getKey('2')&&numCredits>=quadShotCost&&QuadLock2==true)
    {
      QuadLock2=false;
      if (shopTimer==0)
      {
        cNumCredits-=quadShotCost;
        shopTimer=10;
      }
    }
    if (getKey('4')&&cNumCredits>=damageCost&&damageLock2==true)
    {
      damageLock2=false;
      if (shopTimer==0)
      {
        cNumCredits-=damageCost;
        shopTimer=10;
      }
    }
    if (getKey('3')&&cNumCredits>=homingCost&&homingLock2==true)
    {
      homingLock2=false;
      if (shopTimer==0)
      {
        cNumCredits-=homingCost;
        shopTimer=10;
      }
    }
    if (getKey('5')&&cNumCredits>=shieldsCost&&shieldLock2==true)
    {
      shieldLock2=false;
      if (shopTimer==0)
      {
        cNumCredits-=shieldsCost;
        shopTimer=10;
      }
    }
    if (getKey('6')&&regenState2==1&&cNumCredits>=shieldRegenCost&&shieldRegenLock2==true)
    {
      shieldRegenLock2=false;
      regenState2=2;
      if (shopTimer==0)
      {
        cNumCredits-=shieldRegenCost;
        shopTimer=10;
      }
      shopTimer=20;
    }
    if (getKey('6')&&regenState2==2&&shieldRegenLock2==false&&shopTimer==0&&cNumCredits>=shieldRegen2Cost&&shieldRegen2Lock2==true)
    {
      shieldRegen2Lock2=false;
      regenState2=3;
      if (shopTimer==0)
      {
        cNumCredits-=shieldRegen2Cost;
        shopTimer=10;
      }
    }
    if (getKey('7')&&cNumCredits>=companionCost&&companionLock2==true)
    {
      companionLock2=false;
      if (shopTimer==0)
      {
        cNumCredits-=companionCost;
        shopTimer=10;
      }
    }
  } else if (gamestate=="pause")
  {
    if (getKey('1')&&numCredits>=fireRateCost&&fireRateLock==true)
    {
      fireRateLock=false;
      if (shopTimer==0)
      {
        numCredits-=fireRateCost;
        shopTimer=10;
      }
    }
    if (getKey('2')&&numCredits>=quadShotCost&&QuadLock==true)
    {
      QuadLock=false;
      if (shopTimer==0)
      {
        numCredits-=quadShotCost;
        shopTimer=10;
      }
    }
    if (getKey('4')&&numCredits>=damageCost&&damageLock==true)
    {
      damageLock=false;
      if (shopTimer==0)
      {
        numCredits-=damageCost;
        shopTimer=10;
      }
    }
    if (getKey('3')&&numCredits>=homingCost&&homingLock==true)
    {
      homingLock=false;
      if (shopTimer==0)
      {
        numCredits-=homingCost;
        shopTimer=10;
      }
    }
    if (getKey('5')&&numCredits>=shieldsCost&&shieldLock==true)
    {
      shieldLock=false;
      if (shopTimer==0)
      {
        numCredits-=shieldsCost;
        shopTimer=10;
      }
    }
    if (getKey('6')&&regenState==1&&numCredits>=shieldRegenCost&&shieldRegenLock==true)
    {
      shieldRegenLock=false;
      regenState=2;
      if (shopTimer==0)
      {
        numCredits-=shieldRegenCost;
        shopTimer=10;
      }
      shopTimer=20;
    }
    if (getKey('6')&&regenState==2&&shieldRegenLock==false&&shopTimer==0&&numCredits>=shieldRegen2Cost&&shieldRegen2Lock==true)
    {
      shieldRegen2Lock=false;
      regenState=3;
      if (shopTimer==0)
      {
        numCredits-=shieldRegen2Cost;
        shopTimer=10;
      }
    }
    if (getKey('7')&&numCredits>=companionCost&&companionLock==true)
    {
      companionLock=false;
      if (shopTimer==0)
      {
        numCredits-=companionCost;
        shopTimer=10;
      }
    }
  }
}
void drawInfoScreen2()
{
  if (gamestate=="InfoScreen2")
  {
    if (tCounter>0)
    {
      tCounter2=72;
      tCounter--;
    }
    imageMode(CENTER);
    image(InfoBackground, width/2, height/2, width, height);
    InfoSet();
    textFont(font);
    fill(237, 215, 7);
    textAlign(CENTER);
    textSize(70);
    text(Information, width/2, 50);
    ////////////////////////////////////////////
    background(0);
    fill(255, 0, 0, 28);
    rect(0, 0, width, height);
    for (int i=0; i<stars.length; i++)
    {    
      stars[i].fall();
      stars[i].display();
    }
    ////////////////////////////////////////////////
    image(survivalSingleOption, width/2, height/2, width-920, 100);
    image(survivalMultiOption, width/2, height/2+60, width-920, 100);
    if (tCounter==0)
    {
      image(survivalSingleOption, width/2, height/2, width-920, 100);
      image(survivalMultiOption, width/2, height/2+60, width-920, 100);
      if (tCounter2>0)
      {
        tCounter2--;
      }
      if (tCounter2==0)
      {
        tCounter=72;
      }
    }
    imageMode(CORNER);
    textAlign(CORNER);
  }
  if (unfade&&fadeTintState==1)
  {
    if (fadeTint!=0)
    {
      fadeTint-=5;
    }
    fill(0, 0, 0, fadeTint);
    rect(0, 0, width, height);
    if (fadeTint==0)
    {
      unfade=false;
    }
  }
  if (fade&&fadeTintState==2)
  {
    if (fadeTint!=255)
    {
      fadeTint+=5;
    }
    fill(0, 0, 0, fadeTint);
    noStroke();
    rect(0, 0, width, height);
    if (fadeTint==255)
    {
      fade=false;
      infoState=3;
    }
  }
}
void drawInfoScreen()
{
  ////game states for multiplayer and single player then have it so that it give you the option to start the game

  if (gamestate=="InfoScreen")
  {
    if (tCounter>0)
    {
      tCounter2=72;
      tCounter--;
    }
    imageMode(CENTER);
    image(InfoBackground, width/2, height/2, width, height);
    InfoSet();
    textFont(font);
    fill(237, 215, 7);
    textAlign(CENTER);
    textSize(70);
    text(Information, width/2, 50);
    ////////////////////////////////////////////
    background(0);
    for (int i=0; i<stars.length; i++)
    {    
      stars[i].fall();
      stars[i].display();
    }
    ////////////////////////////////////////////////
    fill(45, 152, 237, 128);
    rect(0, height/2-150, width, 260);
    image(mainGame, width/2, height/2-100, width-820, 50);
    image(singleOption, width/2, height/2, width-920, 100);
    image(multiOption, width/2, height/2+60, width-920, 100);
    image(survivalOption, width/2, height-100, width-750, 110);
    if (tCounter==0)
    {
      image(singleOption, width/2, height/2, width-920, 100);
      image(multiOption, width/2, height/2+60, width-920, 100);
      image(survivalOption, width/2, height-100, width-750, 110);
      if (tCounter2>0)
      {
        tCounter2--;
      }
      if (tCounter2==0)
      {
        tCounter=72;
      }
    }
    imageMode(CORNER);
    textAlign(CORNER);
  }
  if (unfade&&fadeTintState==0)
  {
    if (fadeTint!=0)
    {
      fadeTint-=5;
    }
    fill(0, 0, 0, fadeTint);
    rect(0, 0, width, height);
    if (fadeTint==0)
    {
      unfade=false;
    }
  }
  if (fade&&fadeTintState==1)
  {
    if (fadeTint!=255)
    {
      fadeTint+=5;
    }
    fill(0, 0, 0, fadeTint);
    noStroke();
    rect(0, 0, width, height);
    if (fadeTint==255)
    {
      fade=false;
      infoState=3;
    }
  }
}
void InfoSet()
{ 
  Information= "Use WASD to control your ship \n and press spacebar to shoot"+"\n Press P to pause and backspace to unpause";
}
void drawGameOver()
{
  if (multiplayer==false)
  {
    if (playerGameState=="gameOver")
    {
      drawGameplay();
      if (gamestate=="survival")
      {
        background(0);
      }
      imageMode(CENTER);
      image(GameOver, width/2, height/2);
      if (gamestate=="survival")
      {
        image(LEVEL, width/2-100, height/2+100, 400, 200);
        fill(255);
        textSize(100);
        text(Level, width/2+90, height/2+130);
      }
      imageMode(CORNER);
    }
  } else
  {
    if (playerGameState=="gameOver"&&companionGameState=="gameOver")
    {
      drawGameplay();
      if (gamestate=="survival")
      {
        background(0);
      }
      imageMode(CENTER);
      image(GameOver, width/2, height/2);
      if (gamestate=="survival")
      {
        image(LEVEL, width/2-100, height/2+100, 400, 200);
        fill(255);
        textSize(100);
        text(Level, width/2+90, height/2+130);
      }
      imageMode(CORNER);
    }
  }
}
void addCredits(int amount)
{
  numCredits+=amount;
}
float getCredits()
{
  return numCredits;
}
void advanceWorld()
{
  if (worldIsClear())
  {
    numWorld+=1;
    Level=0;
    if (!(Level==0&&numWorld==3))
    {
      gamestate="spaceTransition";
    }
    if (Level==0&&numWorld==3)
    {
      gamestate="planetTransition";
    }
    if (Level==0&&numWorld==4)
    {
      gamestate="spaceTransition";
    }
  }
}
void advanceLevel()
{
  if (survivalMode==false)
  {
    if (stageIsClear())
    {    
      int timer=50;
      int timer2=50;
      Level+=1;
      for (int i=0; i<2; i++)
      {

        if (timer>0)
        {
          timer2=50;
          timer--;
        }
        if (timer==0)
        {
          if (timer2>0)
          {
            //numLives+=1;
            timer2--;
          }
          if (timer2==0)
          {
            timer=50;
          }
        }
      }
      numLives+=1;
      if (multiplayer==true)
      {
        cNumLives+=1;
      }
      spawnEnemies();
    }
  } else
  {
    if (stageIsClear())
    {    
      int timer=50;
      int timer2=50;
      Level+=1;
      for (int i=0; i<2; i++)
      {

        if (timer>0)
        {
          timer2=50;
          timer--;
        }
        if (timer==0)
        {
          if (timer2>0)
          {
            //numLives+=1;
            timer2--;
          }
          if (timer2==0)
          {
            timer=50;
          }
        }
      }
      if (Level%10==0)
      {
        numLives+=5;
        if (multiplayer==true)
        {
          cNumLives+=5;
        }
      }
      if (Level%5==0)
      {
        enemyRandomMax+=1;
      }
      if (Level>20)
      {
        enemyRollMax=10;
      }
      if (Level>25)
      {
        enemyRollMax=11;
      }
      if (Level>35)
      {
        bossRandomAmount=2;
      }
      if (Level%3==0)
      {
        enemyRollSpawn+=1;
      }
      for (int i=0; i<enemyRollSpawn; i++)
      {
        spawnRandomEnemies();
      }
    }
  }
}
boolean worldIsClear()
{
  if (stageIsClear()&&Level==6)
  {
    return true;
  }
  return false;
}
boolean stageIsClear()
{
  for (GameObject o : objects)  //loops through all objects                                          
  {
    //Enemies.size();
    //objects.size();
    if (o instanceof Enemy)  // and if an enemy object is in the array list, it returns false. Otherwise it returns true
    {
      return false;
    }
  }
  return true;
}
//****************************EDIT LEVELS HERE&& Put MUSIC HERE*****************************\\
void spawnRandomEnemies()
{
  enemyRoll=(int)random(enemyRollMax);
  enemyRandomAmount=(int)random(0, enemyRandomMax);
  if (enemyRoll==0)
  {
    spawnStriker(enemyRandomAmount);
  }
  if (enemyRoll==1)
  {
    spawnKamikazi(enemyRandomAmount);
  }
  if (enemyRoll==2)
  {
    spawnPhaser(enemyRandomAmount);
  }
  if (enemyRoll==3)
  {
    spawnLeacher(enemyRandomAmount);
  }
  if (enemyRoll==4)
  {
    spawnDeathSeeker(enemyRandomAmount);
  }
  if (enemyRoll==5)
  {
    spawnReaper(enemyRandomAmount);
  }
  if (enemyRoll==6&&Level>10)
  {
    spawnLvl3_Ghast(enemyRandomAmount);
  } else if (enemyRoll==8)
  {
    spawnRandomEnemies();
  }
  if (enemyRoll==7&&Level>10)
  {
    spawnLvl3_fireCharger(enemyRandomAmount);
  } else if (enemyRoll==8)
  {
    spawnRandomEnemies();
  }
  if (enemyRoll==8&&Level>10)
  {
    spawnLvl3_PyroSkull(enemyRandomAmount);
  } else if (enemyRoll==8)
  {
    spawnRandomEnemies();
  }
  if (enemyRoll==9)
  {
    spawnLvl1_boss(bossRandomAmount);
  }
  if (enemyRoll==10)
  {
    spawnUltaBoss(bossRandomAmount);
  }
}
void spawnEnemies()
{

  if (Level==1&&numWorld==1)
  {
    spawnStriker(1);
    //spawnLvl1_boss(1);
  }
  if (Level==2&&numWorld==1)
  {
    spawnStriker(4);
    spawnPhaser(4);
  }
  if (Level==3&&numWorld==1)
  {
    spawnStriker(4);
    spawnPhaser(5);
    spawnLeacher(2);
  }
  if (Level==4&&numWorld==1)
  {
    spawnStriker(4);
    spawnPhaser(5);
    spawnLeacher(2);
    spawnDeathSeeker(3);
  }
  if (Level==5&&numWorld==1)
  {
    spawnLvl1_boss(1); //SCALE THE BOSS DOWN!!!!!
    //spawnStriker(1);
  }
  /////////////World 2\\\\\\\\\\\\\\\\\\\\\\\\\\
  if (Level==1&&numWorld==2)
  {
    spawnReaper(4);
    spawnStriker(5);
  }
  if (Level==2&&numWorld==2)
  {
    spawnStriker(1);
    spawnReaper(4);
    spawnKamikazi(3);
  }
  if (Level==3&&numWorld==2)
  {
    spawnStriker(1);
    spawnReaper(4);
    spawnKamikazi(3);
    spawnDeathSeeker(3);
    spawnPhaser(4);
  }
  if (Level==4&&numWorld==2)
  {
    gameMusic();
    gameMode="SideScroller";
    spawnLvl2_boss(1);
    //spawnStriker(1);
  }
  ///////////////////////World 3\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  if (Level==1&&numWorld==3)
  {
    gameMode="TopDown";
    spawnLvl3_Ghast(5);
  }
  if (Level==2&&numWorld==3)
  {
    spawnLvl3_Ghast(3);
    spawnLvl3_PyroSkull(5);
  }
  if (Level==3&&numWorld==3)
  {
    spawnLvl3_fireCharger(3);
    spawnLvl3_Ghast(3);
  }
  if (Level==4&&numWorld==3)
  {
    gamestate="bossAnimation";
  }
  if (Level==5&&numWorld==3)
  {
    spawnUltaBoss(1);
    //spawnStriker(1);
  }
}
//***************************Add new enemies here********************************\\
//World 1
void spawnStriker(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl1_Striker(random(150, width-150), random(0, 10)));
  }
}
void spawnPhaser(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl1_Phaser(random(150, width-150), random(100, 150)));
  }
}
void spawnLeacher(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl1_Leacher(random(-500, -5), random(100, height-450)));
  }
}
void spawnDeathSeeker(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl1_DeathSeeker(random(-500, -5), random(500, height-450)));
  }
}
void spawnLvl1_boss(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl1_boss(random(30, width-150), 0));
  }
}
// World 2
void spawnReaper(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl2_Reaper(random(150, width-150), random(0, 10)));
  }
}
void spawnKamikazi(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl2_Kamikazi(random(150, width-150), random(0, 10)));
  }
}
void spawnLvl2_boss(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new lvl2boss(width-200, height/2));
  }
}
// World 3
void spawnLvl3_Ghast(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl3_Ghast(random(150, width-200), random(-150, -50)));
  }
}
void spawnLvl3_PyroSkull(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl3_PyroSkull(random(150, width-200), random(0, 50)));
  }
}
void spawnLvl3_fireCharger(int amount)
{
  for (int x = 0; x< amount; x++)                                            
  {
    objects.add(new Lvl3_fireCharger(random(150, width-200), random(0, 50)));
  }
}
void spawnUltaBoss(int amount)
{
  float x;
  float y;
  for (int i = 0; i< amount; i++)                                            
  {
    x=random(50, width-50);
    y=50;
    objects.add(new ultaBossBody(x, y+80));
    objects.add(new UltaBossHead(x, y));
  }
}









//*******************************************************************************\\
void update()
{
  act();
  collisions();
  cleanUp();
  ////////////////////////Multiplayer\\\\\\\\\\\\\\\\\\\
  //for (Companion c : multiComp)
  //{
  //  c.display();
  //  c.act();

  //}
}

void collisions()
{
  for (GameObject one : objects)
  {
    for (GameObject two : objects)
    {
      if (one.isCollision(two))
      {
        one.addCollision(two);
        two.addCollision(one);
      }
    }
  }
}
void act()
{
  for (int x = 0; x < objects.size (); x++)
  {
    objects.get(x).act();
  }
}

void cleanUp()
{
  for (int x = 0; x < objects.size (); x++)
  {
    objects.get(x).cleanUp();
  }
}

void render()
{
  //background(0);

  for (int x = 0; x < objects.size (); x++)
  {
    objects.get(x).render();
  }
}
Player getPlayer()
{
  for (GameObject o : objects)
  {
    if (o instanceof Player)
    {
      return (Player) o;
    }
  }
  return null;
}



/***** Malafarina Utility Methods *******\
 
 Supporting code to make processing work better for games
 - Key Press System that handles multiple rapid / concurrent presses better
 
 You do not need to modify or understand this code.
 
 \****************************************/

ArrayList<Character> keysPressed;

void gameSetup()
{
  keysPressed = new ArrayList<Character>();
}

public boolean getKey(char k)
{
  for (char c : keysPressed)
  {
    if (c == k)
    {
      return true;
    }
  }
  return false;
}

public void keyPressed()
{
  for (int x = 0; x < keysPressed.size (); x++)
  {
    if (keysPressed.get(x) == key)
    {
      return;
    }
  }
  keysPressed.add(key);
}

public void keyReleased()
{
  for (int x = 0; x < keysPressed.size (); x++)
  {
    if (keysPressed.get(x) == key)
    {
      keysPressed.remove(x);
    }
  }
}
