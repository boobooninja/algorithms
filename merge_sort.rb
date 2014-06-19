def mergesort(ary)
  return ary if ary.length <= 1

  mid = ary.length / 2
  ary_1 = mergesort( ary[0...mid] )
  ary_2 = mergesort( ary[mid..-1] )

  ary = []
  p1 = 0
  p2 = 0
  while p1 < ary_1.length && p2 < ary_2.length
    num1 = ary_1[p1]
    num2 = ary_2[p2]

    if num1 <= num2
      ary << num1
      p1 += 1
    else
      ary << num2
      p2 += 1
    end
  end

  while p1 < ary_1.length
    ary << ary_1[p1]
    p1 += 1
  end

  while p2 < ary_2.length
    ary << ary_2[p2]
    p2 += 1
  end

  ary
end
