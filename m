From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Mon, 29 Jun 2015 11:22:06 +0100
Message-ID: <20150629102206.GC11162@sirena.org.uk>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
 <20150625145853.GP14071@sirena.org.uk>
 <20150625154407.GE6321@opensource.wolfsonmicro.com>
 <558D3BAA.3080700@linux.intel.com>
 <20150626115823.GY14071@sirena.org.uk>
 <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
 <CAKor6TdzzAqG1yNtqkWftdvNo8_bxC=qnU+60rgiM=38qrJ2yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
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
In-Reply-To: <CAKor6TdzzAqG1yNtqkWftdvNo8_bxC=qnU+60rgiM=38qrJ2yQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2015 at 09:46:41AM +0200, Christian Hartmann wrote:
> Hello,

Please don't top post.

> I have sent an email about the Bug in this firmware to lenovo.
> So I can work on with thhe custom DSDT and will try again to get ACPI
> working with the WM5102.

> As soon as Lenovo has a new BIOS available, I will report that but for
> the case their will not be a new BIOS update in the near future, what
> should we do with the patch??
> As some suggested, its a firmware bug workaround.

We'll need to work around this, I wouldn't hold your breath on Lenovo
fixing their BIOS and even if they do we really ought to support the
shipped BIOS since not everyone is going to want to upgrade (or know to
do that).

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkRxNAAoJECTWi3JdVIfQJXQH/2+gsGq/sSV1JpQmzX52pIxt
udiYRb49rJh+oekeJzpD6fBnAbC+wk0eZd5ok8yDoaWu8kGeiAWRaz2ZRhKbMWLQ
1KgKOK9RoDCeNQRYdhYMPQAWl8bv6zciXpyixQ70t+II9OuW8/t1TIsjNlJxE9jG
n4Ne0mabeW8un+4ovsofsw1AK+yrRfFGqaJ8Ths8dXaZ/BgOOFf4t435y6YKoAco
4rENSkgesUFDz3uX4f3JOJWFaQbaSxynUGaI7BtXdoHprwtgQjNRa7MCycst563V
JKk56+TedK49qrv6S8Nh3bDOjE98/52Xyk6iTZo3/8UGXjIe+wOktgBltmAdxBo=
=33en
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
