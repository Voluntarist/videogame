$: << File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'gosu'
require 'player'
require 'ball'



class MyGame < Gosu::Window
  def initialize
    super(900, 900, false)
    self.caption = "Welcome to 1984"
    @player1 = Player.new(self)
    @balls = 5.times.map {Ball.new(self)}
    @running = true
    @font = Gosu::Font.new(self, Gosu::default_font_name, 30)
    @score = 0
    @background_image = Gosu::Image.new(self, "images/bb.png", false)
  end

  def update
    if @running
      @score = @score + 1
      if button_down? Gosu::Button::KbLeft
        @player1.move_left
      end

      if button_down? Gosu::Button::KbRight
        @player1.move_right
      end

      if button_down? Gosu::Button::KbUp
        @player1.move_up
      end

      if button_down? Gosu::Button::KbDown
        @player1.move_down
      end

      @balls.each {|ball| ball.update}

      if @player1.hit_by? @balls
        stop_game!
      end
    else
      #the game is currently stopped
      if button_down? Gosu::Button::KbEscape
        restart_game
        @score = 0
        @dead = false
      end
    end

  def stop_game!
    @running = false
  end

  def draw
    self.caption
    @player1.draw
    @balls.each {|ball| ball.draw}
    @background_image.draw(0, 0, 0)
    @font.draw("Your Score Is: #{@score}", 20, 20, 5)
  end

  def restart_game
    @running = true
    @balls.each {|ball| ball.reset!}
  end
end

window = MyGame.new
window.show
end