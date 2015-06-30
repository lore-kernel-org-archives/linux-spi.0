From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
	of WM510205 codec via ACPI (resend)
Date: Tue, 30 Jun 2015 11:34:04 +0100
Message-ID: <20150630103404.GI6321@opensource.wolfsonmicro.com>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com> <20150625073618.GH827@lahna.fi.intel.com> <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com> <20150625145853.GP14071@sirena.org.uk> <20150625154407.GE6321@opensource.wolfsonmicro.com> <558D3BAA.3080700@linux.intel.com> <20150626115823.GY14071@sirena.org.uk> <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com> <20150629094854.GB11162@sirena.org.uk> <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jun 30, 2015 at 09:14:37AM +0200, Christian Hartmann wrote:
> Hi,
> 
> 
> 2015-06-29 11:48 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> > On Mon, Jun 29, 2015 at 09:27:17AM +0200, Christian Hartmann wrote:
> >> [    5.927801] spi-WM510205:00 supply DCVDD not found, using dummy regulator
> >> [    5.928958] arizona spi-WM510205:00: Unknown device ID: ffff
> >> [    5.929098] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
> >
> > The above is saying that SPI I/O to the device isn't working - the
> > device ID is not being read back successfully.
> 
> Ok that is the next problem that must be solved.
> I have yesterday made a patchset where I have added
> the enum type 5, but as you said already,
> that was not needed.
> All what I see the same: : Unknown device ID: ffff
> 
> So where I have to look now or what can I do to let this device id
> register correctly?
> I hope the baytrail machine driver is easy peasy to add, but here I
> stuck at the moment.

As I said in my other emails the next step is to work out what
the reset and ldoena gpio's are. You won't be able to read the
device ID until you have those setup. Unfortunately, finding the
right GPIOs is likely to be a bit of a chore, I will see if I can
find anything out from the Windows guys at this end.

Also can you check that the arizona-ldo1 regulator is built in I
am surprised that is falling back to the dummy regulator.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
