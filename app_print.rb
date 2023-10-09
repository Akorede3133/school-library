class Print
  def print_person(persons)
    if persons.length > 0
      persons.each do |person|
        puts "[#{person.class}] Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}"
      end
    else
      puts "List of people is empty"
    end
  end

  def print_books(books)
    if books.length > 0
      books.each do |book|
        puts "Title: \"#{book.title.capitalize}\", Author: #{book.author.capitalize}"
      end
    else
      puts "List of books is empty"
    end
  end

  def print_person_with_index(persons)
    persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def print_books_with_index(books)
    books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title.capitalize}\", Author: #{book.author.capitalize}"
    end
  end

  def print_rental_with_id(persons)
    print 'ID of person: '
    id = gets.chomp.to_i
    person = persons.select { |item| item.id == id }[0]
    puts 'Rentals:'
    if person
      person.rentals.each do |rental|
        puts "Date: #{rental.date}, Book \"#{rental.book.title.capitalize}\" by #{rental.book.author.capitalize}"
      end
    end
  end
end