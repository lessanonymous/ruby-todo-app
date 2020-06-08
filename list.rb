require "./item.rb"

class List

    attr_accessor :label 
    
    def initialize(label)

        @label = label
        @items = []

    end

    def [](idx)

        @items[idx]

    end

    def add_item(title, deadline, description = "")

        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true

    end

    def size

        @items.length

    end

    def valid_index?(idx)

        idx >= 0 && idx < @items.length

    end

    def swap(idx1, idx2)

        return false if !self.valid_index?(idx1) || !self.valid_index?(idx2)
        @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
        true

    end

    def print

        puts "-" * 60
        puts @label.center(60)
        puts "-" * 60
        puts "#{"Index".ljust(7)}| #{"Item".ljust(20)}| #{"Deadline".ljust(13)}| Done"
        puts "-" * 60
        @items.each_with_index do | item, idx |

            puts "#{idx.to_s.ljust(7)}| #{item.title.ljust(20)}| #{item.deadline.ljust(13)}|  [#{item.done ? "\u2713".encode('utf-8') : " "}]"

        end
        puts "-" * 60

    end

    def print_full_item(idx)

        if self.valid_index?(idx)

            item = self[idx]

            puts "-" * 40
            puts "#{item.title.ljust(29)} #{item.deadline.rjust(10)} "
            puts "#{item.description.ljust(29)}Done: [#{item.done ? "\u2713".encode('utf-8') : " "}]"
            puts "-" * 40

        end

    end

    def print_priority

        self.print_full_item(0)

    end

    def up(idx, amount = 1)

        return false if !self.valid_index?(idx)
        while idx > 0 && amount > 0

            self.swap(idx, idx - 1)
            amount -= 1
            idx -= 1

        end

        true

    end

    def down(idx, amount = 1)

        return false if !self.valid_index?(idx)
        while idx < @items.length - 1 && amount > 0

            self.swap(idx, idx + 1)
            amount -= 1
            idx += 1

        end

        true

    end

    def sort_by_date!

        @items.sort_by! { | item | item.deadline }

    end

    def toggle_item(idx)

        idx = idx.to_i
        return false if !self.valid_index?(idx)
        self[idx].toggle 

    end

    def remove_item(idx)

        return false if !self.valid_index?(index)
        @items.delete_at(idx)

    end

    def purge

        @items.delete_if(&:done)

    end

end