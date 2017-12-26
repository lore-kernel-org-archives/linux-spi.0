From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: atmel-quadspi: add an optional
 property 'dmacap,memcpy'
Date: Tue, 26 Dec 2017 17:23:30 -0600
Message-ID: <20171226232330.trljk2ofyvu4ly3n@rob-hp-laptop>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <143542c61ca674d53da4985bbabc142e8e6ebefc.1514087323.git.cyrille.pitchen@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org,
        boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
        linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <143542c61ca674d53da4985bbabc142e8e6ebefc.1514087323.git.cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Dec 24, 2017 at 05:36:05AM +0100, Cyrille Pitchen wrote:
> The optional 'dmacap,memcpy' DT property tells the Atmel QSPI controller
> driver to reserve some DMA channel then to use it to perform DMA
> memcpy() during data transfers. This feature relies on the generic
> bounce buffer helper from spi-nor.c.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mtd/atmel-quadspi.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> index b93c1e2f25dd..002d3f0a445b 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> @@ -12,6 +12,10 @@ Required properties:
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  
> +Optional properties:
> +- dmacap,memcpy:  Reserve a DMA channel to perform DMA memcpy() between the
> +                  system memory and the QSPI mapped memory.

How is this a h/w property? Why would I not want to always enable DMA if 
possible?

Furthermore, you are reusing a property, but giving it a different 
meaning. The current definition is an indication whether a DMA 
controller supports memcpy operations or not. It is not a flag for 
clients to use memcpy channels.

Why don't you use "dmas" property to point to the DMA controller.

> +
>  Example:
>  
>  spi@f0020000 {
> @@ -24,6 +28,7 @@ spi@f0020000 {
>  	#size-cells = <0>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_spi0_default>;
> +	dmacap,memcpy;
>  
>  	m25p80@0 {
>  		...
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
