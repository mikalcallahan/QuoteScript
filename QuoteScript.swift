#!/usr/bin/swift

/*
  Script: QuoteScript
  Author: Mikal Callahan
  Web:    http://mikalcallahan.me
          https://github.com/mikalcallahan
  Last Updated:   19 October 2017

  TODO: Colorize Quote
*/

import Foundation
//import RainbowSwift

var quoteArray = [String]() //  initialize array for quotes

/*
  Parse file and its contents

  - Returns: a string containing the conents of the file
 */
func readFile() -> String{
  var fileText: String? // initialize fileText to null
  // let filePath? = NSString(string:"~/Documents/development/scripts/QuoteScript/Resources/quotes.txt").expandingTildeInPath //this is the file. we will write to and read from it
  let filePath = NSString(string: "~/Documents/developpment/scripts/QuoteScript/Resources/quotes.txt").expandingTildeInPath
  let fileManager = FileManager.default // intailize fileManager
  // let filePath = fileManager.currentDirectoryPath + "/Resources/quotes.txt"
  if fileManager.fileExists(atPath: filePath){ // if the file is found
    do{
      fileText = try String(contentsOfFile: filePath, encoding: .utf8) // fileText gets its contents
    }
    catch{
      print("error: could not read from\n","\"",filePath,"\"") // catch inability to read
    }
  }
  else{
    print("error:","\"",filePath,"\"","not found") // warn file was not found
  }
    return fileText! // return fileText
}

/*
  Fills quote array from fileText
  Remove quoteArray's last item to account for newline at the end of the file

  - Parameter fileText: The String containing all quotes from the file
 */
func addQuote(fileText: String){
  quoteArray = fileText.components(separatedBy: .newlines)
  quoteArray.removeLast()
}

/*
  Chooses a random quotes from quoteArray
  Size gets quoteArray size, then it is returned

  - Returns: the index for the quote chosen
 */
func randQuote() -> Int{
  let size = UInt32(quoteArray.count) //  Size gets quoteArray size
  return Int(arc4random_uniform(size)) // Return size
}

/*
  Prints out the selected quote
 */
func printQuote(quoteIndex: Int){
  // print("Welcome Mikal,")
  print(quoteArray[quoteIndex]) // Print quote at selected index
}

let fileText : String? = readFile()   //  fileText gets file contents
if fileText != nil {  //  if fileText is not null
  addQuote(fileText: fileText!)    //  call addQuote with list of quotes
  let quoteIndex = randQuote() //  quote index = returned index
  printQuote(quoteIndex: quoteIndex)  //  print out quote
}
