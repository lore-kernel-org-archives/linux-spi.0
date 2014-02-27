From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: Remove "renesas,msiof-sh7724" from bindings
Date: Thu, 27 Feb 2014 23:50:36 +0100
Message-ID: <3183546.lDudat1pu0@avalon>
References: <1393505238-11954-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393505238-11954-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Thank you for the patch.

On Thursday 27 February 2014 13:47:17 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> 
> It's not implemented in the driver, so it's a bad example.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/spi/sh-msiof.txt |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> b/Documentation/devicetree/bindings/spi/sh-msiof.txt index
> 1f0cb33763a1..f24baf3b6cc1 100644
> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> @@ -5,7 +5,6 @@ Required properties:
>  			 "renesas,sh-msiof" for SuperH, or
>  			 "renesas,sh-mobile-msiof" for SH Mobile series.
>  			 Examples with soctypes are:
> -			 "renesas,msiof-sh7724" (SH)
>  			 "renesas,msiof-r8a7790" (R-Car H2)
>  			 "renesas,msiof-r8a7791" (R-Car M2)
>  - reg                  : Offset and length of the register set for the
> device

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
