/*
s    Script: QuoteScript
    Author: Mikal Callahan
    Web:    http://mikalcallahan.me
            https://github.com/mikalcallahan
    Last Updated:   16 April 2017

    TODO: Colorize Quote
 */

 // #!/usr/bin/swift

import Foundation

var quoteArray = [String]() //  initialize array for quotes

/*
    Parse file and its contents

    - Returns: a string containing the conents of the file
 */
func readFile() -> String{
    var fileText = "null" // initialize fileText to null
    let filePath = NSString(string:"~/Documents/programming/scripts/QuoteScript/Resources/quotes.txt").expandingTildeInPath //this is the file. we will write to and read from it
    let fileManager = FileManager.default // intailize fileManager
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
    return fileText // return fileText
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
    print(quoteArray[quoteIndex]) // Print quote at selected index
}

let fileText = readFile()   //  fileText gets file contents
if fileText != "null"{  //  if fileText is not null
    addQuote(fileText: fileText)    //  call addQuote with list of quotes
    let quoteIndex = randQuote() //  quote index = returned index
    printQuote(quoteIndex: quoteIndex)  //  print out quote
}
