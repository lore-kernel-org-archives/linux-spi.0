From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Use newer more explicit DMAengine terminate
 API
Date: Thu, 3 Mar 2016 13:12:52 +0200
Message-ID: <20160303111252.GQ1794@lahna.fi.intel.com>
References: <1457002934-9671-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457002934-9671-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Mar 03, 2016 at 01:02:14PM +0200, Jarkko Nikula wrote:
> Commit b36f09c3c441 ("dmaengine: Add transfer termination
> synchronization support") marked dmaengine_terminate_all() as
> deprecated and is being replaced by explicit synchronous and asynchronous
> terminate functions.
> 
> Here DMA termination are done in two cases: FIFO overrun and module
> removal.
> 
> FIFO overrun is handled in interrupt context and converting
> dmaengine_terminate_all() to dmaengine_terminate_async() does the same than
> before.
> 
> Using synchronous termination in module removal however adds a bit more
> robustness as it waits all completion callbacks have finished. Although it
> looks all known DMA engines used with spi-pxa2xx don't implement
> device_synchronize() callback so this too appears to be a no-op in
> practice.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
