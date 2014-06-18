def fizzbuzz(n)
  fizzbuzz(n - 1) if n > 0

  if n % 3 == 0 && n % 5 == 0
    puts 'fizzbuzz'
  elsif n % 3 == 0
    puts 'fizz'
  elsif n % 5 == 0
    puts 'buzz'
  else
    puts n
  end
end


def ex(a, b)
  return a if b == 1
  a * ex(a, b - 1)
end

def
