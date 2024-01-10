within CCC_test.obsolete_eas_e;
model ReversibleAirToWaterEuropeanNorm3D_withPowerData
  "Reversible air to water heat pump based on 2D manufacturer data in Europe"
  extends CCC_test.obsolete_eas_e.ModularReversible_3D(
    final safCtrPar=safCtrParEurNor,
    dTEva_nominal=0,
    mEva_flow_nominal=datTabHea.mEva_flow_nominal*scaFac,
    mCon_flow_nominal=datTabHea.mCon_flow_nominal*scaFac,
    dTCon_nominal=QUse_flow_nominal/cpCon/mCon_flow_nominal,
    final GEvaIns=0,
    final GEvaOut=0,
    final CEva=0,
    final use_evaCap=false,
    final GConIns=0,
    final GConOut=0,
    final CCon=0,
    final use_conCap=false,
    redeclare model RefrigerantCycleHeatPumpCooling =
        IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.EuropeanNorm2D
        (                                                                       redeclare
          IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.NoFrosting
          iceFacCal, final datTab=datTabCoo),
    redeclare model RefrigerantCycleHeatPumpHeating =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.EuropeanNorm2D
        (                                                                        redeclare
          IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.NoFrosting
          iceFacCal, final datTab=datTabHea),
    final use_rev=true,
    redeclare model RefrigerantCycleInertia =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Inertias.NoInertia);

  replaceable parameter
    IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater datTabHea
    constrainedby
    IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater
    "Data Table of HP" annotation (choicesAllMatching=true);
  replaceable parameter IBPSA.Fluid.Chillers.ModularReversible.Data.EuropeanNorm2D.Generic
    datTabCoo constrainedby
    IBPSA.Fluid.Chillers.ModularReversible.Data.EuropeanNorm2D.Generic
    "Data Table of Chiller" annotation (choicesAllMatching=true);
  replaceable parameter
    IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021 safCtrParEurNor
    constrainedby
    IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Generic(
      final tabUppHea=datTabHea.tabUppBou,
      final tabLowCoo=datTabCoo.tabLowBou,
      final use_TUseOut=datTabHea.use_TConOutForOpeEnv,
      final use_TNotUseOut=datTabCoo.use_TEvaOutForOpeEnv)
    "Safety control parameters" annotation (Dialog(enable=
          use_internalSafetyControl, group="Safety Control"),
      choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealOutput QCon_flow(final unit="W", final
      displayUnit="W")
    "Heat flow rate from the refrigerant to the condenser medium"
    annotation (Placement(transformation(extent={{100,22},{120,42}})));
  Modelica.Blocks.Interfaces.RealOutput QEva_flow(final unit="W", final
      displayUnit="W")
    "Heat flow rate from the evaporator medium to the refrigerant"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,12}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,6})));
  Modelica.Blocks.Interfaces.RealOutput PEle(final unit="W", final displayUnit=
        "W")
    "Routing block that picks the component for electric power consumption"
    annotation (Placement(
        transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=0,
        origin={110.5,-20.5})));
equation
  connect(refCyc.PEle, PEle) annotation (Line(points={{19.89,0.09},{58,0.09},{
          58,-20.5},{110.5,-20.5}}, color={0,0,127}));
  connect(refCyc.QEva_flow, QEva_flow) annotation (Line(points={{0,-19.8},{6,
          -19.8},{6,-24},{82,-24},{82,10},{110,10},{110,12}}, color={0,0,127}));
  connect(refCyc.QCon_flow, QCon_flow) annotation (Line(points={{0,19.8},{16,
          19.8},{16,20},{68,20},{68,32},{110,32}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
  Reversible air-to-water heat pump based on
  European Norm 2D data from the standard EN 14511,
  using the ModularReversible model approach.
</p>
<p>
  For more information on the approach, please read the
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.ModularReversibleUsersGuide\">
  UsersGuide</a>.
</p>
<p>
  Internal inertias and heat losses are neglected,
  as these are implicitly obtained in the measured
  data from EN 14511.
  Also, icing is disabled as the performance degradation
  is already contained in the data.
</p>
<p>
  Please read the documentation of the model for heating here:
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.EuropeanNorm2D\">
  IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.EuropeanNorm2D</a>.
</p>
<p>
  For cooling, the assumptions are similar.
  Check this documentation:
  <a href=\"modelica://IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.EuropeanNorm2D\">
  IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.EuropeanNorm2D</a>
</p>
</html>"));
end ReversibleAirToWaterEuropeanNorm3D_withPowerData;
