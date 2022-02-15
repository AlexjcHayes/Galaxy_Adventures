class Particle
{
  int size=5;
  float particleX;
  float particleY;
  
  float xSpeed=random(-5, 5);
  float ySpeed=random(-5, 5);
  int R=(int)random(255);
  int G=(int)random(255);
  int B=(int)random(255);
  int T=255;
  int timer2=10;
  int roll=(int)random(3);
  Particle(float x, float y)
  {
    this.particleX=x;
    this.particleY=y;
    if (roll==0)
    {
      xSpeed=random(-2, 2);
      ySpeed=random(-2, 2);
    } else if (roll==1)
    {
      xSpeed=random(-5, 5);
      ySpeed=random(-5, 5);
    } else
    {
      xSpeed=random(-9, 9);
      ySpeed=random(-9, 9);
    }
  }
  void display()
  {
    fill(R, G, B, T);
    tint(255, 126);
    ellipse(particleX,particleY, size, size);
    if (T>0)
    {
      T=T-7;
    }
  }
  void fall()
  {

    particleX+=xSpeed;
    particleY+=ySpeed;
    ySpeed+=.5;
  }
}
