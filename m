From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-imx: Do not store the irq number in the private
 structure
Date: Tue, 30 Dec 2014 11:25:17 +0000
Message-ID: <20141230112517.GJ11764@sirena.org.uk>
References: <1419889131-15472-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mnWQX77MmGysIXVT"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419889131-15472-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mnWQX77MmGysIXVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2014 at 07:38:51PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> The irq number is only used inside the probe function, so there is really=
 no
> need to store it in the private structure.

Applied, thanks.

--mnWQX77MmGysIXVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUooucAAoJECTWi3JdVIfQYjIH/15Pk+rPLZntDBKgPapp6vfi
3E1LFXlbqkr2Nv5asAZAqmSVP3vcSvqrlHP0cLzrNwUt3fowdh8tCKA+cYAFTx42
CoUjW4/7xn19gyWtZFpFvTDSEcrMexixg6IyUExYSPDPjDu/HHU4vXuc2kW3JXQu
3GD/QKcvnG19Nwnhdd+KpRPSGyTi/9tLeVd8Dte6EC/QASMtlqrDySeO2yd2ODhY
T1NCNAck0nL/UmEMsbQEz9WujvLavNVKCEWJmXSuJI3l2TW4veCjmAoWWcsK3dvs
t3qBaB+Wn6CVdkjjs3zg5byBG5xSjAJuFl1L/ovTMP52E5oKGyUHOpi98qEX5CY=
=wkSa
-----END PGP SIGNATURE-----

--mnWQX77MmGysIXVT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
