//
//  ViewController.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var failedToLoadView: UIView!
    
    var foreCastResult: Result!
    
    var days: [Day] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: String(describing: DayHeaderCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DayHeaderCell.self))
        tableView.register(UINib(nibName: String(describing: ForecastCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ForecastCell.self))
        
        if !Reachability().checkIfIsOnline() {
            self.tableView.isHidden = true
            self.failedToLoadView.isHidden = false
            return
        }
        
        loadWeather()
    }
    
    @IBAction func retryButton(_ sender: Any) {
        loadWeather()
    }
    
    func loadWeather() {
        self.tableView.isHidden = true
        self.failedToLoadView.isHidden = true
        
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        
        self.present(alert, animated: true, completion: nil)
        
        Networking().requestAPI().subscribe(onNext: { (result) in
            self.foreCastResult = result
            self.filterDays()
            alert.dismiss(animated: true, completion: nil)
            
            self.tableView.isHidden = false
            self.failedToLoadView.isHidden = true
        }, onError: { (error) in
            self.tableView.isHidden = true
            self.failedToLoadView.isHidden = false
            alert.dismiss(animated: true, completion: nil)
        })
    }
    
    func filterDays() {
        for result in foreCastResult.list {
            let date = NSDate(timeIntervalSince1970: Double(result.dateTime))
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date as Date)
            
            result.fullDate = components
            
            if days.isEmpty {
                let day = Day(fullDate: components)
                days.append(day)
            }else {
                var isDayAdded = false
                
                for day in days {
                    if components.day! == day.fullDate.day! {
                        isDayAdded = true
                    }
                }
                
                if !isDayAdded {
                    let day = Day(fullDate: components)
                    days.append(day)
                }
            }
            
            for day in days {
                if day.fullDate.day! == components.day! {
                    day.dayForecasts.append(result)
                }
            }
        }
        
        buildUI()
    }
    
    func buildUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days[section].dayForecasts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        vw.backgroundColor = UIColor.lightGray
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.width - 15, height: 30))
        label.text = String(format: "Day: %@/%@/%@", "\(days[section].fullDate.day!)", "\(days[section].fullDate.month!)", "\(days[section].fullDate.year!)")
        label.textColor = UIColor.black
        
        vw.addSubview(label)
        
        return vw
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ForecastCell.self), for:indexPath) as! ForecastCell
        
        cell.fillInformation(dayForeCast: days[indexPath.section].dayForecasts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
