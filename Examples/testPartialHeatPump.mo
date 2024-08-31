within CCC_test.Examples;
model testPartialHeatPump
  HeatPumpAixlibModel2 heatPumpAixlibModel2_1(     redeclare model PerDataMainHP =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (dataTable=
            AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    redeclare model PerDataRevHP =
        AixLib.DataBase.Chiller.PerformanceData.LookUpTable2D (smoothness=
            Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
            AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()))
    annotation (Placement(transformation(extent={{14,-38},{36,-12}})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-118,-34})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-45,-43})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-120,-2},{-100,18}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-52,-6},{-32,14}})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
    annotation (Placement(transformation(extent={{-82,-42},{-52,-8}}),
        iconTransformation(extent={{-22,30},{-4,56}})));
equation
  connect(booleanToReal.y,sigBus1. nSet) annotation (Line(points={{-45,-48.5},{-46,
          -48.5},{-46,-54},{-66.925,-54},{-66.925,-24.915}},
                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y,sigBus1. iceFacMea) annotation (Line(points={{-109.2,-34},{-88,
          -34},{-88,-24.915},{-66.925,-24.915}},
                                              color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y,sigBus1. modeSet) annotation (Line(points={{-99,8},{
          -66.925,8},{-66.925,-24.915}},  color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant1.y,booleanToReal. u) annotation (Line(points={{-31,4},
          {-26,4},{-26,-32},{-45,-32},{-45,-37}},
                                            color={255,0,255}));
  connect(sigBus1, heatPumpAixlibModel2_1.sigBus) annotation (Line(
      points={{-67,-25},{-67,-56},{6,-56},{6,-29.225},{14.11,-29.225}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testPartialHeatPump;
