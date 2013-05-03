part of model;

class Game {
  
  final num width;
  final num height;
  final num middleX;
  final num middleY;
  
  vec2 _ballVel;
  
  Rectangle _ball;
  Rectangle _racketP1;
  Rectangle _racketP2;
  
  int _p1Movement = 0;
  int _p2Movement = 0;
  
  Game(num width, num height) 
      : this.width = width,
        this.height = height,
        this.middleX = width / 2,
        this.middleY = height / 2 {
    
    _ballVel = new vec2(400.0, 400.0);
    
    _ball = new Rectangle(10, middleY, 8, 8);
    _racketP1 = new Rectangle(108 - 4, middleY - 13, 8, 26);
    _racketP2 = new Rectangle(width - 108 + 4, middleY - 13, 8, 26);
  }
  
  Rectangle get ball => _ball;
  Rectangle get racketP1 => _racketP1;
  Rectangle get racketP2 => _racketP2;

  void update(double dt) {
    if ((_p1Movement == RacketMovement.UP && _racketP1.position.y > 0) || 
        (_p1Movement == RacketMovement.DOWN && _racketP1.position.y + _racketP1.height < height)) {
      _racketP1.position.y += 500 * _p1Movement * dt;
    }
    
    _updateBall(dt);
  }
  
  void _updateBall(double dt) {
    vec2 newPos = _ball.position + _ballVel.scaled(dt);

    if (newPos.y < 0) {
      _ballVel = reflect(_ballVel, new vec2(0.0, 1.0));
    } else if (newPos.x + _ball.width > width) {
      _ballVel = reflect(_ballVel, new vec2(-1.0, 0.0));
    } else if (newPos.y + _ball.height > height) {
      _ballVel = reflect(_ballVel, new vec2(0.0, -1.0));
    } else if (newPos.x < 0) {
      _ballVel = reflect(_ballVel, new vec2(1.0, 0.0));
    } else {
      _ball.position = newPos;
    }
  }

  void setP1Movement(int movement) {
    _p1Movement = movement;
  }
  
  void setP2Movement(int movement) {
    _p2Movement = movement;
  }

}

class RacketMovement {
  static const int UP = -1;
  static const int NONE = 0;
  static const int DOWN = 1;
}

