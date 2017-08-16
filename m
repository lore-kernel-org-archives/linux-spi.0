From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: Pick spi bus number from Linux idr or spi alias"
 to the spi tree
Date: Wed, 16 Aug 2017 21:09:08 +0100
Message-ID: <20170816200908.lv6rxxzhvubj2b3p@sirena.org.uk>
References: <E1di0ly-0003WF-HD@debutante>
 <CAMuHMdX0Z8prbMivN5pC+-PycDSEx1tzkjGpRKK4=3RC5aYegQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lclccrsebn3pdhmw"
Cc: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX0Z8prbMivN5pC+-PycDSEx1tzkjGpRKK4=3RC5aYegQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lclccrsebn3pdhmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 16, 2017 at 06:48:07PM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 16, 2017 at 6:02 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Modify existing code, for automatically picking the spi bus number based
> > on Linux idr scheme as mentioned in FIXME.

> FIXME?

It's fixing a FIXME that was in the code rather than a note to fix the
commit message!  Slightly awkward phrasing but it makes sense if you
look at the diff.

--lclccrsebn3pdhmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmUpmQACgkQJNaLcl1U
h9Dx6gf/TSpQlqG2OfIlh3pnrZ7OoUqPi/7byIQ2vSyHhJmfxwEU44W+26wLEwpF
PnLBgI00PihpIovJg2r1qSsy96SZv48cfIlMl/0EDGEBFio0fHKeIF4SNhjymKuF
Qy6sAw07HX44/I2iOR5EHV0spjINd1Hru2D1cKXa+YG7TDLvSNTcnwKkyMmHu/BH
Qh4Y4u96qj1jliLpv+DDIkubU5vLBRDU0/EK3z4BeyGgADk2ssE51KML6ac08aTZ
Ejz+7s0A4I113ZcjqeKKfKPnOlMqBJO1uBej/sd9KwV7XI59ZEhXeVlV4TCgOyUI
D0IRnah2bS0ajexkJY7C0xNBCqqaGA==
=mAE0
-----END PGP SIGNATURE-----

--lclccrsebn3pdhmw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
