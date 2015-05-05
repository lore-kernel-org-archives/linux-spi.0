From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Tue, 5 May 2015 17:48:31 +0200
Message-ID: <20150505174831.5d9acedb@north>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
	<1430741564-2849-2-git-send-email-kernel@martin.sperl.org>
	<20150504134226.GY15510@sirena.org.uk>
	<9A0ADDBC-5D5A-428F-B434-9CCB97505DCB@martin.sperl.org>
	<20150505142008.2087baac@north>
	<20150505150246.GG22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150505150246.GG22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 5 May 2015 16:02:46 +0100, Mark Brown wrote:
> On Tue, May 05, 2015 at 02:20:08PM +0200, Jakub Kici=C5=84ski wrote:
> > On Mon, 4 May 2015 16:25:01 +0200, Martin Sperl wrote:
>=20
> > > that makes it much more complicated to add things per spi_master
> > > implementation (which was my original idea: have a framework that=
 exposes
> > > the distinct transfer modes of the spi-bcm2835 driver (polling, i=
nterrupt
> > > and dma driven) and also to get some stats on how often we run in=
to those
> > > =E2=80=9Ccorner=E2=80=9D cases - that is also why I want to gathe=
r the histogram
> > > statistics, as it may make it easier to understand the use cases =
of people
> > > who complain about =E2=80=9Cperformance=E2=80=9D in case they sha=
re those infos=E2=80=A6
>=20
> > You can also consider adding few strategically placed tracepoints. =
=20
> > It saves the amount of kernel code necessary and is generally more
> > flexible.
>=20
> We already have a bunch of tracepoints in there (probably sufficientl=
y
> detailed for what's here) but they solve a different problem to
> statistics - while you can extract statistics at least as far back as
> the tracepoints go but it's slightly cumbersome and for longer term
> tests the buffer will roll round at some point and it's a bit more wo=
rk
> for people to set them up.

Sure, I definitely agree with complicated setup especially that Martin
is targeting this at RPi users who are usually not the most seasoned
of kernel developers.  Perhaps one day someone will write a generic
tracepoint-like statistic subsystem which can be disabled at runtime
and easily compiled-out...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
