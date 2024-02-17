// Todo Projesi Rise In-Patika DEV Internet Computer Rust Workshop
import Map "mo:base/HashMap";
import Hash "mo:base/Hash"; 
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

actor Assistant {

    type ToDo = {
        description Text;
        completed: Bool;
    };

    func natNash(n: Nat) : Hash.Hash {
        Text.hash(Nat.toText(n))
    };

    var todos= Map.HashMap<Nat, ToDo>(0, Nat.equal, natNash);
    var nextId : Nat = 0;

    public query func getTodos() : async [ToDo] {
        Iter.toArray(todos.vals(););
    };

    public query func addTodo(description: Text) : async Nat {
        let id = nextId;
        todos.put(id, {description = description; completed = false }):
        nextId += 1;
        Id
    };


    public func completeTodo( id: Nat): async () {
        ignore do ? {
            let description = todos.get(id) !.description;
            todos.put(id, {description; completed = true});
        }
        

    };

    public query func showTodos() : async Text {
        var output : Text = "\n____TO-DOs____\n";
        for (todo: ToDo in todos.vals() ) {
            output #= "\n" # todo.description;
            if (todo.completed) { output #= "✓"; };
        };
        output # "\n"
    };

    public func clearCompleted() : async () {
        todos := Map.mapfilter<Nat, ToDo, ToDo>(todos, Nat.equal, natNash,
        func(_, todo) {if (todo.completed) null else ?todo});
    };

    
 