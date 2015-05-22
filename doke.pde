// direccion hacia donde gira la esfera y los cubos
boolean dir = true; 

// textitos
String telnet_msg = "telnet bbs.docksud.com.ar";
String sentimiento_msg = "::: Dock Sud BBS, Un Sentimiento... :::";

// tipografias
PFont font;
int fsize = 24;
int fsize_sm = 16;
float fsize_kern = fsize/2.0;
float fsize_sm_kern = fsize_sm/2.0;


// posiciones
float p = 5;
float x = width;// = +(sentimiento_msg.length()*fsize_sm)*1.0;
float x_step = 0.666;

// clase de sinescroller
S s;

void setup() {
  // canvas y fps
  size(320, 240, P3D);
  frameRate(60);
  
  // definimos posicion de dibujo y texto
  rectMode(CENTER);
  textAlign (LEFT);

  // definimos tipografia
  font = loadFont("Input-Bold-48.vlw");
  textFont(font,fsize);
  
  // sinescroller
  s = new S(telnet_msg, width, height-(height/4), fsize);
}

void draw() {
  // bg gris oscuro
  background(31);

  //BO TEXT  
  fill(0,255,0);
 
  // scroller de arriba 
  textSize(fsize_sm);
  text(sentimiento_msg, x, fsize_sm);
  
  // sinescroller
  textSize(fsize);
  s.display();
  s.move();
  //EO TEXT

  // BO 3D SHAPES
  // scamos rellenos
  noFill();
  pushMatrix();
  beginCamera();
  
  // camara loca
  camera(p, cos(height)/2, (height/2) / tan(TWO_PI/3), width/2, height/2, 0, 0, p, p); 

  // nos vamos al medio
  translate(width/2, height/2, 0);
  
  // esfera
  stroke(0,225,0,25);
  strokeWeight(1);
  sphere(height/PI);

  // cubo grande
  rotateY((sin(PI)+p/20)*-1);
  stroke(108,150,89);
  strokeWeight(2);
  noFill();
  box(height/4); 
  
  // cubo chico
  rotateY(cos(PI)+p/10);
  stroke(125);
  strokeWeight(1);
  noFill();
  box(height/8);
 
  endCamera(); 
  popMatrix();
  //EO 3D SHAPES
    
  //BO DIRECTION
  if( dir ){ p++; }
  else{ p--; }
  
  // gira para alla hasta que llega al limite y rebota
  if( p == 0 ){ dir = true; }
  else if( p == width ){ dir = false; }
  
  // scroller de arriba hasta que se termina la pantalla y vuelve a empezar
  x-=x_step;
  if(x < ((sentimiento_msg.length()*fsize_sm))*-1.0){ x=width; }
  //EO DIRECTION
   
  //saveFrame("frames/"+frameCount+".png");
  //if(keyPressed){ noLoop(); }
}


class S{
  String str; // text to sin
  float x;
  float y;
  boolean yd = true; // y dir
  float ys = 0.05; // y step
  float ang = 0.0; // angle
  float angs = 0.125; // angle step
  char[] letters; // letters
  float[] yp; // letter y pos
  float p; // pos
  int ts; // typography size
  
  // iniciamos la clase
  S(String sstr, float xx, float yy, int tts){
    str = sstr;
    x = xx;
    y = yy;
    ts = tts;
    
    letters = str.toCharArray(); // "hola" -> ['h','o','l','a'];
    yp = new float[letters.length];
  }
  
  // dibujamos en pantalla a cada letra en su x,y
  void display() {
    fill(0,255,0);
    rectMode(CENTER);
    for(int i=0;i<letters.length;i++){
      text(letters[i], x+((ts*1.0)/1.5)*i, y+yp[i]);
    }
  }
  
  // movemos las letras en 'x' y en 'y'
  void move(){
    
    ang += 0.05;
    p = ang;
    for(int i=0;i<yp.length;i++){
      // esto despues se suma (o resta cuando da negativo) a Y, entonces el efecto sinusoidal
      yp[i] = sin(p)*(ts*2);
      p += angs;
    }
        
    // la posicion horizontal del scroll
    x--;
    if( x+(letters.length*((ts*1.0)/1.5)) <= 0.0 ){ x = width; }
  }
  
}
