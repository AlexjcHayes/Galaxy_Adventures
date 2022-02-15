class CompanionPower 
{
  int xSpeed=4;
  int ySpeed=4;
  int timer=20;
  float x;
  float y;
  CompanionPower(float x,float y)
  {
    this.x=x;
    this.y=y;    
    if (gameMode=="SideScroller")
    {
      x=20;
      y=random(height);
    } else
    {
      x=(int)random(width); 
      y=height-50;
    }
    ///////////////////////////////////////
    
  }
void render()
{
  if (gameMode=="SideScroller")
    {
      if (damageLock==false)
      {
        image(companionDS,x,y,pSize,pSize);
      } else
      {
        image(companionS,x,y,pSize,pSize);
      }
    } else
    {
      if (damageLock==false)
      {
        image(companionD,x,y,pSize,pSize);
      } else
      {
        image(companion,x,y,pSize,pSize);
      }
    }
}
   void act()
  {
    if (gameMode=="SideScroller")
    {
      y+=ySpeed;
    } else
    {
      x+=xSpeed;
    }
    if (timer>0)
    {
      timer--;
    }
    if (timer==0)
    {
      timer=0;
    }
    if (timer==0)
    {
      objects.add(new PlayerShotBasic(x+24, y+15));
      objects.add(new PlayerShotBasic(x+60, y+20));
      timer=20;
    }

    if (x>width-30||x<0)
    {
      xSpeed=-xSpeed;
    }
    if (y>height-30||y<0)
    {
      ySpeed=-ySpeed;
    }
    /////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////
  }
  
}
