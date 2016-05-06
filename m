From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Fri, 6 May 2016 13:14:31 +0100
Message-ID: <20160506121431.GQ6292@sirena.org.uk>
References: <56D22823.7090005@gmail.com>
 <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com>
 <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com>
 <20160505235700.GA99474@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C6e6/dnRACxPVebH"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160505235700.GA99474-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--C6e6/dnRACxPVebH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 04:57:00PM -0700, Brian Norris wrote:
> On Thu, Apr 07, 2016 at 09:09:56PM +0200, Heiner Kallweit wrote:

> > 2. At least in the case of fsl-espi the size limit refers to one
> >    physical transfer (including the command) and therefore to the sum
> >    of all transfers.
> > We should change
> > +	t[1].len =3D min_t(size_t, len, spi_max_transfer_size(spi));
> > to
> > +	t[1].len =3D min(len, spi_max_transfer_size(spi) - t[0].len);
> >=20
> > Apart from that the patch set looks good to me.

> That's not what Mark specified here:

> http://lists.infradead.org/pipermail/linux-mtd/2015-November/063616.html

> and that's not what the API's very *name* means; it says max transfer
> size (where a spi_transfer is a very well-defined concept). You need to
> fix the driver or take up the API issues with Mark if you want to
> suggest we interpret this differently.

Yes, it's called the maximum transfer size because it is the maximum
size of a transfer, not because it's the maximum size of a message.

--C6e6/dnRACxPVebH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLIqlAAoJECTWi3JdVIfQC88H/2xva2PCrdlC+6dXK+S1n43y
sse7ST2houCukrSHljK+A+maopvucdVRcMHruitptQQPwv7BoKKVEpBEblUgjZ4s
StWz4vsqc+/T5pZU5OAPCau4IgLM7+QE5phNK3uGm1RZRljQoyTYzYgi1QWn5c5v
pzLS836b5+KcYMCmuubqCuB5tjemj3V4x8oiv5T2WoqkAoGAfZWoNds/cix3QD1c
PNaeBL6EC/TrhHOxNDc36EE0s07+NJptG0rFkh+OHFtyhGfa2sMtN6GOau/rM0ak
4n0+2zMmkoMkInhetqi5fV5N99U2dbZYNv8V9Y3/RfFREKbeSzhnNAivSvfZ2S4=
=E4sK
-----END PGP SIGNATURE-----

--C6e6/dnRACxPVebH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
