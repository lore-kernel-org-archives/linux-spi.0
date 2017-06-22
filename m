From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ACPI / property: Support Apple _DSM properties
Date: Thu, 22 Jun 2017 14:25:41 +0100
Message-ID: <20170622132541.qvnkngd4nmwvlbnk@sirena.org.uk>
References: <cover.1498044532.git.lukas@wunner.de>
 <8ce38be1389dfb0527961ccd0dedb609802b59c1.1498044532.git.lukas@wunner.de>
 <20170622080655.GS629@lahna.fi.intel.com>
 <20170622095439.vquuet562i5scl3n@wunner.de>
 <20170622100422.GX629@lahna.fi.intel.com>
 <20170622112428.q3hpwpfs4xwumued@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j3s7sbuy5gqemui4"
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170622112428.q3hpwpfs4xwumued-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--j3s7sbuy5gqemui4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2017 at 01:24:28PM +0200, Lukas Wunner wrote:
> On Thu, Jun 22, 2017 at 01:04:22PM +0300, Mika Westerberg wrote:
> > On Thu, Jun 22, 2017 at 11:54:39AM +0200, Lukas Wunner wrote:

> > > It would be good to be able to google for this message to detect if there
> > > are ever Macs out there which return something different than "3" to this
> > > _DSM call.  How about KERN_WARN or KERN_INFO?

> > Well, this is something the user might see and then gets confused on the
> > grounds: is my machine somehow broken?

> And indeed it might be:  Conceivably, Apple may change the format of the
> properties and then once again the SPI slave won't be able to initialize.
> In that case it seems beneficial to provide a clue as to the cause in dmesg.

This seems especially important when we're working with a reverse
engineered binding.

--j3s7sbuy5gqemui4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllLxVQACgkQJNaLcl1U
h9BeyAf/aAyU6IO0seK92R1Rq34nQ3Uf5330Gkd8CpyRXG4S7tBlYyLXWKnkQLBE
8FNJ/5n7IwwcM4l/ExVwdjlcFpJ3jeQ0je/ZzndcvXFrPh1HLSRiE6oDClfpQ2jN
nSDFkiIwiNgSKSlUS9iwMD4/vEsVw6VOENh/9MeT/47/HisErVg9USEB1Ak+9rIP
GI0Byo+o9pldf1vaDhx0EthEKVmy0pESx4cnQByTjSKgGeSxI8D0Ytj4Ef5KGh/D
wZx2mp7OZfcMnhGIwxn3811Nvr7VvWWP/9yVvsFgNi2fdxmKwTHlWpkDF6vA7Dhp
d516nptO/0Am1DPqHmZqVQeDW08Hjg==
=SLKy
-----END PGP SIGNATURE-----

--j3s7sbuy5gqemui4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
