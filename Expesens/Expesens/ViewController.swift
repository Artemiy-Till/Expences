import UIKit

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView()

    private var transactions: [Transaction] = [
        Transaction(amount: 500, category: .coffee, date: Date(), comment: "Вкусно"),
        Transaction(amount: 1200, category: .food, date: Date(), comment: nil),
        Transaction(amount: 300, category: .transport, date: Date(), comment: "Не вкусно"),
        Transaction(amount: 700, category: .food, date: Date(), comment: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Расходы"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )

        view.backgroundColor = .systemBackground

        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    @objc private func addTapped() {
        let alert = UIAlertController(title: "Добавление", message: "Введите сумму и выберите категорию", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Сумма (например 350)"
            textField.keyboardType = .numberPad
        }

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        alert.addAction(UIAlertAction(title: "Еда", style: .default) { [weak self] _ in
            self?.addTransaction(from: alert, category: .food)
        })

        alert.addAction(UIAlertAction(title: "Кофе", style: .default) { [weak self] _ in
            self?.addTransaction(from: alert, category: .coffee)
        })

        alert.addAction(UIAlertAction(title: "Транспорт", style: .default) { [weak self] _ in
            self?.addTransaction(from: alert, category: .transport)
        })

        alert.addAction(UIAlertAction(title: "Развлечения", style: .default) { [weak self] _ in
            self?.addTransaction(from: alert, category: .entertainment)
        })

        present(alert, animated: true)
    }

    private func addTransaction(from alert: UIAlertController, category: Category) {
        let text = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard let amount = Double(text) else {
            showError(message: "Введите число, например 350")
            return
        }

        let newTransaction = Transaction(amount: amount, category: category, date: Date(), comment: nil)
        transactions.insert(newTransaction, at: 0)
        tableView.reloadData()
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {

        guard editingStyle == .delete else { return }

        transactions.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let transaction = transactions[indexPath.row]

        cell.textLabel?.text = "\(transaction.amount) ₽ — \(transaction.category.title)"
        cell.detailTextLabel?.text = transaction.comment ?? "Без комментария"

        return cell
    }
}







