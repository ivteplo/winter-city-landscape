// Copyright (c) 2021 Ivan Teplov

class Snowflake {
  PVector position;
  PVector speed;
  float alpha;
  
  Snowflake() { init(); }
  
  private void init() {  
    position = new PVector(
      5 * round(random(0, width / 5)),
      5 * round(random(-height, 0))
    );
    
    speed = new PVector(0, 5);
    alpha = random(50, 255);
  }
  
  void draw() {
    fill(255, 255, 255, alpha);
    rect(position.x, position.y, 5, 5);
  }
  
  void update() {
    position.add(speed);
    
    if (this.position.y > height || this.position.x < 0 || this.position.x > width) {
      init();
    }
  }
  
  Snowflake(PVector pos, PVector speed) {
    position = pos;
    this.speed = speed;
  }
}

class House {
  float width = floor(random(50, 150) / 50) * 50;
  float height = floor(random(50, 150) / 50) * 50;
  color[][] windows = new color[round(width / 5) - 3][round(height / 5) - 3];
  
  House() {
    for (int i = 0; i <= round(width / 5) - 4; i += 2) {
      for (int j = 0; j <= round(height / 5) - 4; j += 2) {
        if (round(random(0, 1)) == 1) {
          windows[i][j] = color(247, 219, 167);
        } else {
          windows[i][j] = color(211, 208, 203);
        }
      }
    }
  }
  
  void draw() {
    fill(163, 213, 255);
    stroke(111, 115, 210);
    strokeWeight(5);
    rect(0, -height, width, height);
    
    noStroke();
    
    for (int i = 2; i <= round(width / 5) - 2; i += 2) {
      for (int j = 2; j <= round(height / 5) - 2; j += 2) {
        fill(windows[i - 2][j - 2]);
        rect(i * 5, -5 * j, 5, 5);
      }
    }
  }
}

int SNOWFLAKE_COUNT = 300;
Snowflake[] snowflakes = new Snowflake[SNOWFLAKE_COUNT];

int HOUSE_ROWS = 7;
int HOUSES_IN_ROW = width / 50 + 10;
House[][] houses = new House[HOUSE_ROWS][HOUSES_IN_ROW];

void setup() {
  size(900, 600);
  
  for (int row = 0; row < HOUSE_ROWS; ++row)
    for (int column = 0; column < HOUSES_IN_ROW; ++column)
      houses[row][column] = new House();
      
  for (int i = 0; i < SNOWFLAKE_COUNT; ++i)
    snowflakes[i] = new Snowflake();
}

void draw() {
  background(255);
  noStroke();
  
  int x = width / 2 - HOUSES_IN_ROW * 50;
  int y = height - HOUSE_ROWS * 50 - 20;
  
  fill(110, 136, 152);
  rect(0, y - 20, width, height);
  
  for (int row = HOUSE_ROWS - 1; row >= 0; --row) {
    fill(217, 240, 255, 120);
    rect(0, 0, width, height);
    
    push();
    translate(x, y);
    
    for (House house : houses[row]) {
      house.draw();
      translate(house.width + 20, 0);
    }
    
    pop();
    y += 50;
  }
  
  for (Snowflake snowflake : snowflakes) {
    snowflake.draw();
    snowflake.update();
  }
  
  y -= 30;
  fill(255);
  rect(0, y, width, height);
}
