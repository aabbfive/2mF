WAIT 5.
RUNPATH("0:getScripts").
SET cutoffFuelB TO 1500.
SET cutoffFuelC TO 2700.

SET lp TO SHIP:GEOPOSITION.
RUNPATH("0:getScripts").
LOCK THROTTLE TO 1.
STAGE.
RUN ascent.
PRINT "LIFTOFF".
TOGGLE GEAR.
FOR eng IN SHIP:PARTSDUBBED("CSE") {
    SET eng:THRUSTLIMIT TO 50.
}
WAIT UNTIL SHIP:PARTSDUBBED("RTB")[0]:RESOURCES[0]:AMOUNT < cutoffFuelB + 100.
LOCK STEERING TO SHIP:VELOCITY:SURFACE.
PRINT "PREPARING TO DETACH".
WAIT UNTIL SHIP:PARTSDUBBED("RTB")[0]:RESOURCES[0]:AMOUNT < cutoffFuelB.
TOGGLE AG5.
FOR eng IN SHIP:PARTSDUBBED("BE") {
    eng:SHUTDOWN().
}
STAGE.
PRINT "BOOSTER SEPARATION".
FOR eng IN SHIP:PARTSDUBBED("CSE") {
    SET eng:THRUSTLIMIT TO 100.
}
RUN ascent.
WAIT UNTIL SHIP:PARTSDUBBED("RTC")[0]:RESOURCES[0]:AMOUNT < cutoffFuelC + 100.
LOCK STEERING TO SHIP:VELOCITY:SURFACE.
PRINT "PREPARING TO SEPARATE".
WAIT UNTIL SHIP:PARTSDUBBED("RTC")[0]:RESOURCES[0]:AMOUNT < cutoffFuelC.
PRINT "MECO - SEPARATION".
TOGGLE RCS.
LOCK THROTTLE TO 0.
TOGGLE AG6.
STAGE.
RUN returnTo(lp, 3.5, 10).