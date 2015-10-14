module.exports = function(app) {
var DIR_CLIENT = app.get('dir_client');
	// server routes ===========================================================
	// handle things like api calls
	// authentication routes

	// frontend routes =========================================================
	// route to handle all angular
	app.get('*', function(req, res) {
		res.render(DIR_CLIENT + '/index', {env: process.env.NODE_ENV});
	});

	app.get('/video', function(req, res) {
		res.render(DIR_CLIENT + '/views/video.html');
	});
};