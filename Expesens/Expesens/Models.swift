import Foundation

enum Category{
    case food
    case transport
    case coffee
    case entertainment
    
    var title: String{
        switch self{
        case.food: return "Еда"
        case.transport: return "Транспорт"
        case.coffee: return "Кофе"
        case.entertainment: return "Развлечения"
        }
    }
}

struct Transaction {
    let amount: Double
    let category: Category
    let date: Date
    let comment: String?
}


func totalAmount(for category: Category, in transactions: [Transaction]) -> Double{
    
    var sum: Double = 0.0
    
    for i in transactions{
        if i.category == category{
            sum += i.amount
        }
    }
    
    return sum
    
}

final class BudgetManager{
    private(set) var transactions: [Transaction]
    
    init(transactions: [Transaction] = []){
        self.transactions = transactions
    }
    
    func add(_ transaction: Transaction){
        transactions.append(transaction)
    }
    
    func totalAmount() -> Double{
        var sum: Double = 0
        for t in transactions{
            sum += t.amount
        }
        return sum
    }
    func totalAmount(for category: Category) -> Double {
        var sum: Double = 0
        for t in transactions {
            if t.category == category {
                sum += t.amount
            }
        }
        return sum
    }
    
    func remove(at index: Int){
        guard transactions.indices.contains(index) else { return }
        transactions.remove(at: index)
    }
    
    func update(at index: Int, with transaction: Transaction){
        guard transactions.indices.contains(index) else { return }
        transactions[index] = transaction
    }
    
    
    
}

















