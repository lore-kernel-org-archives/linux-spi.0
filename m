From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: rockchip: check requesting dma channel with
 EPROBE_DEFER
Date: Tue, 5 Apr 2016 11:08:05 -0700
Message-ID: <20160405180804.GB8930@vkoul-mobl.iind.intel.com>
References: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
 <1457511092-2216-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=Wi9SEtM+o4AEPW6kpuGU+NH1uhW9hk5OQ5U8inyr1y1w@mail.gmail.com>
 <56F0A7F0.5000900@rock-chips.com>
 <CAD=FV=XUKoKq9_Ecx6F_c7XC6FbM6jK5B5XmKqmds_2zHW7i1g@mail.gmail.com>
 <56F0B3A1.9080509@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F0B3A1.9080509-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 22, 2016 at 10:53:21AM +0800, Shawn Lin wrote:
> >Strange, but on 4.4 there was some extra code in
> >dma_request_slave_channel() that wasn't in
> >dma_request_slave_channel_reason().  ...but looks like that all got
> >cleaned up in the same CL that added the new name.
> 
> dma_request_chan already return ERR_PTR(-EPROBE_DEFER), but
> dma_request_slave_channel ignore this and rewrite it to be NULL.
> Strange behaviour looks to me. commit 0ad7c00057dc ("dma: add channel
> request API that supports deferred probe")  did the right thing, but
> what happened then?  It was drop for some reasons?
> 
> Hello Vinod,
> 
> Could you please elaborate some more infomation to commit 0ad7c00057dc
> ("dma: add channel request API that supports deferred probe") :) ?

The request API was cleaned up here and please see the Documentation on how
to do this.

See the commit a8135d0d7 - dmaengine: core: Introduce new, universal API to
request a channel

Thanks
-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
