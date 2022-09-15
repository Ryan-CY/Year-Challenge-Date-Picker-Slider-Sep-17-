//
//  ViewController.swift
//  Year Challenge-Date Picker,Slider
//
//  Created by Ryan Lin on 2022/9/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photosImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var annotationLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var timeWheel: UIDatePicker!
    
    let photos = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    let monthArray = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    let texts = ["嘻嘻...","騎車車","sweet dreams","乖寶寶樣～","幫我推一下","I love water","Knowledge is Power","feeling so good !!","Let's play together","picture time~","Happy Sunday School","吃吃吃..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sliderChange(_ sender: UISlider) {
        
        //手要鬆開，slider才會移到正確位置
        timeSlider.isContinuous = false
        
        //使slider只會跑到整數
        timeSlider.value.round()
        
        //連動ImageView
        photosImageView.image = UIImage(named: photos[Int(sender.value)])
        
        //連動Date Picker
        timeWheel.date = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: 2021, month: Int(timeSlider.value)+1, day: 1).date!
        
        //連動Label
        timeLabel.text = monthArray[Int(sender.value)]
        annotationLabel.text = texts[Int(sender.value)]
    }
    
    @IBAction func wheelChange(_ sender: Any) {
        
        //把Date Piocker存入dateComponents
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: timeWheel.date)
        
        //讓 dateComponents 的月份存入變數 month
        var month = dateComponents.month!
        
        //Array由0開始，因此月份需減1（複合運算子，相當於 month = month - 1）
        month -= 1
        
        //動連影像
        photosImageView.image = UIImage(named: photos[month])
     
        //連動slider
        timeSlider.setValue(Float(month), animated: true)
       
        //連動Label
        timeLabel.text = monthArray[Int(month)]
        annotationLabel.text = texts[Int(month)]
    }
    
    fileprivate func labelAndWheel() {
        
        //透過slider的值連動ImageView
        photosImageView.image = UIImage(named: photos[Int(timeSlider.value)])
        
        //連動Label
        timeLabel.text = monthArray[Int(timeSlider.value)]
        annotationLabel.text = texts[Int(timeSlider.value)]
        
        //連動Date Picker
        timeWheel.date = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: 2021, month: Int(timeSlider.value)+1, day: 1).date!
    }
    
    @IBAction func previousButton(_ sender: Any) {
        
        //讓previousButton可以循環
        if timeSlider.value == 0 {
            timeSlider.value = Float(photos.count-1)
        }
        else {
            timeSlider.value -= 1
        }
        
        labelAndWheel()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        //讓nextButton可以循環
        if timeSlider.value == Float(photos.count-1) {
            timeSlider.value = 0
        }
        else {
            timeSlider.value += 1
        }
        
      labelAndWheel()
    }
}
