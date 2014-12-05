package rize.view;


@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	input new kanban name:<input type=text mage-var=input>
	<input type=button mage-var=makeButton value=make>
	<input type=button mage-var=reloadButton value=reload>
	<div mage-var=children></div>
</div>"
))
class KanbanTableView{}

@:build(mage.CompileHTML.generate(
"package rize.view

<div>
	<ul>
		title :: <bar>{{title}}</bar>
			<input type=text mage-var=changeTitleText>
			<input type=button mage-var=changeTitleButton value=changeTitle>
		<br>

		entry :: <bar>{{entry}}</bar>
		<br>

		state :: <bar>{{state}}</bar>
			<input type=button mage-var=nextStateButton value=next>
		<br>
		
		auth  :: <bar>{{authName}}</bar> 
			<input type=text mage-var=changeAuthText>
			<input type=button mage-var=changeAuthButton value=changeAuth >
		<br> 
		
		start :: <bar>{{startDate}}</bar>
			<input type=button mage-var=setStartDate value=setDate>
		<br>

		end   :: <bar>{{endDate}}</bar>
			<input type=button mage-var=setEndDate value=setDate>
		<br>
		<input type=button mage-var=removeButton value=delete>
	</ul>
</div>"
))
class KanbanView{
	public var id : String;
	public function update(data:rize.model.Developer){
		authName.nodeValue = data.name;
	}
}