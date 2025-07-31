within CCC_test.Example2;
model testTableJan2025
  Modelica.Blocks.Sources.CombiTimeTable MassFieldData(
    tableOnFile=true,
    timeScale(displayUnit="min") = 60,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/MassFieldData/WooleyJan2025data_interpolated.txt"),
    columns=2:11)                                                                                                                                                                                                         annotation (
    Placement(transformation(origin={114,56},  extent = {{-200, -70}, {-180, -50}}, rotation=0)));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=1000)
    annotation (Placement(transformation(extent={{-8,16},{12,36}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{36,-52},{56,-32}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gal2(k=1/4184)
    annotation (Placement(transformation(extent={{198,-32},{218,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{58,24},{78,44}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.01)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Buildings.Controls.OBC.CDL.Reals.Max max2
    annotation (Placement(transformation(extent={{76,-68},{96,-48}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div1
    annotation (Placement(transformation(extent={{120,-16},{140,4}})));
  Buildings.Controls.OBC.CDL.Reals.Min mass_flow
    annotation (Placement(transformation(extent={{234,-60},{254,-40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0.8)
    annotation (Placement(transformation(extent={{100,-106},{120,-86}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter mass_flow_data(k=0.06309)
    annotation (Placement(transformation(extent={{222,-138},{242,-118}})));
equation
  connect(MassFieldData.y[3], gai.u) annotation (Line(points={{-65,-4},{-20,-4},
          {-20,26},{-10,26}},          color={0,0,127}));
  connect(MassFieldData.y[6], sub.u1) annotation (Line(points={{-65,-4},{24,-4},
          {24,-36},{34,-36}},                         color={0,0,127}));
  connect(MassFieldData.y[5], sub.u2) annotation (Line(points={{-65,-4},{24,-4},
          {24,-48},{34,-48}},                         color={0,0,127}));
  connect(sub.y, max2.u1) annotation (Line(points={{58,-42},{66,-42},{66,-52},{
          74,-52}}, color={0,0,127}));
  connect(gai.y, max1.u1) annotation (Line(points={{14,26},{46,26},{46,40},{56,
          40}}, color={0,0,127}));
  connect(con.y, max1.u2) annotation (Line(points={{12,-70},{20,-70},{20,18},{
          48,18},{48,28},{56,28}}, color={0,0,127}));
  connect(con.y, max2.u2) annotation (Line(points={{12,-70},{20,-70},{20,-64},{
          74,-64}}, color={0,0,127}));
  connect(max1.y, div1.u1) annotation (Line(points={{80,34},{110,34},{110,0},{
          118,0}}, color={0,0,127}));
  connect(max2.y, div1.u2) annotation (Line(points={{98,-58},{110,-58},{110,-12},
          {118,-12}}, color={0,0,127}));
  connect(con1.y, mass_flow.u2) annotation (Line(points={{122,-96},{222,-96},{
          222,-56},{232,-56}}, color={0,0,127}));
  connect(div1.y, gal2.u) annotation (Line(points={{142,-6},{186,-6},{186,-22},
          {196,-22}}, color={0,0,127}));
  connect(gal2.y, mass_flow.u1) annotation (Line(points={{220,-22},{230,-22},{
          230,-34},{224,-34},{224,-44},{232,-44}}, color={0,0,127}));
  connect(MassFieldData.y[10], mass_flow_data.u)
    annotation (Line(points={{-65,-4},{220,-4},{220,-128}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=2677200,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testTableJan2025;
