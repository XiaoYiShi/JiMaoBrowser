////
////  CCKit_URL_Extension.swift
////  CCKitDemo
////
////  Created by 史晓义 on 2019/7/15.
////  Copyright © 2019 Tomas. All rights reserved.
////
//
//import UIKit
//
//
////MARK: Private Helpers
//private extension URL {
//    func publicSuffixFromHost( _ host: String, withAdditionalParts additionalPartCount: Int) -> String? {
//        if host.isEmpty {
//            return nil
//        }
//
//        // Check edge case where the host is either a single or double '.'.
//        if host.isEmpty || NSString(string: host).lastPathComponent == "." {
//            return ""
//        }
//
//        /**
//         *  The following algorithm breaks apart the domain and checks each sub domain against the effective TLD
//         *  entries from the effective_tld_names.dat file. It works like this:
//         *
//         *  Example Domain: test.bbc.co.uk
//         *  TLD Entry: bbc
//         *
//         *  1. Start off by checking the current domain (test.bbc.co.uk)
//         *  2. Also store the domain after the next dot (bbc.co.uk)
//         *  3. If we find an entry that matches the current domain (test.bbc.co.uk), perform the following checks:
//         *    i. If the domain is a wildcard AND the previous entry is not nil, then the current domain matches
//         *       since it satisfies the wildcard requirement.
//         *    ii. If the domain is normal (no wildcard) and we don't have anything after the next dot, then
//         *        currentDomain is a valid TLD
//         *    iii. If the entry we matched is an exception case, then the base domain is the part after the next dot
//         *
//         *  On the next run through the loop, we set the new domain to check as the part after the next dot,
//         *  update the next dot reference to be the string after the new next dot, and check the TLD entries again.
//         *  If we reach the end of the host (nextDot = nil) and we haven't found anything, then we've hit the
//         *  top domain level so we use it by default.
//         */
//
//        let tokens = host.components(separatedBy: ".")
//        let tokenCount = tokens.count
//        var suffix: String?
//        var previousDomain: String? = nil
//        var currentDomain: String = host
//
//        for offset in 0..<tokenCount {
//            // Store the offset for use outside of this scope so we can add additional parts if needed
//            let nextDot: String? = offset + 1 < tokenCount ? tokens[offset + 1..<tokenCount].joined(separator: ".") : nil
//
//            if let entry = etldEntries?[currentDomain] {
//                if entry.isWild && (previousDomain != nil) {
//                    suffix = previousDomain
//                    break
//                } else if entry.isNormal || (nextDot == nil) {
//                    suffix = currentDomain
//                    break
//                } else if entry.isException {
//                    suffix = nextDot
//                    break
//                }
//            }
//
//            previousDomain = currentDomain
//            if let nextDot = nextDot {
//                currentDomain = nextDot
//            } else {
//                break
//            }
//        }
//
//        var baseDomain: String?
//        if additionalPartCount > 0 {
//            if let suffix = suffix {
//                // Take out the public suffixed and add in the additional parts we want.
//                let literalFromEnd: NSString.CompareOptions = [NSString.CompareOptions.literal,        // Match the string exactly.
//                    NSString.CompareOptions.backwards,      // Search from the end.
//                    NSString.CompareOptions.anchored]         // Stick to the end.
//                let suffixlessHost = host.replacingOccurrences(of: suffix, with: "", options: literalFromEnd, range: nil)
//                let suffixlessTokens = suffixlessHost.components(separatedBy: ".").filter { $0 != "" }
//                let maxAdditionalCount = max(0, suffixlessTokens.count - additionalPartCount)
//                let additionalParts = suffixlessTokens[maxAdditionalCount..<suffixlessTokens.count]
//                let partsString = additionalParts.joined(separator: ".")
//                baseDomain = [partsString, suffix].joined(separator: ".")
//            } else {
//                return nil
//            }
//        } else {
//            baseDomain = suffix
//        }
//
//        return baseDomain
//    }
//}
//
//// MARK: - Local Resource URL Extensions
//extension URL {
//    //
//    //    public func `init`(string: String) -> URL {
//    //        guard let url = URL(string: string) else {
//    //            fatalError("构造URL失败！")
//    //        }
//    //        return url
//    //    }
//
//    public func allocatedFileSize() -> Int64 {
//        // First try to get the total allocated size and in failing that, get the file allocated size
//        return getResourceLongLongForKey(URLResourceKey.totalFileAllocatedSizeKey.rawValue)
//            ?? getResourceLongLongForKey(URLResourceKey.fileAllocatedSizeKey.rawValue)
//            ?? 0
//    }
//
//    public func getResourceValueForKey(_ key: String) -> AnyObject? {
//        var val: AnyObject?
//        //        do {
//        //            try getResourceValue(&val, forKey: URLResourceKey(rawValue: key))
//
//        //
//        //        } catch _ {
//        //            return nil
//        //        }
//        var keys = Set<URLResourceKey>()
//        keys.insert(URLResourceKey.isDirectoryKey)
//        do{
//            val = try self.resourceValues(forKeys: keys) as AnyObject
//        }catch _{
//            return nil
//        }
//        return val
//    }
//
//    public func getResourceLongLongForKey(_ key: String) -> Int64? {
//        return (getResourceValueForKey(key) as? NSNumber)?.int64Value
//    }
//
//    public func getResourceBoolForKey(_ key: String) -> Bool? {
//        return getResourceValueForKey(key) as? Bool
//    }
//
//    public var isRegularFile: Bool {
//        return getResourceBoolForKey(URLResourceKey.isRegularFileKey.rawValue) ?? false
//    }
//
//    public func lastComponentIsPrefixedBy(_ prefix: String) -> Bool {
//        return (pathComponents.last?.hasPrefix(prefix) ?? false)
//    }
//}
//
//// The list of permanent URI schemes has been taken from http://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml
//private let permanentURISchemes = ["aaa", "aaas", "about", "acap", "acct", "cap", "cid", "coap", "coaps", "crid", "data", "dav", "dict", "dns", "example", "file", "ftp", "geo", "go", "gopher", "h323", "http", "https", "iax", "icap", "im", "imap", "info", "ipp", "ipps", "iris", "iris.beep", "iris.lwz", "iris.xpc", "iris.xpcs", "jabber", "ldap", "mailto", "mid", "msrp", "msrps", "mtqp", "mupdate", "news", "nfs", "ni", "nih", "nntp", "opaquelocktoken", "pkcs11", "pop", "pres", "reload", "rtsp", "rtsps", "rtspu", "service", "session", "shttp", "sieve", "sip", "sips", "sms", "snmp", "soap.beep", "soap.beeps", "stun", "stuns", "tag", "tel", "telnet", "tftp", "thismessage", "tip", "tn3270", "turn", "turns", "tv", "urn", "vemmi", "vnc", "ws", "wss", "xcon", "xcon-userid", "xmlrpc.beep", "xmlrpc.beeps", "xmpp", "z39.50r", "z39.50s"]
//
//extension URL {
//
//    //    public func withQueryParams(params: [NSURLQueryItem]) -> NSURL {
//    //        let components = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)!
//    //        var items = (components.queryItems ?? [])
//    //        for param in params {
//    //            items.append(param)
//    //        }
//    //        components.queryItems = items
//    //        return components.URL!
//    //    }
//    //
//    //    public func withQueryParam(name: String, value: String) -> NSURL {
//    //        let components = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)!
//    //        let item = NSURLQueryItem(name: name, value: value)
//    //        components.queryItems = (components.queryItems ?? []) + [item]
//    //        return components.URL!
//    //    }
//    //
//    //    public func getQuery() -> [String: String] {
//    //        var results = [String: String]()
//    //        let keyValues = self.query?.componentsSeparatedByString("&")
//    //
//    //        if keyValues?.count > 0 {
//    //            for pair in keyValues! {
//    //                let kv = pair.componentsSeparatedByString("=")
//    //                if kv.count > 1 {
//    //                    results[kv[0]] = kv[1]
//    //                }
//    //            }
//    //        }
//    //
//    //        return results
//    //    }
//
//    //    public var hostPort: String? {
//    //        if let host = self.host {
//    //            if let port = self.port?.intValue {
//    //                return "\(host):\(port)"
//    //            }
//    //            return host
//    //        }
//    //        return nil
//    //    }
//
//    public var origin: String? {
//        guard isWebPage(includeDataURIs: false),
//            let hostPort = self.hostPort else {
//                return nil
//        }
//
//        return "\(String(describing: scheme))://\(hostPort)"
//    }
//    
//    public func normalizedHostAndPath() -> String? {
//        if let normalizedHost = self.normalizedHost() {
//            return normalizedHost + (self.path )
//        }
//        return nil
//    }
//
//    public func absoluteDisplayString() -> String? {
//        var urlString = self.absoluteString
//        // For http URLs, get rid of the trailing slash if the path is empty or '/'
//        if (self.scheme == "http" || self.scheme == "https") && (self.path == "/") && urlString.endsWith("/") {
//            urlString = String(urlString[..<urlString.index(urlString.endIndex, offsetBy: -1)])
//            //            urlString = urlString.substring(to: urlString.index(urlString.endIndex, offsetBy: -1))
//        }
//        // If it's basic http, strip out the string but leave anything else in
//        if urlString.hasPrefix("http://") {
//            return String(urlString[urlString.index(urlString.startIndex, offsetBy: 7)...])
//            //            return urlString.substring(from: urlString.index(urlString.startIndex, offsetBy: 7))
//        } else {
//            return urlString
//        }
//    }
//
//    /**
//     Returns the base domain from a given hostname. The base domain name is defined as the public domain suffix
//     with the base private domain attached to the front. For example, for the URL www.bbc.co.uk, the base domain
//     would be bbc.co.uk. The base domain includes the public suffix (co.uk) + one level down (bbc).
//
//     :returns: The base domain string for the given host name.
//     */
//    public func baseDomain() -> String? {
//        guard !isIPv6, let host = host else { return nil }
//
//        // If this is just a hostname and not a FQDN, use the entire hostname.
//        if !host.contains(".") {
//            return host
//        }
//
//        return publicSuffixFromHost(host, withAdditionalParts: 1)
//    }
//
//    /**
//     * Returns just the domain, but with the same scheme, and a trailing '/'.
//     *
//     * E.g., https://m.foo.com/bar/baz?noo=abc#123  => https://foo.com/
//     *
//     * Any failure? Return this URL.
//     */
//    public func domainURL() -> URL {
//        if let normalized = self.normalizedHost() {
//            // Use NSURLComponents instead of NSURL since the former correctly preserves
//            // brackets for IPv6 hosts, whereas the latter escapes them.
//            var components = URLComponents()
//            components.scheme = self.scheme
//            components.host = normalized
//            components.path = "/"
//            return components.url ?? self
//        }
//        return self
//    }
//
//    public func extractDomainName() -> String {
//        //        let urlString =  self.normalizedHost() ?? self.URLString
//        let urlString =  self.normalizedHost() ?? self.absoluteString
//        var arr = urlString.components(separatedBy: ".")
//        if (arr.count >= 2) {
//            arr.popLast()
//            return arr.joined(separator: ".")
//        }
//        return urlString
//    }
//
//    public func normalizedHost() -> String? {
//        // Use components.host instead of self.host since the former correctly preserves
//        // brackets for IPv6 hosts, whereas the latter strips them.
//        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
//            var host = components.host else { return nil }
//
//        if let range = host.range(of: "^(www|mobile|m)\\.", options: .regularExpression) {
//            host.replaceSubrange(range, with: "")
//        }
//
//        return host
//    }
//
//    /**
//     Returns the public portion of the host name determined by the public suffix list found here: https://publicsuffix.org/list/.
//     For example for the url www.bbc.co.uk, based on the entries in the TLD list, the public suffix would return co.uk.
//
//     :returns: The public suffix for within the given hostname.
//     */
//    public func publicSuffix() -> String? {
//        if let host = self.host {
//            return publicSuffixFromHost(host, withAdditionalParts: 0)
//        } else {
//            return nil
//        }
//    }
//
//    public func isWebPage(includeDataURIs: Bool = true) -> Bool {
//        let httpSchemes = ["http", "https"]
//        let dataSchemes = ["data"]
//
//        if httpSchemes.contains(scheme!) || includeDataURIs && dataSchemes.contains(scheme!) {
//            return true
//        }
//
//        return false
//    }
//
//    public var isLocal: Bool {
//        // iOS forwards hostless URLs (e.g., http://:6571) to localhost.
//        guard let host = host, !host.isEmpty else {
//            return true
//        }
//
//        return host.lowercased() == "localhost" || host == "127.0.0.1"
//    }
//
//    public var isIPv6: Bool {
//        return host?.contains(":") ?? false
//    }
//
//    /**
//     Returns whether the URL's scheme is one of those listed on the official list of URI schemes.
//     This only accepts permanent schemes: historical and provisional schemes are not accepted.
//     */
//    public var schemeIsValid: Bool {
//        return permanentURISchemes.contains(scheme!)
//    }
//
//    public func havingRemovedAuthorisationComponents() -> URL {
//        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
//            return self
//        }
//        urlComponents.user = nil
//        urlComponents.password = nil
//        if let url = urlComponents.url {
//            return url
//        }
//        return self
//    }
//}
