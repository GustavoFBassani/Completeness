//
//  IconPickerViewModel.swift
//  Completeness
//
//  Created by Vítor Bruno on 30/09/25.
//

import SwiftUI

@Observable
class IconPickerViewModel: IconPickerViewModelProtocol {
    var searchText = ""
    var searchResults: [String] {
        if searchText.isEmpty {
            return []
        } else {
            let flattedAllIcons = allCategories.flatMap {$0.icons}
            return flattedAllIcons.filter {$0.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    let allCategories: [IconCategory] = [
            IconCategory(name: "Fitness", icons: [
                "figure.walk", "figure.run", "figure.pool.swim", "dumbbell.fill", "sportscourt.fill",
                "figure.strengthtraining.traditional", "bicycle", "figure.yoga", "figure.martial.arts",
                "soccerball", "basketball.fill", "tennis.racket", "flame.fill", "figure.hiking", "medal.fill"
            ]),
            IconCategory(name: "Saúde e Bem-estar", icons: [
                "heart.fill", "brain.head.profile", "lungs.fill", "bandage.fill", "bed.double.fill", "moon.fill",
                "cross.case.fill", "waveform.path.ecg", "eye.fill", "ear.fill", "thermometer.medium", "pills.fill", "stethoscope", "staroflife.fill", "figure.mind.and.body"
            ]),
            IconCategory(name: "Comida e Bebida", icons: [
                "fork.knife", "cup.and.saucer.fill", "takeoutbag.and.cup.and.straw.fill", "carrot.fill", "waterbottle.fill", "mug.fill",
                "wineglass.fill", "birthday.cake.fill", "spoon.serving", "oven.fill", "fish.fill", "stove.fill", "cart.fill", "frying.pan.fill", "apple.meditate"
            ]),
            IconCategory(name: "Casa e Trabalho", icons: [
                "house.fill", "briefcase.fill", "desktopcomputer", "trash.fill", "book.fill", "pencil.and.ruler.fill",
                "lightbulb.fill", "chair.lounge.fill", "wrench.adjustable.fill",
                "hammer.fill", "scissors", "key.fill", "lock.fill", "paperclip", "calendar"
            ]),
            IconCategory(name: "Natureza e Animais", icons: [
                "leaf.fill", "tree.fill", "mountain.2.fill", "camera.macro", "sun.max.fill", "cloud.rain.fill",
                "pawprint.fill", "wind", "snowflake", "drop.fill", "wave.3.right", 
                "bolt.fill", "ladybug.fill", "globe.americas.fill", "fossil.shell.fill"
            ]),
            IconCategory(name: "Hobbies e Diversão", icons: [
                "gamecontroller.fill", "music.mic", "paintpalette.fill", "movieclapper.fill", 
                "airplane", "map.fill", "dice.fill", "puzzlepiece.extension.fill", "photo.artframe",
                "ticket.fill", "headphones", "camera.fill", "guitars.fill",
                "paintbrush.pointed.fill", "theatermasks.fill"
            ]),
            IconCategory(name: "Símbolos Comuns", icons: [
                "star.fill", "flag.fill", "bell.fill", "bookmark.fill", "trophy.fill", "shield.fill",
                "hand.thumbsup.fill", "checkmark.seal.fill", "xmark.octagon.fill", 
                "gift.fill", "clock.fill", "gearshape.fill", "magnifyingglass",
                "paperplane.fill", "lightbulb.max.fill"
            ])
        ]
}
