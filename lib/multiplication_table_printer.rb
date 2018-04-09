# Given a list of N numbers, prints a multiplication table where the first element
# of each row and the column headers are the list of numbers, and each cell within
# those borders labeled i, j is the multiplication list[i] * list[j].
#
# Example output to STDOUT:
#  - |  2 |  3 |  5
#  2 |  4 |  6 | 10
#  3 |  6 |  9 | 15
#  5 | 10 | 15 | 25
#
class MultiplicationTablePrinter
  attr_reader :number_list, :list_to_print, :column_widths

  def initialize(number_list)
    @number_list = number_list
    # Appending 1 to the beginning of the number list allows for simplification of the
    # iteration code since we are printing each entry as a row and column header.
    # The 1 row/col marker gets replaced with a '-' character.
    @list_to_print = [1] + number_list
    @column_widths = generate_final_row(list_to_print).map { |num| num.to_s.length }
  end

  def print_table
    if number_list.none?
      puts 'No numbers present!'
      return
    end

    # Starting with the first number, fill in each subsequent row by printing the number number
    # and then printing it multiplied by the column header number in each column.
    list_to_print.each_index do |row|
      list_of_multiples = list_to_print.map.with_index do |_, column|
        table_entry_for_cell(row, column)
      end
      puts list_of_multiples.join(' | ')
    end

    nil
  end

  def table_entry_for_cell(row, column)
    if row == 0 && column == 0
      # Special handling for the top-left character, replacing a '1' entry.
      table_entry = '-'
    else
      table_entry = list_to_print[row] * list_to_print[column]
    end
    get_justified_string(table_entry, column)
  end

  def get_justified_string(entry, column)
    # Figure out how much space to add for the column based on how much the largest entry needs
    entry.to_s.rjust(column_widths[column])
  end

  private

  def generate_final_row(list_to_print)
    # This allows us to determine how much space we'll need to print each column. Start with [1]
    # because the first element of each row will be one of the numbers in our number_list.
    largest_number = list_to_print.last
    list_to_print.map { |num| num * largest_number }
  end
end

