class ShoppingCart:
    def __init__(self):
        self.__item_list = []

    def add_to_cart(self,item):
        self.__item_list.append(item)

class AuthenticateUser:
    def __init__(self, name, email):
        self.__name = name
        self.__email = email
        self.__shopping_cart = ""

    def get_shopping_cart(self):
        self.__shopping_cart = ShoppingCart()

    def add_to_cart(self,product, number):
        item = Item(product,number)
        self.__shopping_cart.add_to_cart(item)

class Product:
    def __init__(self,name) :
        self.__name = name

class Item(Product):
    def __init__(self, name, number):
        super().__init__(name)
        self.__number = number


john = AuthenticateUser("john","mail")
john.get_shopping_cart

p1 = Product("oil")
john.add_to_cart(p1,2)

