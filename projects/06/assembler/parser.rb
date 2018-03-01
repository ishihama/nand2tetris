class Parser

    attr_reader :current_command
    attr_accessor :input_enum

    def initialize(input_file_path)
        @input_enum = File.foreach(input_file_path)
    end
    
    def hasMoreCommands()

        begin
            @input_enum.peek
        rescue StopIteration => e
            return false
        end

        return true
    end

    def advance()

        line = @input_enum.next_values
        @current_command = line.join.sub(/\/\/.*/, "").strip

    end

    def commandType()

        #print line
        case @current_command
        when /@.+/ then
            command_type = "A_COMMAND"
        when /.+=.+/ then
            command_type = "C_COMMAND"
        when /.+;J.{2}/ then
            command_type = "C_COMMAND"
        when /\(.+\)/ then
            command_type = "L_COMMAND"
        else
            #puts "unknown command"
        end

        return command_type
    end

    def symbol()
        # "A_COMMAND"
        symbol_string = @current_command.sub(/^@(.*)$/, '\1').sub(/^\((.*)\)$/, '\1')

        return symbol_string
    end

    def dest()
        # "C_COMMAND"
        dest_mnemonic = nil
        if @current_command =~ /(.+)=.+/
            dest_mnemonic = $1
        end

        return dest_mnemonic
    end

    def comp()
        # "C_COMMAND"
        comp_mnemonic = nil
        if @current_command =~ /.+=(.+)/
            comp_mnemonic = $1
        elsif @current_command =~ /(.+);.+/
            comp_mnemonic = $1
        end

        return comp_mnemonic
    end

    def jump()
        # "C_COMMAND"
        jump_mnemonic = nil
        if @current_command =~ /.+;(.+)/
            jump_mnemonic = $1
        end

        return jump_mnemonic
    end
end