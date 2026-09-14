within CCC_test.ESTCP;
model MainBlockValidation
  extends Modelica.Icons.Example;
  MainBlock mainBlock(numSubBlo=9)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
equation
  connect(con.y, mainBlock.u1) annotation (Line(points={{-58,50},{-40,50},{-40,
          16},{-22,16}}, color={0,0,127}));
  connect(con1.y, mainBlock.u2) annotation (Line(points={{-58,-50},{-40,-50},{
          -40,4},{-22,4}}, color={0,0,127}));
end MainBlockValidation;
