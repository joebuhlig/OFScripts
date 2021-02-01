(() => {
	var action = new PlugIn.Action(function(selection, sender){
		
		// IDENTIFY KANBAN TAG, CREATE IF MISSING
		var targetTag = flattenedTags.byName("kanban") || new Tag("kanban")
		
		// ADD KANBAN CATEGORIES IF MISSING
		var tagTitles = ["to-do", "in-progress", "waiting", "done"]
		tagTitles.forEach(title => {
			if (!targetTag.children.byName(title)){
				new Tag(title, targetTag)
			}
		})
		
		// REORDER THE CATEGORIES
		tagTitles.forEach(title => {
			var tag = targetTag.children.byName(title)
			moveTags([tag], targetTag)
		})
		
		// SHOW THE TAGS
		var tagIDs = targetTag.children.map(tag => tag.id.primaryKey)
		var tagIDsString =  tagIDs.join(",")
		URL.fromString("omnifocus:///perspective/kanban").open()
		
	});
	
	return action;
})();