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

var quoteArray = [String]()  //  initialize array for quotes

/*
  Parse file and its contents

  - Returns: a string containing the conents of the file
 */
func readFile() -> String {
  var fileText: String?  // initialize fileText to null
  // let filePath? = NSString(string:"~/Documents/development/scripts/QuoteScript/Resources/quotes.txt").expandingTildeInPath //this is the file. we will write to and read from it
  let filePath = NSString(string: "~/Developer/desktop/QuoteScript/Resources/quotes.txt")
    .expandingTildeInPath
  let fileManager = FileManager.default  // intailize fileManager
  // let filePath = fileManager.currentDirectoryPath + "/Resources/quotes.txt"
  if fileManager.fileExists(atPath: filePath) {  // if the file is found
    do {
      fileText = try String(contentsOfFile: filePath, encoding: .utf8)  // fileText gets its contents
    } catch {
      print("error: could not read from\n", "\"", filePath, "\"")  // catch inability to read
    }
  } else {
    print("error:", "\"", filePath, "\"", "not found")  // warn file was not found
  }
  return fileText!  // return fileText
}

/*
  Fills quote array from fileText
  Remove quoteArray's last item to account for newline at the end of the file

  - Parameter fileText: The String containing all quotes from the file
 */
func addQuote(fileText: String) {
  quoteArray = fileText.components(separatedBy: .newlines)
  quoteArray.removeLast()
}

/*
  Chooses a random quotes from quoteArray
  Size gets quoteArray size, then it is returned

  - Returns: the index for the quote chosen
 */
func randQuote<T>(value: [T]) -> Int {
  let size = UInt32(value.count)  //  Size gets quoteArray size
  return Int(arc4random_uniform(size))  // Return size
}

/*
  Prints out the selected quote
 */
func printQuote(quoteIndex: Int) {
  // print("Welcome Mikal,")
  print(quoteArray[quoteIndex])  // Print quote at selected index
}

let fileText: String? = readFile()  //  fileText gets file contents
if fileText != nil {  //  if fileText is not null
  let decoder = JSONDecoder()
  addQuote(fileText: fileText!)  //  call addQuote with list of quotes
  let defaultQuote: Quotes = try decoder.decode(
    Quotes.self,
    from:
      Data(
        """
        {
        "quotes": [
        {
        "author": "Edward S. Balian",
        "text": "Are you treating yourself like a business?"
        },
        {
        "author": "Eckhart Tolle",
        "text": "Accept every moment as if you had chosen it"
        },
        {
        "author":"Eckhart Tolle",
        "text": "Live in a space of 'no time' and pay visits to clock time when necessary."
        }
        ]
        }
        """.utf8))
  // let quotes = readLocalJSONFile(forName: "./quotes.json")
  // print("quotes", defaultQuote.quotes[0].author)
  let quoteIndex = randQuote(value: defaultQuote.quotes)  //  quote index = returned index
  let quote = defaultQuote.quotes[quoteIndex]
  print("\(quote.text)\n- \(quote.author)")
  // printQuote(quoteIndex: quoteIndex)  //  print out quote
}

struct Quote: Codable {
  let author: String
  let text: String
}

struct Quotes: Codable {
  let quotes: [Quote]
}

func decodeJsonFromData(data: Data) -> Quotes? {
   let decoder = JSONDecoder()
   // print("data", data)
  guard
    let quotes = try? decoder.decode(Quotes.self, from: data)
  else {
    return nil
  }

  return quotes 
}

func readLocalJSONFile(forName name: String) -> Data? {
  // print("readlocaljson", name)
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
          // print("in if")
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

func loadJson(fileName: String) -> Quote? {
  let decoder = JSONDecoder()
  guard
    let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
    let data = try? Data(contentsOf: url),
    let quotes = try? decoder.decode(Quote.self, from: data)
  else {
    return nil
  }

  return quotes
}
