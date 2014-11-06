package rize;

import rize.model.*;
import rize.view.KanbanTableView;
import mlkcca.MilkCocoa;


//登録　一覧　更新

class Main{

	public static function main(){
		var milkcocoa = new MilkCocoa("io-ui2316wnm");
		js.Browser.window.addEventListener("load",function(e){
			var messageDataStore = milkcocoa.dataStore('message');

			var kanbanTableView = new KanbanTableView();
			var kanbanCollection = new KanbanCollection(milkcocoa);
			
			kanbanCollection.loadData(function(kanbanArray){
				trace("response data size ::"+kanbanArray.length);
				for(kanban in kanbanArray){
					var kanbanView = new KanbanView({name:kanban.title, state:kanban.stateString(), authName:kanban.auth.name});
					kanbanView.id = kanban.id;
					kanbanView.removeButton.addEventListener("click",function(e){
						kanbanCollection.remove(kanbanView.id,function(){
							js.Browser.window.location.reload();
						});
					});
					kanbanTableView.children.appendChild(kanbanView.nodes[0]);
				}
			});

			kanbanTableView.input.addEventListener("change",function(e){
				var kanban = new Kanban(kanbanTableView.input.value);
				kanbanCollection.push(kanban,function(){
					js.Browser.window.location.reload();
				});
			});
			kanbanTableView.makeButton.addEventListener("click",function(e){
				var kanban = new Kanban(kanbanTableView.input.value);
				kanbanCollection.push(kanban,function(){
					js.Browser.window.location.reload();
				});
			});

			kanbanTableView.reloadButton.addEventListener("click",function(e){
				js.Browser.window.location.reload();
			});

			js.Browser.document.body.appendChild(kanbanTableView.nodes[0]);
			
		});
	}
}