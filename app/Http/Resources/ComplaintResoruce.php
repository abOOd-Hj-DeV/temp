<?php

namespace App\Http\Resources;

use App\Constants\MediaCollection;
use App\Constants\RouteNames;
use App\Http\Resources\BaseJsonResource;
use App\Http\Resources\Media\MediaResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ComplaintResoruce extends BaseJsonResource
{
    protected function resourceArray($request)
    {
        $data = [
            'id' => $this->id,
            'type' => $this->type,
            'subject' => $this->subject,
            'description' => $this->description,
            'sender_id' => $this->sender_id,
            'sender_type' => getActorByModel($this->sender_type),
            'files' => MediaResource::collection($this->getMedia(MediaCollection::COMPLAINT_COLLECTION)),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at
        ];

        $from = getModelByPath($this->sender_type)::find($this->sender_id);
        $from->load('user');
        $from_name = $from->user?->name;

        $data['sender_name'] = $from_name;

        if(auth()->user()->isAdmin())
            $data['archived'] = $this->archived;
        
        return $data;
    }

    protected function extendForHttp(array $data, $request)
    {
        $routeName = $request->route()->getName();

        switch ($routeName) 
        {
            //case RouteNames::EXAMPLE:
            //    $data['foo'] = 'bar';
            //    break;
        }

        return $data;
    }
}
