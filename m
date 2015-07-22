From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
Date: Wed, 22 Jul 2015 09:33:19 +0200
Message-ID: <201507220933.19752.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <20150722044925.GN23525@localhost> <CAOMqctQH4MnKMthOnuPgB-A5k6PCOAmhwHzJfn7gE3R4w8bufg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	"Bean Huo =?utf-8?q?=E9=9C=8D=E6=96=8C=E6=96=8C?= (beanhuo)"
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	"linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	=?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak@codeaurora
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMqctQH4MnKMthOnuPgB-A5k6PCOAmhwHzJfn7gE3R4w8bufg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, July 22, 2015 at 09:30:54 AM, Michal Suchanek wrote:
> On 22 July 2015 at 06:49, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > On Tue, Jul 21, 2015 at 10:14:11AM +0200, Michal Suchanek wrote:
> >> > Or alternatively we could publish the limitations of the channel using
> >> > capabilities so SPI knows I have a dmaengine channel and it can
> >> > transfer max N length transfers so would be able to break rather than
> >> > guessing it or coding in DT. Yes it may come from DT but that should
> >> > be dmaengine driver rather than client driver :)
> >> > 
> >> > This can be done by dma_get_slave_caps(chan, &caps)
> >> > 
> >> > And we add max_length as one more parameter to existing set
> >> > 
> >> > Also all this could be handled in generic SPI-dmaengine layer so that
> >> > individual drivers don't have to code it in
> >> > 
> >> > Let me know if this idea is okay, I can push the dmaengine bits...
> >> 
> >> It would be ok if there was a fixed limit. However, the limit depends
> >> on SPI slave settings. Presumably for other buses using the dmaengine
> >> the limit would depend on the bus or slave settings as well. I do not
> >> see a sane way of passing this all the way to the dmaengine driver.
> > 
> > I don't see why this should be client (SPI) dependent. The max length
> > supported is a dmaengine constraint, typically flowing from max
> > blocks/length it can transfer. Know this limit can allow clients to split
> > transfers.
> 
> In practice on the board I have the maximum transfer length before it
> fails depends on SPI bus speed which is set up per slave. I did not
> try searching the space of possible settings thorougly and settled for
> a setting that gives reasonable speed and transfer length.

This looks more like a signal integrity issue though.

> However, if this was not tied to the particular slave setting picked
> in the current DT a formula would be needed that translates arbitrary
> client settings to transfer size limit and there would be need to
> somehow get the client settings to the formula in the dmaengine
> driver.
> 
> Thanks
> 
> Michal

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
