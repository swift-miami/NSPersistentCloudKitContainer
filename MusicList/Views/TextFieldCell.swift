//
//  TextFieldCell.swift
//  MusicList
//
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    //MARK: - Properties
    private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(for: .title1, weight: .bold)
        textField.adjustsFontForContentSizeCategory = true
        return textField
    }()
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Layout
    private func setupCell() {
        contentView.addSubview(textField)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            textField.topAnchor.constraint(equalTo: guide.topAnchor),
            textField.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
        
        backgroundColor = .secondarySystemBackground
        selectionStyle = .none
    }
    
    
    //MARK: - Interface
    func configureTextFieldCell(placeholder: TextFieldPlaceholder, textFieldDelegate: UITextFieldDelegate) {
        self.textField.placeholder = placeholder.rawValue
        self.textField.delegate = textFieldDelegate
    }
    
    
}

enum TextFieldPlaceholder: String {
    case Band = "Add a new band"
    case Album = "Add a new album"
}
