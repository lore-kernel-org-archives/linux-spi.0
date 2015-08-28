From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 28 Aug 2015 09:22:37 +0200
Message-ID: <CAKor6TfExEsvG1O6PgNdCPOwE_PC77pu66=x5g2CtvvVN7MbZg@mail.gmail.com>
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
	<20150826091312.GA19411@ck-lbox>
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
In-Reply-To: <20150826091312.GA19411@ck-lbox>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mika,
hi,


2015-08-26 11:13 GMT+02:00 Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>:
>  4) The chip select needs to be active.
>
> It seems very likely that 1) is already taken care of, so I
> probalby won't spend too much time worrying about that. It looks
> like we are getting a valid GPIO for the reset (2) and LDOENA (3),
> so it feels like those are probably ok. I guess this leaves the
> SPI config as the next place to investigate, are there other
> devices on the SPI that you can talk to that might at least
> verify the SPI is working? Also might be worth trying to look at
> how the chip selects are done perhaps that is not happening for
> some reason?

ok, that seems logical .
And no I cannot prove or check other devices, I just learned a lot in
the past three month about
this (driver, spi, gpio, acpi, dsdt etc. ) at all.

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
