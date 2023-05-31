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

    user_data = [1, "Azizbek", "Isroilov", 18, "password", "azizdev.full@gmail.com"]
    user = User.new(user_data)

    puts user.id          # 1
    puts user.firstname   # "Azizbek"
    puts user.lastname    # "Isroilov"
    puts user.age         # 18
    puts user.password    # "password"
    puts user.email       # "azizdev.full@gmail.com"