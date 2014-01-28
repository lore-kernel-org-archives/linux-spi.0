From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: dw: add support for gpio controlled chip
 select
Date: Tue, 28 Jan 2014 18:16:52 +0000
Message-ID: <20140128181652.GU11841@sirena.org.uk>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <b9ce1224f836ec84d5c75636b6838039a7664c89.1390723880.git.baruch@tkos.co.il>
 <20140127185754.GK11841@sirena.org.uk>
 <20140128123506.GY5596@tarshish>
 <20140128154212.GN11841@sirena.org.uk>
 <20140128181116.GB5596@tarshish>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4AM+rnxdOuBVVwz5"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140128181116.GB5596@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4AM+rnxdOuBVVwz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2014 at 08:11:16PM +0200, Baruch Siach wrote:
> On Tue, Jan 28, 2014 at 03:42:12PM +0000, Mark Brown wrote:

> > It needs to before otherwise we'll try to instantiate the slaves without
> > their chip select which isn't going to be a great idea.  The ideal thing
> > would be for this to be handled in the core rather than in the
> > individual drivers, the property is standard.

> So until the core code gains this ability to request gpios what is the be=
st=20
> option? Do as pl022 is doing? Leave it at .setup? Something else?

There's always the option of enhancing the core yourself! :P  But yeah,
copy pl022.

--4AM+rnxdOuBVVwz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5/QQAAoJELSic+t+oim9TfkP/jQeT3TnerqWb/5jquKJ3eBj
V59L5JvxUtF4UbpMIciPGYg9nrx+uYCh6KgL2pZwBMbE8rLlEgTKDFJkM0e3k3Mn
RoRPhkNFfS4lG/bygUODo4xfOeg/fyjclNGy60MRYwC2sMi8wGjFSMt7ktkessN6
uhbnB59y+cD0NQt0GGkTkAFAG/1bMKrZ/8C7JZMgOBTIsV2bsoPxPGt10mpPXqrJ
AcXz1IZqLSjjuJdkIJZshBQI+vBPW+bE4GUya1erQ5D+1nLwlS414zFgznfGDnwk
mvIDPcCTexw+8FMDwEZdy/Tsdc/Mj+HqwFQJFMPPBNzC68xlXrRWgAlJKgrab01s
zfbH/4FA2JI6QA97+9dpe6Q44dDDveZGM6HmkQRgQD0LfCw6gmwSuUnDto9oPwa7
WHoQv5jvdof8ysaADO832oYJ3Lzd9FD8rVZ2SQ7RhYEOLynwAyHFRfUq66NZGeNG
lgQ/X6RHZap+c0rwyCLq75C0Rr7hyTUWLIk9zo+1WaNwGvYvsKarAUhLS16q/zJ2
lP4pCMnbopPmPKqaCN0fsSgP0ktBEz8NWqKx8glm04852d/lFKwVYnzGxASP50Li
ZNn4gu1MiESFxSHcvKyfcSXRBQ/krA7juoauDPNSEH5aH+OASAtCLjegD4L4p2d/
SeCCN7rl9kn7xrwIRYy8
=UbCD
-----END PGP SIGNATURE-----

--4AM+rnxdOuBVVwz5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
