<?php
namespace App\Events;

use App\Http\Resources\Order\OrderResource;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class DirectEvent implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;


    public function __construct()
    {

    }

    public function broadcastOn(): array
    {
        return [
            new PrivateChannel("foo.{$this->entity}.bar"),
        ];
    }

    public function broadcastAs(): string
    {
        return 'event.name';
    }

    public function broadcastWith()
    {
        return [
            
        ];
    }
}