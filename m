From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/8] dt-bindings: spi: stm32: fix example with
 st,spi-midi-ns property
Date: Mon, 26 Jun 2017 14:12:11 -0500
Message-ID: <20170626191211.2u3rd63flfrxthik@rob-hp-laptop>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
 <1498222550-19092-4-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498222550-19092-4-git-send-email-amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 23, 2017 at 02:55:45PM +0200, Amelie Delaunay wrote:
> This patch aligns example with the optional property description.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-stm32.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
> index 415378b..25d2ed6 100644
> --- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
> @@ -55,6 +55,6 @@ Example:
>  			compatible = "spidev";

As I mentioned in the original patch, please use a real compatible.

>  			reg = <0>;
>  			spi-max-frequency = <4000000>;
> -			st,spi-midi = <4000>;
> +			st,spi-midi-ns = <4000>;
>  		};
>  	};
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
