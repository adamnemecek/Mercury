//
//  File.swift
//  Mercury
//
//  Created by Joshua Knapp on 12/24/15.
//
//

import Foundation
import simd
import Metal
import ModelIO
import MetalKit

class HgSkyboxNode:HgNode {
    
    //var tex:MTLTexture?
    
    
    init(size:Int) {
    
        super.init()
        
        let s = Float(1)//Float(size / 2)
        
        vertexData = Array(repeating: vertex(), count: 36)
        
        //top face
        vertexData[0].position = ( s,     -s,      1)
        vertexData[1].position = ( -s,       -s,      1)
        vertexData[2].position = ( -s,      s,     1)
        vertexData[3].position = vertexData[2].position
        vertexData[4].position = ( s,       s,     1)
        vertexData[5].position = vertexData[0].position
        
        for i in 0..<6 {
            vertexData[i].normal = (0,0,-1)
            vertexData[i].ambientColor = (0,1,1,1)
            vertexData[i].diffuseColor = (1,0,1,1)
        }
        
        //bottom face
        vertexData[6].position = ( s,     s,      -1)
        vertexData[7].position = ( -s,       s,      -1)
        vertexData[8].position = ( -s,      -s,     -1)
        vertexData[9].position = vertexData[8].position
        vertexData[10].position = ( s,       -s,     -1)
        vertexData[11].position = vertexData[6].position
        
        for i in 6..<12 {
            vertexData[i].normal = (0,0,1)
            vertexData[i].ambientColor = (0,1,1,1)
            vertexData[i].diffuseColor = (1,0,1,1)
        }
        
        //north face
        vertexData[12].position = ( s,     s,      1)
        vertexData[13].position = ( -s,       s,      1)
        vertexData[14].position = ( -s,      s,     -1)
        vertexData[15].position = vertexData[14].position
        vertexData[16].position = ( s,       s,     -1)
        vertexData[17].position = vertexData[12].position
        
        for i in 12..<18 {
            vertexData[i].normal = (0,-1,0)
            vertexData[i].ambientColor = (0,1,1,1)
            vertexData[i].diffuseColor = (1,0,1,1)
        }
        
        //south face
        vertexData[18].position = ( -s,     -s,      1)
        vertexData[19].position = ( s,       -s,      1)
        vertexData[20].position = ( s,      -s,     -1)
        vertexData[21].position = vertexData[20].position
        vertexData[22].position = ( -s,       -s,     -1)
        vertexData[23].position = vertexData[18].position
        
        for i in 18..<24 {
            vertexData[i].normal = (0,1,0)
            vertexData[i].ambientColor = (0,1,1,1)
            vertexData[i].diffuseColor = (1,0,1,1)
        }
        
        //east face
        vertexData[24].position = ( s,     -s,      1)
        vertexData[25].position = ( s,       s,      1)
        vertexData[26].position = ( s,      s,     -1)
        vertexData[27].position = vertexData[26].position
        vertexData[28].position = ( s,       -s,     -1)
        vertexData[29].position = vertexData[24].position
        
        for i in 24..<30 {
            vertexData[i].normal = (-1,0,0)
            vertexData[i].ambientColor = (0,1,1,1)
            vertexData[i].diffuseColor = (1,0,1,1)
        }
        
        //west face
        vertexData[30].position = ( -s,     s,      1)
        vertexData[31].position = ( -s,       -s,      1)
        vertexData[32].position = ( -s,      -s,     -1)
        vertexData[33].position = vertexData[32].position
        vertexData[34].position = ( -s,       s,     -1)
        vertexData[35].position = vertexData[30].position
        
        for i in 30..<36 {
            vertexData[i].normal = (1,0,0)
            vertexData[i].ambientColor = (0,1,1,1)
            vertexData[i].diffuseColor = (1,0,1,1)
        }

        vertexCount = 36
        
        //self.scale = float3(Float(size),Float(size),Float(size))
        
        self.updateVertexBuffer()
    }

    override func updateModelMatrix(){
        
        
        if let p = self.parent {
            //give a slight amount of parralax with skybox... this could potentially scroll off screen right now
            //self.position = float3(0, 0, -p.position.z)
            //...found this relationship empirically
            self.rotation = float3(p.rotation.x + Float(Float.pi / 2), p.rotation.z, p.rotation.y)
        }
        
        let x = float4x4(XRotation: rotation.x)
        let y = float4x4(YRotation: rotation.y)
        let z = float4x4(ZRotation: rotation.z)
        let t = float4x4(translation: position)
        let s = float4x4(scale: scale)
        let m = t * s * x * y * z
    
        modelMatrix = m
        modelMatrixIsDirty = false
        
    }
}
