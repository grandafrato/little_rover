defmodule LittleRover do
  def start() do
    GPIO.set_pin_mode(2, :output)
    GPIO.digital_write(2, :high)
  end
end
