From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Wed, 26 Aug 2015 13:01:55 +0300
Message-ID: <20150826100155.GA1513@lahna.fi.intel.com>
References: <CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
 <20150820115845.GF30005@lahna.fi.intel.com>
 <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
 <20150821074310.GM30005@lahna.fi.intel.com>
 <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
 <20150824085140.GA5647@ck-lbox>
 <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
 <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 26, 2015 at 10:58:06AM +0200, Christian Hartmann wrote:
> Question about the spi-irq to clarify it for me: does this spi irq
> device belongs to the arizona child (the wm5102) or is this irq only
> of the spi master ? I much as I understand, this irq is from the spi
> master, the arizona spi child , the wm510205, has another irq ,
> attachted at the irq_gpio - I am right so far??

The master should already have IRQ. This is about assigning IRQ for the
SPI childe device.

You probably want to do same to SPI core that was done for I2C:

845c877009cf014b9 ("i2c / ACPI: Assign IRQ for devices that have GpioInt automatically")

Then it will automatically assign first found GpioInt to the SPI device
in question.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
