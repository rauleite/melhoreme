var app = angular.module('HomeCtrl', []);

app.controller('HomeController', function ($scope, $localStorage, $location, authService, Sidenav) {
    var home = this;
    //$scope.myEnvironment = $scope;
    home.toggle = Sidenav.toggle;
    home.close = Sidenav.close;

    //home.toggle.rightCadastro();

    // Login ---------------------------------------------------
    home.isLogged = function isLogged () {
        if ($localStorage.token) {
            //TODO[RAUL]: Entra aqui um milhao de vezes
            return true;
        } else {
            return false;
        }
    };

    // ----------------------------------------------------------

    // ----------------------------------------------------------

    // Progress Bar

    $scope.$on('showProgress', function(event, data) {
        home.showProgress = data;
    });
});
