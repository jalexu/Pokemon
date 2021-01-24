//
//  ImagesForPokemons.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import UIKit

protocol ProtocolImagesForPokemons {
    func setImage(_ url: String) -> Data
    func setImageOfPowers(typePower: String) -> UIImage
    func getColorForPower(namePower: String) -> UIColor
}

class ImagesForPokemons: ProtocolImagesForPokemons {
    
    
    func setImage(_ url: String) -> Data {
        let imageURL = URL(string: url)
        let imageData = try? Data(contentsOf: imageURL!)
        return imageData!
    }
    
    func setImageOfPowers(typePower: String) -> UIImage {
        
        guard let imgFormalities: UIImage = UIImage(named: typePower, in:
                                                        Bundle(identifier: "com.jaime.uribe.co.Pokemon"), compatibleWith: nil) else {
            let imgFormalityEmpty: UIImage = UIImage(named: "normal", in: Bundle(identifier: "com.jaime.uribe.co.Pokemon"), compatibleWith: nil)!
            return imgFormalityEmpty
        }
        
        return imgFormalities
    }
    
    func getColorForPower(namePower: String) -> UIColor{
        
        switch namePower {
            case DARK_POWER:
                return UIColor(red: 86 / 255, green: 101 / 255, blue: 115 / 255, alpha: 1)
            case ELECTRIC_POWER:
                return UIColor(red: 249 / 255, green: 231 / 255, blue: 159 / 255, alpha: 1)
            case FIRE_POWER:
                return UIColor(red: 245 / 255, green: 176 / 255, blue: 65 / 255, alpha: 1)
            case FLYING_POWER:
                return UIColor(red: 174 / 255, green: 214 / 255, blue: 241 / 255, alpha: 1)
            case GOST_POWER:
                return UIColor(red: 81 / 255, green: 106 / 255, blue: 172 / 255, alpha: 1)
            case GRASS_POWER:
                return UIColor(red: 95 / 255, green: 188 / 255, blue: 81 / 255, alpha: 1)
            case GROUND_POWER:
                return UIColor(red: 220 / 255, green: 117 / 255, blue: 69 / 255, alpha: 1)
            case PSYCHIC_POWER:
                return UIColor(red: 246 / 255, green: 111 / 255, blue: 113 / 255, alpha: 1)
            case ICE_POWER:
                return UIColor(red: 112 / 255, green: 204 / 255, blue: 189 / 255, alpha: 1)
            case STEEL_POWER:
                return UIColor(red: 82 / 255, green: 134 / 255, blue: 157 / 255, alpha: 1)
            case FIGHTING_POWER:
                return UIColor(red: 206 / 255, green: 66 / 255, blue: 101 / 255, alpha: 1)
            case NORMAL_POWER:
                return UIColor(red: 146 / 255, green: 152 / 255, blue: 164 / 255, alpha: 1)
            case FAIVY_POWER:
                return UIColor(red: 236 / 255, green: 140 / 255, blue: 229 / 255, alpha: 1)
            case BUG_POWER:
                return UIColor(red: 146 / 255, green: 188 / 255, blue: 44 / 255, alpha: 1)
            case POISON_POWER:
                return UIColor(red: 168 / 255, green: 100 / 255, blue: 199 / 255, alpha: 1)
            case WATER_POWER:
                return UIColor(red: 74 / 255, green: 144 / 255, blue: 221 / 255, alpha: 1)
            default:
                return UIColor(red: 236 / 255, green: 140 / 255, blue: 229 / 255, alpha: 1)
        }
    }
    
    
}
