class Boom
{
  float x;
  float y;
  float size;
  int timer;
  int duration;
  Boom(float x, float y, float size, int duration)
  {
    this.x=x;
    this.y=y;
    this.size=size*random(2);
    this.duration=duration;
    timer=this.duration;
  }
  void render()
  {
    stroke(232,155,12);
    fill(232, 214, 9);
    ellipse(x, y, size, size);
    fill(255);
  }
  void update()
  {
    if (timer>0)
    {
      timer--;
    } 
    if (timer<duration/2)
    {
      die();
    }
    if (timer<1)
    {
      size=0;
    }
  }
  void die()
  {
    if (size>20)
    {
      for (int i=0; i<5; i++)
      {
        booms.add(new Boom(x+random(-2, 2), y+random(-2, 2), size/2+random(-5, 5), duration/2));
      }
    }
    if (size<10)
    {
      size=0;
    }
  }

  public float  getSize()
  {
    return size;
  }
}
