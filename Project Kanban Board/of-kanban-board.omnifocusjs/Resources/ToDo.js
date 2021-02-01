(() => {
    var action = new PlugIn.Action(function(selection, sender){
    
    	try {
			var parentTag = flattenedTags.byName("kanban")
			if(!parentTag){
				var errMessage = "There is no “Kanban” tag. Please select “Display Board” from the “Kanban Board” sub-menu in the Automation menu to add the missing tag."
				throw new Error(errMessage)
			}
			
			var childTag = parentTag.children.byName("to-do")
			if(!childTag){
				var errMessage = "There is no “To Do” tag. Please select “Display Board” from the “Kanban Board” sub-menu in the Automation menu to add the missing tag."
				throw new Error(errMessage)
			}
			
			var tagSet = parentTag.flattenedChildren;
		
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
		return (selection.projects.length > 0)
	};
	
	return action;
})();