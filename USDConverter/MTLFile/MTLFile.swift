//
//  MTLFile.swift
//  USDConverter
//
//  Created by Peter Wunder on 10.12.19.
//  Copyright © 2019 Peter Wunder. All rights reserved.
//

import Cocoa

class MTLFile {

	let file: URL
	var materials: [MTLMaterial]

	init(mtlFile: URL) throws {
		self.file = mtlFile
		self.materials = []
		
	}

}
