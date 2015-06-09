From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: remove legacy PXA DMA bits
Date: Tue, 9 Jun 2015 11:54:36 +0300
Message-ID: <20150609085436.GE1478@lahna.fi.intel.com>
References: <1433795557-18036-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433795557-18036-1-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jun 08, 2015 at 10:32:37PM +0200, Robert Jarzmik wrote:
> From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Generic DMA support was already implemented by commit cd7bed003404
> ("spi/pxa2xx: break out the private DMA API usage into a separate file")
> which moved all the legacy PXA DMA implementation code into its own
> file.
> 
> With generic DMA available for PXA, we can now just trash this file.
> 
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> [respin after pxa dmaengine support upstream]
> Signed-off-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
