within CCC_test.Examples;
model testInnerCycle
  AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle_HeatPump innerCycle_HeatPump(
  redeclare model PerDataMainHP =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (dataTable=
            AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    redeclare model PerDataRevHP =
        AixLib.DataBase.Chiller.PerformanceData.LookUpTable2D (smoothness=
            Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
            AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()))
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-62,24})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={11,15})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
    annotation (Placement(transformation(extent={{-26,16},{4,50}}),
        iconTransformation(extent={{-22,30},{-4,56}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-64,56},{-44,76}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{4,52},{24,72}})));
equation
  connect(booleanToReal.y, sigBus1.nSet) annotation (Line(points={{11,9.5},{10,9.5},
          {10,4},{-10.925,4},{-10.925,33.085}},
                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y, sigBus1.iceFacMea) annotation (Line(points={{-53.2,24},{-32,
          24},{-32,33.085},{-10.925,33.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus1, innerCycle_HeatPump.sigBus) annotation (Line(
      points={{-11,33},{-11,-22},{-19.9,-22},{-19.9,-29.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(booleanConstant.y, sigBus1.modeSet) annotation (Line(points={{-43,66},
          {-10.925,66},{-10.925,33.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant1.y, booleanToReal.u) annotation (Line(points={{25,62},
          {30,62},{30,26},{11,26},{11,21}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testInnerCycle;
