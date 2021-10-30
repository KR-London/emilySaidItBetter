//
//  Verse.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 10/10/2021.
//

import Foundation
import NaturalLanguage

// I'd really rather take this in as a gazetter file to reduce risk of the first line being transcribed differently

// also a bit lame to remake this on every run 

struct Verse {
    
    var lines = [String]()
    //var weights = [[Double]]()
   // var averagedWeight = [Double]()
    
    init(lines: [String]){
        
        self.lines = lines
        
//        for line in lines {
//
//            if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english){
//
//                if let vector = sentenceEmbedding.vector(for: line){
//                    weights.append(vector)
//                }
//            }
//        }
//
//        for i in 0 ... weights[0].count - 1 {
//
//            var average = 0.0
//
//            for j in 0 ... weights.count - 1 {
//
//                average += weights[j][i]
//
//            }
//
//            average = average / Double(weights.count)
//            averagedWeight.append(average)
  //      }
    }
}
