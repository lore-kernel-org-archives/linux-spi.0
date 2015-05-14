From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_MASTER_MUST_* with scatter-gather only option and avoiding realloc
Date: Thu, 14 May 2015 13:19:14 +0200
Message-ID: <BF513C5A-6BB9-423C-9244-F65EEA5AA2DD@martin.sperl.org>
References: <20150512165053.GE3066@sirena.org.uk> <1431597524-7907-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431597524-7907-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 14.05.2015, at 11:58, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> 
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Rewrite of spi_map_msg and spi_map_buf so that for SPI_MASTER_MUST_*:
> * short transfers are handled by a page-sized buffer instead of
>  reallocating and freeing memory (if smaller than PAGE_SIZE)
> * with an extra set of flags allows to ONLY create a scatter/gather list
>  that reuses the same page for all the transfers
>  The scatter list produced is a match of the corresponding template
>  scatter list (so tx-sg is the template for the rx-sg and vice versa)
> 
> It also fixes the insufficient cleanup in case __spi_map_msg returns
> an error.
> 
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---

Forgot to mention:

Tested on a raspberry pi with the following devices:
* 2x mcp2515
* 1x mmc_spi (with dma)
* 1x enc28j60 (with dma)
* 1x fb_st7735r (with dma)

The fbtft-device played all of the BigBuckBunny movie without any issues.
The spi-ethernet card was able to transfer 64MB without hickups
the fsck of the attached sd card worked flawlessly.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
