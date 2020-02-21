
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import UIKit

class AlbumsCell: UITableViewCell, CanWriteToDatabase {
    
    //MARK: Properties
    private var albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(for: .title3, weight: .thin)
        return label
    }()
    
    private var albumYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(for: .body, weight: .medium)
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
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(albumYearLabel)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            albumNameLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            albumNameLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            
            albumYearLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
            albumYearLabel.leadingAnchor.constraint(equalTo: albumNameLabel.leadingAnchor),
            albumYearLabel.trailingAnchor.constraint(equalTo: albumNameLabel.trailingAnchor),
            albumYearLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    
    
    //MARK: - Interface
    func configureAlbumCell(albumName: String?, albumYear: String?) {
        albumNameLabel.text = albumName
        albumYearLabel.text = albumYear
    }
    
}
