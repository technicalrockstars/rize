package rize.model;

import mlkcca.MilkCocoa;
import haxe.Serializer;
import haxe.Unserializer;

class KanbanCollection extends Model{
	public var data(default,null):Array<rize.model.Kanban>;
	private var dataStore : mlkcca.DataStore;

	public function new(dataStore){
		this.data = [];
		this.dataStore = dataStore;
		this.dataStore.query().limit(100).done(function(data){
			for(d in data ){
				if( d.kanban != null ){
					var unserializer = new Unserializer(d.kanban);
					this.data.push(unserializer.unserialize());
				}
			}
			this.changed();
		});

		this.dataStore.on("push",function(d){
			if( d.value.kanban != null ){
				var unserializer = new Unserializer(d.value.kanban);
				var kanban = unserializer.unserialize();
				this.data.unshift(kanban);
				this.changed();
			}
		});
	}

	public function push(kanban){
		
		var serializer = new Serializer();
		serializer.serialize(kanban);
		this.dataStore.push({kanban:serializer.toString()});
	}

}