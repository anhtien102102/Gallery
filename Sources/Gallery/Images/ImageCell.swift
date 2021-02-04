import UIKit
import Photos
let heightWidthSelected: CGFloat = 30
protocol ImageCellDelegate {
    func selectedImage(indexPath: IndexPath)
}
class ImageCell: UICollectionViewCell {

    lazy var imageView: UIImageView = self.makeImageView()
    lazy var highlightOverlay: UIView = self.makeHighlightOverlay()
    lazy var frameView: FrameView = self.makeFrameView()
    lazy var selectedBtn: UIButton = self.selectedView()
    lazy var titleView: UILabel = self.titleIndexView()
    var delegate:ImageCellDelegate?
    var indexPath: IndexPath?
    var isImage = true
  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Highlight

  override var isHighlighted: Bool {
    didSet {
      highlightOverlay.isHidden = !isHighlighted
    }
  }

  // MARK: - Config

  func configure(_ asset: PHAsset) {
    imageView.layoutIfNeeded()
    imageView.g_loadImage(asset)
  }

  func configure(_ image: Image) {
    configure(image.asset)
  }

  // MARK: - Setup

  func setup() {
    [imageView, frameView, highlightOverlay, selectedBtn, titleView].forEach {
      self.contentView.addSubview($0)
    }
    

    imageView.g_pinEdges()
    frameView.g_pinEdges()
    highlightOverlay.g_pinEdges()
  }

  // MARK: - Controls

  private func makeImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill

    return imageView
  }

  private func makeHighlightOverlay() -> UIView {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.backgroundColor = Config.Grid.FrameView.borderColor.withAlphaComponent(0.3)
    view.isHidden = true

    return view
  }

  private func makeFrameView() -> FrameView {
    let frameView = FrameView(frame: .zero)
    frameView.alpha = 0

    return frameView
  }
    
    private func selectedView() -> UIButton {
        let selectedButton = UIButton(frame: CGRect(x: self.frame.width - heightWidthSelected - 2, y: 4, width: heightWidthSelected, height: heightWidthSelected))
        selectedButton.alpha = 1
//        selectedButton.layer.borderColor = UIColor.gray.cgColor
//        selectedButton.layer.borderWidth = 1
        selectedButton.addTarget(self, action: #selector(selectedImage), for: .touchUpInside)
//        selectedButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        selectedButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        selectedButton.titleLabel?.font =  UIFont.systemFont(ofSize: 14)
        selectedButton.layer.cornerRadius = selectedButton.frame.width / 2
        selectedButton.setImage(GalleryBundle.image("radio_uncheck"), for: UIControl.State.normal)
        selectedButton.layer.masksToBounds = true
      return selectedButton
    }
    
    private func titleIndexView() -> UILabel {
        let label = UILabel(frame: CGRect(x: self.frame.width - heightWidthSelected - 2, y: 4, width: heightWidthSelected, height: heightWidthSelected))
        label.font =  UIFont.systemFont(ofSize: 14)
        
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        return label
    }
    
    @objc func selectedImage() {
        if let _delegate = self.delegate, let _indexPath = self.indexPath {
            _delegate.selectedImage(indexPath: _indexPath)
        }
    }
}
