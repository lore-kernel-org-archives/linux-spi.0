From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI	controller
Date: Mon, 26 Apr 2010 13:34:40 +0300
Message-ID: <20100426103440.GI26418@gw.healthdatacare.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<p2h56d259a01004241114qb1b1815em9657e5a857a9d4ee@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D9B7E4F@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0D753D10438DA54287A00B0270842697636D9B7E4F-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 25, 2010 at 02:55:08PM -0500, H Hartley Sweeten wrote:
> On Saturday, April 24, 2010 11:15 AM, Martin Guy wrote:
> > static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
> > {
> > ...
> >         if (!(irq_status & (SSPIIR_RORIS | SSPIIR_TIS | SSPIIR_RIS)))
> >                 return IRQ_NONE; /* not for us */
> > 
> > -       /* clear the interrupt */
> > -       ep93xx_spi_write_u8(espi, SSPICR, 0);
> > 
> >         /*
> >          * If we got ROR (receive overrun) interrupt we know that something is
> >          * wrong. Just abort the message.
> >          */
> >         if (unlikely(irq_status & SSPIIR_RORIS)) {
> > +               /* clear the overrun interrupt */
> > +               ep93xx_spi_write_u8(espi, SSPICR, 0);
> >                 dev_warn(&espi->pdev->dev,
> >                          "receive overrun, aborting the message\n");
> >                 espi->current_msg->status = -EIO;
> >         } else {
> 
> With this patch the interrupts only get cleared if it's a ROR interrupt.
> 
> Do the RIS/TIS interrupts get cleared by the upper layers?  If so, do we
> really need to clear the ROR interrupt here?

I believe it is not necessary but doesn't hurt either so I would keep it.

Regards,
MW

------------------------------------------------------------------------------
