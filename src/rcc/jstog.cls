Class rcc.jstog
{

ClassMethod file(
	file = "",
	global = "^json") As %Status
{
	open file:"R":0 else  quit $system.Status.Error(340)
	close file
	try {
		set dao=##class(%DynamicObject).%FromJSONFile(file)
	}
	catch (err) {
		return err.AsStatus()
		}
	quit ..toglobal(dao,global)
}

ClassMethod stream(
	str As %Stream.Object = "",
	global = "^json") As %Status
{
	try {
		do str.Rewind()
		set dao=##class(%DynamicObject).%FromJSON(str)
	}
	catch (err) {
		return err.AsStatus()
		}
	quit ..toglobal(dao,global)
}

ClassMethod toglobal(
	dao As %DynamicObject = "",
	global = "^json") As %Status
{
	new %global
	set %global=global
	set it=dao.%GetIterator(), sc=1
	while it.%GetNext(.key,.val,.typ) {
		if typ="string"  {set @%global@(key)=val }
		elseif "number,boolean"[typ  {set @%global@(key)=+val }
		elseif $isobject(val) {
			if $d(@%global@(key))
			set sc=..toglobal(val,$zr)								   
			}
		quit:'sc  
	}
	quit sc
}

}
