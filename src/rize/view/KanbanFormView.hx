package rize.view;

@:build(mage.CompileHTML.generate(
'package rize.view.kanbanForm;

<div>
	<dt>カンバン名(必須)</dt>
	<dd><input type="text" mage-var=name /></dd>

	<dt>詳細(必須)</dt>
	<dd><textarea name="" id="" cols="30" rows="10" mage-var=comment></textarea></dd>

	<dt>作成者(必須)</dt>
	<dd><input type="text" mage-var=author /></dd>

	<dt>開発者</dt>
	<dd><input type="text" mage-var=developer /></dd>

	<button mage-var=updateBtn>追加</button>
</div>'
))
class KanbanFormView{

}