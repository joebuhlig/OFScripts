(() => {
    var action = new PlugIn.Action(function(selection, sender){
    
    	try {
			var parentTag = flattenedTags.byName("kanban")
			if(!parentTag){
				var errMessage = "There is no “Kanban” tag. Please select “Display Board” from the “Kanban Board” sub-menu in the Automation menu to add the missing tag."
				throw new Error(errMessage)
			}
			
			var childTag = parentTag.children.byName("in-progress")
			if(!childTag){
				var errMessage = "There is no “In Progress” tag. Please select “Display Board” from the “Kanban Board” sub-menu in the Automation menu to add the missing tag."
				throw new Error(errMessage)
			}
			
			var tagSet = parentTag.flattenedChildren;
		
			// if called externally (from script) generate selection array
			if (typeof selection == 'undefined'){
				// convert nodes into items
				nodes = document.editors[0].selectedNodes
				selectedItems = nodes.map((node) => {return node.object})
			} else {
				selectedItems = selection.items
			}
			selection.projects.forEach(task => {
				task.removeTags(tagSet)
				task.addTag(childTag)
			})
		}
		catch(err){
			new Alert("Missing Tag", err.message).show()
		}
	});

	action.validate = function(selection, sender){
				// validation check. For example, are items selected?
		// if called externally (from script) generate selection array
		if (typeof selection == 'undefined'){
			selNodesCount = document.editors[0].selectedNodes.length
			return (selNodesCount > 0)
		} else {
			return (selection.projects.length > 0)
		}
	};
	
	return action;
})();