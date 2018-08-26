import UIKit

class BenefitCell: UICollectionViewCell {
    
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
