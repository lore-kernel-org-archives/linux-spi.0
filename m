From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: atmel-quadspi: add an optional
 property 'dmacap,memcpy'
Date: Tue, 2 Jan 2018 11:22:34 +0100
Message-ID: <20180102102234.GG2612@rfolt0960.corp.atmel.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <143542c61ca674d53da4985bbabc142e8e6ebefc.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <20171226232330.trljk2ofyvu4ly3n@rob-hp-laptop>
 <0149ba05-64b1-2739-e61f-78d5170775fb@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        <richard-/L3Ra7n9ekc@public.gmane.org>, <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <vigneshr-l0cyMroinI0@public.gmane.org>, <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0149ba05-64b1-2739-e61f-78d5170775fb-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Cyrille,

On Wed, Dec 27, 2017 at 10:40:00PM +0100, Cyrille Pitchen wrote:
> Hi Rob,
> 
> + Ludovic Desroches, maintainer of the DMA controller drivers for AT91 SoCs.
> 
> Le 27/12/2017 à 00:23, Rob Herring a écrit :
> > On Sun, Dec 24, 2017 at 05:36:05AM +0100, Cyrille Pitchen wrote:
> >> The optional 'dmacap,memcpy' DT property tells the Atmel QSPI controller
> >> driver to reserve some DMA channel then to use it to perform DMA
> >> memcpy() during data transfers. This feature relies on the generic
> >> bounce buffer helper from spi-nor.c.
> >>
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
> >> ---
> >>  Documentation/devicetree/bindings/mtd/atmel-quadspi.txt | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> >> index b93c1e2f25dd..002d3f0a445b 100644
> >> --- a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> >> +++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> >> @@ -12,6 +12,10 @@ Required properties:
> >>  - #address-cells: Should be <1>.
> >>  - #size-cells:    Should be <0>.
> >>  
> >> +Optional properties:
> >> +- dmacap,memcpy:  Reserve a DMA channel to perform DMA memcpy() between the
> >> +                  system memory and the QSPI mapped memory.
> > 
> > How is this a h/w property? Why would I not want to always enable DMA if 
> > possible?
> 
> The number of DMA channels is limited for a given SoC. This number may be
> lower than the number of enabled controllers (spi, i2c, qspi, aes, sha,
> des, sdmmc, usart, ...).
> 
> So we use a DT property to explicitly tell the matching drivers to request
> and reserved the DMA channels they need. This policy is not driver or even
> SoC specific but board specific. It's very common to reserved DMA channels
> for the most used or most performance dependent controllers, setting the
> relevant properties in the device-tree then restricting remaining
> controllers to their PIO mode.
> 
> > 
> > Furthermore, you are reusing a property, but giving it a different 
> > meaning. The current definition is an indication whether a DMA 
> > controller supports memcpy operations or not. It is not a flag for 
> > clients to use memcpy channels.
> >
> 
> I don't mind changing the name. I thought it would be better to use some
> existing one than creating another. However I was not confident on whether
> "dmacap,memcpy" was actually a good candidate for what I do in the DMA
> patch for the atmel-quadspi.c driver.
> 
> Actually, I was relying on your feedbacks :)
> 
> > Why don't you use "dmas" property to point to the DMA controller.
> 
> I didn't use the "dmas" property because I thought it would not have been
> consistent with how this property is used in all other nodes of the sama5*
> device-trees. The flags provided in the dma-cells are designed for "memory
> to peripheral" or "peripheral to memory" DMA transfers only.
> 
> However, here I need to perform some "memory to memory" transfer: the SPI
> NOR flash memory is mapped into the AHB bus of SAMA5D2 SoCs. Besides,
> once in Serial Memory Mode, data can no longer be transfered through the
> TDR or RDR registers of the QSPI controller, only through its AHB mapped
> memory window.
> 
> So I cannot configured the DMA channel for "peripheral to memory" or
> "memory to peripheral" like for other controllers embedded in the SoC but
> only for "memory to memory".
> 
> Maybe we could extend the flags supported by the "dmas" property but I
> guess it may require some little rework in the at_xdmac_xlate() function
> of the at_xdmac.c driver.
> 

I have no objection about changing the at_xdmac_xlate() behavior.

>From your cover-letter, I understand that the issue you're trying to
solve is not only related to the Atmel devices so you may also have to update
the xlate functions of the other DMA controllers.

> Or maybe no change at all is required at the at_xdmac.c driver side: we
> just don't care about the provided flags in the "dmas" property, especially
> the "peripheral id". They would be ignored anyway when the atmel-quadspi.c
> driver later calls dmaengine_prep_dma_memcpy(). So I could simply set the
> dma cells to 0 in the device-tree?
> 
> Ludovic, what do you think about that ?

It may work but I won't do this. Usually, channels requested through the xlate
function have usually their capaiblities set to DMA_SLAVE and not DMA_MEMCPY.
In the at_xdmac case, it won't be an issue but if you have a controller
which has channels which can support only mem-to-mem or peripheral, it
won't work.

Regards

Ludovic
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
