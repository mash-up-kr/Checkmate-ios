import UIKit

class TodayMoneyCell: UITableViewCell {
    
    @IBOutlet weak var lblMoney: UILabel!
    
    var additionalSeparator: UIView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(1.0)
        
        additionalSeparator = UIView.init(frame: CGRect(x: 0, y: frame.size.height - separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        addSubview(additionalSeparator)
        
        showSeparator()
    }
    
    func setMoney(money: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let strDailyWage = numberFormatter.string(from: NSNumber(value: money)) {
            lblMoney.text = "\(strDailyWage)"
        }
        else {
            lblMoney.text = "\(money)"
        }
    }
    
    func hideSeparator() {
        additionalSeparator.isHidden = true
    }

    func showSeparator() {
        additionalSeparator.isHidden = false
    }
    
}
