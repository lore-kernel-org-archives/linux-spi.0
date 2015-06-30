From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Tue, 30 Jun 2015 10:25:32 +0100
Message-ID: <20150630092532.GL11162@sirena.org.uk>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
 <20150625145853.GP14071@sirena.org.uk>
 <20150625154407.GE6321@opensource.wolfsonmicro.com>
 <558D3BAA.3080700@linux.intel.com>
 <20150626115823.GY14071@sirena.org.uk>
 <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
 <20150629094854.GB11162@sirena.org.uk>
 <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
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


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2015 at 09:14:37AM +0200, Christian Hartmann wrote:
> 2015-06-29 11:48 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> >> [    5.928958] arizona spi-WM510205:00: Unknown device ID: ffff

> > The above is saying that SPI I/O to the device isn't working - the
> > device ID is not being read back successfully.

> Ok that is the next problem that must be solved.
> I have yesterday made a patchset where I have added
> the enum type 5, but as you said already,
> that was not needed.
> All what I see the same: : Unknown device ID: ffff

> So where I have to look now or what can I do to let this device id
> register correctly?
> I hope the baytrail machine driver is easy peasy to add, but here I
> stuck at the moment.

You need to look at the SPI controller configuration still - like I say
that's saying that I/O to the device is not working correctly.  Most
likely there is some meaning to the chip select setting that's being
used and so the main chip select is not doing the job.

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkmCLAAoJECTWi3JdVIfQA5oH/joWDZ7iWpr/SRadsYy6RWxf
PF6UM64Xf3ieWoMnmGyWAd+9y9bAjs3MadTpwszOBLiI1cPbbneOfbr7eI/P8SXk
rSZCt1kRtTf9aAQjS7prAXLRKzGGxfTKLhU0yUVeJPLw09z8Crpsd+SrvBc5SClv
prU6ArOBy6TUHZN6hyFVGi9n46tI8HgsGYq2T13eSXJBQjrMLBV2tJHJ1fosdLoW
8wL1GlQtsEHeitYFjHCO2Qdi9kUX2kc31pJGqYHHjAMv1NRsIe8+ae6uRG/DtZQG
Gcbtfs8OuWW03zF1qFQplLU04yPIKfIvjAX/WPKWWL0cS73u8GejqskfIfZ93ms=
=IEdG
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
