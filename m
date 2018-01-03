From: "ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: atmel-quadspi: add an optional
 property 'dmacap,memcpy'
Date: Wed, 3 Jan 2018 07:51:29 +0100
Message-ID: <20180103065129.GH2612@rfolt0960.corp.atmel.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <143542c61ca674d53da4985bbabc142e8e6ebefc.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <20171226232330.trljk2ofyvu4ly3n@rob-hp-laptop>
 <0149ba05-64b1-2739-e61f-78d5170775fb@wedev4u.fr>
 <20180102102234.GG2612@rfolt0960.corp.atmel.com>
 <1514920738.26695.171.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org" <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        "ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <boris.brezillon@free-e
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1514920738.26695.171.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 02, 2018 at 07:18:58PM +0000, Trent Piepho wrote:
> On Tue, 2018-01-02 at 11:22 +0100, Ludovic Desroches wrote:
> > On Wed, Dec 27, 2017 at 10:40:00PM +0100, Cyrille Pitchen wrote:
> > 
> > > Or maybe no change at all is required at the at_xdmac.c driver side: we
> > > just don't care about the provided flags in the "dmas" property, especially
> > > the "peripheral id". They would be ignored anyway when the atmel-quadspi.c
> > > driver later calls dmaengine_prep_dma_memcpy(). So I could simply set the
> > > dma cells to 0 in the device-tree?
> > > 
> > > Ludovic, what do you think about that ?
> > 
> > It may work but I won't do this. Usually, channels requested through the xlate
> > function have usually their capaiblities set to DMA_SLAVE and not DMA_MEMCPY.
> > In the at_xdmac case, it won't be an issue but if you have a controller
> > which has channels which can support only mem-to-mem or peripheral, it
> > won't work.
> 
> Maybe one could create an "AT91_XDMAC_DT_" macro to indicate a memcpy
> channel.  There are still unused bits for another flag.  It also looks
> like at_xdma uses peripheral id 0x3f for memcpy transfers (will that
> work with memcpy DMA on multiple channels at the same time?).  So
> perhaps perid 0x3f could be the indication of wanting a memcpy channel,
> rather than another flag bit.  But however it's done, one writes:
> 
> dmas = <&dma0 AT91_XDMAC_DT_MEMCPY>; dma-names = "rx-tx";
> 

If have no objection about doing that, my concerns are:
- most (all ?) of the dma controllers used the xlate function to provide
  slave channel. Does it have to provide slave channel or can we
  use it for all kind of channel? From my point of view, we can do it,
  just need the confirmation.
- this set of patches if focused on the atmel qspi controller but other
  ones may be interested in doing the same thing so they would have to
  update the behavior of the xlate function of the DMA controller they
  are using. So having the request of a DMA_MEMCPY channel inside the
  spi/qspi controller doesn't seem to be a wrong idea. Moreover, it may
  be confusing for the user who don't know the context: why do I have to
  use memcpy and not slave as usal?

Honestly I have no opinion about the way to do it. Both have pros and
cons.

> I think one could have the quadspi driver automatically fill in the dma
> cell in the dma specifier if it is not present in the device tree.  So
> one could write "dmas = <&dma0>" and the driver adds the
> AT91_XDMAC_DT_MEMCPY cell before xlating.  I'm not sure if that's a
> good idea or not.

I don't think so, there is enough black magic, let's try to not add more
:p

Regards

Ludovic
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
