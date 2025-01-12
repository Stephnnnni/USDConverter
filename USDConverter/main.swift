//
//  main.swift
//  USDConverter
//
//  Created by Peter Wunder on 27.11.21.
//  Copyright © 2021 Peter Wunder. All rights reserved.
//

import Foundation
import ArgumentParser

struct Main: ParsableCommand {
	static var configuration = CommandConfiguration(
		abstract: "usdconv v\(USDConverter.version)",
		discussion: "Specify one or more .usdz files (.scn and .scnz files have experimental support as well) to generate .obj/.mtl files."
	)

	@Flag(name: .shortAndLong, help: "Show the version number and exit.")
	var version: Bool = false

	@Flag(name: .long, help: "Convert all texture formats to PNG.")
	var png: Bool = false

	@Flag(name: .long, help: "Try to force conversion, even if the input format is unsupported.")
	var force: Bool = false

	@Flag(name: .long, help: "Keep initial files generated by Model I/O.")
	var includeGarbage: Bool = false

	@Option(name: .shortAndLong, help: "The directory to write the generated files to. Omit to use the input file's directory.", completion: .directory)
	var outputDirectory: String?

	@Argument(help: "The input file(s).", completion: .file())
	var input: [String] = [] // give default value so --version can work

	mutating func run() throws {
		guard let fullVersion = USDConverter.fullVersion else {
			print("Couldn't determine path to binary")
			Darwin.exit(1)
		}

		print(fullVersion)

		if self.version {
			return
		}

		print("".padding(toLength: fullVersion.count, withPad: "-", startingAt: 0))

		guard !self.input.isEmpty else {
			print("Error: Specify at least one input file")
			Darwin.exit(1)
		}

		USDConverter.run(options: self)
	}
}

Main.main()
