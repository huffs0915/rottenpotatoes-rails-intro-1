module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
   def hilite_col(col)
    session[:sorted_session] == col.to_s ? 'hilite' : nil
  end

end
