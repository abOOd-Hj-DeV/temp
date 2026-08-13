<?php

namespace App\Events\Driver;

use App\Http\Resources\Order\OrderResource;
use App\Models\Order;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class QueuedEvent implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets;

     public $afterCommit = true;
     
    /**
     * Create a new event instance.
     */

    // public Order $order;
    public function __construct(
    )
    {=
    }

    /**
     * The name of the queue on which to place the broadcasting job.
     */
    public function broadcastQueue(): string
    {
        return 'default';
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, \Illuminate\Broadcasting\Channel>
     */
    public function broadcastOn(): array
    {
        return [
            new PrivateChannel("foo.{$this->entity}.bar"),
        ];
    }

    public function broadcastAs()
    {
        return 'event.name';
    }

    public function broadcastWith()
    {
        
    }   
}
