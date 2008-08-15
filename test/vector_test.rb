require 'test/unit'
require 'user_approved/vector'

class VectorTests < Test::Unit::TestCase
  def setup
    @a = Vector[ 1,-1, 2]
    @b = Vector[ 1, 2, 4]
    
    @c = Vector[ 0, 0, 0]
    @d = Vector[ 4, 4, 4]
    
    @e = Vector[ 0, 1]
  end
  
  def test_dimensions
    assert_equal(3, @a.dimensions)
    assert_equal(2, @e.dimensions)
  end
  
  def test_raise_dim_errors
    assert_raise(ArgumentError) { @a.dot_product @e }
    assert_raise(ArgumentError) { @a.cosine_similarity @e }
  end
  
  def test_orthoginal_vectors_cosine_is_0
    assert_in_delta(0.0, @d.cosine_similarity(@c), 0.000001)
  end
  
  def test_cosine_of_equal_vectors
    assert_in_delta(1.0, @d.cosine_similarity(@d), 0.000001)
  end
  
  def test_cosine_similarty
    assert_in_delta(0.623609564462324, @b.cosine_similarity(@a), 0.000001)
  end
  
  def test_dot_product
    assert_equal(7, @a.dot_product(@b))
  end
end


