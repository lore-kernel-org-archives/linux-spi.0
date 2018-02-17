From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: spi: updated usage example for
 spi-rx/tx-bus-width properties
Date: Sat, 17 Feb 2018 09:48:46 +0100
Message-ID: <20180217094846.60475e2f@bbrezillon>
References: <1518504675-26286-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1518504675-26286-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, prabhakar.kushwaha-3arQi8VN3Tc@public.gmane.org,
        suresh.gupta-3arQi8VN3Tc@public.gmane.org, cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org, han.xu-3arQi8VN3Tc@public.gmane.org,
        computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518504675-26286-3-git-send-email-yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Yogesh,

Looks like you forgot to Cc Mark and the linux-spi ML.

Regards,

Boris

On Tue, 13 Feb 2018 12:21:15 +0530
Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org> wrote:

> Updated usage example by adding properties spi-rx-bus-width
> and spi-tx-bus-width for slave node binding.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>
> ---
> Changes for v3:
> - None
> Changes for v2:
> - None
> 
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 1f6e86f..4dbe267 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -101,6 +101,8 @@ SPI example for an MPC5200 SPI bus:
>  			compatible = "micrel,ks8995m";
>  			spi-max-frequency = <1000000>;
>  			reg = <0>;
> +			spi-rx-bus-width = 4;
> +			spi-tx-bus-width = 4;
>  		};
>  
>  		codec@1 {



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
