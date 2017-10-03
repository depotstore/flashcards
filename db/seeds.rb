data =
    %w[shape		        форма
       quadrilateral	  четырёхугольник
       square		        квадрат
       rectangle	      прямоугольник
       trapezoid	      трапеция
       rhombus		      ромб
       rhomboid	        ромбоид
       parallelogram	  параллелограмм
       trapezium	      трапеция]

  data.each_index do |i|
    if i.odd?
      Card.create!(original_text: data[i - 1],
                   translated_text: data[i],
                   review_date: Time.now + 3.days)
    end
  end
