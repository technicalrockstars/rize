package rize.controller;

import rize.model.*;
import rize.view.TagTableView;
import mlkcca.MilkCocoa;

class TagTableController{
	var milkcocoa : MilkCocoa;

	public function new (mlk:MilkCocoa){
		milkcocoa = mlk;
	}

	public function makeView(){
		var tagTableView = new TagTableView();
		var tagCollection = new TagCollection(milkcocoa);

		tagCollection.loadData(function(data){
			trace(data);
			for(tag in data){
				var tagView = new TagView({
					title : tag.title
				});
				tagView.id = tag.id;
				
				tagView.removeButton.addEventListener("click",function(e){
					tagCollection.remove(tagView.id,function(){
						js.Browser.window.location.reload();
					});
				});

				tagTableView.children.appendChild(tagView.nodes[0]);
			}
		});

		tagTableView.input.addEventListener("change",function(e){
			var tag = new Tag(tagTableView.input.value);
			tagCollection.push(tag,function(){
				js.Browser.window.location.reload();
			});
		});

		tagTableView.makeButton.addEventListener("click",function(e){
			var tag = new Tag(tagTableView.input.value);
			tagCollection.push(tag,function(){
				js.Browser.window.location.reload();
			});
		});

		tagTableView.reloadButton.addEventListener("click",function(e){
			js.Browser.window.location.reload();
		});

		return tagTableView.nodes[0];
	}
}