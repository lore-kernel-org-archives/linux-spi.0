From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 28 Aug 2015 12:12:57 +0300
Message-ID: <20150828091257.GK28428@lahna.fi.intel.com>
References: <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
 <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
 <20150826100155.GA1513@lahna.fi.intel.com>
 <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
 <20150827115914.GF28428@lahna.fi.intel.com>
 <20150827145614.GC5313@sirena.org.uk>
 <20150828090042.GI28428@lahna.fi.intel.com>
 <1440752855.25096.3.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440752855.25096.3.camel-WeElTRBN8n0bEPBeyYQi64iQ8/zYDDdY1BehtkLrGTY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Aug 28, 2015 at 10:07:35AM +0100, Richard Fitzgerald wrote:
> On Fri, 2015-08-28 at 12:00 +0300, Mika Westerberg wrote:
> > On Thu, Aug 27, 2015 at 03:56:14PM +0100, Mark Brown wrote:
> > > On Thu, Aug 27, 2015 at 02:59:14PM +0300, Mika Westerberg wrote:
> > > > On Thu, Aug 27, 2015 at 01:44:45PM +0200, Christian Hartmann wrote:
> > > 
> > > > > drivers/gpio/gpio-arizona.c
> > > > > and drivers/extcon/extcon-arizona.c
> > > 
> > > > > I have already CONFIG_GPIO_ARIZONA=y, but it does not be used at all.
> > > > > Is it save to ignore ?? Or should I use them as well ??
> > > 
> > > > If the SPI device interrupt is connected to arizona GPIO pin, then you
> > > > probably need that.
> > > 
> > > I can't see how that would work, the interrupt output isn't a GPIO.
> > 
> > I mean that if the SPI device (codec) interrupt pin is connected to a GPIO
> > pin of arizona instead of GPIO pin of the SoC itself.
> 
> It makes no sense to connect the codec interrupt pin back to one of its
> own GPIOs. If you did that the GPIO could only generate another
> interrupt to itself and you'd have a circular interrupt storm that went
> nowhere.

Ah, arizona is the chip providing the codec functionality as well? I
thought they were separate chips.

In that case, I take my previus comment back. Sorry about the confusion.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
