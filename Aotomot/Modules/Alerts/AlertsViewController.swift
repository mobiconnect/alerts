//
//  AlertsViewController.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 11/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit

class AlertsViewController: BaseViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private let refreshControl:UIRefreshControl = UIRefreshControl()
  var alerts:[Alert] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.contentInsetAdjustmentBehavior = .never
    
    // Configure Refresh Control
    self.tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(getLatestNotifications), for: .valueChanged)
    
    let textHeaderView = UINib(nibName: "TextHeaderView", bundle: nil)
    self.tableView.register(textHeaderView, forHeaderFooterViewReuseIdentifier: "TextHeaderView")
    
    let contentEmptyFooter = UINib(nibName: "ContentEmptyFooter", bundle: nil)
    self.tableView.register(contentEmptyFooter, forHeaderFooterViewReuseIdentifier: "ContentEmptyFooter")
    
    self.postDeviceRegister()
  }

  private func postDeviceRegister(){
    APIData.shared.postDeviceRegister({_ in
      self.getLatestNotifications()
    })
  }
  
  @objc func getLatestNotifications() {
    APIData.shared.getAlerts({alertList in
      self.alerts = alertList
      self.tableView.reloadData()
      self.refreshControl.endRefreshing()
      self.animateViews(self.tableView.visibleCells)
    })
  }
}

extension AlertsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0))
    headerView.backgroundColor = UIColor.clear
    return headerView
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    if alerts.count == 0 {
      let cell=tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContentEmptyFooter") as! ContentEmptyFooter
      cell.icon.image = UIImage(named: "icon-notification-white")
      cell.updateView("No alerts to show")
      return cell
    } else {
      let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0))
      headerView.backgroundColor = UIColor.clear
      return headerView
    }
  }
}

extension AlertsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alerts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell=tableView.dequeueReusableCell(withIdentifier: "AlertsListCell", for: indexPath) as! AlertsListCell
    if indexPath.row < alerts.count{
      let alertsList = alerts[indexPath.row]
      cell.updateData(alertsList)
    }
    cell.selectionStyle = .none
    return cell
  }
}

