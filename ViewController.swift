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
        //瓦片
        let tiledLayer = CATiledLayer()
        tiledLayer.frame = rect
        tiledLayer.delegate = self
        contentView.layer.addSublayer(tiledLayer)
        scrollView.addSubview(contentView)
        
        scrollView.contentSize = contentView.frame.size
        
        //draw layer
        tiledLayer.setNeedsDisplay()
        self.contentView = contentView
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        let layer = layer as! CATiledLayer
        
        //配置瓦片位置
        let bounds = ctx.boundingBoxOfClipPath
        let x = bounds.origin.x / layer.tileSize.width
        let y = bounds.origin.y / layer.tileSize.height
        
         //加载瓦片图片
        let imageName = "LiuYan_0\(Int(x))_0\(Int(y))"//大图切成的小图
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

