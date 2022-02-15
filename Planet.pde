
class num3Planets
{
  float x;
  float y;
  int size;
  int planetRoll;
  int ySpeed=1;
  num3Planets(float x, float y)
  {
    this.x=x;
    this.y=y;
    //planetRoll=(int)random(
  }
  void render()
  {
    image(planetFour, x, y, 30, 30);
  }
  void update()
  {
    y+=ySpeed;
    if (y>height+30)
    {

      y=-50;
      x=random(15, width-15);
    }
  }
}
