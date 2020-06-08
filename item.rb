class Item

    attr_accessor :title, :description
    attr_reader :done, :deadline
    
    def self.valid_date?(date)

        valid_day = (1..31).to_a
        valid_month = (1..12).to_a
        year, month, day = date.split("-")
        return true if year.length == 4 && month.length == 2 && day.length == 2 && valid_month.include?(month.to_i) && valid_day.include?(day.to_i)
        false

    end

    def initialize(title, deadline, description)

        raise "Date is invalid" if !Item.valid_date?(deadline)
        @title = title
        @description = description
        @deadline = deadline 
        @done = false

    end

    def deadline=(deadline)

        raise "Date is invalid" if !Item.valid_date?(deadline)
        @deadline = deadline 

    end

    def toggle

        @done = !@done

    end

end