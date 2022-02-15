class Lvl2_Kamikazi extends Lvl1_Enemies
{
  int bombTimer;
  Lvl2_Kamikazi(float x, float y)
  {   
    super(x, y);
    //curHealth=50;
    //  maxHealth=50;
    if (numWorld==1)
    {
      curHealth=50;
      maxHealth=50;
    } else if (numWorld==2)
    {
      curHealth=80;
      maxHealth=80;
    } else if (numWorld==3)
    {
      curHealth=120;
      maxHealth=120;
    }
    xSpeed = 6;
    ySpeed = 2;
    image = Kamikazi ;
    bombTimer=180;
  }
  void act()
  {
    super.act();
    if(bombTimer>0)
    {
      bombTimer--;
    }
    if(bombTimer==0)
    {
      objects.add(new bomb(x, y));
      bombTimer=180;
    }
    
    if (x>width-75||x<-30)
    {
      xSpeed=-xSpeed;
    }
    if (y>height)
    {
      x=random(100, width-100);
      y=random(-20, 0);
    }
    if (eTimer==0)
    {
      objects.add(new RedShot(x+40, y+40));  //the lasers
      objects.add(new RedShot(x+105, y+40));

      if (objects.size()>2)
      {
        for (int i=0; i<10; i++)
        {
          objects.remove(new RedShot(x+40, y+40));
        }
      }
      eTimer=50;
    }
  }

  //public void reactions()
  //{
  //  for (int x = 0; x < collisions.size (); x++)
  //  {
  //    GameObject o = collisions.get(x);

  //    if (o instanceof PlayerProjectile)//|| o instanceof Player)
  //    {
  //      if (curHealth>0)
  //      {
  //        curHealth-=5;
  //      }
  //      if (curHealth==0)
  //      {
  //        takeDamage(o.getDamage());
  //      }
  //    }
  //  }
  //}
}
