within CCC_test.Example3;
model testList
  parameter Real tesVar[5]={10,9,8,7,6};
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr[5](t=tesVar)
    "The zone cooling temperature setpoint is greater than the load-shed cooling target temperature setpoint, taking into account of the temperature resolution"
    annotation (Placement(transformation(extent={{-20,2},{0,22}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[5](k={7,13,5,2,3})
    annotation (Placement(transformation(extent={{-88,22},{-68,42}})));
equation
  connect(con.y, greThr.u) annotation (Line(points={{-66,32},{-46,32},{-46,12},{
          -22,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testList;
