data =
%w{ shape		        форма
    quadrilateral	  четырёхугольник
    square		      квадрат
    rectangle	      прямоугольник
    trapezoid	      трапеция
    rhombus		      ромб
    rhomboid	      ромбоид
    parallelogram	  параллелограмм
    trapezium	      трапеция}

  data.each_with_index do |word, index|
    if index % 2 == 1
      Card.create!( original_text: data[index - 1],
                    translated_text: data[index],
                    review_date: Time.now + 3.days)
    end
  end
