import UIKit

class DayView: UIView {
    
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
