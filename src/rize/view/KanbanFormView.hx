package rize.view;

@:build(mage.CompileHTML.generate(
'package rize.view.kanbanForm;

<div>
	<dt>カンバン名(必須)</dt>
	<dd><input(name) type="text"></dd>

	<dt>詳細(必須)</dt>
	<dd><textarea(comment) name="" id="" cols="30" rows="10" ></textarea></dd>

	<dt>作成者(必須)</dt>
	<dd><input(author) type="text"></dd>

	<dt>開発者</dt>
	<dd><input(developer) type="text"></dd>

	<button(updateBtn)>追加</button>
</div>'
))
class KanbanFormView{

}