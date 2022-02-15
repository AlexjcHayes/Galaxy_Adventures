/****************************************************\
 
 Evil Square
 (a subclass of Enemy)
 
 \****************************************************/


class Lvl1_Enemies extends Enemy
{
  int eTimer=50;
  int eTimer2=1;
  Lvl1_Enemies(float x, float y)
  {   
    super(x, y, eSize, eSize);
    this.x=x;
    this.y=y;
    curHealth=100;
    maxHealth=100;
    xSpeed = EVIL_SQUARE_X_SPEED;
    ySpeed = EVIL_SQUARE_Y_SPEED;
    image = Lvl1Enemy1 ;
  }

  public void act()
  {
    super.act();
    // This code causes the enemy to wrap when it goes to the bottom of the screen
    if (y > height+50) //added 50 so it wouldn't interfear with the random x location when wrapping
    {
      y = -image.height;
    }

    // This enemy does not know how to shoot - fix that!

    if (eTimer>0)
    {
      eTimer--;
    }
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size(); x++)
    {
      GameObject o = collisions.get(x);
      // is [variablename] an instance of the class [classname]
      if (o instanceof PlayerShotBasic)
      {
        if (curHealth>0)
        {
          tint(255,0,0);
          image(image,this.x,y,w,h);
          tint(255);
          curHealth-=PLAYER_SHOT_DAMAGE;
        }
        if (curHealth==0||curHealth<0)
        {
          numCredits+=5;
          takeDamage(o.getDamage());
          int size=50;
          float boomSize = size * boomScale;
          for (int i=0; i<5; i++)
          {
            booms.add(new Boom(this.x+50,this.y, boomSize, boomDuration));
          }
          numCredits+=5;
        }
      }
      if (o instanceof playerMissle)
      {
        if (curHealth>0)
        {
          //numLives+=1;
          tint(255,0,0);
          image(image,this.x,y,w,h);
          tint(255);
          curHealth-=playerMissleDamage;
        }
        if (curHealth==0||curHealth<0)
        {
          //numLives+=100; // this works!!!!!!!!! now make it so that the rest of the enemies work off of this template
          takeDamage(o.getDamage());
          int size=50;
          float boomSize = size * boomScale;
          for (int i=0; i<5; i++)
          {
            booms.add(new Boom(this.x+random(-2, 2), this.y+random(-2, 2), boomSize, boomDuration));
          }
          //numLives+=1;
          addCredits(5);
        }
      }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    for (int x = 0; x < collisions.size(); x++)
    {
      GameObject o = collisions.get(x);
      // is [variablename] an instance of the class [classname]
      if (o instanceof CompanionShotBasic)
      {
        if (curHealth>0)
        {
          tint(255,0,0);
          image(image,this.x,y,w,h);
          tint(255);
          curHealth-=PLAYER_SHOT_DAMAGE;
        }
        if (curHealth==0||curHealth<0)
        {
          cNumCredits+=5;
          takeDamage(o.getDamage());
          int size=50;
          float boomSize = size * boomScale;
          for (int i=0; i<5; i++)
          {
            booms.add(new Boom(this.x+50,this.y, boomSize, boomDuration));
          }
          cNumCredits+=5;
        }
      }
      if (o instanceof companionMissle)
      {
        if (curHealth>0)
        {
          //numLives+=1;
          tint(255,0,0);
          image(image,this.x,y,w,h);
          tint(255);
          curHealth-=playerMissleDamage;
        }
        if (curHealth==0||curHealth<0)
        {
          //numLives+=100; // this works!!!!!!!!! now make it so that the rest of the enemies work off of this template
          takeDamage(o.getDamage());
          int size=50;
          float boomSize = size * boomScale;
          for (int i=0; i<5; i++)
          {
            booms.add(new Boom(this.x+random(-2, 2), this.y+random(-2, 2), boomSize, boomDuration));
          }
          //numLives+=1;
          cNumCredits+=5;
        }
      }
    }
  }
}
