private _weathers = [
    [0.25],
    [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55],
    [0, 0.1, 0.15, 0.2, 0.25, 0.3, 0.325, 0.35, 0.375, 0.4, 0.425, 0.45, 0.475, 0.5, 0.525, 0.55, 0.575, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1]
] select (3 - 1);

private _newWeather = selectRandom _weathers;
0 setOvercast _newWeather;
forceWeatherChange;


_newWeather = selectRandom _weathers;
(3600 * timeMultiplier) setOvercast _newWeather;
sleep 3000; // Slighty less than weather transition time, as sleep duration is depending on FPS



