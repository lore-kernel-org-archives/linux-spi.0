From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] SPI: spi-orion: add runtime PM support
Date: Sat, 21 Jun 2014 16:31:57 +0100
Message-ID: <20140621153157.GH5099@sirena.org.uk>
References: <20140621110339.GG5099@sirena.org.uk>
 <E1WyJNV-0004DZ-Sb@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Q2XQl/uTluQbjdP"
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1WyJNV-0004DZ-Sb-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5Q2XQl/uTluQbjdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 21, 2014 at 12:22:37PM +0100, Russell King wrote:
> Add trivial runtime PM support.  This will only be of benefit on SoCs
> where the clock to the SPI interface can be shut down.

Applied, thanks.

--5Q2XQl/uTluQbjdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpaVpAAoJELSic+t+oim9dnQQAJXUrAe7zl/s14Fm/2IbnDWD
FQIkXncA9HPEZ2OEhhv9SKrsk1b4sEiT069rVFE/ocy6PLHyXXrVGxj8YpojPUPA
T/6P/IKXEsm2ymwT26jgUsibNCbbXDukM/dpx8OrwY7UI+tRK1S9hnHvkKDLcFU0
f4Ib0ziEF/gW8b3xIMjmKJ1lsruJDs90i8SVoPmUEXBALxddonn6Kwhd461zirEj
sCt25yZymbIjvc3POE+XNpvnx3NcFijeoaKHEoVW3ZInOjQzNdpZR6MfKKuojzpi
3EGG6MkfjvrzT9frMOvJX/DEj8DPpK90zTZC7vjXHhLAuCHg4Uv7/LBUlR9sawNz
aOHIWfjSyGK+W3MxNffZq5EUo0F8Sd2rhDDjgtOPOdvls1g/qw0+8elYMwJPEbTf
T4U+t0TpaccPgrL/xbK1l/Bdg8QPLGKvpZWlf/AQDi2EyyoKKBNhgZLKxoPrtV8g
sGEtADZLecaAZdgCWekFprBOPczKSBDifJGOzXdzH3YPDIFDjRcIV+jV3w2rkN90
PLd7apxaPSgwgFfxhA4Z6Ww0aLhSsCHH8Ng5UOKzBBRB8IKwl7S+WxkoIej7+vCa
0C+m1juPgvJxHwvCF7amkqTpWCaGmUfNuzKXBXVtggfNdzyK/3QxzEmzI9VsfKmh
bqn+UnH98gaqbpV2Pu6z
=afxD
-----END PGP SIGNATURE-----

--5Q2XQl/uTluQbjdP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
