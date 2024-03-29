require 'sinatra'
require 'json'
require 'sqlite3'

set('views', './views')

enable :sessions
 
set :port, 8080
set :bind, '0.0.0.0'

$db_filename = "usr_db_sql.sql"
$tablename = "users"

class ConnectionSqLite
    def new
        @db = nil
    end
    def get_connection
        if @db == nil
            @db = SQLite3::Database.new($db_filename)
            createdb
        end
        @db
    end 

    def createdb
        asd = self.get_connection().execute <<-SQL
        CREATE TABLE IF NOT EXISTS #{$tablename} (
            id INTEGER PRIMARY KEY,
            firstname varchar(255),
            lastname varchar(25),
            age int,
            password varchar(255),
            email varchar(255)
        );
        SQL
    end

    def execute(query)
        self.get_connection().execute(query)
    end
end

class User
    attr_accessor :id, :firstname, :lastname, :age, :password, :email

    def initialize(array)
        @id         = array[0]
        @firstname  = array[1]
        @lastname   = array[2]
        @age        = array[3]
        @password   = array[4]
        @email      = array[5]
    end

    def to_hash
        {id: @id, firstname: @firstname, lastname: @lastname, age: @age, password: @password, email: @email}
    end

    def inspect
        %Q|<User id: #{@id}, firstname: "#{@firstname}", lastname: "#{@lastname}", age: #{@age}, password: "#{@password}", email: "#{@email}">|
    end

    def self.create(user_data)
       query = <<-REQUEST
        INSERT INTO #{$tablename} (firstname, lastname, age, password, email) VALUES ("#{user_data[:firstname]}",
        "#{user_data[:lastname]}",
        "#{user_data[:age]}",
        "#{user_data[:password]}",
        "#{user_data[:email]}");    
       REQUEST

        ConnectionSqLite.new.execute(query)
    end 

    def self.get(user_id)
            query = <<-REQUEST
            SELECT * FROM #{$tablename} WHERE id = #{user_id};
            REQUEST
            
            asd = ConnectionSqLite.new.execute(query)
            if asd.any?
                User.new(asd[0])
            else
                nil
            end
    end

    def self.all
        query = <<-REQUEST
            SELECT * FROM #{$tablename};
       REQUEST

       asd = ConnectionSqLite.new.execute(query)
       if asd.any?
            asd.collect do |row|
                User.new(row)
            end
       else
            []
       end
    end

    def self.filter_password(email, password)
        User.all.select {|user| user.email == email && user.password == password}.first
    end

    def self.update(user_id, attribute, value)
        query = <<-REQUEST
            UPDATE #{$tablename}
            SET #{attribute.to_s} = '#{value}'
            WHERE id = #{user_id};
        REQUEST
        puts query
        ConnectionSqLite.new.execute(query)
        updated = self.get(user_id).to_hash
    end

    def self.destroy(user_id)
         query = <<-REQUEST
            DELETE FROM #{$tablename}
            WHERE id = #{user_id};
        REQUEST
    
        ConnectionSqLite.new.execute(query)
    end
end



get '/users' do
    @results = User.all
    erb :foydalanuvchi
end

post '/users' do
    User.create(params)
    "User created"
end

post '/sign_in' do
    user = User.filter_password(params['email'], params['password'])
    if user
        session[:user_id] = user.id
        session[:password] = user.password
        "Signed in" 
    else
        "Not authorized"
    end
end

put '/users' do
    params['password']
    if session[:user_id]
        user_updated = User.update(session[:user_id], :password, params['password'])
        "#{user_updated}" 
    else
        "Not authorized"
    end
end

delete '/sign_out' do
    if session[:user_id]
      user = User.get(session[:user_id])
      session[:user_id] = nil
      "Signed out"
    else
        "Not authorized"
    end
end

delete '/users' do
    if session[:user_id]
        user = User.get(session[:user_id])
        if user
            User.destroy(session[:user_id])
            session[:user_id] = nil
            "User deleted"
        end
    
    else
            "Not authorized"
    end
end