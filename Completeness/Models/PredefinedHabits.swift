//
//  PredefinedHabits.swift
//  Completeness
//
//  Created by Gustavo Melleu on 22/09/25.
//

//
//  PredefinedHabits.swift
//  Completeness
//
//  Created by Gustavo Melleu on 22/09/25.
//

import Foundation

enum PredefinedHabits: String, CaseIterable, Identifiable {
    case drinkWater
    case meditate
    case vitamins
    case stretch
    case skincare
    case gratitude
    case makeBed
    case walk
    case noSocialMedia
    case callFriends
    case journal
    case eatHealthy
    case tea
    case brushTeeth
    case hug
    case noScreens
    case coldShower
    case smile
    case noSmoking
    case checkAgenda
    case checkEmails
    case takeStairs
    case beGrateful
    case readPages
    case ideas
    case trackExpenses
    case breathing
    case sendAudio
    case drinkCoffee
    case mobility
    case takePhotos
    case washHands
    case refillBottle
    case fixPosture
    case familyTime
    case write
    case learnNew
    case draw
    case steps
    case study
    case reading
    case walking
    case running
    case meditation
    case yoga
    case cook
    case rest
    case noScreensAlt
    case pomodoro
    case sleep
    case outdoors
    case listenMusic
    case petCare
    case learnLanguages
    case creativity
    case cleaning
    case organize
    case podcast

    var id: String { rawValue }

    var habitName: String {
        switch self {
        case .drinkWater: return "Água"
        case .meditate: return "Meditar"
        case .vitamins: return "Vitaminas"
        case .stretch: return "Alongar"
        case .skincare: return "Skincare"
        case .gratitude: return "Gratidão"
        case .makeBed: return "Arrumar a cama"
        case .walk: return "Caminhar"
        case .noSocialMedia: return "Sem redes sociais"
        case .callFriends: return "Ligar para amigos"
        case .journal: return "Escrever diário"
        case .eatHealthy: return "Comer saudável"
        case .tea: return "Chá"
        case .brushTeeth: return "Escovar os dentes"
        case .hug: return "Dar um abraço"
        case .noScreens, .noScreensAlt: return "Sem telas"
        case .coldShower: return "Banho frio"
        case .smile: return "Sorriso"
        case .noSmoking: return "Sem fumar"
        case .checkAgenda: return "Checar agenda"
        case .checkEmails: return "Revisar e-mails"
        case .takeStairs: return "Subir escadas"
        case .beGrateful: return "Ser grato"
        case .readPages: return "Ler páginas"
        case .ideas: return "Anotar ideias"
        case .trackExpenses: return "Registrar gastos"
        case .breathing: return "Exercício de respiração"
        case .sendAudio: return "Mandar áudio"
        case .drinkCoffee: return "Beber café"
        case .mobility: return "Mobilidade"
        case .takePhotos: return "Tirar fotos"
        case .washHands: return "Lavar as mãos"
        case .refillBottle: return "Encher garrafa d’água"
        case .fixPosture: return "Arrumar postura"
        case .familyTime: return "Estar em família"
        case .write: return "Escrever"
        case .learnNew: return "Aprender algo novo"
        case .draw: return "Desenhar"
        case .steps: return "Dar passos"
        case .study: return "Estudar"
        case .reading: return "Leitura"
        case .walking: return "Caminhada"
        case .running: return "Correr"
        case .meditation: return "Meditação"
        case .yoga: return "Yoga"
        case .cook: return "Cozinhar"
        case .rest: return "Descansar"
        case .pomodoro: return "Pomodoro"
        case .sleep: return "Dormir bem"
        case .outdoors: return "Ar livre"
        case .listenMusic: return "Ouvir música"
        case .petCare: return "Cuidar do pet"
        case .learnLanguages: return "Estudar idiomas"
        case .creativity: return "Criatividade"
        case .cleaning: return "Limpeza"
        case .organize: return "Organizar"
        case .podcast: return "Ouvir podcast"
        }
    }
    var completionType: CompletionHabit {
            switch self {
            case .drinkWater: return .byMultipleToggle
            case .meditate: return .byToggle
            case .vitamins: return .byToggle
            case .stretch: return .byToggle
            case .skincare: return .byToggle
            case .gratitude: return .byToggle
            case .makeBed: return .byToggle
            case .walk: return .byToggle
            case .noSocialMedia: return .byToggle
            case .callFriends: return .byToggle
            case .journal: return .byToggle
            case .eatHealthy: return .byToggle
            case .tea: return .byToggle
            case .brushTeeth: return .byToggle
            case .hug: return .byToggle
            case .noScreens: return .byToggle
            case .coldShower: return .byToggle
            case .smile: return .byToggle
            case .noSmoking: return .byToggle
            case .checkAgenda: return .byToggle
            case .checkEmails: return .byMultipleToggle
            case .takeStairs: return .byMultipleToggle
            case .beGrateful: return .byMultipleToggle
            case .readPages: return .byMultipleToggle
            case .ideas: return .byMultipleToggle
            case .trackExpenses: return .byMultipleToggle
            case .breathing: return .byMultipleToggle
            case .sendAudio: return .byMultipleToggle
            case .drinkCoffee: return .byToggle
            case .mobility: return .byToggle
            case .takePhotos: return .byToggle
            case .washHands: return .byToggle
            case .refillBottle: return .byToggle
            case .fixPosture: return .byToggle
            case .familyTime: return .byToggle
            case .write: return .byToggle
            case .learnNew: return .byToggle
            case .draw: return .byToggle
            case .steps: return .byToggle
            case .study: return .byTimer
            case .reading: return .byTimer
            case .walking: return .byTimer
            case .running: return .byTimer
            case .meditation: return .byTimer
            case .yoga: return .byTimer
            case .cook: return .byTimer
            case .rest: return .byTimer
            case .noScreensAlt: return .byTimer
            case .pomodoro: return .byToggle
            case .sleep: return .byToggle
            case .outdoors: return .byToggle
            case .listenMusic: return .byToggle
            case .petCare: return .byToggle
            case .learnLanguages: return .byToggle
            case .creativity: return .byToggle
            case .cleaning: return .byToggle
            case .organize: return .byToggle
            case .podcast: return .byToggle
            }
        }

    var habitSimbol: String {
        switch self {
        case .drinkWater, .refillBottle: return "drop.fill"
        case .meditate, .meditation: return "brain.head.profile"
        case .vitamins: return "pills.fill"
        case .stretch, .mobility: return "figure.cooldown"
        case .skincare: return "hands.and.sparkles"
        case .gratitude, .beGrateful: return "heart.text.square.fill"
        case .makeBed: return "bed.double.fill"
        case .walk, .walking, .steps: return "figure.walk"
        case .noSocialMedia: return "antenna.radiowaves.left.and.right.slash"
        case .callFriends: return "phone.arrow.up.right.fill"
        case .journal, .write: return "book.closed.fill"
        case .eatHealthy: return "carrot"
        case .tea: return "cup.and.saucer.fill"
        case .brushTeeth: return "mouth.fill"
        case .hug: return "person.2.fill"
        case .noScreens, .noScreensAlt: return "tv.slash.fill"
        case .coldShower: return "snowflake"
        case .smile: return "face.smiling.inverse"
        case .noSmoking: return "nosign.app.fill"
        case .checkAgenda: return "calendar"
        case .checkEmails: return "envelope.fill"
        case .takeStairs: return "figure.stairs"
        case .readPages, .reading: return "book.pages.fill"
        case .ideas: return "lightbulb.fill"
        case .trackExpenses: return "dollarsign.circle.fill"
        case .breathing: return "lungs.fill"
        case .sendAudio: return "microphone.fill"
        case .drinkCoffee: return "cup.and.saucer.fill"
        case .takePhotos: return "camera.fill"
        case .washHands: return "water.waves"
        case .fixPosture: return "figure.seated.side.right"
        case .familyTime: return "person.3.fill"
        case .learnNew: return "graduationcap.fill"
        case .draw: return "pencil.and.ruler.fill"
        case .study, .learnLanguages: return "book.fill"
        case .running: return "figure.run.treadmill"
        case .yoga: return "figure.mind.and.body"
        case .cook: return "fork.knife"
        case .rest: return "eye.fill"
        case .pomodoro: return "gauge.with.needle.fill"
        case .sleep: return "powersleep"
        case .outdoors: return "leaf.fill"
        case .listenMusic: return "music.note"
        case .petCare: return "pawprint.fill"
        case .creativity: return "paintpalette.fill"
        case .cleaning: return "dishwasher.fill"
        case .organize: return "house.fill"
        case .podcast: return "headphones"
        }
    }
}
