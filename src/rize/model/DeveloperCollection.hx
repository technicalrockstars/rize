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

	public function addTag(id:String,tag:rize.model.Tag){
		var tmp = data.filter(function(d:rize.model.Developer){
			return d.id == id;
		});
		for(i in tmp){
			var index = data.indexOf(i);
			data[index].addTag(tag);
			change(data[index].id,{tags:data[index].tags},function(){});
		}
	}

	public function removeTag(tagID:String,callback){
		loadData(function(data){
			for(i in data){
				trace(i);
				i.removeTag(tagID);
				trace(i);
				push(i,function()return);
			}
			callback();
		});
	}

	public function addKanban(id:String,kanban:rize.model.Kanban){
		var tmp = data.filter(function(d:rize.model.Developer){
			return d.id == id;
		});
		for(i in tmp){
			var index = data.indexOf(i);
			data[index].addKanban(kanban);
			change(data[index].id,{kanbans:data[index].kanbans},function(){});
		}
	}

	public function removeKanban(kanbanID:String,callback){
		loadData(function(data){
			for(i in data){
				trace(i);
				i.removeKanban(kanbanID);
				trace(i);
				push(i,function()return);
			}
			callback();
		});
	}

	public function findName(name:String,callback:Array<String>->Void){
		loadData(function(data){
			var tmp = data.filter(function(d){
				return d.name == name;
			});
			var res = new Array<String>();
			for(i in tmp){
				res.push(i.id);
			}
			callback(res);
		});
	}

	public function findById(id:String,callback:rize.model.Developer->Void){
		loadData(function(data){
			var tmp = data.filter(function(d){
				return d.id == id;
			});
			trace(tmp.length);
			var res = tmp[0];
			callback(res);
		});
	}

	public var listener:rize.view.KanbanTableView.KanbanView;
	public function addListener(l:rize.view.KanbanTableView.KanbanView){
		listener = l;
	}
	public function notify(data:Dynamic){
		this.listener.update(data);
	}

}
