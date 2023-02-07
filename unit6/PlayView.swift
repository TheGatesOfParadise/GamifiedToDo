//
//  PlayView.swift
//  unit6
//
//  Created by Scarlett Ruan on 2/6/23.
//

import SwiftUI
import AVFoundation

struct PlayView: View {
    @EnvironmentObject var dataModel : DataModel
    @State var pet: AVAudioPlayer?
    @State var feed: AVAudioPlayer?
    @State var walk: AVAudioPlayer?
    
    var body: some View {
        NavigationView{
            VStack{
                CatView(cat: Cat.getSampleCat())
                    .border(.red)
                
                HStack{
                    Button(action:
                            {playPetSound()},
                           label:
                            {
                        Image(systemName: "heart.square")
                        Text("pet!")
                    })
                    .tint(.pink)
                    .padding()
                    
                    Button(action:
                            {playFeedSound()},
                           label:
                            {
                        Image(systemName: "fork.knife")
                        Text("feed!")
                    })
                    .tint(.mint)
                    .padding()
                    
                    Button(action:
                            {playWalkSound()},
                           label:
                            {
                        Image(systemName: "pawprint")
                        Text("walk!")
                    })
                    .tint(.purple)
                    .padding()
                }
            }
        }
    }
    
    
  // from this article:https://www.advancedswift.com/play-a-sound-in-swift/#play-a-sound-on-button-press
  func playPetSound() {
        // Load a local sound file
        guard let soundFileURL = Bundle.main.url(
            forResource: "pet",
            withExtension: "mp3"
        ) else {
            return
        }
        
        do {
            // Configure and activate the AVAudioSession
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback
            )

            try AVAudioSession.sharedInstance().setActive(true)

            // Play a sound
            let pet = try AVAudioPlayer(
                contentsOf: soundFileURL
            )

            pet.play()
        }
        catch {
            // Handle error
        }
    }
    
    func playFeedSound() {
          // Load a local sound file
          guard let soundFileURL = Bundle.main.url(
              forResource: "feed",
              withExtension: "mp3"
          ) else {
              return
          }
          
          do {
              // Configure and activate the AVAudioSession
              try AVAudioSession.sharedInstance().setCategory(
                  AVAudioSession.Category.playback
              )

              try AVAudioSession.sharedInstance().setActive(true)

              // Play a sound
              let feed = try AVAudioPlayer(
                  contentsOf: soundFileURL
              )

              feed.play()
          }
          catch {
              // Handle error
          }
      }
    
    func playWalkSound() {
          // Load a local sound file
          guard let soundFileURL = Bundle.main.url(
              forResource: "walk",
              withExtension: "mp3"
          ) else {
              return
          }
          
          do {
              // Configure and activate the AVAudioSession
              try AVAudioSession.sharedInstance().setCategory(
                  AVAudioSession.Category.playback
              )

              try AVAudioSession.sharedInstance().setActive(true)

              // Play a sound
              let walk = try AVAudioPlayer(
                  contentsOf: soundFileURL
              )

              walk.play()
          }
          catch {
              // Handle error
          }
      }

    
    struct CatView: View {
        var cat: Cat
        var body: some View {
            VStack (spacing: 0){
                Image(cat.parts.imageName)
                    .resizable()
                    .frame(width:iconWidth, height: iconWidth)
            }
            .padding()
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView().environmentObject(DataModel())
    }
}
