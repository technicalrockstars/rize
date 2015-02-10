package rize.model;

import mlkcca.DataStore;
import rize.model.Kanban.State;
using Lambda;

class KanbanCollection extends Model{
	public var collection(get,null):Array<rize.model.Kanban>;
	public var dataStore : DataStore;

	private var state : State;
	private var col:Array<rize.model.Kanban>; 

	public function new(dataStore){
		this.col = [];
		this.state = Regist;
		this.dataStore = dataStore;
		this.dataStore.on("set",this.on_set);
		this.dataStore.on("remove",this.on_remove);
		this.reload();
	}

	private function reload(){
		this.dataStore.query().done(function(data){
			this.col = data.map(function(d){
				var serializedObject = Kanban.unserialized(d.kanban);
				return Kanban.toKanban(this.dataStore,serializedObject);
			});
			this.changed();
		});
	}

	private function on_set(data){
		var serializedObject = Kanban.unserialized(data.value.kanban);
		for(havedKanban in this.col){
			if( havedKanban.id == serializedObject.id ){				
				havedKanban.set(serializedObject);
				this.changed();
				return;
			}
		}
		var kanban = Kanban.toKanban(this.dataStore,serializedObject);
		this.col.unshift(kanban);
		this.changed();
	}

	private function on_remove(data){
		var kanban = this.getKanban(data.id);
		if(this.col.remove(kanban)) this.changed();
	}

	public function addKanban(name,comment, author, ?developer){
		var kanban = new Kanban(this.dataStore, name, comment, author);
		if( developer != null ) kanban.setDeveloper(developer);
		this.col.unshift(kanban);
		this.changed();
		kanban.save();
	}

	public function removeKanban(id:String){
		this.dataStore.remove(id);
	}

	private function getKanban(id:String){
		for( c in this.col){
			if( c.id == id ){
				return c;
			}
		}
		return null;
	}

	private function get_collection(){
		return this.col.filter(function(c) return c.state == this.state);
	}

	public function changeState(state){
		this.state = state;
		this.changed();
	}
}