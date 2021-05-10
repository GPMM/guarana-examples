<?xml version="1.0" encoding="ISO-8859-1"?>

<ncl id="GuaranaTest" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
    <head>
        <regionBase>
            <region id="bgReg" width="100%" height="100%" zIndex="1"/>
        </regionBase>
        
        <descriptorBase>
            <descriptor id="bgDesc" region="bgReg"/>
            <descriptor id="conDesc" region="bgReg" focusIndex="0"/>
        </descriptorBase>
        
        <connectorBase>
            <causalConnector id="onSelectionStopStart">
                <simpleCondition role="onSelection"/>
                <compoundAction operator="seq">
                    <simpleAction role="stop" max="unbounded" qualifier="par"/>
                    <simpleAction role="start" max="unbounded" qualifier="par"/>
                </compoundAction>
            </causalConnector>
            
            <causalConnector id="onBeginStart">
                <connectorParam name="del"/>
                <simpleCondition role="onBegin"/>
                <simpleAction role="start" delay="$del" max="unbounded" qualifier="par"/>
            </causalConnector>
            
            <causalConnector id="onEndStart">
                <connectorParam name="del"/>
                <simpleCondition role="onEnd"/>
                <simpleAction role="start" delay="$del" max="unbounded" qualifier="par"/>
            </causalConnector>
            
            <causalConnector id="onEndStop">
                <simpleCondition role="onEnd"/>
                <simpleAction role="stop" max="unbounded" qualifier="par"/>
            </causalConnector>
            
            <causalConnector id="onLookAtStart">
                <simpleCondition role="onLookAt"/>
                <simpleAction role="start" max="unbounded" qualifier="par"/>
            </causalConnector>
            
            <causalConnector id="onLookAwayStop">
                <simpleCondition role="onLookAway"/>
                <simpleAction role="stop" max="unbounded" qualifier="par"/>
            </causalConnector>
        </connectorBase>
    </head>

    <body>
        <!-- esperar usuario conectar Guarana -->
        <port id="entry" component="connect"/>
        <media id="connect" src="https://github.com/GPMM/guarana-examples/raw/main/media/connect.png" descriptor="conDesc"/>
        
        <link xconnector="onSelectionStopStart">
            <bind role="onSelection" component="connect"/>
            <bind role="stop" component="connect"/>
            <bind role="start" component="intro"/>
        </link>
        <!-- esperar usuario conectar Guarana -->
        
        
        <media id="intro" src="https://github.com/GPMM/guarana-examples/raw/main/media/intro.mp4" descriptor="bgDesc"/>
        
        <media id="louvre" src="https://github.com/GPMM/guarana-examples/raw/main/media/louvre2D.mp4" descriptor="bgDesc">
            <area id="scene1" end="29s"/>
            <area id="scene2" begin="29.5s" end="55s"/>
            <area id="scene3" begin="55.5s"/>
        </media>
        
        <media id="louvre360" src="https://github.com/GPMM/guarana-examples/raw/main/louvre.ncl360">
            <area id="mainVideo"/>
            <area id="mapFloor0"/>
            <area id="mapFloor1"/>
            <area id="scene1Photo"/>
            <area id="scene1Info"/>
            <area id="scene2Statue"/>
            <area id="scene2Info"/>
            <area id="scene3Sound"/>
            <area id="scene3Drawing"/>
            <area id="scene3Info"/>
        </media>
        
        <!-- inicia e para a cena 1 -->
        <link xconnector="onEndStart">
            <linkParam name="del" value="0"/>
            <bind role="onEnd" component="intro"/>
            <bind role="start" component="louvre"/>
            <bind role="start" component="louvre360" interface="mainVideo"/>
            <bind role="start" component="louvre360" interface="mapFloor0"/>
            <bind role="start" component="louvre360" interface="scene1Photo">
                <bindParam name="del" value="5s"/>
            </bind>
            <bind role="start" component="louvre360" interface="scene1Info">
                <bindParam name="del" value="5s"/>
            </bind>
        </link>
        
        <link xconnector="onEndStop">
            <bind role="onEnd" component="louvre" interface="scene1"/>
            <bind role="stop" component="louvre360" interface="scene1Photo"/>
            <bind role="stop" component="louvre360" interface="scene1Info"/>
        </link>
        
        <!-- inicia e para a cena 2 -->
        <link xconnector="onBeginStart">
            <linkParam name="del" value="0"/>
            <bind role="onBegin" component="louvre" interface="scene2"/>
            <bind role="start" component="louvre360" interface="scene2Statue"/>
            <bind role="start" component="louvre360" interface="scene2Info"/>
        </link>
        
        <link xconnector="onEndStop">
            <bind role="onEnd" component="louvre" interface="scene2"/>
            <bind role="stop" component="louvre360" interface="scene2Statue"/>
            <bind role="stop" component="louvre360" interface="scene2Info"/>
            <bind role="stop" component="louvre360" interface="mapFloor0"/>
        </link>
        
        <!-- inicia e para a cena 3 -->
        <link xconnector="onBeginStart">
            <linkParam name="del" value="0"/>
            <bind role="onBegin" component="louvre" interface="scene3"/>
            <bind role="start" component="louvre360" interface="scene3Drawing"/>
            <bind role="start" component="louvre360" interface="scene3Info"/>
            <bind role="start" component="louvre360" interface="mapFloor1"/>
        </link>
        
        <link xconnector="onEndStop">
            <bind role="onEnd" component="louvre" interface="scene3"/>
            <bind role="stop" component="louvre360" interface="scene3Drawing"/>
            <bind role="stop" component="louvre360" interface="scene3Info"/>
            <bind role="stop" component="louvre360" interface="mapFloor1"/>
            <bind role="stop" component="louvre360" interface="mainVideo"/>
        </link>
        
        <!-- interacao da cena 3 -->
        <link xconnector="onLookAtStart">
            <bind role="onLookAt" component="louvre360" interface="scene3Info"/>
            <bind role="start" component="louvre360" interface="scene3Sound"/>
        </link>
        
        <link xconnector="onLookAwayStop">
            <bind role="onLookAway" component="louvre360" interface="scene3Info"/>
            <bind role="stop" component="louvre360" interface="scene3Sound"/>
        </link>
    </body>
</ncl>