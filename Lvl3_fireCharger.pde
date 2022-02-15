class Lvl3_fireCharger extends Lvl1_Enemies
{
  Lvl3_fireCharger(float x, float y)
  {   
    super(x, y);
    //curHealth=50;
    //  maxHealth=50;
    curHealth=950;
    maxHealth=950;
    xSpeed = 3;
    eTimer=150;
    ySpeed = 0;
    image = fireCharger ;
  }
  void act()
  {
    super.act();
    if (y>height)
    {
      x=random(100, width-100);
      y=random(-20, 0);
    }
    if(x>width-80||x<-30)
    {
      xSpeed=-xSpeed;
    }
    if (eTimer==0)
    {
      objects.add(new Charge((x+66), y+110));  //the lasers
      //objects.add(new RedShot(x+105, y+40));


      //if (objects.size()>2)
      //{
      //  for (int i=0; i<10; i++)
      //  {
      //    objects.remove(new RedShot(x+40, y+40));
      //  }
      //}
      eTimer=150;
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
