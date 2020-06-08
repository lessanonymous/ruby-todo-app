require "./list.rb"

class TodoBoard
    
    def initialize(label)

        @lists = {}

    end

    def get_command

        print "\nEnter a command: "
        cmd, label, *args = gets.chomp.split(" ")
        case cmd
        when "mktodo"

            @lists[label].add_item(*args)

        when "quit"

            return false

        when "up"

            @lists[label].up(*args.map(&:to_i))

        when "down"

            @lists[label].down(*args.map(&:to_i))

        when "swap"

            @lists[label].swap(*args.map(&:to_i))

        when "sort"

            @lists[label].sort_by_date!

        when "priority"

            @lists[label].print_priority

        when "print"

            args.empty? ? @lists[label].print : @lists[label].print_full_item(*args[0].to_i)

        when "toggle"

            @lists[label].toggle_item(*args[0].to_i)

        when "rm"

            @lists[label].remove_item(*args[0].to_i)

        when "purge"

            @lists[label].purge
            
        when "mklist"

            @lists[label] = List.new(label)

        when "ls"

            puts "-" * 40
            puts "Lists".center(40)
            puts "-" * 40
            @lists.keys.each { | label | puts label.center(40) }
            puts "-" * 40

        when "showall"

            @lists.each do | label, list |

                puts 
                list.print
                puts

            end

        else

            puts "Sorry, that command is not recognized"

        end

        true

    end

    def run 

        if self.get_command

            self.run

        end

    end

end

print "Enter label for your todo board: "
label = gets.chomp
board = TodoBoard.new(label)
board.run