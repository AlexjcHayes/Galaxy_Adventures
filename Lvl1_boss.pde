class Lvl1_boss extends Lvl1_Enemies
{

  Lvl1_boss(float x, float y)
  {   
    super(x, y);
    curHealth=2600;
    //maxHealth=250;
    xSpeed = 2;
    ySpeed =0 ;
    image = Lvl1_boss ;
    x=x+xSpeed;
  }
  //void render()
  //{
  //  imageMode(CENTER);
  //  image(Lvl1_Boss,x,y,700,700);
  //  imageMode(CORNER);
  //}
  void act()
  {
    super.act();
    //int glideCounter=0;
    x=x+xSpeed;
    if (Btimer>0)
    {
      //Btimer2=520;
      //xSpeed = 5;
      glideCounter=0;
      Btimer--;
    }
    if (Btimer==0)
    {
      Btimer=0;
    }
    if (Btimer==0)
    {
      if (glideCounter!=5)
      {
        //if (x>width-100)
        //{
        //  xSpeed=-xSpeed;
        //}
        //if (x<100)
        //{
        //  xSpeed=-xSpeed;
        //}
        //if (y>height)
        //{
        //  x=random(100, width-100);
        //  y=random(-20, 0);
        //}
        //xSpeed=0;
        ySpeed=8;
        y+=ySpeed;
      }
      //if (Btimer2==0)
      //{
      //  xSpeed=5;
      //  Btimer=500;
      //}
    }
    if (glideCounter==5)
    {

      Btimer=1000;
      ySpeed=0;
    }
    if (eTimer>0)
    {
      eTimer--;
    }
    if (x>width-150)
    {
      xSpeed=-xSpeed;
    }
    if (x<25)
    {
      xSpeed=-xSpeed;
    }
    if (y>height)
    {
      glideCounter+=1;
      x=random(30, width-160);
      y=0;//random(-20, 0);
    }
    if (eTimer==0)
    {
      objects.add(new DragonBreath(x+40, y+60));
      //objects.add(new RedShot(x+35, y+35));
      //objects.add(new RedShot(x+105, y+40));


      //if (objects.size()>2)
      //{
      //  for (int i=0; i<10; i++)
      //  {
      //    objects.remove(new RedShot(x+40, y+40));
      //  }
      //}
      eTimer=50;
    }
  }
}
