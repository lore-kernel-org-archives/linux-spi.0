From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Wed, 17 Jun 2015 22:10:51 +0800
Message-ID: <1434550251.23617.38.camel@mtksdaap41>
References: <1431434356.2128.9.camel@mhfsdcap03>
	 <20150512160540.GB3066@sirena.org.uk> <1431675522.2128.13.camel@mhfsdcap03>
	 <20150515092543.GY2761@sirena.org.uk>
	 <1433758546.19786.16.camel@mtksdaap41>
	 <20150608175927.GO14071@sirena.org.uk>
	 <1433844321.16178.6.camel@mtksdaap41>
	 <20150609103951.GA14071@sirena.org.uk>
	 <1433923569.22080.1.camel@mtksdaap41>
	 <1434532083.19346.27.camel@mtksdaap41>
	 <20150617124758.GE3214@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Leilk Liu =?UTF-8?Q?=28=E5=88=98=E7=A3=8A=29?=
	<Leilk.Liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"Kumar Gala" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	HongZhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617124758.GE3214-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2015-06-17 at 13:47 +0100, Mark Brown wrote:
> On Wed, Jun 17, 2015 at 05:08:03PM +0800, Eddie Huang wrote:
> 
> > Here comes the problem, although total length of tx, rx is the same,
> > each entry in rx and tx scatterlist may not be the same (in the case
> > data buffer allocate from vmalloc). Other vendor have dmaengine driver
> > to send entry-by-entry automatically, so it is ok due to total length is
> > the same.But mediatek hw can only send tx and rx scatterlist entry one
> > by on, which means in full duplex, mediatek SPI hardware need send each
> > entry separately, will cause full duplex fail because tx/rx entry size
> > or entry number may not be the same.
> 
> I don't see why this is a problem - your driver is going to have to do
> more work to overcome the limitations of the hardware but surely it's
> just a question of how you parse the scatterlists (or rewriting them if
> that's appropriate)?
> 
> > The problem is not dma map discuss earlier, it is mediatek spi hardware
> > limitation that can't support scatterlist dma transfer in full-duplex
> > mode. We can only support both tx and rx has the same size continuous
> > memory data in full-duplex mode. I don't know whether should modify
> > spi.c to support mediatek spi, or we just return can_dma() false and do
> > transfer one continuous data in transfer function.
> 
> > By the way, I think maybe it is better to change can_dma() to So 
> > can_dma_sg().
> 
> Don't you just need to handle the scatterlists in page sized chunks
> here?  There's nothing about passing information about the memory that
> was mapped around in a scatterlist that means you have to pass the whole
> list to the hardware at once - at heart the scatterlist is just a
> convenient structure for passing around where the data to be transferred
> is.

Our hardware limitation is: we don't have separate dma tx, rx channel
with transfer finish interrupt, only have spi trigger operation.So the
mediatek SPI dma full duplex operation steps are:
1. Set TX DMA address.
2. Set RX DMA address.
3. Set length (this step assume TX, RX are the same size).
4. Set TX DMA enable, RX DMA enable bit in spi config register. (not
trigger DMA, just told spi use dma)
5. Trigger spi operations.
6. Wait spi operations finish interrupt.

If tx scatterlist per list data size are 128, 4096, 256. rx scatterlist
per list data size are 128, 4096, 256. So we need to go through above
steps three times. If tx scatterlists per list data size are 128, 4096,
256. rx scatterlists per list data size are 256, 4096, 128. If we start
sending first entry, tx size is 128, rx size is 256, this will cause
hardware malfunction because tx, rx data length are not the same.

The solution I think is copy scatterlist data into one single buffer in
mediatek spi transfer function, but I think this is odd because
__spi_map_msg() map single buffer into scatterlist, then our driver map
scatterlist into single buffer again. I hope this explaination is more
clear than before.

Eddie
Thanks



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
