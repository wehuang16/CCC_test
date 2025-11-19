within CCC_test.cdl;
model timeTableTest
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable loaShe(
    table=[0,0; 7,1; 20,0; 24,0],
    timeScale=3600,
    period=86400)
    annotation (Placement(transformation(extent={{-60,36},{-40,56}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput
                                                   TZonHeaSetCom
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{74,22},{114,62}}),  iconTransformation(extent={{280,18},{320,
            58}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle" "@prefix brick: <https://brickschema.org/schema/Brick#> .
            @prefix hpfs: <http://hpflex/shapes#> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
            @prefix sh: <http://www.w3.org/ns/shacl#> .
            @prefix qudt: <http://qudt.org/schema/qudt/> .
            @prefix ref: <https://brickschema.org/schema/Brick/ref#> .
            @prefix unit: <http://qudt.org/vocab/unit/> .
            hpfs:<cdl_instance_name> a rdfs:Class, sh:NodeShape ;
              sh:class brick:Heating_Zone_Air_Temperature_Setpoint ;
              sh:property hpfs:temperature-setpoint_Kelvin, hpfs:temperature-setpoint_ref .
            hpfs:temperature-setpoint_Kelvin a sh:PropertyShape ;
              sh:hasValue unit:Kelvin ;
              sh:minCount 1 ;
              sh:path qudt:hasUnit .
            hpfs:temperature-setpoint_ref a sh:PropertyShape ;
                sh:minCount 1 ;
                sh:path ref:hasExternalReference .",
          naturalLanguage="en"
          "<cdl_instance_name> is a temperature heating setpoint input")));
equation
  connect(loaShe.y, TZonHeaSetCom) annotation (Line(points={{-38,46},{18,46},
          {18,42},{94,42}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end timeTableTest;
