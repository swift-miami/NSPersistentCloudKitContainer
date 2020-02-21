//
//  UITableViewExt.swift
//  MusicList
//
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var tableCellReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func registerCell<T: UITableViewCell>(cellClass: T.Type) {
        register(T.self, forCellReuseIdentifier: T.tableCellReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let reuseIdentifier = T.tableCellReuseIdentifier
        
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T else {
            assertionFailure("Unable to dequeue Cell for ID: \(reuseIdentifier)")
            return T()
        }
        return cell
    }
    
    
    func setTableViewFullScreenConstraints(in view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


/*

 extension UITableView {
     
     func registerCell<T: UITableViewCell>(cellClass: T.Type) {
         register(T.self, forCellReuseIdentifier: T.cellReuseIdentifier)
     }
     
     func registerView<T: UITableViewHeaderFooterView>(viewClass: T.Type) {
      register(T.self, forHeaderFooterViewReuseIdentifier: T.viewReuseIdentifier)
     }
     
     func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
         let reuseIdentifier = T.cellReuseIdentifier
         
         guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T
             else {
                 assertionFailure("Unable to deque cell for \(reuseIdentifier)")
                 return T()
         }
         return cell
     }
     
     func dequeueReusableView<T: UITableViewHeaderFooterView>() -> T {
         let reuseIdentifier = T.viewReuseIdentifier
         
         guard let view = dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T
             else {
                 assertionFailure("Unable to dequeu view for \(reuseIdentifier)")
                 return T()
         }
         return view
     }
    
     
     func setFullScreenTableViewConstraints(in view: UIView) {
         NSLayoutConstraint.activate([
             topAnchor.constraint(equalTo: view.topAnchor),
             bottomAnchor.constraint(equalTo: view.bottomAnchor),
             leadingAnchor.constraint(equalTo: view.leadingAnchor),
             trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }
     
     func handleEmptyView(isEmpty: Bool, view: EmptyView) {
         UIView.animate(withDuration: 0.3) {
             self.backgroundView = isEmpty ? view : nil
         }
     }
 }


 */
