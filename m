From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: rockchip: check requesting dma channel with EPROBE_DEFER
Date: Mon, 21 Mar 2016 19:33:04 -0700
Message-ID: <CAD=FV=XUKoKq9_Ecx6F_c7XC6FbM6jK5B5XmKqmds_2zHW7i1g@mail.gmail.com>
References: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
	<1457511092-2216-1-git-send-email-shawn.lin@rock-chips.com>
	<CAD=FV=Wi9SEtM+o4AEPW6kpuGU+NH1uhW9hk5OQ5U8inyr1y1w@mail.gmail.com>
	<56F0A7F0.5000900@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56F0A7F0.5000900-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Shawn,

On Mon, Mar 21, 2016 at 7:03 PM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> ...but, looking at this, presumably before landing any patch that made
>> dma_request_slave_channel() return -EPROBE_DEFER you'd need to modify
>> _all_ users of dma_request_slave_channel to handle error pointers
>> being returned.  Right now dma_request_slave_channel() says it returns
>> a pointer to a channel or NULL and the function explicitly avoids
>> returning any errors.  That might be possible, but it's a big
>> change...
>
>
> At first glance, it's a big change, but maybe not really.
> Almost all of them use the templet like:
> ch = dma_request_slave_channel
> if (!ch)
>         balabala....
>
> It's same for all the non-null return pointer/non-zero value ?
>
> So from my view, we can safely change dma_request_slave_channel,
> and leave the caller here. I presumably the respective
> drivers will graduately migrate to check the return value with
> EPROBE_DEFER if they do care this issue. Otherwise, we believe
> they don't suffer the changes we make, just as what they did in the
> past. Does that make sense?

...but if you return ERR_PTR(-EPROBE_DEFER) and don't change existing
callers, then existing callers will think you've returned a valid
pointer when you really returned an error pointer.  They'll pass this
error pointer around like it's a valid "struct dma_chan", won't then?

Actually, could your code just call
dma_request_slave_channel_reason().  Oh, looks like that's exactly
what you want.  See commit 0ad7c00057dc ("dma: add channel request API
that supports deferred probe").  Oh, but I'm looking at 4.4.  Looking
at linuxnext, it looks like this got renamed to dma_request_chan().
...so you need to use that, no?

Strange, but on 4.4 there was some extra code in
dma_request_slave_channel() that wasn't in
dma_request_slave_channel_reason().  ...but looks like that all got
cleaned up in the same CL that added the new name.


-Doug
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
