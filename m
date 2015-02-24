From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: clarify what driver can do with
 message->status
Date: Tue, 24 Feb 2015 23:17:06 +0900
Message-ID: <20150224141706.GK6236@finisterre.sirena.org.uk>
References: <1424772249-9676-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150224132411.GF6236@finisterre.sirena.org.uk>
 <1424784807.14897.24.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nkAIkdqOakIAdIKa"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424784807.14897.24.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nkAIkdqOakIAdIKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 03:33:27PM +0200, Andy Shevchenko wrote:
> On Tue, 2015-02-24 at 22:24 +0900, Mark Brown wrote:

> > > +	/* The actual driver may set this field to indicate an error, e.g. -EIO
> > > +	 * for failed transfer. */
> > >  	int			status;

> > Let's take a step back here: what documentation are you looking at which
> > says anything else about status?

> The description of this field above, namely " * @status: zero for
> success, else negative errno".

...which suggests that anything detecting an error should report it via
status, no?

> > I'd also expect this to go with the other kerneldoc for the field.

> Any place that suits better.

Well, see above...

--nkAIkdqOakIAdIKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJU7IfhAAoJECTWi3JdVIfQ4cEH8wWR7LtVzA+epAboZEtO7eO4
hM9M9Cex74n7dgS5aflt322QCTmkdWoergkF2A38STATmsY+u83Dgxm43295Z8sB
8q0gfi3VxBr4WUb7OEKguG3RdxxOzf4Odk13WIEcDqpP+lJhFVeMKAjmOvbqom6z
OSuXGyFp/YMcMfpPJvk6sDihH3N/SyMDYjK5kK/aGo5+5S8+7qBqfMtQ5RqfpiUG
mz7hzhyl9QNrDKxdMNatTgYuUKZRK3gzqNX7Cn8ngHcfFPjO+3VR8X96kzTfUtFb
QUxsIJjrvw4DodCAKfi0nzu/J5CTmoHtslsx24CjGjKK04ks89yDGAw1qJIb1A==
=Xvnq
-----END PGP SIGNATURE-----

--nkAIkdqOakIAdIKa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
