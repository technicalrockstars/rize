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
					var kanbanView = new KanbanView({
						name:kanban.title,
						state:kanban.stateString(),
						authName:kanban.auth.name,
						startDate : kanban.getStartString(),
						endDate : kanban.getEndString()
					});

					kanbanView.id = kanban.id;
					kanbanView.changeTitleButton.addEventListener("click",function(e){
						kanbanCollection.change(kanbanView.id,{title:kanbanView.changeTitleText.value},function(){
							js.Browser.window.location.reload();
						});
					});

					kanbanView.nextStateButton.addEventListener("click",function(e){
						kanbanCollection.changeState(kanbanView.id,function(){
							js.Browser.window.location.reload();
						});
					});

					kanbanView.changeAuthButton.addEventListener("click",function(e){
						kanbanCollection.changeAuth(kanbanView.id,new rize.model.Developer(kanbanView.changeAuthText.value),function(){
							js.Browser.window.location.reload();
						});
					});

					kanbanView.setStartDate.addEventListener("click",function(e){
						kanbanCollection.change(kanbanView.id,{start:Date.now()},function(){
							js.Browser.window.location.reload();
						});
					});

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