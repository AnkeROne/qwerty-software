@extends('layouts.layout')

@section('content')
    <div class="blog-post">
        <div class="row">
            <div class="col-xs-5 col-sm-4">
                <h2 class="blog-post-title">{{$post->title}}</h2>
                <p class="blog-post-meta hidden" id='post_id'>{{$post->id}}</p>
                <p class="blog-post-meta">Опубликовано: <strong>{{$post->created_at}}</strong></p>
                <p class="blog-post-meta">Редактировано: <strong>{{$post->updated_at}}</strong></p>
                <p class="blog-post-meta">Статью написал: <strong>{{$author}}</strong></p>
                <p class="blog-post-meta" id='total-likes'>Понравилось: <strong>{{$count}}</strong></p>
                <br>
            </div>
            
                <div class="col-xs-5 col-sm-4 img-resp">
                    @if ($post->logo != '0')
                        <img src="{{asset($post->logo)}}" class="img-size">
                    @endif
                </div>
            
        </div>
        <div class="row">
            <div class="col-xs-10 col-sm-8">
                <p class="text-justify">
                    {{$post->body}}
                </p>
                <div class="nav-btn-bar">
                    <hr>
                    @if (Auth::guest())
                        <p>Для того что бы оценить статью - <a href="{{ route('login') }}">авторизируйтесь</a>!</p>
                    @else
                        @if ($like == 0)
                            <p class="nav-btn-bar show" id="set-like"><a href="" class="btn btn-default">Like</a></p>
                            <p class="nav-btn-bar hidden" id="unset-like"><a href="" class="btn btn-default">Dislike</a></p>
                        @else
                            <p class="nav-btn-bar hidden" id="set-like"><a href="" class="btn btn-default">Like</a></p>
                            <p class="nav-btn-bar show" id="unset-like"><a href="" class="btn btn-default">Dislike</a></p>
                        @endif
                        @if (Auth::user()->name == $author)
                            <p class="nav-btn-bar"><a href="/posts/{{$post->id}}/edit" class="btn btn-primary">Редактировать</a> </p>
                            <form action="/posts/{{$post->id}}" method="post" class="nav-btn-bar">
                                    {{csrf_field()}}
                                    {!! method_field('delete') !!}
                                <button type="submit" class="nav-btn-bar btn btn-danger">Удалить</button>
                            </form>
                        @endif
                    @endif
                </div>    
            </div>
        </div>
    </div>

    <div class="row hidden">

        <div class="col-sm-8 blog-main">

            <div class="blog-post">
                <div class="col-sm-6">
                    <h2 class="blog-post-title">{{$post->title}}</h2>
                    <p class="blog-post-meta hidden" id='post_id'>{{$post->id}}</p>
                    <p class="blog-post-meta">Опубликовано: <strong>{{$post->created_at}}</strong></p>
                    <p class="blog-post-meta">Редактировано: <strong>{{$post->updated_at}}</strong></p>
                    <p class="blog-post-meta">Статью написал: <strong>{{$author}}</strong></p>
                    <p class="blog-post-meta" id='total-likes'>Понравилось: <strong>{{$count}}</strong></p>
                    <br>
                </div>
                <div class="col-sm-6">

                </div>
                <p class="text-justify">
                    {{$post->body}}
                </p>
                <div class="nav-btn-bar">
                    <hr>
                    @if (Auth::guest())
                        <p>Для того что бы оценить статью - <a href="{{ route('login') }}">авторизируйтесь</a>!</p>
                    @else
                        @if ($like == 0)
                            <p class="nav-btn-bar show" id="set-like"><a href="" class="btn btn-default">Like</a></p>
                            <p class="nav-btn-bar hidden" id="unset-like"><a href="" class="btn btn-default">Dislike</a></p>
                        @else
                            <p class="nav-btn-bar hidden" id="set-like"><a href="" class="btn btn-default">Like</a></p>
                            <p class="nav-btn-bar show" id="unset-like"><a href="" class="btn btn-default">Dislike</a></p>
                        @endif
                        @if (Auth::user()->name == $author)
                            <p class="nav-btn-bar"><a href="/posts/{{$post->id}}/edit" class="btn btn-primary">Редактировать</a> </p>
                            <form action="/posts/{{$post->id}}" method="post" class="nav-btn-bar">
                                    {{csrf_field()}}
                                    {!! method_field('delete') !!}
                                <button type="submit" class="nav-btn-bar btn btn-danger">Удалить</button>
                            </form>
                        @endif
                    @endif
                </div>

            </div><!-- /.blog-sidebar -->

        </div>
@endsection