var _ = function(){
	var action = new PlugIn.Action(function(selection){
		versNum = this.plugIn.version.versionString
		pluginName = this.plugIn.displayName
		pluginID = this.plugIn.identifier
		pluginLibraries = this.plugIn.libraries
		if (pluginLibraries.length != 0){
			libraryNames = []
			pluginLibraries.forEach(function(aLibrary){
				libraryName = aLibrary.name
				libraryVersion = aLibrary.version.versionString
				displayString = libraryName + ' v' + libraryVersion
				libraryNames.push(displayString)
			})
			libraryNamesString = "LIBRARIES:"
			libraryNamesString = libraryNamesString + '\n' + libraryNames.join('\n')
		} else {
			libraryNamesString = "This plugin has no libraries."
		}
		alertTitle = pluginName + ' v.' + versNum
		descriptionString = "A plug-in for creating and maintaining a tag-based Kanban Board in OmniFocus. Based upon a concept and project by Serena (www.sleepyowl.ink)\n\nTo use, run the “Display Board” script to create the Kanban tags and display the board."
		companyURL = 'https://omni-automation.com/omnifocus'
		alertMessage = "©2021 Otto Automator" + '\n'
		alertMessage = alertMessage + pluginID + '\n'
		alertMessage = alertMessage + companyURL + '\n' + '\n'
		alertMessage = alertMessage + descriptionString + '\n' + '\n' 
		alertMessage = alertMessage + libraryNamesString
		var alert = new Alert(alertTitle, alertMessage)
		alert.show()
	});

	// routine determines if menu item is enabled
	action.validate = function(selection){
		return true
	};

	return action;
}();
_;