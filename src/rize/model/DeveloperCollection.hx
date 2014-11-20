package rize.model;

import mlkcca.MilkCocoa;


class DeveloperCollection{
	public var cocoa:MilkCocoa;
	public var developerDataStore:mlkcca.DataStore;
	public var data : Array<rize.model.Developer>;

	public function new(c:MilkCocoa){
		cocoa = c;
		developerDataStore = cocoa.dataStore("Developers");
	}
	
	public function loadData(callback:Array<rize.model.Developer>->Void){
		data = new Array<rize.model.Developer>();
		var query = developerDataStore.query();
		query.done(function(d:Array<Dynamic>){
			trace(d);
			for(i in 0...d.length){
				data.push(rize.model.Developer.restore(d[i]));
			}
			callback(data);
		});
	}

	public function push(dev:rize.model.Developer,callback){
		var tmp = {
			name : dev.name,
			tags : dev.tags,
			kanbans : dev.kanbans
		};
		if(dev.id != null) {
			change(dev.id,tmp,callback);
		}else{
			developerDataStore.push(tmp);
			loadData(function(data){});
			callback();
		}
	}

	public function remove(id:String,callback){
		developerDataStore.remove(id);
		var tmp = data.filter(function(d){
			return d.id == id;
		});
		for(i in tmp){
			data.remove(i);
		}
		callback();
	}

	public function change(id:String,change:Dynamic,callback){
		developerDataStore.set(id,change);
		callback();
	}
}
