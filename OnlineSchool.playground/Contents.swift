/// Классы. Структуры. Перечисления

// MARK: Classes

/**
 Класс является ссылочным типом данных в Swift. Это значит, что доступ к экземляру объекта происходит по ссылке. Иными словами
 при работе с классом доступ есть лишь к адресу памяти, которая указывает на место в куче. Одной из особенностей классов является то,
 что классы поддерживают наследование и полимоорфизм
 */
class FooParent {
    var parentValue: Int
    
    init(parentValue: Int) {
        self.parentValue = parentValue
    }
    
    func bar() {
        print("Parent says: Hello, world!")
    }
    
    final func finalBar() {
        print("Only paren version")
    }
}

class Foo: FooParent {
    var value: Int
    
    init(value: Int, parentValue: Int) {
        self.value = value
        
        super.init(parentValue: parentValue)
    }
    
    override func bar() {
        print("Hello, world!")
    }
    
    private func privateBar() {}
}

// Usage

let foo = Foo(value: 0, parentValue: 1)
let fooParent = FooParent(parentValue: 2)

// Благодаря полиморфизму класс-наследник может переопределять функции и свойства родителя, добавляе или полностью заменяя их функциональность
foo.bar() // Output: Hello, world!
fooParent.bar() // Output: Parent says: Hello, world!

// Из-за того, что при работе с классов работа идет только лишь со ссылкой, то при присвоении объекта другой переменной
// происходит копирование ссылки. Тогда, при изменении нового объекта исходный также будет изменен
let anotherFoo = foo
foo.value = 10
anotherFoo.value = 11

foo.value // 11
anotherFoo.value // 11

/**
 Структуры, в отличии от классов, являются value type. При создании стурктуры память для нее выделяется не на куче, а в стэке. Это очень сильно уменьшает затраты памяти, а также работа происходит непосредственно с объектом, а не ссылкой на область памяти. Но стоит учесть, что стуктуры не поддерживают наследование и полиморфизм
 */

struct FooStruct {
    var value: Int
}

// let fooStruct = FooStruct(value: 0)
// fooStruct.value = 11 // Error: мы работает с конкретным объектом, а не ссылкой, поэтому стуктуру нельзя модифицировать, если они помечена как неизменяемая
var fooStruct = FooStruct(value: 0)
fooStruct.value = 10

// При назначении объекта другой переменной структура копируется. Другими словами, после присовени объекта дальнейшая работа ведется совершенно с другим объетом. Изменяя новый объект исходный остается в прежнем состоянии
var fooStruct2 = fooStruct
fooStruct2.value = 11

fooStruct.value // 10
fooStruct2.value // 11

/**
 Перечисления являются тем, чем кажутся. Они представляют собой набор каких-то данных. В каждый момент времени объект перечисления может принимать только
 значение, которое содержится в нем и только одно. Семантически перечисления также являтеся value type, то есть работа идет напрямую с объектом.
Из значения перечисления можно получать какое-то конкретное значение, если указать тип значения после двоеточия
 */

enum FooEnum: String {
    case one
    case two
    case three = "Hey, three"
}

// Для работы с перечисления не обязательно создавать объект. Как правило перечисления используются для установки и проверки различных состояний

FooEnum.one.rawValue // one
FooEnum.two.rawValue // two
FooEnum.three.rawValue // Hey, three

var fooEnum: FooEnum = .one
fooEnum.rawValue // one
fooEnum = .two
fooEnum.rawValue // one
fooEnum = .three
fooEnum.rawValue // Hey, three

enum Foo2Enum {
    case hello(String)
    
    var value: String {
        switch self {
        case let .hello(name):
            return "Hello, \(name)!"
        }
    }
}

Foo2Enum.hello("student").value // Hello, student!
