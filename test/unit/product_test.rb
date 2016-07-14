require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "product attriutes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?, 'description is invalid'
    assert product.errors[:price].any?, 'price is invalid'
    assert product.errors[:image_url].any?, 'image url is invalid'

  end
end
