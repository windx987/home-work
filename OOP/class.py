from dataclasses import dataclass, field
from abc import ABC,abstractmethod
from typing import List

@dataclass
class User(ABC):
    name: str
    age : int
    identity_card : str

    @abstractmethod
    def vote():
        pass

@dataclass
class Member(User):
    name: str
    age : int
    identity_card : str
    
    def vote(self, system, political_id):
        system.vote(political_id)
        return system.show(political_id)

@dataclass
class Admin(User):
    name: str
    age : int
    identity_card : str
    
    def vote(self, system, political_id):
        system.vote(political_id)
        return system.show(political_id)
    
    def โกง(self, system, political_id, qty):
        for political in system.political_list:
            if political.identity == political_id :
                political.edit_point = political.edit_point + qty
                print("โกง!")
                return political.edit_point
        
    
@dataclass
class Political: 
    identity : int
    name : str
    point : int

    @property
    def edit_point(self):
        return self.point

    @edit_point.setter
    def edit_point(self, qty):
        self.point = qty

@dataclass
class System:
    political_list : List[Political] = field(default_factory=list)

    def append_political(self, political):
        self.political_list.append(political)
    
    def vote(self, id):
        for political in self.political_list:
            if political.identity == id :
                political.edit_point = political.edit_point + 1
                print("vote!")
                return political.edit_point

    def show(self, id):
        for political in self.political_list:
            if political.identity == id :
                print("show!")
                return political.edit_point

member = Member(name="WIND", age=1000,identity_card=987654321)
admin = Admin(name="HEE", age=1000, identity_card=123456789)
            
hee_hee = Political(identity = 100000, name = "HeeHee", point = 250)
nine_near = Political(identity = 696969, name = "9near", point = 0)

print(hee_hee.edit_point)
print(nine_near.edit_point)

system = System()

system.append_political(hee_hee)
system.append_political(nine_near)

system.vote(100000)
system.vote(696969)

print(hee_hee.edit_point)
print(nine_near.edit_point)

member.vote(system, 100000)
member.vote(system, 696969)

print(hee_hee.edit_point)
print(nine_near.edit_point)

admin.โกง(system, 100000, 1000)

print(hee_hee.edit_point)
print(nine_near.edit_point)