From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: fix possible NULL dereference
Date: Fri, 11 Sep 2015 18:19:45 +0530
Message-ID: <20150911124945.GA10016@sudip-pc>
References: <1441883893-20596-1-git-send-email-sudipm.mukherjee@gmail.com>
 <55F2C4F4.3090704@linux.intel.com>
 <20150911122513.GT12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150911122513.GT12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Sep 11, 2015 at 01:25:13PM +0100, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 03:11:32PM +0300, Jarkko Nikula wrote:
> 
> > Actually this fixes a *real* NULL dereference case but it is not related to
> > normal open/close life cycle of spidev. It requires that spidev is kept open
> > when SPI master is removed.
> 
> > spidev->spi is set to NULL in spidev_remove() and it is called before
> > spidev_release() in case master is removed while spidev is in use
> 
> > It would be good to update this to commit log, add a tag below and Cc
> > <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> 
> > Fixes: 9169051617df ("spi: spidev: Don't mangle max_speed_hz in underlying
> > spi device")
> 
> The patch was already applied :(
Applied? But usually I will receive an auto mail from you after applying.
I dont think I have received any.

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
