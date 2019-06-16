//
//  ViewController.swift
//  ARSample
//
//  Created by 大川葵 on 2019/06/16.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import ARKit
import SceneKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var arSceneView: ARSCNView!
    // ステータスバーの非表示
    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .slide }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //　セッション生成
        let scene = SCNScene()
        arSceneView.scene = scene
        // デバッグ情報のプリント
        arSceneView.showsStatistics = true
        arSceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.asObservable()
            .subscribe { [weak self] _ in
                self?.handleTap()
        }
        .disposed(by: disposeBag)
        self.arSceneView.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        // Configration：現実空間のどんな情報をトラッキングするかを指定
        let configration = ARWorldTrackingConfiguration()
        arSceneView.session.run(configration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        // セッションの停止
        arSceneView.session.pause()
    }
    
    
    // MARK: Internal
    
    let disposeBag = DisposeBag()
    
    func handleTap() {
        
        guard let currentFrame = arSceneView.session.currentFrame else { return }
        
        let viewWidth = arSceneView.bounds.width
        let viewHeight = arSceneView.bounds.height
        let imagePlane = SCNPlane(width: viewWidth/8000, height: viewWidth/8000)
        imagePlane.firstMaterial?.diffuse.contents = UIImage(named: "iekei_60.png")
        imagePlane.firstMaterial?.lightingModel = .constant
        
        let planeMode = SCNNode(geometry: imagePlane)
        arSceneView.scene.rootNode.addChildNode(planeMode)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.1
        planeMode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
    }
}

