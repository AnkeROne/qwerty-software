<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Auth;

class Post extends Model
{
    protected $fillable = ['logo', 'title', 'alias', 'intro', 'body', 'user_id'];

    /* Get all posts */
    public static function getAllPosts(){

    	$posts = Post::all()->sortByDesc("created_at");
    	return $posts;

    }
   	/* Get {id} post */
    public static function getPost($post, $user_id = 0){
    	$likes = Like::where('post_id', $post->id)->get();
        $is_like = Like::where('user_id', $user_id)
                        ->where('post_id', $post->id)
                        ->first();
        
        if (isset($is_like)){ 
            $like = $is_like['is_like'];   
        } else{
            $like = 0;
        }

        $count = 0;
        foreach ($likes as $value){
            if ($value['is_like'] == 1) {
                $count+=1;
            }
        }

        $author = User::where('id', $post->user_id)->get();
        $author = $author[0]['name'];


        return array(
	        	'post' 		=> $post, 
	        	'count' 	=> $count, 
	        	'author' 	=> $author, 
	        	'like' 		=> $like,
        		);

    }
    /* Create post */
    public static function createPost(){
  
        $title = Post::checkText( request(array('title'))['title'] );
        $alias = Post::checkText( request(array('alias'))['alias'] );
        $intro = Post::checkText( request(array('intro'))['intro'] );
        $body  = Post::checkText( request(array('body'))['body']  );    

    	$post = Post::create(
            array_merge(
	            	[
		            	'user_id'=>Auth::user()->id, 
		            	'title'=>$title, 
		            	'alias'=>$alias,
		            	'intro'=>$intro,
		            	'body'=>$body
	            	]
            	)
        );
        $path = Post::upload($post->id);
        $post->logo = $path;
        $post->save();

    }
    /* Check for restricted words */
    public static function checkText($text){
        $restrictedWords = ['бублик' => '', 
        					'ревербератор' => '', 
        					'кастет' => '', 
        					'хорь' => '', 
        					'алкоголь' => '', 
        					'превысокомногорассмотрительствующий' => '', 
        					'гражданин' => '', 
        					'паста' => ''];
        foreach ($restrictedWords as $key => $word) {
            $arrayTemp = array();
            $arrayTemp[0] = mb_substr($key, 0, 1, 'utf-8');
            for ($i = 1; $i < strlen($key)/2 - 1; $i++ ) $arrayTemp[$i] = '*';
            $arrayTemp[strlen($key)/2-1] = mb_substr($key, strlen($key)/2-1, 1, 'utf-8');
            $restrictedWords[$key] = implode($arrayTemp);
        }
        foreach ($restrictedWords as $key => $word) {
            $text = str_replace($key, $word, $text);           
        }
        return $text;
    }
    /* Update {id} post */
    public static function updatePost($data, $post){

    	$data['title'] = Post::checkText( $data['title'] );
        $data['alias'] = Post::checkText( $data['alias'] );
        $data['intro'] = Post::checkText( $data['intro'] );
        $data['body']  = Post::checkText( $data['body']  );
        if (Input::hasFile('file')) {
        	$path = Post::upload($post->id);
        	$data['logo'] = $path;
        }
    	$post->update($data);

    }
    /* Delete {id} post */
    public static function deletePost($post){

    	$likes = Like::where('post_id', $post->id);
    	if($likes){
    		$likes->delete();
    	}
    	$post->delete();

    }
    /* (UN)Set like for {id} post and {id} user */
    public static function setLike($post, $isLike){
    	$user_id = Auth::user()->id;
        $post_id = $post->id;
        
        $like = Like::where('user_id', $user_id)
                        ->where('post_id', $post_id)
                        ->first();

        if (isset($like)){ 
            $like->is_like = $isLike;
            $like->save(); 
        } else{
            $like = new Like;
            $like->user_id = $user_id;
            $like->post_id = $post_id;
            $like->is_like = $isLike;
            $like->save(); 
        }
    }

    public static function upload($id){

        $structure = "uploads/post/$id/";

        $rules = [
            'file' => 'required|mimes:jpeg,bmp,png|size:5000',
        ];        

        if (!is_dir($structure)) {
            mkdir($structure, 0777, true);
        }

        if (Input::hasFile('file')) {
            $file = Input::file('file');
            $validator = Validator::make(array(request('file')), $rules);
            $name = md5(rand(000, 999));
            $file->move($structure, $name . '.' . $file->getClientOriginalExtension());
            $fullPath = $structure . $name . '.' . $file->getClientOriginalExtension();
            return $fullPath;
        }else{
            return 0;
        }

    }

}
