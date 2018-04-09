# Given a list of N numbers, prints an (N + 1)x(N + 1) multiplication table where
# the first element of each row and the column headers are the list of numbers,
# and each cell within those borders labeled i, j is the multiplication list[i] * list[j].
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
    # Print the values row-by-row. For each row, the first entry will be a prime number that
    # gets multiplied by 1 (due to the formatting of list_to_print), and then for each column we
    # print the product of the row's base prime and the prime number represented in the given column.
    list_to_print.each_index do |row|
      list_of_multiples = list_to_print.map.with_index do |_, column|
        entry = table_entry_for_cell(row, column)
        get_justified_string(entry, column)
      end
      puts list_of_multiples.join(' | ')
    end

    nil
  end

  # The reason that #table_entry_for_cell and #get_justified_string are separate is to allow for
  # testing of the table entries without having to re-parse the formatted string into an integer.
  def table_entry_for_cell(row, column)
    if row == 0 && column == 0
      # Special handling for the top-left character, replacing a '1' entry.
      '-'
    else
      list_to_print[row] * list_to_print[column]
    end
  end

  def get_justified_string(entry, column)
    # Figure out how much space to add for the column based on how much the largest entry needs.
    entry.to_s.rjust(column_widths[column])
  end

  private

  def generate_final_row(list_to_print)
    # This allows us to determine how much space we'll need to print each column from the start.
    largest_number = list_to_print.last
    list_to_print.map { |num| num * largest_number }
  end
end

