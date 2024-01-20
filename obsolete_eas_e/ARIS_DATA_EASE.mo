within CCC_test.obsolete_eas_e;
record ARIS_DATA_EASE
  "Aris Performance data input for MAX condition. Based off Alpha Innotec LW 80 M-A table in IBPSA.Fluid.HeatPumps.RefrigerantCycleModels.EuropeanNorm2DData.EN14511.AlphaInnotec_LW80MA"
  extends
    IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericHeatPump(
    devIde="AlphaInnotec_LW80MA",
    tabPEle=[
      0,-25,-15,-7,2,7,12;
      35,3483,3715,3947,4142,4142,3471;
      45,4242,4426,4610,4850,4998,4237;
      55,4901,5173,5462,5005,5956,5185],
    tabQCon_flow=[
      0,-25,-15,-7,2,7,12;
      35,6888,9730,12572,18526,18526,18404;
      45,6403,9039,11675,15702,18222,17413;
      55,5610,8505,10683,13041,17677,16502],
    mCon_flow_nominal=9400/4180/5,
    mEva_flow_nominal=1,
    tabUppBou=[-25,65; 40,65],
    use_conOut=true,
    use_evaOut=false);
    //These boundary-tables are not from the datasheet but default values.
    // parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=14800;

    //These boundary-tables are not from the datasheet but default values.
    //values that correspond with LWT and outdoor air temp combinations listed below are not valid values and should not be used.
    //  LWT   and Outdoor Air Temp
    //35 degC and -25 deg C
    //45 degC and -25 deg C

  annotation (Documentation(info="<html>
<p>Data for air-to-water heat pump Alpha Innotec LW 80 M-A.</p>
<p>Operational envelope data is not from the data table, as it 
is not given. Instead, default values are used.</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>November 26, 2018</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">AixLib #577</a>)
  </li>
</ul>
</html>
"));
end ARIS_DATA_EASE;
