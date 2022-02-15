class UltaBossHead extends Lvl1_Enemies
{
  UltaBossHead(float x, float y)
  {   
    super(x, y);
    this.ultaBossX=x;
    this.ultaBossY=y;
    curHealth=3500;
    maxHealth=3500;
    xSpeed = 3;
    ySpeed = 0;
    eTimer=10;
    eTimer2=4;
    image = ultaBossHead ;
  }
  void act()
  {
    super.act();
    if (eTimer>0)
    {
      eTimer--;
    }
    if (eTimer2>0)
    {
      eTimer2--;
    }
    if (y<0||y>height+10)
    {
      ySpeed=-ySpeed;
    }
    if (x>width+10||x<-10)
    {
      xSpeed=-xSpeed;
    }
    if (eTimer2==0)
    {
      objects.add(new ultaBomb(x+40, y+65));
      if (curHealth<maxHealth/2)
      {
        eTimer2=10;
      } else
      {
        eTimer2=40;
      }
    }
    if (eTimer==0)
    {
      // second timer to add in projectiles
      
      if (curHealth<maxHealth/2)
      {
        eTimer=10;
      } else
      {
        eTimer=100;
      }
    }
    ///////////////////////
    //println(curHealth);
    //println(PLAYER_SHOT_DAMAGE);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ultaBossBody extends Lvl1_Enemies
{
  ultaBossBody(float x, float y)
  {   
    super(x, y);
    this.ultaBossX=x;
    this.ultaBossY=y;
    curHealth=1600;
    maxHealth=1600;
    xSpeed = 3;
    ySpeed = 0;
    eTimer=10;
    eTimer2=4;
    image = ultaBossBody ;
  }
  void act()
  {
    super.act();
    if (eTimer>0)
    {
      eTimer--;
    }
    if (eTimer2>0)
    {
      eTimer2--;
    }
    if (y<0||y>height+10)
    {
      ySpeed=-ySpeed;
    }
    //if (curHealth>=maxHealth/2)
    //{
    if (x>width+10||x<-10)
    {
      xSpeed=-xSpeed;
    }
    // }
    if (eTimer2==0)
    {
      objects.add(new RedShot(x+120, y+85));
      objects.add(new RedShot(x+105, y+40));
      objects.add(new RedShot(x+20, y+85));
      objects.add(new RedShot(x+30, y+40));
      if (multiplayer==false)
      {
        objects.add(new enemyMissleP(x+17, y+40, nearestPlayer((int)x, (int) y)));
        objects.add(new enemyMissleP(x+17, y+40, nearestPlayer((int)x, (int) y)));
      } else
      {
        if (playerGameState!="gameOver")
        {
          objects.add(new enemyMissleP(x+17, y+40, nearestPlayer((int)x, (int) y)));
        }else
        {
          objects.add(new enemyMissleC(x+17, y+40, nearestCompanion((int)x, (int) y)));
        }
        if (companionGameState!="gameOver")
        {
          objects.add(new enemyMissleC(x+135, y+40, nearestCompanion((int)x, (int) y)));
        }else
        {
          objects.add(new enemyMissleP(x+17, y+40, nearestPlayer((int)x, (int) y)));
        }
      }
      if (objects.size()>2)
      {
        for (int i=0; i<10; i++)
        {
          objects.remove(new RedShot(x+105, y+40));
        }
      }
      if (curHealth<maxHealth/2)
      {
        eTimer2=10;
      } else
      {
        eTimer2=40;
      }
    }
    if (eTimer==0)
    {
      objects.add(new plasmaShot(x+40, y+40));


      if (objects.size()>2)
      {
        for (int i=0; i<10; i++)
        {
          objects.remove(new plasmaShot(x+40, y+40));
        }
      }
      if (curHealth<maxHealth/2)
      {
        eTimer=10;
      } else
      {
        eTimer=100;
      }
    }
    ///////////////////////
    //println(curHealth);
    //println(PLAYER_SHOT_DAMAGE);
  }
}
