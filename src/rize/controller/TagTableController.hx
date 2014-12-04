package rize.controller;

import rize.model.*;
import rize.view.TagTableView;
import mlkcca.MilkCocoa;

class TagTableController{
	var milkcocoa : MilkCocoa;
	var tagCollection : rize.model.TagCollection;

	public function new (mlk:MilkCocoa){
		milkcocoa = mlk;
		tagCollection = new TagCollection(milkcocoa);

	}

	public function makeView(){
		var tagTableView = new TagTableView();
		
		tagCollection.loadData(function(data){
			trace(data);
			for(tag in data){
				tagTableView.children.appendChild(makeTagView(tag));
			}
		});
		var makeNewTagFunction = function(e){
			var tag = new Tag(tagTableView.input.value);
			tagCollection.push(tag,function(){
				js.Browser.window.location.reload();
			});
		};
		tagTableView.input.addEventListener("change",makeNewTagFunction);
		tagTableView.makeButton.addEventListener("click",makeNewTagFunction);

		var reloadFunction = function(e){
			js.Browser.window.location.reload();
		};
		tagTableView.reloadButton.addEventListener("click",reloadFunction);

		return tagTableView.nodes[0];
	}

	public function makeTagView(tag:rize.model.Tag){
		var tagView = new TagView({
			title : tag.title
		});
		tagView.id = tag.id;
		
		tagView.removeButton.addEventListener("click",function(e){
			tagCollection.remove(tagView.id,function(){
				js.Browser.window.location.reload();
			});
		});
		return tagView.nodes[0];
	}
}