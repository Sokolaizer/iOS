//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Admin on 08.02.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Animals" : "🐼🐔🦄🐤🙊🐝🐞🐙",
        "Sports" : "🏀🏈⚾️🎱🎾🏐⚽️🎲",
        "Faces" : "😀😢😔😗😣🤬🤯😬"
    ]


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            
            if let themeName = (sender as? UIButton)?.currentTitle,
                let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
                
            }
        }
        
    }
    
}
