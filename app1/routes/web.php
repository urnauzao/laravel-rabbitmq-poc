<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/enviar', function(Request $request){
    $mensagem = $request->input('mensagem',"Mensagem vazia"). " : " .now()->format('H:i:s d-m-Y');
    dispatch(new App\Jobs\EnviarMensagemJob($mensagem));
});
