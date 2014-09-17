From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v6] spi: spi-imx: add DMA support
Date: Wed, 17 Sep 2014 02:49:17 +0200
Message-ID: <201409170249.17597.marex@denx.de>
References: <1410398324-15284-1-git-send-email-b38343@freescale.com> <20140915223944.GH7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140915223944.GH7960-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, September 16, 2014 at 12:39:44 AM, Mark Brown wrote:
> On Thu, Sep 11, 2014 at 09:18:44AM +0800, Robin Gong wrote:
> > Enable DMA support on i.mx6. The read speed can increase from 600KB/s
> > to 1.2MB/s on i.mx6q. You can disable or enable dma function in dts.
> > If not set "dma-names" in dts, spi will use PIO mode. This patch only
> > validate on i.mx6, not i.mx5, but encourage ones to apply this patch
> > on i.mx5 since they share the same IP.
> 
> Adding Maerk (who I had to add to earlier versions of this patch).

Looks OK to me.

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Thank you!

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
