class UserManager:
    def __init__(self):
        self.__users = []
        self.__admins = []

    def add_user_to_list(self, user):
        self.__users.append(user)
    def show_user(self):
        for user in self.__users:
            print(user)

class User :
    def __init__(self, name, email):
        self.__name = name
        self.__email = email

    def __str__(self) -> str:
        return f"email : {self.__email}, name : {self.__name}"

system = UserManager()

user1 = system.add_user_to_list(User("ten", "tenserflow@gmail.com"))
user2 = system.add_user_to_list(User("win", "winter@gmail.com"))
system.show_user()

