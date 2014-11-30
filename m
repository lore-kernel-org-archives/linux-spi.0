From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH][RFC] spi: sh-msiof: Configure MSIOF sync signal timing in device tree
Date: Sun, 30 Nov 2014 22:23:15 +0200
Message-ID: <3485316.4muPRcz2if@avalon>
References: <5477EFD7.50307@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5477EFD7.50307-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Shimoda-san,

Thank you for the patch.

On Friday 28 November 2014 12:45:27 Yoshihiro Shimoda wrote:
> The MSIOF controller has DTDL and SYNCDL in SITMDR1 and SIRMDR1
> registers. So, this patch adds new properties like the following
> commit:
>   d0fb47a5237d8b9576113568bacfd27892308b62
>   (spi: fsl-espi: Configure FSL eSPI CSBEF and CSAFT)
> 
> The DTDL is the chip select (SYNC) setup time.
>  b'000: No bit delay
>  b'001: 1-clock-cycle delay
>  b'010: 2-clock-cycle delay
>  b'101: 0.5-clock-cycle delay
>  b'110: 1.5-clock-cycle delay
> 
> The SYNCDL is the chip select (SYNC) hold time.
>  b'000: No bit delay
>  b'001: 1-clock-cycle delay
>  b'010: 2-clock-cycle delay
>  b'011: 3-clock-cycle delay
>  b'101: 0.5-clock-cycle delay
>  b'110: 1.5-clock-cycle delay
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> 
>  I would like to add new properties for sh-msiof driver to adjust
> the SYNC siginal timing using DTDL and SYNCDL. In the current driver,
> these parameters are hardcoded to 0. And then, I checked other spi
> drivers, and I found the following commit:
>   d0fb47a5237d8b9576113568bacfd27892308b62
>   (spi: fsl-espi: Configure FSL eSPI CSBEF and CSAFT)
> 
> If this patch is reasonable, I will modify the sh-msiof driver.
> Or, should we add a new function for this timing adjusting in the
> spi framework?
> 
>  Documentation/devicetree/bindings/spi/sh-msiof.txt |    8 ++++++++
>  drivers/spi/spi-sh-msiof.c                         |    2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> b/Documentation/devicetree/bindings/spi/sh-msiof.txt index d11c372..5fe8ffd
> 100644
> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> @@ -30,6 +30,14 @@ Optional properties:
>  			 specifiers, one for transmission, and one for
>  			 reception.
>  - dma-names            : Must contain a list of two DMA names, "tx" and
> "rx".
> +- renesas,tdmr-dtdl    : delay sync signal (setup) in transmit mode
> +			 (default is 0, we can set it to 0, 1, 2, 5, or 6)
> +- renesas,tdmr-syncdl  : delay sync signal (hold) in transmit mode
> +			 (default is 0, we can set it to 0, 1, 2, 3, 5, or 6)
> +- renesas,rdmr-dtdl    : delay sync signal (setup) in receive mode
> +			 (default is 0, we can set it to 0, 1, 2, 5, or 6)
> +- renesas,rdmr-syncdl  : delay sync signal (hold) in receive mode
> +			 (default is 0, we can set it to 0, 1, 2, 3, 5, or 6)

Was it really the intent of this patch to add DT properties without providing 
an implementation in the sh-msiof driver ?

>  Optional properties, deprecated for soctype-specific bindings:
>  - renesas,tx-fifo-size : Overrides the default tx fifo size given in words
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 3f36540..09e0c38 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -296,11 +296,13 @@ static void sh_msiof_spi_set_pin_regs(struct
> sh_msiof_spi_priv *p, tmp = MDR1_SYNCMD_SPI | 1 << MDR1_FLD_SHIFT |
> MDR1_XXSTP;
>  	tmp |= !cs_high << MDR1_SYNCAC_SHIFT;
>  	tmp |= lsb_first << MDR1_BITLSB_SHIFT;
> +printk("%s: TMDR1 = %x\n", __func__, tmp | MDR1_TRMD | TMDR1_PCON);
>  	sh_msiof_write(p, TMDR1, tmp | MDR1_TRMD | TMDR1_PCON);
>  	if (p->chipdata->master_flags & SPI_MASTER_MUST_TX) {
>  		/* These bits are reserved if RX needs TX */
>  		tmp &= ~0x0000ffff;
>  	}
> +printk("%s: RMDR1 = %x\n", __func__, tmp);

I suppose these printk are debugging leftovers.

>  	sh_msiof_write(p, RMDR1, tmp);
> 
>  	tmp = 0;

-- 
Regards,

Laurent Pinchart
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
