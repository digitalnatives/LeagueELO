class EloCalculator

  attr_reader :r1, :r2, :w1, :w2, :m
  K = 40

  def initialize(r1, r2, w1, w2, d=0)
    @r1, @r2, @w1, @w2 = r1.to_f, r2.to_f, w1, w2
    @m =  w1 + w2 + d
  end

  def calculate
    K * (w1 - m * e1)
  end

  private

  def e1
    1.0 / ( 1 + 10 ** ((r2-r1)/400) )
  end

  # def e2
  #   1.0 - e1
  # end
end
