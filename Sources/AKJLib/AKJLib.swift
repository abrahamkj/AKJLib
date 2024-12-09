import Foundation
import UIKit

public struct AKJLib {
       
    public static func removeSpace(str: String?)->String{
      var retVal = ""
      if str != nil && !str!.isEmpty {
        retVal = str?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
      }
      return retVal
    }
    
    public static func removeExtraSpacesMorethan2(input: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "\\s{2,}", options: .caseInsensitive)
            let range = NSRange(location: 0, length: input.utf16.count)
            return regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: " ")
        } catch {
            print("Error creating regular expression: \(error.localizedDescription)")
            return input
        }
    }
    
    public static func GetCompanyCode(CompanyID : Int) -> String {
           var CodeName = ""
           switch CompanyID {
           case 1: CodeName = "HDE"
           case 3: CodeName = "HDK"
           case 4: CodeName = "HFR"
           case 5: CodeName = "HUS"
           case 10: CodeName = "RCS"
           case 11: CodeName = "ICME"
           case 13: CodeName = "ICE"
           case 16: CodeName = "FW"
           case 18: CodeName = "RCG"
           case 19: CodeName = "ISO"
           case 22: CodeName = "ICU"
           case 27: CodeName = "RSY"
           case 36: CodeName = "IUS"
          default:
               CodeName = "ICE"
           }
          return CodeName
          
        }
    
    
    public static func GetCompanyName(CompanyID : Int) -> String{
        var Name = ""
        switch CompanyID {
        case 1: Name = "HALDRUP GmbH"
        case 3: Name = "J. Haldrup A/S"
        case 4: Name = "HALDRUP France"
        case 5: Name = "HALDRUP USA"
        case 6: Name = "inotec USA"
        case 10: Name = "Inoclad GmbH"
        case 11: Name = "Inoclad Middle East FZ-LLC"
        case 13: Name = "Inoclad Engineering GmbH"
        case 14: Name = "RCH Holding"
        case 15: Name = "inotec GmbH & Co KG"
        case 16: Name = "Fenster Werner"
        case 17: Name = "FW Verwaltungs GmbH"
        case 18: Name = "RCH Gastro"
        case 19: Name = "INOSO GmbH"
        case 20: Name = "Rüdiger Hofmann"
        case 21: Name = "Claudia Hofmann"
        case 22: Name = "Inoclad USA"
        case 25: Name = "JLAH GmbH & Co. KG"
        case 26: Name = "JLAH Verwaltungs GmbH"
        case 27: Name = "RSY Green GmbH"
        case 36: Name = "Inotec USA Corp"
            
        default:
            Name = "Inoclad Group"
        }
        return Name
    }
    
   
    public static func capitalizeFirstLetter(_ inputString: String) -> String {
           // Check if the input string is not empty
           guard !inputString.isEmpty else {
               return inputString
           }
           // Convert the first character to uppercase and the rest to lowercase
           let firstLetter = inputString.prefix(1).uppercased()
           let restOfString = inputString.dropFirst().lowercased()
           
           // Combine the first uppercase letter with the lowercase rest of the string
           let capitalizedString = firstLetter + restOfString
           
           return capitalizedString
       }
       
    public static func TimeStamp() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "ddMMyyyyHHmmssSSS"
        let dateString: String = formatter.string(from: Date())
        let uniqueName: String = "\(dateString)"
        
        return uniqueName
    }
    
    
    public static func colorWithHexString (hex:String) -> UIColor {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
    public static func daysBetweenDates( endDate: Date) -> Int {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: endDate)
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }
    
    public static func formatAsEuro(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.currencySymbol = "€"
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            return "Error formatting currency"
        }
    }
  
    public enum DateConversionError: Error {
        case invalidFormat
        case nilInput
    }
    
    public enum ConversionMode {
        case toDate
        case toString
        case formatChange
    }

    public static func convertDate(_ input: Any?, mode: ConversionMode) throws -> Any {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSS"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        switch mode {
        case .toDate:
            guard let dateString = input as? String else {
                throw DateConversionError.nilInput
            }
            guard let date = inputDateFormatter.date(from: dateString) else {
                throw DateConversionError.invalidFormat
            }
            return date
        case .toString:
            guard let date = input as? Date else {
                throw DateConversionError.invalidFormat
            }
            return outputDateFormatter.string(from: date)
        case .formatChange:
            guard let dateString = input as? String else {
                throw DateConversionError.nilInput
            }
            guard let date = inputDateFormatter.date(from: dateString) else {
                throw DateConversionError.invalidFormat
            }
            return outputDateFormatter.string(from: date)
        }
    }
    
    public static func convertDate(_ input: Any?, mode: ConversionMode,inputFormat:String,outputFormat:String) throws -> Any {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = outputFormat
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        switch mode {
        case .toDate:
            guard let dateString = input as? String else {
                throw DateConversionError.nilInput
            }
            guard let date = inputDateFormatter.date(from: dateString) else {
                throw DateConversionError.invalidFormat
            }
            return date
        case .toString:
            guard let date = input as? Date else {
                throw DateConversionError.invalidFormat
            }
            return outputDateFormatter.string(from: date)
        case .formatChange:
            guard let dateString = input as? String else {
                throw DateConversionError.nilInput
            }
            guard let date = inputDateFormatter.date(from: dateString) else {
                throw DateConversionError.invalidFormat
            }
            return outputDateFormatter.string(from: date)
        }
    }
    
    public static func fileExtension(fromPath path: String) -> String? {
        // Create a URL from the given path
        if let url = URL(string: path) {
            // Get the path extension from the URL
            let fileExtension = url.pathExtension
            return fileExtension
        }
        return nil
    }
}
