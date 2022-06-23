<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Curso extends Model
{
    use HasFactory,SoftDeletes;
    protected $table='curso';
    protected $primaryKey = 'cod_curso';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;
}
