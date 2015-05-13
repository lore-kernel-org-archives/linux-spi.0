From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add option to bind spidev to all chipselects
Date: Wed, 13 May 2015 12:05:41 +0100
Message-ID: <20150513110541.GE3066@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513093441.80359.qmail@dec59.ruk.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xd7ZVmXU2EjaW0+X"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513093441.80359.qmail-ve7rdfgbAvJ3WEpVTuSGmqVXKuFTiq87@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xd7ZVmXU2EjaW0+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 09:34:41AM -0000, Michal Suchanek wrote:
> Bypass the check if CS is in use for spidev devices if CONFIG_SPIDEV_SHADOW is
> set.  Rename spidev devices to avoid sysfs conflict.

To repeat my previous feedback I don't see any way in which this is
sane, having two drivers simultaneously controlling the same device is
an obviously terrible idea.

--xd7ZVmXU2EjaW0+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzAEAAoJECTWi3JdVIfQmcQH/2zvxH1c8YX6A5SFkK0LPv9f
sbWTlejEQt/f2+qZxmotUqrvKlpHx7kF7Y0sVQcN0LDB9PRoYwWrKeykvlvY5osR
BsAXK/VeC5EV6DGSPSdBXLojfnXdhQzVgc6tcK6Q9qi02Pf7uRGO1zEcQm0bmFZB
8cVZtHFfcpbA5M37+Q7o0CwbwfqghBWJ/IvFsmwotB7fWNTIyJ07n0WR2lmkeL7s
wdZdInb2BPtEAA2nSgYJkTzDP2/U2v/vrQAW3kYgtEXYyqG7W4AUbTlSevWsgzcq
GnsFokmjtYvs5X3zLcC1XY4FPheKTIPsIdQC6qVeBIKLGogdpejZh6wPHT92Qc0=
=UZLV
-----END PGP SIGNATURE-----

--xd7ZVmXU2EjaW0+X--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
