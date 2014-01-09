From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: oc-tiny: Simplify tiny_spi_txrx_bufs
 implementation when irq is not used
Date: Thu, 9 Jan 2014 18:02:33 +0000
Message-ID: <20140109180233.GM12858@sirena.org.uk>
References: <1389168004.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389168004.28019.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 04:00:04PM +0800, Axel Lin wrote:
> Currently we have similar code for (txp && rxp), (txp && !rxp), (!rxp & txp),
> and (!txp && !rxp) cases. This patch refactors the code a bit to avoid
> duplicate similar code.

Applied, thanks - it's actually a moderately common pattern in various
ways in drivers.  I was thinking it might be good to have the core
provide dummy buffers to drivers that need to do bidirectional transfers
so the drivers only need to set a flag and don't need to open code this.

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzuQ2AAoJELSic+t+oim9vtEQAJxiQbUJ8mMPy15532YUbIgF
32wHTkmW0axaNNEFa0w7F66wAWnv+NmpVkpfgUNyRDIpAqLo4gBmwMR/23fZoFtn
jmUmLNgrcnKb8wuuke6YNetjyJKpDv+D4ziyuvHSR9TmkEnqlG63eV8FJ21VJ4YX
AxZbnfmjd3remPx5L463siCVfplX9OXuRGNI/wXmMjRreUkOJxG/QD82cnPzlwIc
5Vm/niBiXbmHksp0wfbmEgsfpzP1p1JBP10sAy1o4eawcvC78kUSo2+IGepJc1GZ
6h7G3MCE/W2GwdeXwR9BBHQq4k/1s7YLwgI4yLC8AcLktZwXCynPMg50xDhc/2fZ
6WitNS68JRcNtqKT1zHD3saVmR8dmLHmUdWjtcFSvTp99blIw/vfcWKdklDXxY2J
juZFdZGFVj+cryKu3KQcHiJD6PntKMyK0vuta+yATGhyUR/7XTSoX6H8N8aFkQXj
X4ANlS7lmeFCtKN5q4/P9GfdjgwgX4Nd53GXnlzlmMNzLv2tVec0QVR/n9RM+Wrh
2zvLvKNctJlkxmanmoPxyiC3bOcD/fIjEcR3sN3kDq8xNfpKze58BZ1FAlUUD+E7
EBNLhuEs96HQqxtSfNWWTTVgiK9TOzRbpiA/7ErEiPQu4LgcCuHL/vOJMBOvnVok
/IKcWDMLY109scLyME1X
=v2ue
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
