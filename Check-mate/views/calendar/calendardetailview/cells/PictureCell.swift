import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func setImage(_ img: UIImage) {
        self.image.image = img
    }
    
}

class PictureCell: UITableViewCell, OpenButtonProtocol, SeparatorViewProtocol {
    
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
