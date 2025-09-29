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
        // MARK: - byToggle (Habitos done/undone)
        case .meditate, .vitamins, .stretch, .skincare,
             .gratitude, .makeBed, .walk, .noSocialMedia,
             .callFriends, .journal, .eatHealthy, .tea,
             .brushTeeth, .hug, .noScreens, .coldShower,
             .smile, .noSmoking, .checkAgenda:
            return .byToggle

        // MARK: - byMultipleToggle (Habitos Steps)
        case .drinkWater, .checkEmails, .takeStairs,
             .beGrateful, .readPages, .ideas,
             .trackExpenses, .breathing, .sendAudio,
             .drinkCoffee, .mobility, .takePhotos,
             .washHands, .refillBottle, .fixPosture,
             .familyTime, .write, .learnNew,
             .draw, .steps:
            return .byMultipleToggle

        // MARK: - byTimer (Habitos Timer)
        case .study, .reading, .walking, .running,
             .meditation, .yoga, .cook, .rest,
             .noScreensAlt, .pomodoro,
             .sleep, .outdoors, .listenMusic,
             .petCare, .learnLanguages, .creativity,
             .cleaning, .organize, .podcast:
            return .byTimer
        }
    }
    
    var habitSimbol: String {
        switch self {
        case .drinkWater: return "drop.fill"
        case .refillBottle: return "waterbottle.fill"
        case .meditate: return "brain.head.profile"
        case .meditation: return "brain.fill"
        case .vitamins: return "pills.fill"
        case .stretch: return "figure.cooldown"
        case .mobility: return "figure.flexibility"
        case .skincare: return "hands.and.sparkles"
        case .gratitude: return "heart.text.square.fill"
        case .beGrateful: return "hands.clap.fill"
        case .makeBed: return "bed.double.fill"
        case .walk: return "figure.walk"
        case .walking: return "figure.walk.treadmill"
        case .steps: return "shoeprints.fill"
        case .noSocialMedia: return "antenna.radiowaves.left.and.right.slash"
        case .callFriends: return "phone.arrow.up.right.fill"
        case .journal: return "book.closed.fill"
        case .write: return "pencil.and.scribble"
        case .eatHealthy: return "carrot"
        case .tea: return "cup.and.saucer.fill"
        case .brushTeeth: return "mouth.fill"
        case .hug: return "person.2.fill"
        case .noScreens: return "tv.slash.fill"
        case .noScreensAlt: return "iphone.slash"
        case .coldShower: return "snowflake"
        case .smile: return "face.smiling.inverse"
        case .noSmoking: return "nosign.app.fill"
        case .checkAgenda: return "calendar"
        case .checkEmails: return "envelope.fill"
        case .takeStairs: return "figure.stairs"
        case .readPages: return "book.pages.fill"
        case .reading: return "text.book.closed.fill"
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
        case .study:  return "book.fill"
        case .learnLanguages: return "character.book.closed.fill"
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
