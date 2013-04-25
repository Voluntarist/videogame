class Player

  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "images/winston.png", true)
    @x = 150
    @y = 330
    @death = Gosu::Image.new(@game_window, "images/skull.png", true)
    @dead = false
  end

  def draw
    if @dead
      @death.draw(@x, @y, 4)
    else
      @icon.draw(@x, @y, 1)
    end
  end

  def move_left
    if @x < 0
      @x = 0
    else
    @x = @x - 10
    end
  end

  def move_right
    if @x > (@game_window.width - 75)
      @x = @game_window.width - 75
    else
      @x = @x + 10
    end
  end

  def move_up
    if @y < 0
      @y = 0
    else
      @y = @y - 10
    end
  end

  def move_down
    if @y > @game_window.height - 100
      @y = @game_window.height - 100
    else
      @y = @y + 10
    end
  end

  def hit_by?(balls)
    if balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) < 50}
      @dead = true
    else
      @dead = false
    end
  end
end