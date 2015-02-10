package rize.view;

import rize.model.Kanban;
import rize.model.Kanban.State;
using rize.model.Kanban.StateUtil;


@:build(mage.CompileHTML.generate(
'package rize.view.kanban;

<input type="text" mag-var=input/>'
))
class DeveloperForm{}

@:build(mage.CompileCSS.generate(
"package rize.view.kanban;

dt,dd {
	color: #999;
}
.title, .developer{
	color: #222;
}

"))
@:build(mage.CompileHTML.generate(
"package rize.view.kanban;

<dl>
	<dt>カンバン名</dt>
	<dd class='title'>{{title}}</dd>
	<dt>詳細</dt>
	<dd>{{comment}}</dd>
	<dt>作成者</dt>
	<dd>{{author}}</dd>
	<dt>開発者</dt>
	<dd class='developer'><input type='text' mage-var=developer/></dd>
	<dt>状態</dt>
	<dd>{{state}}</dd>
	<dt>登録時</dt>
	<dd>{{entryDate}}</dd>
	<dt>着手時</dt>
	<dd>{{startDate}}</dd>
	<dt>完了時</dt>
	<dd>{{endDate}}</dd>
	<dt>WIP</dt>
	<dd>{{wip}}</dd>
	<button mage-var=updateBtn>更新</button>
</dl>"
))
class KanbanView{
	public var model:Kanban = null;

	public function setup(model){
		this.model = model;
		this.model.addObserver(this);
		this.update();
	}

	public function update(){
		this.title.nodeValue = model.title;
		this.comment.nodeValue = model.comment;
		this.author.nodeValue = model.author;

		if(model.developer.name != null && model.developer.name != ""){
			var parentNode = this.developer.parentNode;
			var textNode = js.Browser.document.createTextNode(model.developer.name);
			if( parentNode != null )
				parentNode.replaceChild(textNode, this.developer);
		}


		this.state.nodeValue = model.state.toString();
		this.entryDate.nodeValue = model.entryDate.toString();

		if(model.startDate != null)
			this.startDate.nodeValue = model.startDate.toString();

		if(model.endDate != null){
			this.endDate.nodeValue = model.endDate.toString();
			this.wip.nodeValue = model.wip;
		}

		if(model.state == Finish && this.updateBtn != null)
			this.updateBtn.remove();
	}

}