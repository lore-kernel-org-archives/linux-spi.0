From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: Add support for SH-Mobile AG5
Date: Fri, 4 Dec 2015 12:56:08 -0600
Message-ID: <20151204185608.GA10576@rob-hp-laptop>
References: <1448892840-8195-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448892840-8195-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Nov 30, 2015 at 03:14:00PM +0100, Geert Uytterhoeven wrote:
> MSIOF in SH-Mobile AG5 (sh73a0) is handled fine by the existing driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Applied, thanks.

Rob


Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> index 705075da2f10156e..aa005c1d10d95756 100644
> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> @@ -10,6 +10,7 @@ Required properties:
>  			 "renesas,msiof-r8a7792" (R-Car V2H)
>  			 "renesas,msiof-r8a7793" (R-Car M2-N)
>  			 "renesas,msiof-r8a7794" (R-Car E2)
> +			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
>  - reg                  : A list of offsets and lengths of the register sets for
>  			 the device.
>  			 If only one register set is present, it is to be used
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
