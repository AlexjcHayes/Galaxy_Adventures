class Lvl1_Phaser extends Lvl1_Enemies
{
  int starter=(int)random(2);
  Lvl1_Phaser(float x, float y)
  {   
    super(x, y);
    //curHealth=80;
    //  maxHealth=80;
    if (numWorld==1)
    {
      curHealth=80;
      maxHealth=80;
    } else if (numWorld==2)
    {
      curHealth=120;
      maxHealth=120;
    } else if (numWorld==3)
    {
      curHealth=160;
      maxHealth=160;
    }
    if (starter==0)
    {
      xSpeed = 5;
    } else
    {
      xSpeed=-5;
    }
    ySpeed = 2;
    image = Phaser ;
  }
  void act()
  {
    super.act();
    if (x>width-5||x<0)
    {
      xSpeed=-xSpeed;
    }
    if (y>height)
    {
      x=random(50, width-50);
      y=random(-20, 0);
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
