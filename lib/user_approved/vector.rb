[:forwardable, :enumerator].each {|lib| require lib.to_s }

class Vector
  extend Forwardable
  include Enumerable
  
  def initialize(*args)
    @storage = [*args]
  end

  def_delegator  :@storage, :length, :dimensions
  def_delegators :@storage, :[], :each
  
  class << self
    alias_method :[], :new
  end
  
  # Calculates the Euclidean norm for the vector.
  #
  def magnitude
    map {|e| e ** 2}.inject(0){|s,e| s+e} ** 0.5    
  end
  
  # Calculates the Dot Product of two vectors.
  #
  def dot_product(other)
    assert_equal_dimmensions(other)
    sum_pairwise(other) { |x, ox| x * ox }
  end
  
  # Calculate the cosine of the angle between two given vectors.
  #
  def cosine_similarity(other)
    assert_equal_dimmensions(other)
    product_of_magnitudes = magnitude * other.magnitude
    return 0 if product_of_magnitudes == 0.0
    dot_product(other) / product_of_magnitudes
  end

  # Find the Euclidean distance between the end points of two vectors.
  #
  def euclidean_distance(other)
    assert_equal_dimmensions(other)
    sum_pairwise(other) { |x, ox| (x - ox) ** 2 } ** 0.5
  end
  
  private
  
    def assert_equal_dimmensions(other)
      raise ArgumentError, 'vector are not the same length' unless dimensions == other.dimensions
    end
    
    def sum_pairwise(other)
      [*(0..other.dimensions-1)].inject(0.0) do |sum, i|
        sum + yield(self[i], other[i])
      end
    end
end