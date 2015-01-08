package rize.view;


import rize.model.KanbanCollection;
import rize.controller.KanbanVC;

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<div mage-var=inputform></div>
	<div mage-var=children></div>
</div>"
))
class KanbanTableFrame{}

class KanbanTableView extends KanbanTableFrame{
	private var model : KanbanCollection = null;
	public var submitButton : js.html.ButtonElement;
	public var form : KanbanFormView;

	public function new(){
		super();
		this.form = new KanbanFormView();
		this.inputform.appendChild(form.nodes[0]);
		this.submitButton = form.updateBtn;
	}

	public function setup(model){
		this.model = model;
		this.model.addObserver(this);
		this.update();
	}

	public function update(){
		this.removeAll();
		var childrenView = this.model.data.map(function(kanban){
			var kanbanView = new KanbanView();
			var kanbanVC = new KanbanVC(kanbanView, kanban);
			return kanbanView;
		});


		for(c in childrenView){
			this.children.appendChild(c.nodes[0]);
		}

	}

	private function removeAll(){
		if(this.children.hasChildNodes()){
			this.children.removeChild(this.children.firstChild);
			this.removeAll();
		}
	}

}