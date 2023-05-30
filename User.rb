class User
    attr_accessor :id, :firstname, :lastname, :age, :password, :email # bu bolmasa "puts user" ishalmidi

    def initialize(array)
        @id         = array[0]
        @firstname  = array[1]
        @lastname   = array[2]
        @age        = array[3]
        @password   = array[4]
        @email      = array[5]
    end
end

    user_data = [1, "John", "Doe", 25, "password123", "john.doe@example.com"]
    user = User.new(user_data)

    puts user.id          # 1
    puts user.firstname   # "John"
    puts user.lastname    # "Doe"
    puts user.age         # 25
    puts user.password    # "password123"
    puts user.email       # "john.doe@example.com"