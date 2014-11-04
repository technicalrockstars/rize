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
			messageDataStore.push({ text : "hello World!" },function(data){
				trace("pushed data : ");
				trace(data);
				messageDataStore.query().done(function(data){
					trace("queried data:");
					trace(data);
					for( d in data){
						messageDataStore.remove(d.id);
					}
					});
				});
			var kanbanTableView = new KanbanTableView();
			var kanbanCollection = new KanbanCollection();

			for(kanban in kanbanCollection.data){
				var kanbanView = new KanbanView({name:kanban.title, state:kanban.stateString()});
				kanbanView.button.addEventListener("onClick",function(e){

				});
				kanbanTableView.children.appendChild(kanbanView.nodes[0]);
			}

			kanbanTableView.input.addEventListener("change",function(e){
				var kanban = new Kanban(kanbanTableView.input.value);
				kanbanCollection.push(kanban);
				var kanbanView = new KanbanView({name:kanban.title, state:kanban.stateString()});
				kanbanTableView.children.appendChild(kanbanView.nodes[0]);
				// js.Browser.window.location.reload();
			});

			js.Browser.document.body.appendChild(kanbanTableView.nodes[0]);
		});
	}
}