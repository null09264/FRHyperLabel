//
//  ViewController.swift
//  FRHyperLabelDemoSwift
//
//  Created by Jinghan Wang on 3/2/16.
//  Copyright © 2016 JW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var label: FRHyperLabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		label.numberOfLines = 0;
		
		//Step 1: Define a normal attributed string for non-link texts
		let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque quis blandit eros, sit amet vehicula justo. Nam at urna neque. Maecenas ac sem eu sem porta dictum nec vel tellus."
		
		let attributes = [NSForegroundColorAttributeName: UIColor.blackColor(),
			NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)]
		
		label.attributedText = NSAttributedString(string: string, attributes: attributes)
		
		//Step 2: Define a selection handler block
		let handler = {
			(hyperLabel: FRHyperLabel!, substring: String!) -> Void in
			let controller = UIAlertController(title: substring, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
			controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
			self.presentViewController(controller, animated: true, completion: nil)
		}
		
		//Step 3: Add link substrings
		label.setLinksForSubstrings(["Lorem", "Pellentesque", "blandit", "Maecenas"], withLinkHandler: handler)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

