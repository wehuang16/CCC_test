within CCC_test.obc_cdl2;
model test_sort3

  Buildings.Controls.OBC.CDL.Reals.Sort sort(ascending=true, nin=5)
    "Output the indices of the sorted vector in ascending order"
    annotation (Placement(transformation(extent={{-82,78},{-62,98}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1[5](k={7,13,5,2,3})
    annotation (Placement(transformation(extent={{-148,68},{-128,88}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor extIndRea(nin=5)
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=2)
    annotation (Placement(transformation(extent={{-116,14},{-96,34}})));
  Buildings.Controls.OBC.CDL.Reals.Greater
                                        gre[5]
    annotation (Placement(transformation(extent={{76,104},{96,124}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=5)
    annotation (Placement(transformation(extent={{64,-18},{84,2}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[5]
    annotation (Placement(transformation(extent={{104,100},{124,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2[5](k=1:1:5)
    annotation (Placement(transformation(extent={{-186,24},{-166,44}})));
equation
  connect(conInt.y, extIndRea.index) annotation (Line(points={{-94,24},{20,24},{
          20,20},{60,20},{60,68}}, color={255,127,0}));
  connect(extIndRea.u, sort.y) annotation (Line(points={{48,80},{40,80},{40,88},
          {-60,88}},         color={0,0,127}));
  connect(extIndRea.y, reaScaRep.u) annotation (Line(points={{72,80},{66,80},{66,
          -8},{62,-8}}, color={0,0,127}));
  connect(reaScaRep.y,gre. u2) annotation (Line(points={{86,-8},{80,-8},{80,106},
          {74,106}}, color={0,0,127}));
  connect(gre.y, not1.u) annotation (Line(points={{98,114},{100,114},{100,110},
          {102,110}}, color={255,0,255}));
  connect(con1.y, gre.u1) annotation (Line(points={{-126,78},{-122,78},{-122,
          114},{-116,114},{-116,138},{74,138},{74,114}}, color={0,0,127}));
  connect(con1.y, sort.u) annotation (Line(points={{-126,78},{-106,78},{-106,88},
          {-84,88}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_sort3;
