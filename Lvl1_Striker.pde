class Lvl1_Striker extends Lvl1_Enemies
{
  Lvl1_Striker(float x, float y)
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
    xSpeed = 0;
    ySpeed = 4;
    image = Striker ;
  }
  void act()
  {
    super.act();
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
  //      noStroke();
  //      fill(255, 0, 0, 128);
  //      ellipse(x, y, 150, 150);
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
