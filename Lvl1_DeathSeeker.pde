class Lvl1_DeathSeeker extends Lvl1_Enemies
{
  int dSTimer;
  int starter=(int)random(2);
  Lvl1_DeathSeeker(float x, float y)
  {   
    super(x, y);
    //curHealth=100;
    //maxHealth=100;
    if (numWorld==1)
    {
      curHealth=80;
      maxHealth=80;
    } else if (numWorld==2)
    {
      curHealth=140;
      maxHealth=140;
    } else if (numWorld==3)
    {
      curHealth=160;
      maxHealth=160;
    }
    xSpeed = 3;
    if (starter==0)
    {
      ySpeed = 2;
    } else 
    {
      ySpeed=-2;
    }
    image = DeathSeeker ;
  }
  void act()
  {
    super.act();
    for ( int i=0; i<dSTimer; i++)
    {
      dSTimer=30;
    }
    if (dSTimer>0)
    {
      dSTimer--;
    }
    if (x>width)
    {
      x=random(-10, -5);
      y=random(75, height-150);
    }
    if (eTimer==0)
    {
      objects.add(new RedLaser(x+100, y+50));  

      if (objects.size()>2)
      {
        for (int i=0; i<10; i++)
        {
          objects.remove(new RedLaser(x+130, y+55));
        }
      }
      eTimer=50;
    }
    change();
  }
  void change()
  {
    if (y<75||y>height-150)
    {
      ySpeed=-ySpeed;
    }
  }
}
