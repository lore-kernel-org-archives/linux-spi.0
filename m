From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Mon, 7 Sep 2015 09:58:22 +0200
Message-ID: <CAKor6TfhaHfqkmz-dogJ6dEUe06QFv-ee7uPOLiEGSTh3ibkhQ@mail.gmail.com>
References: <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
	<20150826100155.GA1513@lahna.fi.intel.com>
	<CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
	<20150827115914.GF28428@lahna.fi.intel.com>
	<20150827145614.GC5313@sirena.org.uk>
	<CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA@mail.gmail.com>
	<CAKor6TfW4reRz3m-xkCr_ZUfHQkfqT3q+S7JCpO-9F+k1QW38g@mail.gmail.com>
	<CAKor6Tf7_Hiyc1v_TGvdVAU+G84Gp+KgKeSGi8EQJRoq9rhMuw@mail.gmail.com>
	<20150902081334.GB15505@ck-lbox>
	<CAKor6TdaRqi0+a0ZHkdJngE2LPKHk0PUFrdQQ2-x59cxUa8cXA@mail.gmail.com>
	<20150904143434.GA1514@edi-sw-dsktp001.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150904143434.GA1514-ARjQNJ2nNhTg0ogRn3sK4gTTu0opVTaCmpATvIKMPHk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

2015-09-04 16:34 GMT+02:00 Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>:
> Not entirely unexpected I guess, but certainly my gut feel here
> is that this is a problem with the chip selects. I guess really
> trying to find any available documentation on the AP/SPI and
what do you mean with AP ?

I have googled and found some technical datasheets and
developer documentation about the marvell pxa27 under this link/webpage
http://www.marvell.com/application-processors/pxa-family/

I also asked lenovo about datasheets (not the short brief productsheet) to get
facts about it. But again,  I do not think that lenovo will ever
support me in this case.
if I got some datasheets and if its not against laws etc I will report it here.

> tearing apart the SPI driver are the next steps from here. But
> afraid I don't really have any great ideas for diving much
> deeper. I will try to chase the Windows guys here again and see
That would be nice, hope they got some glues.

> if I can gain any clues from them but I don't really know at what
> level these things are abstracted in Windows and thus if they can
> really help us much.
>
> Thanks,
> Charles

Thanks,
Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
