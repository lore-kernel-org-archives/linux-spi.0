From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Wed, 2 Sep 2015 09:13:34 +0100
Message-ID: <20150902081334.GB15505@ck-lbox>
References: <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
 <20150826100155.GA1513@lahna.fi.intel.com>
 <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
 <20150827115914.GF28428@lahna.fi.intel.com>
 <20150827145614.GC5313@sirena.org.uk>
 <CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA@mail.gmail.com>
 <CAKor6TfW4reRz3m-xkCr_ZUfHQkfqT3q+S7JCpO-9F+k1QW38g@mail.gmail.com>
 <CAKor6Tf7_Hiyc1v_TGvdVAU+G84Gp+KgKeSGi8EQJRoq9rhMuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	<dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6Tf7_Hiyc1v_TGvdVAU+G84Gp+KgKeSGi8EQJRoq9rhMuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Sep 01, 2015 at 11:45:31AM +0200, Christian Hartmann wrote:
> hi
> 
> 2015-08-28 11:50 GMT+02:00 Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>:
> >
> >  and thats what I got:
> >
> > [    6.182903] pxa2xx-spi 80860F0E:00: bus_num = -1
> > [    6.182909] pxa2xx-spi 80860F0E:00: num_chipselect = 2
> > [    6.182928] pxa2xx-spi 80860F0E:00: IRQ 194
> > [    6.183049] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
> > [    6.183111] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
> > [    6.192761] spi spi-WM510205:00: 8333333 Hz actual, PIO
> > .... the rest of the dmesg is currently the same....
> >
> >
> > Q:  this thread is about the patch for the pxa2xx-spi where the
> > num_chipselect was raised by one to so that the slave connects here at
> > all. otherwise the cs1 >= max will be hit.
> > Do you think the bus_number is ok ?
> > And shouldn't it be set the cs1=0 and num_chipselect=1  ??
> 
> What is with the bus_num ? where can I find the correct one ?
> I have no working example, is it possible to find the right settings
> only via a windows installation??

I am not sure the problem would be the bus number it is basically
just a number allocated in the kernel, it should really matter as
long as it represents the right device. Which as far as we can
see here looks likely.

The chip select being wrong could well be the issue, perhaps the
Windows driver supports multiple chipselects where as the Linux
one doesn't? Do you have access to any datasheets for the SPI on
the AP? Alternatively you could try hacking it to use chip select
0 and see if that makes the system work, seems like a long shot
but perhaps worth a quick go.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
