class SymbolTable

    attr_accessor :rom_address, :ram_address

    def initialize()
        @symbol_table = {"SP"=>0, "LCL"=>1, "ARG"=>2, "THIS"=>3, "THAT"=>4,
                         "R0"=>0, "R1"=>1, "R2"=>2, "R3"=>3, "R4"=>4,"R5"=>5, "R6"=>6, "R7"=>7,
                         "R8"=>8, "R9"=>9, "R10"=>10, "R11"=>11, "R12"=>12, "R13"=>13, "R14"=>14, "R15"=>15,
                         "SCREEN"=>16384, "KBD"=>24576}
        @rom_address = 0
        @ram_address = 16
    end

    def addEntry(symbol, address)
        @symbol_table[symbol] = address
    end

    def contains(symbol)
        return @symbol_table.has_key?(symbol)
    end

    def getAddress(symbol)
        return @symbol_table[symbol]
    end

end
