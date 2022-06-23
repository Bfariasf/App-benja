<?php

namespace App\Http\Controllers;

use App\Models\Alumno;
use Illuminate\Http\Request;

class AlumnosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        return Alumno::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        $alumno = new Alumno();
        $alumno -> cod_alumno = $request -> cod_alumno;
        $alumno -> nom_alumno = $request -> nom_alumno;
        $alumno -> direccion = $request -> direccion;
        $alumno -> telefono = $request -> telefono;
        $alumno -> edad = $request -> edad;
        $alumno -> nom_curso = $request -> nom_curso;
        $alumno -> save();
        return $alumno;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Alumno  $alumno
     * @return \Illuminate\Http\Response
     */
    public function show(Alumno $alumno)
    {
        //

        return $alumno;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Alumno  $alumno
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Alumno $alumno)
    {
        //
        $alumno -> cod_alumno = $request -> cod_alumno;
        $alumno -> nom_alumno = $request -> nom_alumno;
        $alumno -> direccion = $request -> direccion;
        $alumno -> telefono = $request -> telefono;
        $alumno -> edad = $request -> edad;
        $alumno -> nom_curso = $request -> nom_curso;
        $alumno -> save();
        return $alumno;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Alumno  $alumno
     * @return \Illuminate\Http\Response
     */
    public function destroy(Alumno $alumno)
    {
        //
        $alumno -> delete();
    }
}
