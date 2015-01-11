package rize.model;

import mlkcca.DataStore;

class KanbanCollection extends Model{
	public var collection(default,null):Array<rize.model.Kanban>;
	public var dataStore : DataStore;

	public function new(dataStore){
		this.collection = [];
		this.dataStore = dataStore;

		this.dataStore.on("set",function(data){
			var serializedObject = Kanban.unserialized(data.value.kanban);
			for(havedKanban in this.collection){
				if( havedKanban.id == serializedObject.id ){
					havedKanban.set(serializedObject);
					return;
				}
			}
			var kanban = Kanban.toKanban(this.dataStore,serializedObject);
			this.collection.unshift(kanban);
			this.changed();
		});

		this.dataStore.query().limit(100).done(function(data){
			this.collection = data.map(function(d){
				var serializedObject = Kanban.unserialized(d.kanban);
				return Kanban.toKanban(this.dataStore,serializedObject);
			});
			this.changed();
		});
	}

	public function addKanban(name,comment, author, ?developer){
		var kanban = new Kanban(this.dataStore, name, comment, author);
		if( developer != null ) kanban.setDeveloper(developer);
		this.collection.unshift(kanban);
		kanban.save();
		this.changed();
	}


}