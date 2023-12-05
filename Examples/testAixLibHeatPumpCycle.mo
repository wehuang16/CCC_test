within CCC_test.Examples;
model testAixLibHeatPumpCycle
  AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle_HeatPump innerCycle_HeatPump
    annotation (Placement(transformation(extent={{-40,-6},{-20,14}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAixLibHeatPumpCycle;
