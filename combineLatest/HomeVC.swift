//
//  HomeVC.swift
//  combineLatest
//
//  Created by Kaushik on 12/12/23.
//

import UIKit
import Combine

class HomeVC: UIViewController 
{

    @IBOutlet weak var lblselectedSegment: UILabel!
    @IBOutlet weak var lblFirstValue: UILabel!
    @IBOutlet weak var lblSecondValue: UILabel!
    
    var subscription   = Set<AnyCancellable>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    @IBAction func actionOpenSheet(_ sender: Any) 
    {
        guard let bottomVC : bottomSheetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bottomSheetVC") as? bottomSheetVC
        else{return}
        if let sheet = bottomVC.sheetPresentationController
        {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = true
        }
        
        // Listening
        bottomVC.presetControlPassthroughSubject
            .sink{
                [weak self] preset in
                self?.lblselectedSegment.text = preset
            }
            .store(in: &self.subscription)
        
        bottomVC.firstCurrentValueSubject
            .sink{
                [weak self] preset in
                self?.lblFirstValue.text = "\(preset)"
            }
            .store(in: &self.subscription)
        bottomVC.secondCurrentValueSubject
            .sink{
                [weak self] preset in
                self?.lblSecondValue.text = "\(preset)"
            }
            .store(in: &self.subscription)
        
        
        
        self.present(bottomVC, animated: true, completion: nil)
    }
    
    @IBAction func actionBack(_ sender: Any)
    {
        self.navigationController!.popViewController(animated: true)
    }
}
