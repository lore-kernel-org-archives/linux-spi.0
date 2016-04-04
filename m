From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: Re: 4.6-rc1 regression in SPI core -- deadlock
Date: Mon, 4 Apr 2016 03:04:47 -0400
Message-ID: <20160404070446.GJ21636@brightrain.aerifal.cx>
References: <20160404012013.GA5735@brightrain.aerifal.cx>
 <5701E53B.5040407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5701E53B.5040407-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Apr 04, 2016 at 09:23:31AM +0530, Vignesh R wrote:
> 
> 
> On 04/04/2016 06:50 AM, Rich Felker wrote:
> > I've spent several days trying to debug a deadlock using our local
> > (not yet ready for upstream) driver for the J-Core SPI device and it
> > seems to be a new deadlock in the SPI core caused by commit
> > 556351f14e74 and unrelated to the particular driver. Commit
> > 49023d2e4ead tried to solve a related deadlock problem, but there
> > still seems to be a lock order issue and it's affecting SPI use even
> > without the spi_flash_read optimization. The deadlock I'm observing
> > has a kworker thread stuck in wait_for_completion called from
> > spi_sync_locked (ultimately from mmc_rescan) and the completion is
> > never finishing because this kworker thread has the bus locked while
> > the spi master task has already started processing the queue but can't
> > proceed because the bus lock is taken.
> > 
> > Anyone else seen this? Ideas for a proper fix?
> 
> Could you try 24c8cd1b081286("spi: fix possible deadlock between
> internal bus locks and bus_lock_flag") from linux-next?

This seems to fix the problem. I'm still hitting an issue where
mmc_rescan deadlocks (at best) or crashes/corrupts the card state, but
I think that's a separate bug since it happened with my workaround
hack too. The patch in linux-next makes sense to me from what I've
read of the SPI core code so far. Thanks!

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
