import UIKit

class DetailTimeHistoryCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblTimeAMPM: UILabel!
    
    @IBOutlet weak var innerView: UIView!
    
    var date: Date = Date()
    
    override func awakeFromNib() {
        innerView.layer.masksToBounds = false
        innerView.layer.cornerRadius = innerView.bounds.height / 2
        
        lblState.textColor = UIColor.white
        lblState.layer.masksToBounds = false
        lblState.clipsToBounds = true
        lblState.layer.cornerRadius = lblState.bounds.height / 2
    }
    
    func setTime(_ date: Date) {
        self.date = date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        formatter.amSymbol = "Am"
        formatter.pmSymbol = "Pm"
        let ampmString = formatter.string(from: self.date)
        
        lblTimeAMPM.text = ampmString
        
        formatter.dateFormat = "hh:mm"
        let timeString = formatter.string(from: self.date)
        
        lblTime.text = timeString
    }
    
    func setOn() {
        lblState.text = "On"
        lblState.backgroundColor = UIColor.init(red: 48 / 255, green: 79 / 255, blue: 254 / 255, alpha: 1.0)
    }
    
    func setOff() {
        lblState.text = "Off"
        lblState.backgroundColor = UIColor.init(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1.0)
    }
    
}
