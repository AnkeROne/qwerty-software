<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use App\Post;
use App\Like;
use App\User;
use Auth;

class PostsController extends Controller
{
    public function index()
    {
        $posts = Post::getAllPosts();

        return view('index', compact('posts'));
    }

    public function show(Post $post)
    {
        if (Auth::guest()){
            $getPost = Post::getPost($post, 0);
        } else {
            $getPost = Post::getPost($post, Auth::user()->id);
        }        
        $count = $getPost['count'];
        $author = $getPost['author'];
        $like = $getPost['like'];

        return view('posts.show', compact('post', 'count', 'author', 'like') );
    }

    public function create()
    {
        return view("posts.create");
    }

    public function store()
    {
        $this->validate(request(), [
            'title' => 'required|min:2',
            'alias' => 'required',
            'intro' => 'required',
            'body' => 'required',
        ]);

        $dataPost = array_merge(request(array('title', 'alias', 'intro', 'body')), ['user_id'=>Auth::user()->id]);
        Post::createPost($dataPost);

        return redirect('/');
    }

    public function edit(Post $post)
    {
        $author = User::where('id', $post->user_id)->get();
        $author = $author[0]['name'];
        if ($author == Auth::user()->name){
            return view("posts.edit", compact('post'));
        }else{
            return redirect('/');
        }
    }

    public function update(Post $post)
    {
        $author = User::where('id', $post->user_id)->get();
        $author = $author[0]['name'];
        if ($author == Auth::user()->name){
            $this->validate(request(), [
                'title' => 'required|min:2',
                'alias' => 'required',
                'intro' => 'required',
                'body' => 'required',
            ]);
            $data = request(['title', 'alias', 'intro', 'body']);
            Post::updatePost($data, $post);
            return redirect('/');
        }else{
            return redirect('/');
        }
    }

    public function destroy(Post $post){
        $author = User::where('id', $post->user_id)->get();
        $author = $author[0]['name'];
        if ($author == Auth::user()->name){
            Post::deletePost($post);
            return redirect('/');
        }else{
            return redirect('/'); 
        }
    }

    public function setLike(Post $post){

        if (!Auth::guest()){
           Post::setLike($post, 1); 
        }

    }

    public function unsetLike(Post $post){
        
        if (!Auth::guest()){
           Post::setLike($post, 0); 
        }

    }

}
