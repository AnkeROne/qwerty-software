<?php
/**
 * Created by PhpStorm.
 * User: Дмитрий
 * Date: 16.04.2018
 * Time: 22:54
 */

namespace App;

use Illuminate\Database\Eloquent\Model;

class Like extends Model
{
    protected $fillable = ['is_like','user_id','post_id'];
}