require "./parser.rb"
require "./code.rb"
require "./symbol_table.rb"

puts ARGV[0]
parser = Parser.new(ARGV[0])
symbol_table = SymbolTable.new()

hack_filename = File.basename(ARGV[0], ".asm") + ".hack"

loop do
    if parser.hasMoreCommands then
        parser.advance
        current_command_type = parser.commandType
        if current_command_type == "L_COMMAND" then
            symbol = parser.symbol
            symbol_table.addEntry(symbol, symbol_table.rom_address)
        elsif current_command_type == "A_COMMAND" || current_command_type == "C_COMMAND" then
            symbol_table.rom_address += 1
        end
    else
        break
    end
end

parser.input_enum.rewind

File.open(hack_filename, "w") do |f|
    loop do
        if parser.hasMoreCommands then
            parser.advance
            current_command_type = parser.commandType
            if current_command_type == "A_COMMAND" then
                symbol = parser.symbol

                if (not symbol_table.contains(symbol)) && (not symbol.match(/^\d+$/)) then
                    symbol_table.addEntry(symbol, symbol_table.ram_address)
                    symbol = symbol_table.ram_address
                    symbol_table.ram_address += 1
                elsif symbol_table.contains(symbol) then
                    symbol = symbol_table.getAddress(symbol)
                end

                symbol_bits = sprintf("%016b", symbol)
                
                f.puts symbol_bits
                
            end

            if current_command_type == "C_COMMAND" then
                comp_mnemonic = parser.comp
                dest_mnemonic = parser.dest
                jump_mnemonic = parser.jump

                comp_bits = Code.comp(comp_mnemonic)
                dest_bits = Code.dest(dest_mnemonic)
                jump_bits = Code.jump(jump_mnemonic)

                f.puts "111" + comp_bits + dest_bits + jump_bits
            end
        else
            break
        end
    end
end