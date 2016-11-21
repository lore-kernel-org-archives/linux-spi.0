From: maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH v2 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when
 using multiple SPI_IOC_MESSAGE
Date: Tue, 22 Nov 2016 00:44:30 +0530
Message-ID: <20161121191430.GA24521@Sanchayan-Arch.localdomain>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
 <20161121191847.vg32cwople4qmini@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161121191847.vg32cwople4qmini-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

On 16-11-21 19:18:47, Mark Brown wrote:
> On Mon, Nov 21, 2016 at 11:24:01AM +0530, Sanchayan Maity wrote:
> > Current DMA implementation had a bug where the DMA transfer would
> > exit the loop in dspi_transfer_one_message after the completion of
> > a single transfer. This results in a multi message transfer submitted
> > with SPI_IOC_MESSAGE to terminate incorrectly without an error.
> 
> Please don't resend already applied patches.  If there are any changes
> needed please send incremental changes on top of what's already applied.

This is not a resend of an applied patch. The whole series applies on
top of your topic/fsl-dspi branch and has fixes for the SPI DMA as
incremental changes

- Sanchaya.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
