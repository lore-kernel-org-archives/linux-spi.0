From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 26 Jun 2015 12:58:23 +0100
Message-ID: <20150626115823.GY14071@sirena.org.uk>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
 <20150625145853.GP14071@sirena.org.uk>
 <20150625154407.GE6321@opensource.wolfsonmicro.com>
 <558D3BAA.3080700@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OIXtKW6WvMSdyEGO"
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <558D3BAA.3080700-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OIXtKW6WvMSdyEGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 26, 2015 at 01:46:50PM +0200, Pierre-Louis Bossart wrote:
> On 6/25/15 5:44 PM, Charles Keepax wrote:

> >I think from the Linux side we can safely ignore those last two
> >digits. I expect that all systems of the same make and model
> >would report the same last two digits but that it might change
> >between models if the Windows driver is expected to something
> >differently for that model.

> Here's the summary of what a valid _HID  should look like. It took me a
> couple of days to gather the rules from different sources, I hope it helps
> others figure things out.

None of which really affact the matching that the kernel does since
whatever form the string is generated in we need to do a full string
match (nor do they correspond to what it seems the Wolfson drivers have
invented but that's a separate issue).  Yay standards.

--OIXtKW6WvMSdyEGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjT5fAAoJECTWi3JdVIfQDAMH/2fmCvcaglPFA4AP5Du3sPXD
nkR1XdFuaMcZo4j+JcE35ejS33QcvB5ucKa50FqXHqRusN0EcYkoJZBjhbPVKliW
cFAl61LDzzBH+UF11ZY93sydOsdtkCbD3g4wuJc4TYwKKF1Xk9kVdSxVpHWEh9kY
ddjoxCsey3jeL3cLqvZbZSDDRlpWTwH+XfAvUewOlspkdD+Lyt5bFEtAFKdytdgx
DoRyCPi9h3z58dq/VyYuAHZRqOp3kdHqxk4a9rsf31IkDXmGwTi8qVMjccKZwWwm
lF0vdi+leUoQv0+NeZBGW9N9IQdW3EUBM4C8dUbCswn5kzeTuR9FNiaX6AzlWFY=
=KPEr
-----END PGP SIGNATURE-----

--OIXtKW6WvMSdyEGO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
