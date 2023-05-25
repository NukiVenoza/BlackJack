import Vision
import AVFoundation
import UIKit

extension ViewController {
    
    func setupDetector() {
        let modelURL = Bundle.main.url(forResource: "playingCardModel2", withExtension: "mlmodelc")
        
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL!))
            let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
            self.requests = [recognitions]
        } catch let error {
            print(error)
        }
    }
    
    func detectionDidComplete(request: VNRequest, error: Error?) {
        DispatchQueue.main.async(execute: {
            if let results = request.results {
                self.extractDetections(results)
            }
        })
    }
    
    //    func extractDetections(_ results: [VNObservation]) {
    //        detectionLayer.sublayers = nil
    //
    //        for observation in results where observation is VNRecognizedObjectObservation {
    //            guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
    //
    //            // Transformations
    //            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(screenRect.size.width), Int(screenRect.size.height))
    //            let transformedBounds = CGRect(x: objectBounds.minX, y: screenRect.size.height - objectBounds.maxY, width: objectBounds.maxX - objectBounds.minX, height: objectBounds.maxY - objectBounds.minY)
    //
    //            let boxLayer = self.drawBoundingBox(transformedBounds, label: objectObservation.labels.first?.identifier ?? "", confidence: objectObservation.labels.first?.confidence ?? 0.0)
    //
    //            detectionLayer.addSublayer(boxLayer)
    //        }
    //    }
    
    func extractDetections(_ results: [VNObservation]) {
        detectionLayer.sublayers = nil
        var totalValue: Float = 0.0
        var cardValue: Float = 0.0
        
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
            
            // Transformations
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(screenRect.size.width), Int(screenRect.size.height))
            let transformedBounds = CGRect(x: objectBounds.minX, y: screenRect.size.height - objectBounds.maxY, width: objectBounds.maxX - objectBounds.minX, height: objectBounds.maxY - objectBounds.minY)

            let label = objectObservation.labels.first?.identifier ?? ""
            let confidence = objectObservation.labels.first?.confidence ?? 0.0
            let boxLayer = self.drawBoundingBox(transformedBounds, label: label, confidence: confidence)
            
            if label.hasPrefix("A") == true {
                cardValue += 11
            }
            else if label.hasPrefix("2") == true {
                cardValue += 2
            }
            else if label.hasPrefix("3") == true {
                cardValue += 3
            }
            else if label.hasPrefix("4") == true {
                cardValue += 4
            }
            else if label.hasPrefix("5") == true {
                cardValue += 5
            }
            else if label.hasPrefix("6") == true {
                cardValue += 6
            }
            else if label.hasPrefix("7") == true {
                cardValue += 7
            }
            else if label.hasPrefix("8") == true {
                cardValue += 8
            }
            else if label.hasPrefix("9") == true {
                cardValue += 9
            }
            else if label.hasPrefix("10") == true || label.hasPrefix("J") == true || label.hasPrefix("Q") || label.hasPrefix("K"){
                cardValue += 10
            }
            
            totalValue = cardValue
            
            if totalValue > 21 {
                if label.hasPrefix("A") == true {
                    cardValue += 1
                }
                
                totalValue = totalValue - 21
                
            }
            
            detectionLayer.addSublayer(boxLayer)
        }
        totalLabel.text = "Total: \(Int(totalValue))"
        
    }
    
    func setupLayers() {
        let labelX = (screenRect.size.width - 182) / 2.0

        totalLabel = UILabel(frame: CGRect(x: labelX, y: 120, width: 182, height: 76))
        totalLabel.textColor = UIColor(.white)
        totalLabel.font = UIFont.boldSystemFont(ofSize: 36)
        totalLabel.textAlignment = .center
        totalLabel.text = "Total: 0"
//        totalLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        totalLabel.backgroundColor = UIColor(red: 140/255.0, green: 0/255.0, blue: 5/255.0, alpha: 1)
        totalLabel.layer.cornerRadius = 8
        totalLabel.layer.masksToBounds = true
        self.view.addSubview(totalLabel)
        
        detectionLayer = CALayer()
        detectionLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        detectionLayer.zPosition = 1
        self.view.layer.addSublayer(detectionLayer)
    }
    
    func updateLayers() {
        detectionLayer?.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
    }
    
    //    func drawBoundingBox(_ bounds: CGRect) -> CALayer {
    //        let boxLayer = CALayer()
    //        boxLayer.frame = bounds
    //        boxLayer.borderWidth = 3.0
    //        boxLayer.borderColor = CGColor.init(red: 180.0, green: 0.0, blue: 0.0, alpha: 1.0)
    //        boxLayer.cornerRadius = 4
    //        return boxLayer
    //    }
    
    func drawBoundingBox(_ bounds: CGRect, label: String, confidence: Float) -> CALayer {
        let boxLayer = CALayer()
        boxLayer.frame = bounds
        boxLayer.borderWidth = 3.0
        boxLayer.borderColor = CGColor.init(red: 180.0, green: 0.0, blue: 0.0, alpha: 1.0)
        boxLayer.cornerRadius = 4
        
        let textLayer = CATextLayer()
        textLayer.string = "\(label) (\(confidence * 100))"
        textLayer.fontSize = 14
        textLayer.foregroundColor = UIColor.red.cgColor
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: 0, y: bounds.height, width: bounds.width + 100, height: 20)
        
        boxLayer.addSublayer(textLayer)
        
        return boxLayer
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:]) // Create handler to perform request on the buffer
        
        do {
            try imageRequestHandler.perform(self.requests) // Schedules vision requests to be performed
        } catch {
            print(error)
        }
    }
}
