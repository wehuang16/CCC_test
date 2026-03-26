within CCC_test.ESTCP;
model FixedApproachDryBulb
  "Test model for cooling tower with fixed approach temperature using the dry-bulb temperature"
  extends Modelica.Icons.Example;
  extends Buildings.Fluid.HeatExchangers.CoolingTowers.Examples.BaseClasses.PartialStaticTwoPortCoolingTower
                                                      (redeclare
      Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach tow(
        m_flow_nominal=m_flow_nominal), vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{128,-84},{148,-64}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yTemDif
    annotation (Placement(transformation(extent={{188,-96},{228,-56}})));
equation
  connect(weaBus.TDryBul, tow.TAir) annotation (Line(
      points={{-59.95,50.05},{0,50.05},{0,-46},{20,-46}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(tow.TLvg, sub.u1) annotation (Line(points={{43,-56},{86,-56},{86,-68},
          {126,-68}}, color={0,0,127}));
  connect(sub.u2, tow.TAir) annotation (Line(points={{126,-80},{74,-80},{74,-46},
          {20,-46}}, color={0,0,127}));
  connect(sub.y, yTemDif) annotation (Line(points={{150,-74},{180,-74},{180,-76},
          {208,-76}}, color={0,0,127}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,-260},
            {140,100}})),
experiment(StartTime=15552000, Tolerance=1e-06, StopTime=15984000),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatExchangers/CoolingTowers/Examples/FixedApproachDryBulb.mos"
        "Simulate and plot"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
            Documentation(info="<html>
<p>
This example illustrates the use of the cooling tower model
<a href=\"modelica://Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach\">
Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach</a>, using
the outdoor dry-bulb temperature as the potential for heat transfer.
Heat is injected into the volume <code>vol</code>. An on/off controller
switches the cooling loop water pump on or off based on the temperature of
this volume.
The cooling tower outlet temperature has a fixed approach temperature to the
outdoor dry-bulb temperature.
</p>
</html>", revisions="<html>
<ul>
<li>
July 12, 2011, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FixedApproachDryBulb;
