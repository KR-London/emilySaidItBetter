//
//  PlaygroundCodeToMakeModel.swift
//import Cocoa
//import NaturalLanguage
//import CreateML

//var str = "Hello, playground"
//
//
//struct Verse {
//
//    var lines = [String]()
//    var weights = [[Double]]()
//    var averagedWeight = [Double]()
//
//    init(lines: [String]){
//
//        self.lines = lines
//
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
//        }
//    }
//}
//
//
//var poemCollection = [Verse]()
//var rawString = ""
//
//if let filepath = Bundle.main.url(forResource: "Emily", withExtension: "tsv")
//{
//    do {
//        rawString = try String(contentsOf: filepath)
//    } catch{
//        print("oh no")
//    }
//}
//else{
//    print("Your filepath failed")
//}
//    ///remake the file without all the commas by taking it in from a single column
//
//var unprocessedVerses = rawString.components(separatedBy: "\r\n\r\n")
//    //print(unprocessedVerses.first!)
//
//for unprocessedVerse in unprocessedVerses {
//        //var lines = unprocessedVerses.first!.components(separatedBy: "\r\n")
//    var lines = unprocessedVerse.components(separatedBy: "\r\n")
//
//    print(lines.count)
//        // initialise the verse object, including working out their average vector
//    if lines.count > 1 {
//
//        for i in 0 ... lines.count-1 {
//            lines[i] = lines[i].replacingOccurrences(of: "\"", with: "")
//            lines[i] = lines[i].replacingOccurrences(of: "T ", with: "It ")
//            lines[i] = lines[i].trimmingCharacters(in: .whitespaces)
//        }
//
//        let verse = Verse(lines: lines)
//        poemCollection.append(verse)
//    }
//}
//
//var embeddingsDictionary = [String : [Double]]()
//
//for poem in poemCollection{
//    embeddingsDictionary[poem.lines.first!] = poem.averagedWeight
//}
//
//    //let embedding = try! MLWordEmbedding(dictionary: embeddingsDictionary)
//let embedding = try! MLEmbedding(dictionary: embeddingsDictionary)
//try embedding.write(to: URL(fileURLWithPath: "/tmp/Verse.mlmodel"))
