
import UIKit

typealias JSON = [String : Any]

extension UserDefaults {
    func load<T>(withKey key: String, type: T.Type) -> T? {
        let userDefault = UserDefaults.standard
        switch type {
        case is String.Type:
            return userDefault.string(forKey: key) as? T
        case is Int.Type:
            return userDefault.integer(forKey: key) as? T
        case is Double.Type:
            return userDefault.double(forKey: key) as? T
        case is Float.Type:
            return userDefault.float(forKey: key) as? T
        case is Data.Type:
            return userDefault.data(forKey: key) as? T
        case is URL.Type:
            return  userDefault.url(forKey: key) as? T
        case is [String].Type:
            return userDefault.stringArray(forKey: key) as? T
        case is Bool.Type:
            return userDefault.bool(forKey: key) as? T
        case is JSON.Type:
            return userDefault.dictionary(forKey: key) as? T
        default:
            return userDefault.object(forKey: key) as? T
        }
        
    }
    
    func save<T>(withKey key: String, value: T?) -> Bool {
        guard let value = value else {return false}
        let userDefault = UserDefaults.standard
        switch value {
        case is String:
            userDefault.set( value as! String, forKey: key)
        case is Int:
            userDefault.set( value as! Int, forKey: key)
        case is Double:
            userDefault.set( value as! Double, forKey: key)
        case is Float:
            userDefault.set( value as! Float, forKey: key)
        case is Data:
            userDefault.set( value as! Data, forKey: key)
        case is URL:
            userDefault.set( value as? URL, forKey: key)
        case is [String]:
            userDefault.set( value as! [String], forKey: key)
        case is Bool:
            userDefault.set( value as! Bool, forKey: key)
        case is JSON:
            userDefault.set( value as! Bool, forKey: key)
        default:
            userDefault.set( value, forKey: key)
            
        }
        UserDefaults.standard.synchronize()
        return true
        
    }
}
