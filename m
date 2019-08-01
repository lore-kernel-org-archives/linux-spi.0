From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 1 Aug 2019 14:17:18 +0200
Message-ID: <20190801121718.GE31381@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Doug Anderson <dianders@google.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 01, 2019 at 01:27:04PM +0200, Enric Balletbo i Serra wrote:
> 
> cc'ing Doug as he might be really interested on this patch
> 
> On 1/8/19 13:13, Peter Zijlstra wrote:
> > The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> > 
> 
> You say below that is not a suitable default but there is any other reason? Did
> you observed problems with this?

I didn't observe any problems with it personally. But imagine your
device is used to control something critical, like something leathal,
say a bandsaw. And just as you stick your hand through the laser
guarding it, your SPI device chirps and preempts the task that was about
to pull the emergency break and save your hand.

FIFO-99 is the highest possible prio (for SCHED_FIFO) and by using it
you say your task is the utmost imporant task on the system.

I'm thinking that isn't true 99% of the time, except of course when that
bandsaw emergency break is attached through SPI, but in that case the
admin can very well chrt the prio of this thread.
