within CCC_test.ESTCP;
model SubBlock
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u1 annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent
          ={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u2 annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
          extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y1 annotation (Placement(
        transformation(extent={{100,40},{140,80}}), iconTransformation(extent={
            {100,40},{140,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y2 annotation (Placement(
        transformation(extent={{100,-80},{140,-40}}), iconTransformation(extent={{100,-80},
            {140,-40}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=2)
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar2(p=-1)
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
equation
  connect(u1, addPar1.u)
    annotation (Line(points={{-120,60},{-2,60}}, color={0,0,127}));
  connect(u2,addPar2. u) annotation (Line(points={{-120,-60},{-2,-60}},
                    color={0,0,127}));
  connect(addPar1.y, y1)
    annotation (Line(points={{22,60},{120,60}}, color={0,0,127}));
  connect(addPar2.y,y2)  annotation (Line(points={{22,-60},{120,-60}},
                     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SubBlock;
