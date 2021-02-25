<?xml version="1.0" encoding="ISO-8859-1"?>

<ncl id="GuaranaTest" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
    <head>
        <regionBase>
            <region id="bgReg" width="100%" height="100%" zIndex="1"/>
        </regionBase>
        
        <descriptorBase>
            <descriptor id="bgDesc" region="bgReg"/>
        </descriptorBase>
        
        <connectorBase>
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
        </connectorBase>
    </head>

    <body>
        <port id="entry" component="intro"/>
        
        <media id="intro" src="media/intro.mp4" descriptor="bgDesc"/>
        
        <media id="louvre" src="media/louvre.mp4" descriptor="bgDesc">
            <area id="scene1" end="29s"/>
            <area id="scene2" begin="29.5s" end="55s"/>
            <area id="scene3" begin="55.5s"/>
        </media>
        
        <media id="louvre360" src="louvre.ncl360">
            <media id="vid360" label="mainVideo"/>
            <media id="map" label="mapImage"/>
            <media id="outPic" label="scene1Photo"/>
            <media id="outInf" label="scene1Info"/>
            <media id="statue" label="scene2Statue"/>
            <media id="objInf" label="scene2Info"/>
            <media id="fotos" label="scene3Sound"/>
            <media id="monaVid" label="scene3Drawing"/>
            <media id="monaInf" label="scene3Info"/>
        </media>
        
        <!-- envia a cena no início da introducao -->
        <link xconnector="onBeginStart">
            <linkParam name="del" value="0"/>
            <bind role="onBegin" component="intro"/>
            <bind role="start" component="louvre360"/>  <!-- esse start faria o envio -->
        </link>
        
        <!-- inicia e para a cena 1 -->
        <link xconnector="onEndStart">
            <linkParam name="del" value="0"/>
            <bind role="onEnd" component="intro"/>
            <bind role="start" component="louvre"/>
            <bind role="start" component="louvre360" interface="vid360"/>
            <bind role="start" component="louvre360" interface="map"/>
            <bind role="start" component="louvre360" interface="outPic">
                <bindParam name="del" value="5s"/>
            </bind>
            <bind role="start" component="louvre360" interface="outInf">
                <bindParam name="del" value="5s"/>
            </bind>
        </link>
        
        <link xconnector="onEndStop">
            <bind role="onEnd" component="louvre" interface="scene1"/>
            <bind role="stop" component="louvre360" interface="outPic"/>
            <bind role="stop" component="louvre360" interface="outInf"/>
        </link>
        
        <!-- inicia e para a cena 2 -->
        <link xconnector="onBeginStart">
            <linkParam name="del" value="0"/>
            <bind role="onBegin" component="louvre" interface="scene2"/>
            <bind role="start" component="louvre360" interface="statue"/>
            <bind role="start" component="louvre360" interface="objInf"/>
        </link>
        
        <link xconnector="onEndStop">
            <bind role="onEnd" component="louvre" interface="scene2"/>
            <bind role="stop" component="louvre360" interface="statue"/>
            <bind role="stop" component="louvre360" interface="objInf"/>
        </link>
        
        <!-- inicia e para a cena 3 -->
        <link xconnector="onBeginStart">
            <linkParam name="del" value="0"/>
            <bind role="onBegin" component="louvre" interface="scene3"/>
            <bind role="start" component="louvre360" interface="monaVid"/>
            <bind role="start" component="louvre360" interface="monaInf"/>
        </link>
        
        <link xconnector="onEndStop">
            <bind role="onEnd" component="louvre" interface="scene3"/>
            <bind role="stop" component="louvre360" interface="monaVid"/>
            <bind role="stop" component="louvre360" interface="monaInf"/>
        </link>
        
        <!-- interacao da cena 3 -->
        <link xconnector="onLookAtStart">
            <bind role="onLookAt" component="louvre360" interface="monaInf"/>
            <bind role="start" component="louvre360" interface="fotos"/>
        </link>
    </body>
</ncl>