import UIKit

class DetailTimeHistoryCell: UITableViewCell {
    
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
