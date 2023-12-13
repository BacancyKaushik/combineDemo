//
//  bottomSheetVC.swift
//  combineLatest
//
//  Created by Kaushik on 12/12/23.
//

import UIKit
import Combine

class bottomSheetVC: UIViewController
{

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var FirstSlider: UISlider!
    @IBOutlet weak var SecondSlider: UISlider!
    
    let presetControlPassthroughSubject = PassthroughSubject<String, Never>()
    let firstCurrentValueSubject = CurrentValueSubject<Int, Never>(1)
    let secondCurrentValueSubject = CurrentValueSubject<Int, Never>(1)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    @IBAction func actionSegment(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            print("1")
            presetControlPassthroughSubject.send("1")
        case 1:
            print("2")
            presetControlPassthroughSubject.send("2")
        case 2:
            print("3")
            presetControlPassthroughSubject.send("3")
        default :
            break
        }
    }
    
    @IBAction func firstSliderChange(_ sender: UISlider)
    {
        let value = Int(sender.value)
        firstCurrentValueSubject.send(value)
        print(value)
    }
    @IBAction func secondSliderChange(_ sender: UISlider)
    {
        let value = Int(sender.value)
        print(value)
        secondCurrentValueSubject.send(value)
    }
}
