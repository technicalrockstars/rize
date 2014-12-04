package rize.model;
import mlkcca.MilkCocoa;


class TagCollection{
	public var cocoa:MilkCocoa;
	public var tagDataStore:mlkcca.DataStore;
	public var data:Array<rize.model.Tag>;

	public function new (c:MilkCocoa){
		cocoa = c;
		tagDataStore = cocoa.dataStore("tagCollection");
	}

	public function loadData(callback:Array<rize.model.Tag>->Void){
		data = new Array<rize.model.Tag>();
		var query = tagDataStore.query();
		query.done(function(d:Array<Dynamic>){
			trace(d);
			for(i in 0...d.length){
				data.push(rize.model.Tag.restore(d[i]));
			}
			callback(data);
		});
	}

	public function push(tag:rize.model.Tag,callback){
		var c = {
			title : tag.title
		};
		if(tag.id != null){
			change(tag.id,c,callback);
		}else{
			tagDataStore.push(c);
			callback();
		}
	}
	
	public function change(id:String,change:Dynamic,callback){
		tagDataStore.set(id,change);
		callback();
	}

	public function remove(id:String,callback){
		tagDataStore.remove(id);
		var developerCollection = new rize.model.DeveloperCollection(cocoa);
		developerCollection.removeTag(id,callback);

	}

	public function find(title:String,callback:Array<Dynamic>->Void){
		tagDataStore.query({title:title}).done(callback);
	}
	
	public function findById(id:String,callback:Array<Dynamic>->Void){
		tagDataStore.query({id:id}).done(callback);
	}
}
