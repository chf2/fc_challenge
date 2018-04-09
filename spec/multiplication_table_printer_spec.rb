require_relative '../lib/multiplication_table_printer'

describe MultiplicationTablePrinter do
  let(:list_of_primes) { [2, 3, 5, 7] }
  let(:printer) { MultiplicationTablePrinter.new(list_of_primes) }

  describe '#initialize' do
    it 'stores the required width for each column in an Array' do
      expect(printer.column_widths).to be_kind_of(Array)
    end

    it 'column width store is the same size as the table to print' do
      expect(printer.column_widths.length).to eq(printer.list_to_print.length)
    end

    it 'calculates the widths correctly' do
      expect(printer.column_widths[0]).to eq(1) # 7 is max for column 0 of the printed table
      expect(printer.column_widths[4]).to eq(2) # 49 is max for column 4 of the printed table
    end
  end

  describe '#table_entry_for_cell' do
    # Since the main output of this program is to STDOUT and we are deliberately not calculating
    # the entire matrix to print, the primary correctness test for the multiplication table is that
    # we get the right entry to print for each cell in the table.
    it 'gives correct special first character entry' do
      expect(printer.table_entry_for_cell(0, 0)).to eq('-')
    end

    it 'gives correct number for last row header' do
      # -
      # 2
      # 3
      # 5
      # 7
      expect(printer.table_entry_for_cell(4, 0)).to eq(7)
    end

    it 'gives correct number for second to last column header' do
      # - | 2 | 3 | 5 | 7
      expect(printer.table_entry_for_cell(0, 3)).to eq(5)
    end

    it 'gives correct cross-multiplication' do
      expect(printer.table_entry_for_cell(1, 2)).to eq(6)
    end

    it 'calculates maximum cross correctly' do
      expect(printer.table_entry_for_cell(4, 4)).to eq(49)
    end
  end

  describe '#get_justified_string' do
    let(:entry_value) { 12 }
    let(:column) { 4 }
    let(:max_width) { 5 }
    before do
      allow(printer).to receive(:column_widths).and_return(column => max_width)
    end

    it 'returns string of width required for column' do
      string = printer.get_justified_string(entry_value, column)
      expect(string.length).to eq(max_width)
    end

    it 'maintains correct number of original string' do
      string = printer.get_justified_string(entry_value, column)
      expect(string.to_i).to eq(entry_value)
    end
  end
end
