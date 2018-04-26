@extends('layouts.layout')

@section('content')
    <div class="row">
        @foreach($posts as $post)

                <div class="col-md-12">
                    <h2>{{ $post->title }}</h2>
                    <p>{{ $post->intro }}</p>
                    <div class="nav-btn-bar">
                        <p class="nav-btn-bar"><a href="/posts/{{$post->id}}" class="btn btn-default">Читать далее</a> </p>
                    </div>
                </div>

        @endforeach
    </div>

@endsection