# Test OMGet (doesn't test that much yet other than that it runs.
gap> OMGetTree("abc");
Error, <stream> has to be an input stream
gap> stream := OutputTextString("", true);;
gap> OMGetTree(stream);
Error, <stream> has to be an input stream
gap> stream := InputTextString("abc");; ReadAll(stream);;
gap> OMGetTree(stream);
Error, <stream> is in state end-of-stream
gap> obj := """
> <OMOBJ>
> </OMOBJ>
> """;;
gap> stream := InputTextString(obj);;
gap> tree := OMGetTree(stream);;
gap> obj := """
> <?scscp start ?>
> <OMOBJ xmlns="http://www.openmath.org/OpenMath" version="2.0">
> 	<OMATTR>
> 		<OMATP>
> 			<OMS cd="scscp1" name="call_id"/>
> 			<OMSTR>user007</OMSTR>
> 			<OMS cd="scscp1" name="option_runtime"/>
> 			<OMI>1000</OMI>
> 			<OMS cd="scscp1" name="option_min_memory"/>
> 			<OMI>1024</OMI>
> 			<OMS cd="scscp1" name="option_max_memory"/>
> 			<OMI>2048</OMI>
> 			<OMS cd="scscp1" name="option_debuglevel"/>
> 			<OMI>1</OMI>
> 			<OMS cd="scscp1" name="option_return_object"/>
> 			<OMSTR></OMSTR>
> 		</OMATP>
> 		<OMA>
> 			<OMS cd="scscp1" name="procedure_call"/>
> 			<OMA>
> 				<OMS cd="scscp_transient_1" name="WS_Factorial"/>
> 				<OMI>5</OMI>
> 			</OMA>
> 		</OMA>
> 	</OMATTR>
> </OMOBJ>
> <?scscp end ?>
> """;;
gap> stream := InputTextString(obj);; OMGetTree(stream);;

#
