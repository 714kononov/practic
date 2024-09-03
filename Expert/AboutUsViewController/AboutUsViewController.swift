import UIKit

class AboutUsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем слой градиента
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.gray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Создаем UIScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Создаем контейнер для контента внутри UIScrollView
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Заголовок H1
        let H1 = UILabel()
        H1.text = "О нас"
        H1.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        H1.textColor = .white
        H1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(H1)
        
        // Создаем текстовые блоки
        let text1 = createTextView(withText: "Мы не банальные оценщики, ограничивающие себя типовой работой в регионе. Мы амбициозны и темпераментны, упрямы, современны и не обычны. Мы единственные в Пензе кто принимал участие в Олимпийской стройке страны. Наша компания безупречно поставила на кадастровый учет ряд объектов для Государственной корпорации «Олимпстрой». Мы принимали участие в конкурсах на оценку недвижимости посольства МИДа России в Мексике, многоквартирных домов во Владивостоке, списания боевых вертолетов МИ-24 в Ростове, оценку рыболовных судов на Камчатке.")
        let text2 = createTextView(withText: "Мы не авантюристы, а скорее искатели приключений в хорошем смысле этого слова.")
        let text3 = createTextView(withText: "Практически в любой сфере у нас есть свои консультанты и компетентные специалисты, позволяющие качественно, профессионально и обосновано выполнить поставленную перед нами задачу. Чем сложнее работа, тем интересней она для нас, причем финансовая сторона вопроса далеко не всегда на первом месте.")
        let text4 = createTextView(withText: "С большим интересом отнесемся к любым предложениям о сотрудничестве как местного, так иногороднего и мирового масштаба. В этом разделе сайта мы не пытаемся хвастаться, так как осознаем, что далеко не самые лучшие, но мы твердо стремимся ими быть!")
        let text5 = createTextView(withText: "Фирма имеет большой опыт работы в других регионах: Камчатский край, г. С. Петербург и Ленинградская область, Московская область, г. Новый Уренгой, г.Ростов на Дону, г.Киров, г.Ижевск, г.Сывтывкар, г.Саратов, Чувашская республика, республика Башкортостан, Самарская область, республика Мордовия и мн.др.")
        let text6 = createTextView(withText: "Высокое качество нашей работы подтверждает аккредитация фирмы в ведущих банках: ОАО «Банк ВТБ» г. Пенза, Пензенский филиал ОАО «МДМ Банк», ОАО «Нордэа», ОАО «Россельхозбанк», ОАО «Русьфинансбанк», ОАО «Русьбанк», ОАО Банк «Открытие», и многих других. Мы также имеем аккредитацию при ОАО «АИЖК».")
        let text7 = createTextView(withText: "Мы поставили на кадастровый учет Тренировочный центр для фигурного катания в г.Сочи, тепловые сети для атомной электростанции в Смоленской области, Новую филармонию в г. Пензе, самый большой торговый центр «Коллаж», водные каналы в Ленинградской области, более 3000 км дорог в Пензенской области и городах России, более 4000 км газопроводов и линий электропередач на территории РФ. Список и протяженность объектов постоянно растет.")
        let text8 = createTextView(withText: "Оценщики компании обладают большим опытом защиты своих отчетов в арбитражном и мировом судах, руководитель компании является членом палаты судебных экспертов «СУДЕКС» г.Москва. Фирма располагает современным оргтехническим оборудованием, цифровой техникой и программным обеспечением, имеет собственный автотранспорт.")
        let text9 = createTextView(withText: "Наша надежность подтверждена благодарственными письмами от партнеров и постоянных клиентов. ООО «Центр независимой экспертизы» успешно осуществляет оценочную деятельность с 2006 года.")
        
        //Фото офиса
        images = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")!, UIImage(named: "image5")!, UIImage(named: "image6")!, UIImage(named: "image7")!]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear  // Прозрачный фон
        collectionView.showsHorizontalScrollIndicator = false  // Скрываем горизонтальный индикатор скроллинга
        
        // Регистрируем ячейку
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        // Устанавливаем делегаты
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Добавляем UICollectionView в contentView
        contentView.addSubview(collectionView)
        
        // Добавляем все текстовые блоки в contentView
        contentView.addSubview(text1)
        contentView.addSubview(text2)
        contentView.addSubview(text3)
        contentView.addSubview(text4)
        contentView.addSubview(text5)
        contentView.addSubview(text6)
        contentView.addSubview(text7)
        contentView.addSubview(text8)
        contentView.addSubview(text9)
        
        // Настраиваем констрейнты для scrollView и contentView
        NSLayoutConstraint.activate([
            // Констрейнты для scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Констрейнты для contentView внутри scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)  // Ширина contentView равна ширине scrollView
        ])
        
        // Настраиваем констрейнты для текстовых блоков
        NSLayoutConstraint.activate([
            // Заголовок
            H1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            H1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Первый текстовый блок
            text1.topAnchor.constraint(equalTo: H1.bottomAnchor, constant: 20),
            text1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            text1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Последующие текстовые блоки
            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 10),
            text2.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text2.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 10),
            text3.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text3.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            text4.topAnchor.constraint(equalTo: text3.bottomAnchor, constant: 10),
            text4.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text4.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            text5.topAnchor.constraint(equalTo: text4.bottomAnchor, constant: 10),
            text5.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text5.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            text6.topAnchor.constraint(equalTo: text5.bottomAnchor, constant: 10),
            text6.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text6.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            text7.topAnchor.constraint(equalTo: text6.bottomAnchor, constant: 10),
            text7.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text7.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            text8.topAnchor.constraint(equalTo: text7.bottomAnchor, constant: 10),
            text8.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text8.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            text9.topAnchor.constraint(equalTo: text8.bottomAnchor, constant: 10),
            text9.leadingAnchor.constraint(equalTo: text1.leadingAnchor),
            text9.trailingAnchor.constraint(equalTo: text1.trailingAnchor),
            
            // Констрейнты для UICollectionView
            collectionView.topAnchor.constraint(equalTo: text9.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)  // Закрепляем нижний край
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height)
    }
    
    // Создаем функцию для создания UITextView
    func createTextView(withText text: String) -> UITextView {
        let textView = UITextView()
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
}

class ImageCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
