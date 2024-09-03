import UIKit

class TypeViewController: UIViewController {

    var types: [String] = ["ДТП", "Окон", "Заливов", "Обуви", "Одежды", "Строительная", "Бытовая техника", "Шуб", "Телефонов", "Мебель"]
    var selectedType: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        
        let H1 = UITextView()

        // Создаем атрибутированную строку для H1
        let fullText = "Шаг третий"
        let attributedString = NSMutableAttributedString(string: fullText)

        // Определяем диапазон для слова "Шаг" и задаем ему оранжевый цвет
        let orangeColor = UIColor(red: 251/255, green: 109/255, blue: 16/255, alpha: 1.0)
        let rangeForOrangeText = (fullText as NSString).range(of: "Шаг")
        attributedString.addAttribute(.foregroundColor, value: orangeColor, range: rangeForOrangeText)

        // Определяем диапазон для слова "третий" и задаем ему белый цвет
        let rangeForWhiteText = (fullText as NSString).range(of: "третий")
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: rangeForWhiteText)

        // Устанавливаем шрифт для всего текста
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 30), range: NSMakeRange(0, attributedString.length))

        // Применяем атрибутированную строку к UITextView
        H1.attributedText = attributedString
        H1.backgroundColor = .clear
        H1.isScrollEnabled = false
        H1.isEditable = false
        H1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(H1)
        
        let text1 = UITextView()
        text1.text = "Укажите вид желаемой экспертизы"
        text1.font = UIFont.systemFont(ofSize: 20)
        text1.textColor = .white
        text1.backgroundColor = .clear
        text1.isScrollEnabled = false
        text1.isEditable = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(text1)
        
        // Устанавливаем ограничения для H1 и text1
        NSLayoutConstraint.activate([
            H1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            H1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text1.topAnchor.constraint(equalTo: H1.bottomAnchor, constant: 20),
            text1.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Создаем две колонки для кнопок
        var previousLeftButton: UIButton? = nil
        var previousRightButton: UIButton? = nil

        let buttonSpacing: CGFloat = 20.0
        let columnSpacing: CGFloat = 40.0 // Увеличиваем расстояние между колонками

        for (index, type) in types.enumerated() {
            let button = createButton(title: type)
            button.tag = index + 1 // Используем тег для хранения индекса (1-based)
            button.addTarget(self, action: #selector(typeExpertiza(_:)), for: .touchUpInside)
            view.addSubview(button)
            
            // Устанавливаем ограничения для кнопок в двух колонках
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            if index % 2 == 0 {
                // Левая колонка
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                
                if let previous = previousLeftButton {
                    button.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: buttonSpacing).isActive = true
                } else {
                    button.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 40).isActive = true
                }
                previousLeftButton = button
            } else {
                // Правая колонка
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                
                if let previous = previousRightButton {
                    button.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: buttonSpacing).isActive = true
                } else {
                    button.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 40).isActive = true
                }
                previousRightButton = button
            }
        }
        
        // Добавляем кнопку "Назад"
        let prevButton = createButton(title: "Назад")
        prevButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        view.addSubview(prevButton)
        
        prevButton.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            prevButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            prevButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            prevButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            prevButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 251/255, green: 109/255, blue: 16/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    @objc func typeExpertiza(_ sender: UIButton) {
        selectedType = sender.tag
        print("Selected type index: \(selectedType!)") // Это для проверки в консоли
        UserOrder.shared.UserType = selectedType
        
        let window = UIAlertController(title: "Успешно!", message: "Отлично! Ожидайте уведомление от эксперта.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
            self.navigateToEntrViewController()
        }
        
        // Отображение данных заказа
        print("Заказ: ")
        print("Имя: \(UserOrder.shared.UserName ?? "Не указано")")
        print("Описание: \(UserOrder.shared.UserText ?? "Не указано")")
        print("Тип экспертизы: \(UserOrder.shared.UserType ?? 0)")
        
        // Проверка наличия фотографий
        if let photo1 = UserOrder.shared.UserPhoto1, !photo1.isEmpty {
            print("Фото 1: добавлено")
        }
        if let photo2 = UserOrder.shared.UserPhoto2, !photo2.isEmpty {
            print("Фото 2: добавлено")
        }
        if let photo3 = UserOrder.shared.UserPhoto3, !photo3.isEmpty {
            print("Фото 3: добавлено")
        }
        if let photo4 = UserOrder.shared.UserPhoto4, !photo4.isEmpty {
            print("Фото 4: добавлено")
        }
        if (UserOrder.shared.UserPhoto1?.isEmpty ?? true) &&
           (UserOrder.shared.UserPhoto2?.isEmpty ?? true) &&
           (UserOrder.shared.UserPhoto3?.isEmpty ?? true) &&
           (UserOrder.shared.UserPhoto4?.isEmpty ?? true) {
            print("Произошла ошибка при добавлении фото")
        }
        
        let sql = SQL()
        sql.db = sql.openDatabase()
        if sql.db != nil {
            guard let name = UserOrder.shared.UserName,
                  let text = UserOrder.shared.UserText,
                  let type = UserOrder.shared.UserType else {
                print("Ошибка: отсутствуют обязательные данные для сохранения заказа.")
                return
            }
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: date)
            
            // Передаем Data? вместо String
            let photo1 = UserOrder.shared.UserPhoto1
            let photo2 = UserOrder.shared.UserPhoto2
            let photo3 = UserOrder.shared.UserPhoto3
            let photo4 = UserOrder.shared.UserPhoto4
            let pay = 1000
            let result = "Pending" // Вы можете изменить результат по умолчанию
            
            sql.saveOrder(userName: name, date: formattedDate, userText: text, photo1: photo1, photo2: photo2, photo3: photo3, photo4: photo4, typeExpertiz: type, pay: pay, result: result)
        }
        
        window.addAction(okAction)
        present(window, animated: true)
    }

    func navigateToEntrViewController() {
        let storyboard = UIStoryboard(name: "EntrViewController", bundle: nil)
        if let vsa = storyboard.instantiateViewController(withIdentifier: "EntrViewController") as? EntrViewController {
            // Закрыть все предыдущие экраны
            var presentingVC = self.presentingViewController
            while presentingVC?.presentingViewController != nil {
                presentingVC = presentingVC?.presentingViewController
            }
            presentingVC?.dismiss(animated: true, completion: {
                // Открыть новый главный экран
                UIApplication.shared.windows.first?.rootViewController = vsa
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            })
        } else {
            print("Error: EntrViewController not found in storyboard.")
        }
    }

    @objc func backTapped() {
        self.dismiss(animated: true)
    }
}
