import UIKit
import SQLite3

class MyOrderViewController: UIViewController {
    var db: OpaquePointer?
    var orders: [(id: Int, userName: String, date: String, typeExpertiz: Int, pay: Int, result: String, userText: String?, photo1: Data?, photo2: Data?, photo3: Data?, photo4: Data?)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 251/255, green: 109/255, blue: 16/255, alpha: 1.0)

        if let userName = UserSession.shared.UserName {
            db = openDatabase()
            
            if let userOrders = fetchUserOrders(userName: userName) {
                orders = userOrders
                setupOrdersUI()
            }
        } else {
            print("UserName не найден")
        }
    }
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("expert.sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Ошибка при открытии базы данных")
            return nil
        }
        return db
    }
    
    func fetchUserOrders(userName: String) -> [(id: Int, userName: String, date: String, typeExpertiz: Int, pay: Int, result: String, userText: String?, photo1: Data?, photo2: Data?, photo3: Data?, photo4: Data?)]? {
        var orders: [(id: Int, userName: String, date: String, typeExpertiz: Int, pay: Int, result: String, userText: String?, photo1: Data?, photo2: Data?, photo3: Data?, photo4: Data?)] = []
        let queryStatementString = "SELECT id, UserName, date, typeExpertiz, pay, result, UserText, photo1, photo2, photo3, photo4 FROM orders WHERE UserName = ?;"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (userName as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let userName = String(cString: sqlite3_column_text(queryStatement, 1))
                let date = String(cString: sqlite3_column_text(queryStatement, 2))
                let typeExpertiz = Int(sqlite3_column_int(queryStatement, 3))
                let pay = Int(sqlite3_column_int(queryStatement, 4))
                let result = String(cString: sqlite3_column_text(queryStatement, 5))
                let userText = sqlite3_column_text(queryStatement, 6).flatMap { String(cString: $0) }
                let photo1 = sqlite3_column_blob(queryStatement, 7).map { Data(bytes: $0, count: Int(sqlite3_column_bytes(queryStatement, 7))) }
                let photo2 = sqlite3_column_blob(queryStatement, 8).map { Data(bytes: $0, count: Int(sqlite3_column_bytes(queryStatement, 8))) }
                let photo3 = sqlite3_column_blob(queryStatement, 9).map { Data(bytes: $0, count: Int(sqlite3_column_bytes(queryStatement, 9))) }
                let photo4 = sqlite3_column_blob(queryStatement, 10).map { Data(bytes: $0, count: Int(sqlite3_column_bytes(queryStatement, 10))) }
                
                orders.append((id: Int(id), userName: userName, date: date, typeExpertiz: typeExpertiz, pay: pay, result: result, userText: userText, photo1: photo1, photo2: photo2, photo3: photo3, photo4: photo4))
            }
        } else {
            print("Ошибка при выполнении запроса.")
        }
        sqlite3_finalize(queryStatement)
        return orders
    }

    
    func setupOrdersUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        for order in orders {
            let orderView = createOrderView(order: order)
            stackView.addArrangedSubview(orderView)
        }
    }
    
    func createOrderView(order: (id: Int, userName: String, date: String, typeExpertiz: Int, pay: Int, result: String, userText: String?, photo1: Data?, photo2: Data?, photo3: Data?, photo4: Data?)) -> UIView {
        let containerView = UIView()
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        
        let dateLabel = UILabel()
        dateLabel.text = order.date
        dateLabel.font = UIFont.systemFont(ofSize: 16) // Уменьшен размер шрифта для даты
        dateLabel.textColor = .white
        dateLabel.numberOfLines = 1 // Позволяем перенос на следующую строку
        
        let titleLabel = UILabel()
        titleLabel.text = "Экспертиза от \(order.date)"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18) // Уменьшен размер шрифта для заголовка
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2 // Позволяем заголовку быть на двух строках
        
        let typeLabel = UILabel()
        if order.typeExpertiz == 1 {
            typeLabel.text = "Тип экспертизы: ДТП"
        } else if order.typeExpertiz == 2 {
            typeLabel.text = "Тип экспертизы: Окон"
        } else if order.typeExpertiz == 3 {
            typeLabel.text = "Тип экспертизы: Заливов"
        } else if order.typeExpertiz == 4 {
            typeLabel.text = "Тип экспертизы: Обуви"
        } else if order.typeExpertiz == 5 {
            typeLabel.text = "Тип экспертизы: Одежды"
        } else if order.typeExpertiz == 6 {
            typeLabel.text = "Тип экспертизы: Строительная"
        } else if order.typeExpertiz == 7 {
            typeLabel.text = "Тип экспертизы: Бытовая техника"
        } else if order.typeExpertiz == 8 {
            typeLabel.text = "Тип экспертизы: Шуб"
        } else if order.typeExpertiz == 9 {
            typeLabel.text = "Тип экспертизы: Телефонов"
        } else {
            typeLabel.text = "Тип экспертизы: Мебель"
        }
        typeLabel.font = UIFont.systemFont(ofSize: 16) // Уменьшен размер шрифта для типа экспертизы
        typeLabel.textColor = .lightGray
        
        let detailButton = UIButton(type: .system)
        detailButton.setTitle("Подробнее", for: .normal)
        detailButton.setTitleColor(.white, for: .normal)
        detailButton.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
        detailButton.layer.cornerRadius = 10
        detailButton.addTarget(self, action: #selector(showOrderDetails(_:)), for: .touchUpInside)
        detailButton.tag = order.id
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, typeLabel, detailButton])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        return containerView
    }

    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Формат исходной строки даты
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd-MM-yyyy" // Формат для отображения
            return dateFormatter.string(from: date)
        }
        return nil
    }

    @objc func showOrderDetails(_ sender: UIButton) {
        let orderId = sender.tag
        
        if let order = orders.first(where: { $0.id == orderId }) {
            let detailsVC = OrderDetailsViewController()
            detailsVC.order = order
            
            // Проверяем, есть ли навигационный контроллер
            if let navigationController = self.navigationController {
                navigationController.pushViewController(detailsVC, animated: true)
            } else {
                // Если нет навигационного контроллера, представляем контроллер модально
                present(detailsVC, animated: true, completion: nil)
            }
        }
    }
}
