From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Mon, 28 Sep 2015 10:08:52 +0100
Message-ID: <20150928090852.GF5432@ck-lbox>
References: <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
 <20150827115914.GF28428@lahna.fi.intel.com>
 <20150827145614.GC5313@sirena.org.uk>
 <CAKor6Tf8kB0WPXLTBFmCzUJkMVEDu-xTEyw0-_NZvBdFSyQSFA@mail.gmail.com>
 <CAKor6TfW4reRz3m-xkCr_ZUfHQkfqT3q+S7JCpO-9F+k1QW38g@mail.gmail.com>
 <CAKor6Tf7_Hiyc1v_TGvdVAU+G84Gp+KgKeSGi8EQJRoq9rhMuw@mail.gmail.com>
 <20150902081334.GB15505@ck-lbox>
 <CAKor6TdaRqi0+a0ZHkdJngE2LPKHk0PUFrdQQ2-x59cxUa8cXA@mail.gmail.com>
 <20150904143434.GA1514@edi-sw-dsktp001.ad.cirrus.com>
 <CAKor6TfhaHfqkmz-dogJ6dEUe06QFv-ee7uPOLiEGSTh3ibkhQ@mail.gmail.com>
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
In-Reply-To: <CAKor6TfhaHfqkmz-dogJ6dEUe06QFv-ee7uPOLiEGSTh3ibkhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Sep 07, 2015 at 09:58:22AM +0200, Christian Hartmann wrote:
> Hello,
> 
> 2015-09-04 16:34 GMT+02:00 Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>:
> > Not entirely unexpected I guess, but certainly my gut feel here
> > is that this is a problem with the chip selects. I guess really
> > trying to find any available documentation on the AP/SPI and
> what do you mean with AP ?
> 
> I have googled and found some technical datasheets and
> developer documentation about the marvell pxa27 under this link/webpage
> http://www.marvell.com/application-processors/pxa-family/
> 
> I also asked lenovo about datasheets (not the short brief productsheet) to get
> facts about it. But again,  I do not think that lenovo will ever
> support me in this case.
> if I got some datasheets and if its not against laws etc I will report it here.
> 
> > tearing apart the SPI driver are the next steps from here. But
> > afraid I don't really have any great ideas for diving much
> > deeper. I will try to chase the Windows guys here again and see
> That would be nice, hope they got some glues.
> 
> > if I can gain any clues from them but I don't really know at what
> > level these things are abstracted in Windows and thus if they can
> > really help us much.

Ok no major hints from them, they do have a 10 inch version of
the same tablet lying around though so I will get them to post
that up and have a look see if I can figure anything out.

If you had anywhere I can pull in what you have done already that
would be handy.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
