From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/10] dmaengine: intel-mid-dma: remove the driver
Date: Wed, 15 Oct 2014 20:37:27 +0530
Message-ID: <20141015150727.GX1638@intel.com>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-11-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-b5Z7lJ3WibVrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411060140-2801-11-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Sep 18, 2014 at 08:09:00PM +0300, Andy Shevchenko wrote:
> Since the last and the only user of this driver is converted to use dw_dmac we
> can remove driver from the tree.
> 
> Moreover, besides the driver is unmaintained a long time, it serves for the
> DesignWare DMA IP, for which we have already driver in the tree.
I dont mind, two things:

- were the spi changes merged, if so we cna queue up post rc1
- have you added support for iDMA in DW? I dont think that I have seen stuff
  on that

-- 
~Vinod

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
