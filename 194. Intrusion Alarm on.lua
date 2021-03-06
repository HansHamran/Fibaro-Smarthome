--[[
%% properties
%% events
%% globals
--]]
local startSource = fibaro:getSourceTrigger();
if fibaro:countScenes() > 1 then fibaro:abort() end

if (startSource["type"] == "other") then
  
  -- Copy from 2xBlue in here and add "end", endre 430 sjekk til 0
 -- SETTER PÅ ALARM
  -- sjekker at utgangsdør er åpnet og andre dører lukket før prosedyre starter
  	if ( tonumber(fibaro:getValue(430, "value")) == 0 -- utgangsdør
      	and tonumber(fibaro:getValue(24, "value")) == 0
        and tonumber(fibaro:getValue(639, "value")) == 0 
      	and tonumber(fibaro:getValue(422, "value")) == 0 
        and tonumber(fibaro:getValue(444, "value")) == 0)
 	then
    	-- starter scene for låse opp og igjen garasje
    	-- fibaro:startScene(209);
  		-- venter på at utgangsdøra skal lukkes (60 sekunder)    
    	local teller = 1
    	while ( tonumber(fibaro:getValue(430, "value")) == 1 and teller < 60) do
    	fibaro:sleep(1000)
    	teller = teller + 1
    	end

    	-- låser dør
	  	if ( tonumber(fibaro:getValue(430, "value")) == 0 and tonumber(fibaro:getValue(734, "value")) == 1)
	    then 
	    fibaro:call(753, "secure");
	    end
    
       	-- sjekker at dørslå er i før alarm settes på
    	local teller = 1
    	while ( tonumber(fibaro:getValue(734, "value")) == 1 and teller < 60) do
    	fibaro:sleep(1000)
    	teller = teller + 1
    	end
    		if tonumber(fibaro:getValue(734, "value")) == 0
      		then
			fibaro:call(24, "setArmed", "1");
			-- fibaro:call(430, "setArmed", "1");
			fibaro:call(639, "setArmed", "1");
			fibaro:call(422, "setArmed", "1");
			fibaro:call(444, "setArmed", "1");
    		fibaro:call(210, "setArmed", "1");
			fibaro:call(771, "setArmed", "1");
			fibaro:call(745, "setArmed", "1");
			fibaro:call(601, "setArmed", "1");       
      
      		-- slå av alt lys
       		fibaro:call(55, "turnOff");
			fibaro:call(51, "turnOff");
			fibaro:call(59, "turnOff");
			fibaro:call(67, "turnOff");
			fibaro:call(71, "turnOff");
			fibaro:call(63, "turnOff");
			fibaro:call(267, "turnOff");
			fibaro:call(289, "turnOff");
			fibaro:call(293, "turnOff");
			fibaro:call(251, "turnOff");
			fibaro:call(247, "turnOff");
			fibaro:call(176, "turnOff");
			fibaro:call(585, "turnOff");
			-- fibaro:call(259, "turnOff");
			fibaro:call(263, "turnOff");
			fibaro:call(152, "turnOff");
			fibaro:call(189, "turnOff");
			fibaro:call(164, "turnOff");
			fibaro:call(255, "turnOff");
			fibaro:call(512, "turnOff");
			fibaro:call(296, "turnOff");
			fibaro:call(183, "turnOff");
			fibaro:call(349, "turnOff");
			fibaro:call(236, "turnOff");
			fibaro:call(240, "turnOff");
			fibaro:call(169, "turnOff");
			fibaro:call(244, "turnOff");
			fibaro:call(384, "turnOff");
			fibaro:call(167, "turnOff");
			fibaro:call(395, "turnOff");
      		fibaro:call(183, "turnOff");
			fibaro:call(185, "turnOff");
			fibaro:call(375, "turnOff");
			fibaro:call(379, "turnOff");
			fibaro:call(281, "turnOff");
			fibaro:call(275, "turnOff");
			fibaro:call(271, "turnOff");
      
            	if fibaro:getGlobal("MorgenLysKjokken") ~= "Venter" then
			    fibaro:setGlobal("MorgenLysKjokken", "Venter") end
      
      			if fibaro:getGlobal("Kveldslysstue") ~= "Venter" then
			    fibaro:setGlobal("Kveldslysstue", "Venter") end
  
    		-- setter på simuler fravær
    		fibaro:call(137, "pressButton", "3"); 
      		-- Slår på kamera
      		fibaro:call(479, "turnOn")
      
      
      
        	-- Slår av varme stua
      			if fibaro:getGlobalValue("Ferie") == "Nei"
    			then
  				fibaro:call(135, "pressButton", "4"); -- Normal syklus
        		fibaro:setGlobal("HoldStueVarme", "Nei");
        		else
          		fibaro:call(135, "pressButton", "2"); -- Sparing
        		fibaro:setGlobal("HoldStueVarme", "Nei");
    			end
      		-- Setter Nobø 2, Maris rom
      		    if 	fibaro:getGlobal("RomMari") == "Kaldt"
        			or fibaro:getGlobalValue("Ferie") == "Ja"
		    	then
		  		fibaro:call(606, "pressButton", "3"); -- Sparing
        		else
        		fibaro:call(606, "pressButton", "2"); -- Syklus
				end
      
      		-- Setter Nobø 3, Fannys rom
            	if 	fibaro:getGlobal("RomFanny") == "Kaldt"
        			or fibaro:getGlobalValue("Ferie") == "Ja"
		    	then
		  		fibaro:call(607, "pressButton", "3"); -- Sparing
        		else
        		fibaro:call(607, "pressButton", "2"); -- Syklus
				end
      
           -- Setter varme Katrines rom
            	if 	fibaro:getGlobal("RomKatrine") == "Kaldt"
        			or fibaro:getGlobalValue("Ferie") == "Ja"
		    	then
		  		fibaro:call(627, "pressButton", "2"); -- Sparing
        		else
        		fibaro:call(627, "pressButton", "4"); -- Syklus
				end
      
                 -- Setter varme Kontor
            	if 	fibaro:getGlobal("RomKontor") == "Kaldt"
        			or fibaro:getGlobalValue("Ferie") == "Ja"
		    	then
		  		fibaro:call(626, "pressButton", "2"); -- Sparing
        		else
        		fibaro:call(626, "pressButton", "4"); -- Syklus
				end
      
                       -- Setter varme Foreldre
            	if 	fibaro:getGlobal("RomForeldre") == "Kaldt"
        			or fibaro:getGlobalValue("Ferie") == "Ja"
		    	then
		  		fibaro:call(136, "pressButton", "3"); -- Sparing
        		else
        		fibaro:call(136, "pressButton", "2"); -- Syklus
				end
      
      		fibaro:debug("Alarm slått på")
      			if ( fibaro:getGlobalValue("Ferie") == "Ja" and tonumber(fibaro:getValue(755, "value")) > 0 )
				then 
        		fibaro:call(755, "turnOff");
        		fibaro:debug("Hovedkran er stengt");
				end
    		end
    else
    		fibaro:call(367, "turnOn");
    		fibaro:sleep(10);
    		fibaro:call(367, "turnOff");
    		fibaro:sleep(10);
        	fibaro:call(367, "turnOn");
    		fibaro:sleep(10);
    		fibaro:call(367, "turnOff");
      		fibaro:debug("Alarm kunne ikke slås på.")
	end
  end
  

