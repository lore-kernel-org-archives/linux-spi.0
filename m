From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] spi: sh-msiof: Add support for SH-Mobile AG5
Date: Mon, 30 Nov 2015 09:57:18 -0600
Message-ID: <20151130155718.GA2805@rob-hp-laptop>
References: <1448892840-8195-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448892840-8195-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Nov 30, 2015 at 03:14:00PM +0100, Geert Uytterhoeven wrote:
> MSIOF in SH-Mobile AG5 (sh73a0) is handled fine by the existing driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Rob Herring <robh@kernel.org>

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
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
