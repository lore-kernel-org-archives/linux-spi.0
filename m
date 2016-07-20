From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: Applied "spi: rockchip: limit transfers to (64K - 1) bytes" to
 the spi tree
Date: Wed, 20 Jul 2016 10:01:52 -0700
Message-ID: <20160720170151.GA14956@google.com>
References: <1468546259-136659-1-git-send-email-briannorris@chromium.org>
 <E1bPubM-0002u3-AQ@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Eddie Cai <eddie.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1bPubM-0002u3-AQ@debutante>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Wed, Jul 20, 2016 at 05:44:04PM +0100, Mark Brown wrote:
> The patch
> 
>    spi: rockchip: limit transfers to (64K - 1) bytes
> 
> has been applied to the spi tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From 5185a81c02d4118b11e6cb7b5fbf6f15ff7aff90 Mon Sep 17 00:00:00 2001
> From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Date: Thu, 14 Jul 2016 18:30:59 -0700
> Subject: [PATCH] spi: rockchip: limit transfers to (64K - 1) bytes
> 
> The Rockchip SPI controller's length register only supports 16-bits,
> yielding a maximum length of 64KiB (the CTRLR1 register holds "length -
> 1"). Trying to transfer more than that (e.g., with a large SPI flash
> read) will cause the driver to hang.
> 
> Now, it seems that while theoretically we should be able to program
> CTRLR1 with 0xffff, and get a 64KiB transfer, but that also seems to
> cause the core to choke, so stick with a maximum of 64K - 1 bytes --
> i.e., 0xffff.
> 
> Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks for applying! I'm OK with that, but just to be clear this might
qualify as a (very slight) hack, since I believe we should be able to
support a full 64KiB on both PIO and DMA. But it is better than the
current state of things on this driver, IMO. I suppose it's up to
Rockchip (or me) to figure out why some PIO transfers fail at exactly
64K if we want to support that. They have reproduced the failures I've
seen.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
