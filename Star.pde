class Star
{
  float x=random(width);
  float y=random(height);
  float z=random(0, 3);
  float s=map(z, 0, 1, 0, 1);//size of the star
  float ySpeed=map(z, 0, 2, 1, 2);
  

  void display()
  {
    fill(255);
    noStroke();
    ellipse(x, y, s, s);
  }
  void fall()
  {
    y= y+ySpeed; 
    if (y>height)
    {
      y=random(-100, -50);
    }
  }
  //void changeSpeed()
  //{
  //  if ((mousePressed)&&(mouseButton==(LEFT)))
  //  {
  //    ySpeed=ySpeed*1.03;
  //  }
  //  if ((mousePressed)&&(mouseButton==(RIGHT)))
  //  {
  //    ySpeed=ySpeed*.97;
  //  }
  //}
  

}
