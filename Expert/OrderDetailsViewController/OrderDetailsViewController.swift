import UIKit
import SQLite3

class OrderDetailsViewController: UIViewController {
    var order: (id: Int, userName: String, date: String, typeExpertiz: Int, pay: Int, result: String, userText: String?, photo1: Data?, photo2: Data?, photo3: Data?, photo4: Data?)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251/255, green: 109/255, blue: 16/255, alpha: 1.0)
        setupUI()
        
        if let order = order {
            displayOrderDetails(order: order)
        }
    }
    
    func setupUI() {
        // Контейнер для текста с черным фоном
        let textContainerView = UIView()
        textContainerView.backgroundColor = .black
        textContainerView.layer.cornerRadius = 10
        textContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textContainerView)
        
        // Добавление UILabel для отображения типа экспертизы
        let typeLabel = UILabel()
        typeLabel.font = UIFont.systemFont(ofSize: 18)
        typeLabel.textColor = .white
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        textContainerView.addSubview(typeLabel)
        
        // Добавление UILabel для отображения даты
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        textContainerView.addSubview(dateLabel)
        
        // Добавление UILabel для отображения описания заказа
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        textContainerView.addSubview(descriptionLabel)
        
        // Добавление UIScrollView для фотографий
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let photosStackView = UIStackView()
        photosStackView.axis = .horizontal
        photosStackView.spacing = 10
        photosStackView.distribution = .fillEqually
        photosStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(photosStackView)
        
        // Контейнер для ответа эксперта
        let answerFromExpert = UIView()
        answerFromExpert.backgroundColor = .black
        answerFromExpert.translatesAutoresizingMaskIntoConstraints = false
        answerFromExpert.layer.cornerRadius = 10
        view.addSubview(answerFromExpert)

        let text1Answer = UILabel()
        text1Answer.text = "Ответ эксперта"
        text1Answer.font = UIFont.systemFont(ofSize: 18)
        text1Answer.textColor = .white // Изменен цвет текста на белый для контраста с черным фоном
        text1Answer.translatesAutoresizingMaskIntoConstraints = false
        answerFromExpert.addSubview(text1Answer)
        
        let answerExpertText = UILabel()
        answerExpertText.font = UIFont.systemFont(ofSize: 16)
        answerExpertText.textColor = .white
        answerExpertText.numberOfLines = 0
        answerExpertText.translatesAutoresizingMaskIntoConstraints = false
        answerFromExpert.addSubview(answerExpertText)
        
        // Установка constraint для элементов интерфейса
        NSLayoutConstraint.activate([
            textContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            typeLabel.topAnchor.constraint(equalTo: textContainerView.topAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -10),
            
            dateLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: textContainerView.bottomAnchor, constant: -10),
            
            scrollView.topAnchor.constraint(equalTo: textContainerView.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.heightAnchor.constraint(equalToConstant: 200),
            
            photosStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            photosStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            photosStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            photosStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            photosStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            // Исправление topAnchor для контейнера с ответом эксперта
            answerFromExpert.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20), // Привязка к нижнему краю scrollView с отступом
            answerFromExpert.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerFromExpert.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            text1Answer.topAnchor.constraint(equalTo: answerFromExpert.topAnchor, constant: 10),
            text1Answer.leadingAnchor.constraint(equalTo: answerFromExpert.leadingAnchor, constant: 10),
            text1Answer.trailingAnchor.constraint(equalTo: answerFromExpert.trailingAnchor, constant: -10),
            
            answerExpertText.topAnchor.constraint(equalTo: text1Answer.bottomAnchor, constant: 10),
            answerExpertText.leadingAnchor.constraint(equalTo: answerFromExpert.leadingAnchor, constant: 10),
            answerExpertText.trailingAnchor.constraint(equalTo: answerFromExpert.trailingAnchor, constant: -10),
            answerExpertText.bottomAnchor.constraint(equalTo: answerFromExpert.bottomAnchor, constant: -10)
        ])

        // Сохранение ссылок на UI элементы для последующего заполнения данными
        self.typeLabel = typeLabel
        self.dateLabel = dateLabel
        self.descriptionLabel = descriptionLabel
        self.photosStackView = photosStackView
        
        // Получение ответа эксперта из базы данных
        if let orderId = order?.id {
            let answer = getAnswerFromExpert(forOrderId: orderId)
            answerExpertText.text = answer ?? "Ответ эксперта отсутствует."
        }
    }
    
    private var typeLabel: UILabel!
    private var dateLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var photosStackView: UIStackView!
    private var answerExpertText: UILabel!

    func displayOrderDetails(order: (id: Int, userName: String, date: String, typeExpertiz: Int, pay: Int, result: String, userText: String?, photo1: Data?, photo2: Data?, photo3: Data?, photo4: Data?)) {
        // Заполнение данных в UILabel
        
        let textType = UILabel()
        textType.font = UIFont.systemFont(ofSize: 18)
        textType.translatesAutoresizingMaskIntoConstraints = false
        textType.textColor = .white
        
        if order.typeExpertiz == 1
        {
            typeLabel.text = "Тип экспертизы: ДТП"
        }else if order.typeExpertiz == 2{
            typeLabel.text = "Тип экспертизы: Окон"
        }else if order.typeExpertiz == 3{
            typeLabel.text = "Тип экспертизы: Заливов"
        }else if order.typeExpertiz == 4{
            typeLabel.text = "Тип экспертизы: Обуви"
        }else if order.typeExpertiz == 5{
            typeLabel.text = "Тип экспертизы: Одежды"
        }else if order.typeExpertiz == 6{
            typeLabel.text = "Тип экспертизы: Строительная"
        }else if order.typeExpertiz == 7{
            typeLabel.text = "Тип экспертизы: Бытовая техника"
        }else if order.typeExpertiz == 8{
            typeLabel.text = "Тип экспертизы: Шуб"
        }else if order.typeExpertiz == 9{
            typeLabel.text = "Тип экспертизы: Телефонов"
        }else{
            typeLabel.text = "Тип экспертизы: Мебель"
        }
        dateLabel.text = "Дата: \(order.date)"
        descriptionLabel.text = order.userText ?? "Описание отсутствует"
        
        // Очистка предыдущих фотографий
        photosStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Добавление фотографий в StackView, если они доступны
        if let photoData = order.photo1, let image = UIImage(data: photoData) {
            let imageView = createImageView(with: image)
            photosStackView.addArrangedSubview(imageView)
        }
        if let photoData = order.photo2, let image = UIImage(data: photoData) {
            let imageView = createImageView(with: image)
            photosStackView.addArrangedSubview(imageView)
        }
        if let photoData = order.photo3, let image = UIImage(data: photoData) {
            let imageView = createImageView(with: image)
            photosStackView.addArrangedSubview(imageView)
        }
        if let photoData = order.photo4, let image = UIImage(data: photoData) {
            let imageView = createImageView(with: image)
            photosStackView.addArrangedSubview(imageView)
        }
    }
    
    private func createImageView(with image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true // Ограничение ширины для фото
        return imageView
    }
    
    func getAnswerFromExpert(forOrderId orderId: Int) -> String? {
        let queryStatementString = "SELECT answerExpert FROM orders WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var answerExpert: String? = nil
        
        let db = SQL()
        db.db = db.openDatabase()
        
        if sqlite3_prepare_v2(db.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // Привязываем значение orderId к первому параметру запроса
            sqlite3_bind_int(queryStatement, 1, Int32(orderId))
            
            // Выполняем запрос
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // Получаем значение answerExpert
                if let answerExpertPointer = sqlite3_column_text(queryStatement, 0) {
                    answerExpert = String(cString: answerExpertPointer)
                } else {
                    print("Ответ эксперта отсутствует")
                }
            } else {
                print("Заказ с id \(orderId) не найден")
            }
        } else {
            print("Ошибка при подготовке SQL-запроса")
        }
        
        // Освобождаем ресурсы
        sqlite3_finalize(queryStatement)
        
        return answerExpert
    }
}
