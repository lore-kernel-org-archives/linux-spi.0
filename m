From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/9] spi: dw-mid: clear BUSY flag fist and test other
 one
Date: Fri, 6 Mar 2015 11:25:19 +0000
Message-ID: <20150306112519.GH21293@sirena.org.uk>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425320166-13788-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jj43h3y7V46AI03H"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425320166-13788-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Jj43h3y7V46AI03H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 08:15:59PM +0200, Andy Shevchenko wrote:
> The logic of DMA completion is broken now since test_and_clear_bit() never
> returns the other bit is set. It means condition are always false and we =
have
> spi_finalize_current_transfer() called per each DMA completion which is w=
rong.
>=20
> The patch fixes logic by clearing BUSY bit first and then check for the o=
ther
> one.
>=20
> Fixes: 30c8eb52cc4a (spi: dw-mid: split rx and tx callbacks when DMA)

The commit this is fixing is in v3.19 so this should go to stable but I
can't apply this against my fix/dw branch.  Can you generate a version
that can be applied there please?  We'll need to work out the merge
issues with the current code I gues...

--Jj43h3y7V46AI03H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+Y6eAAoJECTWi3JdVIfQQv4H/ROnWKRmeFcNsKDPmhPhxO2w
ovgIvF6SUlzeUTzaa4X7SzobMTTaUh2k8QJy/iWF9iQgVUWRCJvAwQSZCqqI2TP4
WMMlPu2smDX848nuFzaB3jGTh589NOC8+jRtP8q3HUlRsATDsh7DgHtQOv4ufMkq
WX544HQCZcZO71i3/AXhyxyffgD3Pssk/2IbgnXlDxsyXO/Hvp0CdluLyCQRDJlX
74lvujuFBylYp0VI9Nd6qJ+kTxjD7ULZrcy38uVwQy+Y77Pezs+d0Exo0oA861y2
FhrnkSQOwyvDU7kYUV/Xs79rURStAEHMdrPmmmDcFyWfcNmMxHHJol+PQnO8U1s=
=YmLC
-----END PGP SIGNATURE-----

--Jj43h3y7V46AI03H--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
