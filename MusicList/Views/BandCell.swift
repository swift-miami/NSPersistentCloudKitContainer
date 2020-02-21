
import UIKit


class BandCell: UITableViewCell {
    
    //MARK: - Properties
    private var bandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(for: .title3, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK:
    private func setupCell() {
        contentView.addSubview(bandLabel)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            bandLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            bandLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bandLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            bandLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
        
    }
    
    
    
    //MARK: - Interface
    func configureBandCell(bandName: String?) {
        self.bandLabel.text = bandName
    }
    
}
