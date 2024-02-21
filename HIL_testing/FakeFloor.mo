within CCC_test.HIL_testing;
model FakeFloor

    parameter Integer nout=1
    "Number of outputs";
      parameter Modelica.Units.SI.Volume VRooNor=nor.VRoo "Zone 1 volume";
         parameter Modelica.Units.SI.Volume VRooCor=cor.VRoo "Zone 2 volume";
            parameter Modelica.Units.SI.Volume VRooSou=sou.VRoo "Zone 3 volume";
  Modelica.Blocks.Interfaces.RealOutput TRooAir[nout]
    annotation (Placement(transformation(extent={{100,-2},{120,18}})));
  Modelica.Blocks.Sources.Constant const100(k=273.15 + 20.5)
    annotation (Placement(transformation(extent={{-2,-6},{18,14}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator repla(final nout=nout)
    "Replicate real input"
    annotation (Placement(transformation(extent={{46,-8},{66,12}})));
  FakeZone nor
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  FakeZone cor
    annotation (Placement(transformation(extent={{-10,-68},{10,-48}})));
  FakeZone sou
    annotation (Placement(transformation(extent={{-14,-100},{6,-80}})));
equation
  connect(const100.y, repla.u)
    annotation (Line(points={{19,4},{36,4},{36,2},{44,2}}, color={0,0,127}));
  connect(repla.y, TRooAir)
    annotation (Line(points={{68,2},{94,2},{94,8},{110,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FakeFloor;
