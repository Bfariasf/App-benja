<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Alumno extends Model
{
    use HasFactory, softDeletes;
    protected $table = 'alumnos';
    protected $primaryKey = 'cod_alumno';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;
}
