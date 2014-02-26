From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation:spi:fsl-dspi:add DSPI dma transfer
 support
Date: Wed, 26 Feb 2014 22:19:49 +0800
Message-ID: <20140226141947.GE23892@S2101-09.ap.freescale.net>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
 <20140225090830.GO28555@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140225090830.GO28555-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 25, 2014 at 09:08:30AM +0000, Mark Rutland wrote:
> On Tue, Feb 25, 2014 at 06:54:16AM +0000, Chao Fu wrote:
> > From: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > 
> > Add bool value use-dma.
> > The bool will determine whether DSPI use dma channel transfer data
> > in a platform.
> > 
> > Add dmas and dma-names for describing dma channels of DSPI.
> > 
> > Signed-off-by: Chao Fu      <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > index 5376de4..76a1039 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > @@ -11,6 +11,11 @@ Required properties:
> >  - spi-num-chipselects : the number of the chipselect signals.
> >  - bus-num : the slave chip chipselect signal number.
> >  - big-endian : if DSPI modudle is big endian, the bool will be set in node.
> > +- use-dma: the bool decide if use dma method in DSPI transfering.
> 
> Why can the OS not decide this based on the presence of dmas which it
> can use?

Yes, OS/driver should decide to use DMA or not, but it shouldn't be
based on the presence of 'dmas' property.  The DMA is a hardware
resource just like IRQ.  It should be just there in client device's node
as long as the SoC design assigns the channel to the device.  The device
driver should make the decision when DMA should be used, e.g. big amount
data transfer, and when PIO should be used, e.g. small data.

Shawn

> 
> Is there ever a case that there would be dmas present but it would be in
> the interests of the OS to not use them?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
