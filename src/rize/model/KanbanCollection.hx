package rize.model;
import mlkcca.MilkCocoa;


class KanbanCollection {
	public var cocoa:MilkCocoa;
	public var kanbanDataStore:Dynamic;
	public var data:Array<rize.model.Kanban>;

	public function new(c:MilkCocoa){
		cocoa = c;
		kanbanDataStore = cocoa.dataStore("kanbanCollection");
	}
	public function push(k:rize.model.Kanban,callback){
		trace("push");
		trace(k);
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
			trace(data.length);
			callback(data);
		});
	}
	public function getData(){
		return data;
	}

	public function remove(id:Dynamic,callback){
		trace(id);
		kanbanDataStore.remove(id);
		callback();
	}
}