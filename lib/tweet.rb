class Tweet

    attr_accessor :user, :content, :id

    # creating objects 
    # persisting objects to the database(record)
    # create a table specifically for this class
    # return all records of a table 
    # find a record the table 

    def initialize(attr_hash={})
        attr_hash.each do |key, value|
            self.send("#{key}=", value) 
        end 
    end 

   # method that returns all records in a table 

    def self.all 
        sql = <<-SQL
            SELECT * FROM tweets;
        SQL

        records = DB[:conn].execute(sql) # an array of hashes 

        records.map do |record_hash| # turning sql data into ruby data/objects
            Tweet.new(record_hash)
        end 
    end 

    # save method that persists each record to database 

    def save 
        # adding attribute values to the table
        if self.id
            self.update
        else 
            sql = <<-SQL
                INSERT INTO tweets (user, content) VALUES (?, ?);
            SQL

            DB[:conn].execute(sql, self.user, self.content)
            @id = DB[:conn].last_insert_row_id
            #last insert row id 
        end 
        self # what is self?
    end 

    def update 
        sql = <<-SQL
           UPDATE tweets SET user = ?, content = ? WHERE id = ?
        SQL

        DB[:conn].execute(sql, self.user, self.content, self.id)
        self
    end 

    def self.find(id)
        sql = <<-SQL
            SELECT * FROM tweets WHERE tweets.id = ?
        SQL

        record = DB[:conn].execute(sql, id)[0]
        # binding.pry
        self.new(record)
    end 


    def self.create_table 
        # write a query that creates the table 
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS tweets (
            id INTEGER PRIMARY KEY, 
            user TEXT,
            content TEXT
        );
        SQL
            DB[:conn].execute(sql)
    end 

end
