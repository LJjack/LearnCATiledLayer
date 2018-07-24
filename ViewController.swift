//
//  ViewController.swift
//  LearnCATiledLayer
//
//  Created by 刘俊杰 on 2017/2/23.
//  Copyright © 2017年 天翼. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CALayerDelegate, UIScrollViewDelegate {
    
    var contentView:UIView?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect(x: 0, y: 0, width: 1280, height: 960)
        
        let contentView = UIView(frame: rect)
        let tiledLayer = CATiledLayer()
        tiledLayer.frame = rect
        tiledLayer.delegate = self
        contentView.layer.addSublayer(tiledLayer)
        scrollView.addSubview(contentView)
        //configure the scroll view 
        scrollView.contentSize = contentView.frame.size
        
        //draw layer
        tiledLayer.setNeedsDisplay()
        self.contentView = contentView
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        let layer = layer as! CATiledLayer
        
        //determine tile coordinate
        let bounds = ctx.boundingBoxOfClipPath
        let x = bounds.origin.x / layer.tileSize.width
        let y = bounds.origin.y / layer.tileSize.height
        
        //load tile image
        let imageName = "LiuYan_0\(Int(x))_0\(Int(y))"
        let tileImage = UIImage(named: imageName)
        
        //draw tile
        UIGraphicsPushContext(ctx)
        tileImage?.draw(in: bounds)
        UIGraphicsPopContext()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }

}

