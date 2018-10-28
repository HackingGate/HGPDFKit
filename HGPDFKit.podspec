Pod::Spec.new do |s|
  s.name         = "HGPDFKit"
  s.version      = "0.0.1"
  s.summary      = "Apple PDFKit extension in Swift"
  s.homepage     = "https://github.com/HackingGate/HGPDFKit"
  s.license      = "MIT"
  s.author             = { "HackingGate" => "i@hackinggate.com" }

  s.platform     = :ios
  s.platform     = :ios, "11.3"
  s.swift_version = "4.2"

  s.source       = { :git => "https://github.com/HackingGate/HGPDFKit.git", :tag => s.version }
  s.source_files  = "Source/*.swift"
end
