require 'pry'
def consolidate_cart(cart)
  # code here
  result = {}
  cart.each do |itemhash| #eg {kale => {:price int, :clearance boolean}
    itemhash.each do |item, infohash|
      if result[item] == nil
        result[item] = {}
        result[item][:count] = 1
      else
        result[item][:count] += 1
      end
      infohash.each do |key, value| #eg. :price => int, :clearance => bool
        result[item][key] = value
      end
    end
  end
  result
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    discountitem = coupon[:item]
    if cart[discountitem] == nil || cart[discountitem][:count] < coupon[:num]
      cart
    else
      newkey = "#{discountitem} W/COUPON"
      cart[newkey] = {count: 0, clearance: cart[discountitem][:clearance], price: coupon[:cost]}
      discountcount = coupon[:num]
      discounted = cart[discountitem][:count]/discountcount
      leftover = cart[discountitem][:count]%discountcount
      cart[discountitem][:count] = leftover
      cart[newkey][:count] = discounted if discounted != 0
    end
  end
  cart
end


def apply_clearance(cart)
  # code here
  cart.each do |item, infohash|
    if infohash[:clearance] == true
      infohash[:price] -= infohash[:price]*0.2
    end
  end
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total = 0
  cart.each do |key, valuehash|
    total += (valuehash[:price]*valuehash[:count])
  end

  if total > 100
    total -= total*0.1
  end
  total
end
