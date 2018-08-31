import UIKit

class TodayTimeCell: UITableViewCell, OpenButtonProtocol {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    weak var delegate: TodayTimeCellDelegate?
    
//    var additionalSeparator: UIView = UIView()
//
//    override func awakeFromNib() {
//        let screenSize = UIScreen.main.bounds
//        let separatorHeight = CGFloat(10.0)
//
//        additionalSeparator = UIView.init(frame: CGRect(x: 0, y: frame.size.height, width: screenSize.width, height: separatorHeight))
//        additionalSeparator.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
//        additionalSeparator.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(additionalSeparator)
//
//        hideSeparator()
//    }
    
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
    
//    func showSeparator() {
//        additionalSeparator.isHidden = false
//    }
//
//    func hideSeparator() {
//        additionalSeparator.isHidden = true
//    }
    
}
