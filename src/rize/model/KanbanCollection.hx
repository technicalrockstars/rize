package rize.model;
import mlkcca.MilkCocoa;


class KanbanCollection {
	public var cocoa:MilkCocoa;
	public var kanbanDataStore:mlkcca.DataStore;
	public var data:Array<rize.model.Kanban>;

	public function new(c:MilkCocoa){
		cocoa = c;
		kanbanDataStore = cocoa.dataStore("kanbanCollection");
	}
	public function push(k:rize.model.Kanban,callback){
		if(k.id != null) kanbanDataStore.remove(k.id);
		kanbanDataStore.push({
			title : k.title,
			start : k.start,
			end   : k.end,
			auth  : k.auth,
			entry : k.entry,
			state : k.state
		});
		callback();
	}
	public function loadData(callback){
		data = new Array<rize.model.Kanban>();
		var query = kanbanDataStore.query();
		query.done(function(d:Array<Dynamic>){
			trace(d);
			for(i in 0...d.length){
				data.push(Kanban.restore(d[i]));
			}
			callback(data);
		});
	}

	public function getData(){
		return data;
	}

	public function remove(id:Dynamic,callback){
		kanbanDataStore.remove(id);
		var tmp = data.filter(function(d){
			return d.id == id;
		});
		for(i in tmp){
			data.remove(i);
		}
		callback();
	}

	public function change(id:String,change:Dynamic,callback){
		kanbanDataStore.set(id,change);
		callback();
	}

	public function changeState(id:String,callback){
		var tmp = data.filter(function(d){
			return d.id == id;
		});
		for(i in tmp){
			var index = data.indexOf(i);
			trace(data[index]);
			data[index].toNextState();
			trace(data[index]);
			kanbanDataStore.set(id,{state:data[index].state});
		}
		trace("fin");
		callback();
	}

	public function changeAuth(id:String,dev:rize.model.Developer,callback){
		kanbanDataStore.set(id,{auth:dev});
		var tmp = data.filter(function(d){
			return d.id == id;
		});
		for(i in tmp){
			var index = data.indexOf(i);
			data[index].auth = dev;
		}
		callback();
	}
}