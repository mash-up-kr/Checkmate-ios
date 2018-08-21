//
//  CalendarDetailViewController.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class CalendarDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    
    @IBOutlet weak var MonthLabel: UILabel!
    
    @IBOutlet weak var dayStackView: UIStackView!
    var DayViews: [DayView] = []
    
    var selectedModel: DetailDateModel = DetailDateModel()
    
    var boolDetailMoney: Bool = false
    var boolDetailTime: Bool = false
    var boolPicture: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false;
        tableView.allowsSelection = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        
        if let centerDate = dateFormatter.date(from: "\(selectedModel.year)-\(selectedModel.month + 1)-\(selectedModel.day)") {
            
            let calendar = Calendar(identifier: .gregorian)
            
            let displayDays: [Date] = [calendar.date(byAdding: .day, value: -2, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: -1, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: 0, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: 1, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: 2, to: centerDate)!
            ]
            
            for i in 0..<5 {
                let view: DayView = DayView()
                
                let weekday = Calendar.current.component(.weekday, from: displayDays[i]) - 1
                let nameOfDay = NameOfDays[weekday]
                
                let indexStartOfText = nameOfDay.index(nameOfDay.startIndex, offsetBy: 2)
                view.setTitle(text: "\(nameOfDay[...indexStartOfText])\n\(Calendar.current.component(.day, from: displayDays[i]))")
                
                dayStackView.addArrangedSubview(view)
            }
        }
        else {
            for _ in 0..<5 {
                let view = DayView()
                view.setDummyData()
                dayStackView.addArrangedSubview(view)
            }
        }
        
        let currentMonth = "\(Months[selectedModel.month])"
        let indexStartOfText = currentMonth.index(currentMonth.startIndex, offsetBy: 2)
        
        MonthLabel.text = "\(currentMonth[...indexStartOfText])"
        weekdayLabel.text = "\(NameOfDays[selectedModel.weekday])"
        dayLabel.text = "\(selectedModel.day)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

internal class DayView: UIView {
    
    private var centerDate: Date = Date()
    
    private var didUpdateConstraints: Bool = false
    private var WeekDayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(red: 103/255, green: 103/255, blue: 103/255, alpha: 1.0)
        label.textAlignment = .center
        
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13.0)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
       return label
    }()
    
    private var circleView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0).cgColor
        
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(WeekDayLabel)
        self.addSubview(circleView)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented.")
    }
    
    func setDummyData() {
        WeekDayLabel.text = "Tue\n22"
        showHighlight()
    }
    
    func setTitle(text: String) {
        WeekDayLabel.text = text
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            NSLayoutConstraint.activate([
                WeekDayLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
                WeekDayLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0),
                WeekDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                WeekDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
            NSLayoutConstraint.activate([
                circleView.widthAnchor.constraint(equalToConstant: 4.0),
                circleView.heightAnchor.constraint(equalToConstant: 4.0),
                circleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                circleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1)
            ])
            
            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func hideHighlight() {
        circleView.isHidden = true
    }
    
    func showHighlight() {
        circleView.isHidden = false
    }
}

protocol OpenButtonProtocol: class {
    func showButton()
    func hideButton()
}

protocol SeparatorViewProtocol: class {
    func showSeparator()
    func hideSeparator()
}

protocol TodayMoneyCellDelegate: class {
    func openPressed(_ cell: TodayMoneyCell)
}

internal class TodayMoneyCell: UITableViewCell, OpenButtonProtocol, SeparatorViewProtocol {
    
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var openButton: UIButton!
    weak var delegate: TodayMoneyCellDelegate?
    
    var additionalSeparator: UIView = UIView()
    
    override func awakeFromNib() {
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(10.0)
        
        additionalSeparator = UIView.init(frame: CGRect(x: 0, y: frame.size.height, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        additionalSeparator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(additionalSeparator)
        
        hideSeparator()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.openPressed(self)
        hideButton()
    }
    
    func showButton() {
        openButton.isHidden = false
    }
    
    func hideButton() {
        openButton.isHidden = true
    }
    
    func setMoney(money: Int) {
        lblMoney.text = String(money) + " won"
    }
    
    func hideSeparator() {
        additionalSeparator.isHidden = true
    }
    
    func showSeparator() {
        additionalSeparator.isHidden = false
    }
    
}

extension CalendarDetailViewController: TodayMoneyCellDelegate {
    func openPressed(_ cell: TodayMoneyCell) {
        boolDetailMoney = true
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

protocol DetailMoneyCellDelegate: class {
    func closedPressed(_ cell: DetailMoneyCell)
}

internal class DetailMoneyCell: UITableViewCell {
    
    weak var delegate: DetailMoneyCellDelegate?
    
    @IBOutlet weak var lblWage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBAction func closedButton(_ sender: Any) {
        delegate?.closedPressed(self)
    }
    
    func setHourlyWage(_ hourlyWage: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let strHourlyWage = numberFormatter.string(from: NSNumber(value: hourlyWage)) {
            lblWage.text = "시급 \(strHourlyWage) won"
        }
        else {
            lblWage.text = "시급 \(hourlyWage) won"
        }
    }
    
    func setHour(_ hour: Int) {
        lblTime.text = "\(hour)h"
    }
    
}

extension CalendarDetailViewController: DetailMoneyCellDelegate {
    func closedPressed(_ cell: DetailMoneyCell) {
        boolDetailMoney = false
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
        if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TodayMoneyCell {
            cell.showButton()
        }
    }
}

protocol TodayTimeCellDelegate: class {
    func openPressed(_ cell: TodayTimeCell)
}

internal class TodayTimeCell: UITableViewCell, OpenButtonProtocol, SeparatorViewProtocol {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    weak var delegate: TodayTimeCellDelegate?
    
    var additionalSeparator: UIView = UIView()
    
    override func awakeFromNib() {
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(10.0)
        
        additionalSeparator = UIView.init(frame: CGRect(x: 0, y: frame.size.height, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        additionalSeparator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(additionalSeparator)
        
        hideSeparator()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.openPressed(self)
        hideButton()
    }
    
    func showButton() {
        openButton.isHidden = false
    }
    
    func hideButton() {
        openButton.isHidden = true
    }
    
    func showSeparator() {
        additionalSeparator.isHidden = false
    }
    
    func hideSeparator() {
        additionalSeparator.isHidden = true
    }
    
}

extension CalendarDetailViewController: TodayTimeCellDelegate {
    func openPressed(_ cell: TodayTimeCell) {
        boolDetailTime = true
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

internal class DetailTimeHistoryCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    var date: Date = Date()
    
    func setTime(_ date: Date) {
        self.date = date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: self.date)
        
        lblTime.text = timeString
    }
    
    func setOn() {
        lblState.text = "On"
    }
    
    func setOff() {
        lblState.text = "Off"
    }
    
    
    
}

protocol DetailTimeCellDelegate: class {
    func closedPressed(_ cell: DetailTimeCell)
}

internal class DetailTimeCell: UITableViewCell {
    
    weak var delegate: DetailTimeCellDelegate?
    @IBOutlet weak var timeTableView: UITableView!
    var times: [Date] = []
    
    override func awakeFromNib() {
        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        timeTableView.separatorStyle = .none
        timeTableView.showsVerticalScrollIndicator = false;
        timeTableView.allowsSelection = false
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.closedPressed(self)
    }
    
    func setTimes(_ times: [Date]) {
        self.times = times
        timeTableView.reloadData()
    }
    
}

extension CalendarDetailViewController: DetailTimeCellDelegate {
    func closedPressed(_ cell: DetailTimeCell) {
        boolDetailTime = false
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
        if let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? TodayTimeCell {
            cell.showButton()
        }
    }
}

extension DetailTimeCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = timeTableView.dequeueReusableCell(withIdentifier: "timeHistoryCell", for: indexPath) as? DetailTimeHistoryCell else {
            return UITableViewCell()
        }
        
        cell.setTime(times[indexPath.row])
        
        if indexPath.row % 2 == 0 {
            // [ON]
            cell.setOn()
        }
        else {
            // [OFF]
            cell.setOff()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61.0
    }
}

internal class BenefitCell: UICollectionViewCell {
    
    @IBOutlet weak var extraImage: UIImageView!
    @IBOutlet weak var lblExtra: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var sepView: UIView!

    func showSeparator() {
        sepView.isHidden = false
    }
    
    func hideSeparator() {
        sepView.isHidden = true
    }
    
}

internal class EtcCell: UITableViewCell {
    
    @IBOutlet weak var extraCollectionView: UICollectionView!
    
    var extras: [ExtraPay] = []
    
    override func awakeFromNib() {
        extraCollectionView.delegate = self
        extraCollectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 86, height: 91)
        
        layout.scrollDirection = .horizontal
        
        self.extraCollectionView.setCollectionViewLayout(layout, animated: true)
        self.extraCollectionView.isPagingEnabled = true
    }
    
    func setExtras(_ extras: [ExtraPay]) {
        self.extras = extras
        extraCollectionView.reloadData()
    }
    
}

extension EtcCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return extras.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = extraCollectionView.dequeueReusableCell(withReuseIdentifier: "benefitCell", for: indexPath) as? BenefitCell else {
            return UICollectionViewCell()
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        cell.lblExtra.text = extras[indexPath.row].type.description()
        
        let price = extras[indexPath.row].value
        
        if let strExtraMoney = numberFormatter.string(from: NSNumber(value: price)) {
            cell.lblPay.text = strExtraMoney
        }
        else {
            cell.lblPay.text = "NONE"
        }
        
        if indexPath.row == extras.count - 1 {
            cell.hideSeparator()
        }
        else {
            cell.showSeparator()
        }
        
        return cell
    }
}

extension EtcCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.extraCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}

internal class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func setImage(_ img: UIImage) {
        self.image.image = img
    }
    
}

protocol PictureCellDelegate: class {
    func buttonPressed(_ pictureCell: PictureCell)
}

internal class PictureCell: UITableViewCell, OpenButtonProtocol, SeparatorViewProtocol {
 
    weak var delegate: PictureCellDelegate?
    
    @IBOutlet weak var pictureCollectionView: UICollectionView!
    @IBOutlet weak var openButton: UIButton!
    
    var additionalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var images: [UIImage] = []
    
    private var didUpdateConstraints: Bool = false
    
    override func awakeFromNib() {
        self.contentView.addSubview(additionalSeparator)
        self.setNeedsUpdateConstraints()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 140)
        
        self.pictureCollectionView.setCollectionViewLayout(layout, animated: true)
        self.pictureCollectionView.isPagingEnabled = true;
        self.pictureCollectionView.showsHorizontalScrollIndicator = false
        
        self.pictureCollectionView.dataSource = self
        hideCollectionView()
    }
    
    func setImages(images: [UIImage]) {
        self.images = images
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                additionalSeparator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:   0.0),
                additionalSeparator.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0.0),
                additionalSeparator.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0.0),
                additionalSeparator.heightAnchor.constraint(equalToConstant: 10.0)
                ])
            
            print("Run!")
            
            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.buttonPressed(self)
    }
    
    func showButton() {
        openButton.isHidden = false
    }
    
    func hideButton() {
        openButton.isHidden = true
    }
    
    func showSeparator() {
        additionalSeparator.isHidden = false
    }
    
    func hideSeparator() {
        additionalSeparator.isHidden = true
    }
    
    func showCollectionView() {
        pictureCollectionView.isHidden = false
    }
    
    func hideCollectionView() {
        pictureCollectionView.isHidden = true
    }
    
}

extension CalendarDetailViewController: PictureCellDelegate {
    func buttonPressed(_ pictureCell: PictureCell) {
        boolPicture = !boolPicture
        
        if boolPicture {
            pictureCell.showCollectionView()
        }
        else {
            pictureCell.hideCollectionView()
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

extension PictureCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: "pictureCollectionViewCell", for: indexPath) as? PictureCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setImage(images[indexPath.row])
        
        return cell
    }
}

extension CalendarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todayMoneyCell", for: indexPath) as? TodayMoneyCell else {
                return UITableViewCell()
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            if let strDailyWage = numberFormatter.string(from: NSNumber(value: selectedModel.dailyWage)) {
                cell.lblMoney.text = "\(strDailyWage) won"
            }
            else {
                cell.lblMoney.text = "\(selectedModel.dailyWage) won"
            }
            
            cell.delegate = self
            cell.showSeparator()
            
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailMoneyCell", for: indexPath) as? DetailMoneyCell else {
                return UITableViewCell()
            }
            
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowOffset = .zero
            cell.contentView.layer.shadowOpacity = 0.6
            cell.contentView.layer.shadowRadius = 10.0
            cell.contentView.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
            cell.contentView.layer.shouldRasterize = true
            
            cell.setHourlyWage(selectedModel.hourlyWage)
            cell.setHour(selectedModel.workingHour)
            cell.delegate = self
            return cell
        }
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todayTimeCell", for: indexPath) as? TodayTimeCell else {
                return UITableViewCell()
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            
            if selectedModel.times.count > 0 {
                let firstHour: String = formatter.string(from: selectedModel.times.first!)
                let lastHour: String = formatter.string(from: selectedModel.times.last!)
                
                cell.lblTime.text = "\(firstHour) - \(lastHour)"
            }
            else {
                cell.lblTime.text = "None"
            }
            
            cell.delegate = self
            cell.showSeparator()
            
            return cell
        }
        else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailTimeCell", for: indexPath) as? DetailTimeCell else {
                return UITableViewCell()
            }
            
            cell.setTimes(selectedModel.times)
            
            cell.delegate = self
            
            return cell
        }
        else if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as? PictureCell else {
                return UITableViewCell()
            }
            
            cell.setImages(images: selectedModel.pictures)
            
            cell.showSeparator()
            cell.delegate = self
            
            return cell
        }
        else if indexPath.row == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "etcCell", for: indexPath) as? EtcCell else {
                return UITableViewCell()
            }
            
            cell.setExtras(selectedModel.extraPaies)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 88.0 + 10.0
        }
        else if indexPath.row == 1 {
            if boolDetailMoney {
                return 101
            }
            else {
                return 0
            }
        }
        else if indexPath.row == 2 {
            return 146.0 + 10.0
        }
        else if indexPath.row == 3 {
            if boolDetailTime {
                return 204.0
            }
            else {
                return 0
            }
        }
        else if indexPath.row == 4 {
            if boolPicture {
                return 223.0 + 10.0
            }
            else {
                return 83 + 10.0
            }
        }
        else if indexPath.row == 5 {
            return 247.0
        }
        
        return 60.0
    }
}

extension Date {
    var dayBeforeYesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var today: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var dayAfterTomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    var isLastDayOfMonth: Bool {
        return Calendar.current.component(.month, from: tomorrow) != month
    }
}
