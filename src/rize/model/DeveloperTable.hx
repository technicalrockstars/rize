package rize.model;

import mlkcca.MilkCocoa;


class DeveloperTable{
	public var cocoa:MilkCocoa;
	public var developerDataStore:mlkcca.DataStore;
	var developers : Array<rize.model.Developer>;
	public function new(c:MilkCocoa){
		cocoa = c;
		developerDataStore = cocoa.dataStore("Developers");
	}
	public function loadData(callback:Array<rize.model.Developer>->Void){
		developers = new Array<rize.model.Developer>();
		var query = developerDataStore.query();
		query.done(function(d:Array<Dynamic>){
			trace(d);
			for(i in 0...d.length){
				developers.push(rize.model.Developer.restore(d[i]));
			}
			callback(developers);
		});
	}

	public function push(dev:rize.model.Developer,callback){
		if(dev.id != null) developerDataStore.remove(dev.id);
		developerDataStore.push({
			id : dev.id,
			name : dev.name,
			tags : dev.tags,
			kanbans : dev.kanbans
		});
		callback();
	}
}
