//
//  main.swift
//  ImageConverter
//
//  Created by Scott D. Bowen on 28-Jul-2021.
//

import Foundation
import AppKit           // Required for NSImage
import AVKit            // Required for AVFileType.heic


extension NSImage {

    public var cgImage: CGImage? {

        guard let imageData = self.tiffRepresentation else { return nil }

        guard let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }

        return CGImageSourceCreateImageAtIndex(sourceData, 0,nil)
        
    }
}


var imageFile : String?

print("Hello, World!")

if (CommandLine.arguments.count < 2) {
    print("You must specify a filename.")
} else {
    print("Working from: \(CommandLine.arguments.first)")
    print("Operating on file: \(CommandLine.arguments[1])")
    imageFile = CommandLine.arguments[1]
    
    let image = NSImage(contentsOfFile: imageFile!)
    // let outputURL = URL(fileURLWithPath: "usr/share/man/man1/\(imageFile!).heic")
    let outputURL = URL(fileURLWithPath: "\(imageFile!).heic")
    
    // 3
    let quality: CFString = "0.63683" as CFString
    let options: NSDictionary = [
        kCGImageDestinationLossyCompressionQuality: ( quality ) // as CFNumber/CFString Type!?
    ]
    
    guard let destination = CGImageDestinationCreateWithURL(outputURL as CFURL,
                                                            AVFileType.heic as CFString,
                                                            1,
                                                            options) else { fatalError("Unable to create CGImageDestination")
    }
    
    CGImageDestinationAddImage(destination, image!.cgImage!, options)
    CGImageDestinationFinalize(destination)
}

print("Goodbye.")
