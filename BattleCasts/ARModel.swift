//
//  ARModel.swift
//  BattleCasts
//
//  Created by Shreya Agrawal on 6/29/24.
//

import SceneKit
import ARKit

class ARModel {
    var modelName: String
    var modelNode: SCNNode?

    init(modelName: String) {
        self.modelName = modelName
        self.loadModel()
    }

    private func loadModel() {
        guard let scene = SCNScene(named: "\(modelName).scn") else {
            print("Model not found: \(modelName)")
            return
        }
        self.modelNode = scene.rootNode.childNodes.first
    }

    func addToScene(_ sceneView: ARSCNView, at position: SCNVector3) {
        guard let modelNode = modelNode else { return }
        modelNode.position = position
        sceneView.scene.rootNode.addChildNode(modelNode)
    }
}
