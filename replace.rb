$PROGRAM_NAME = "./replace.rb"

def main(inputString, outputString)
    @allFiles = Dir.glob("./**/*").reject { |f| File.directory?(f) }
    
    for i in (0..@allFiles.length) do
        # skip the replace.rb file (do not write to program file)
        
        if (@allFiles[i] == $PROGRAM_NAME)
            next
        end

        # replace occurances and store value inside local variable
        @replacedText = self.readFile(@allFiles[i]).gsub(inputString, outputString)

        # write and replace original file with replaced/updated text
        puts "[#{i}] Completed replace of file: #{@allFiles[i]}:#{self.writeToFile(@allFiles[i], @replacedText)}"
    end

    # end program
    exit
end

def readFile(fileName)
    # null statement return
    if (fileName == nil)
        return ""
    end

    @filePointer = File.open(fileName)
    @file_data = @filePointer.read

    # close file to prevent overflow error
    @filePointer.close

    return @file_data
end

def writeToFile(fileName, value) 
    # null statement return
    if (fileName == nil || fileName == "" || value == nil || value == "")
        return false
    end
    
    File.open(fileName, "w") { |f| f.write "#{value}" }
    return true
end

# call main function
main(ARGV[0].to_s, ARGV[1].to_s)
