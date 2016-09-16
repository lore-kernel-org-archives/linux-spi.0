From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi-meson: Add GXBB Compatible string
Date: Fri, 16 Sep 2016 10:33:05 -0500
Message-ID: <20160916153305.GB6795@rob-hp-laptop>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
 <1473321206-32284-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473321206-32284-2-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 08, 2016 at 09:53:25AM +0200, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
> index bb52a86..dc6d031 100644
> --- a/Documentation/devicetree/bindings/spi/spi-meson.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
> @@ -7,7 +7,7 @@ NOR memories, without DMA support and a 64-byte unified transmit /
>  receive buffer.
>  
>  Required properties:
> - - compatible: should be "amlogic,meson6-spifc"
> + - compatible: should be "amlogic,meson6-spifc" or "amlogic,meson-gxbb-spifc"

If you are going to use both, make sure the order is clear (most 
specific, best match first). Sometimes the chip names make that clear, 
but not here.

>   - reg: physical base address and length of the controller registers
>   - clocks: phandle of the input clock for the baud rate generator
>   - #address-cells: should be 1
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
