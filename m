From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Sat, 21 Nov 2015 13:49:46 +0000
Message-ID: <20151121134946.GI26072@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com>
 <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <08871ECD-52DF-4CBF-AF3D-4C3A442C008A-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2015 at 01:56:13PM +0100, Martin Sperl wrote:

> > Every line of code that's in a driver that could be in the core is a
> > maintainence burden, people will want to start doing things like
> > combining functions in fun ways and if we want to try to do things like
> > figure out if we can coalesce adjacent transfers in the core (which we
> > really ought to) it won't know what the limitations that exist are.

> this =E2=80=9Ccolaesce=E2=80=9D of transfers into one could be one of tho=
se=20
> =E2=80=9Ctransformation=E2=80=9D I am talking about - and this one would =
be implemented
> in core making certain assumptions (like starting on a page, ...)

Why would we want to force that assumption?  It massively reduces the
utility for DMA controllers that don't have such limitations.

> >> I wonder if such a variant-construct does not create more headaches in
> >> the long run as each spi_driver wanting to do something =E2=80=9Csomet=
hing=E2=80=9D
> >> special would then need to get updated for any additional constraint=
=E2=80=A6

> > I'm sorry but I don't understand what you mean here.  However we
> > implement things anything that wants to know about constraints is going
> > to need to be updated to use them.

> That is what I want to avoid if possible - the one thing that may come
> handy (at least from my perspective) could be to give some hints to
> make optimal use of the HW
> Say:
> * preferred alignment on X byte boundry
> * preferred max spi_transfer.length

> All the other possible constraints parameters should be opaque to=20
> a spi_device driver, so I would not want to include those inside the
> spi_master structure, as _then_ these get used.

You're conflating two unrelated design decisions here.  Yes, it's
unfortunate that the SPI API was written to allow client drivers to see
the master structure but that doesn't mean that converting data into
code is a good idea, that's still a bad pattern independently of the
visibility issue.

> Also the =E2=80=9Crestrictions=E2=80=9D on the spi HW need to get defined=
 inside the
> driver, so there will not be a new =E2=80=9Crestriction=E2=80=9D that app=
lies to
> an existing piece of HW just because we incorporate new options.

That's what I was saying?

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUHZ5AAoJECTWi3JdVIfQXI0H/jXDo8oNREzJHNDjafAAurcs
DNTRCHy5wq74vvkYwPRtCVUN8kmUeow7yx7N7krEYE+KIBD94tyw/IEGjDkSOOgi
O1pLV/NMh/ZFVmpzx5rqgRHPlMOv+zb6MU3q9oiR8zPsmSL549lTbCkvt6KkwWdn
HE/z++efWlY7I4+BNU18NWuqrHBe4b1LpF5c2dzqL5/AgfsezypAltbeSXHJ5/kE
khqyAh66lNW+OlwjP1Zj8vKw+F3hrZBYN8rzYeX2R3TCKLyqeLdF+6cyWJLVXJUn
DMKGJJJuTenx4euZ8tfVQ8fEjDuev0nVJPiMygDm8wwOo7Ecyv3Sqy3QMRfGE7Q=
=wKEn
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
