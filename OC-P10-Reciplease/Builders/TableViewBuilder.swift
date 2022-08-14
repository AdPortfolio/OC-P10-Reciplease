//
//  TableViewBuilder.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit

final class TableViewBuilder {
    
    private var backgroundColor = UIColor()
    private var cellClass: AnyClass?
    private var identifier = String()
    private var sectionIndexColor = UIColor()
    private var accessibilityLabel: String?
 
    func setBackgroundColor(color: UIColor) -> TableViewBuilder {
        self.backgroundColor = color
        return self
    }
    
    func registerCell(cellClass: AnyClass, and identifier: String) -> TableViewBuilder {
        self.cellClass = cellClass
        self.identifier = identifier
        return self
    }
    
    func setSectionIndexColor(color: UIColor) -> TableViewBuilder {
        self.sectionIndexColor = color
        return self
    }
    
    func setAccessibilityLabel(_ label: String?) -> TableViewBuilder {
        self.accessibilityLabel = label
        return self
    }
 
    func build() -> UITableView {
        let table = UITableView()
        table.backgroundColor = backgroundColor
        table.register(cellClass, forCellReuseIdentifier: identifier)
        table.refreshControl = UIRefreshControl()
        table.sectionIndexColor = sectionIndexColor
        table.accessibilityLabel = accessibilityLabel
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }
}
