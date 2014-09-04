From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/8] spi: sirf: set default spi frequency if it is not set
Date: Thu, 4 Sep 2014 23:39:13 +0100
Message-ID: <20140904223913.GU29327@sirena.org.uk>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-2-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80TIu+lzzbJOSSak"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409648557-5470-2-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--80TIu+lzzbJOSSak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 05:02:35PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> give spi a default frequence if it is not set and the value is 0.

I think this is a good idea but I think we should do this in the SPI
core rather than this driver since the same thing is going to apply to
many drivers.  Can you do a patch for that?

--80TIu+lzzbJOSSak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCOoOAAoJELSic+t+oim9xqMQAJmkCDjis1nT1Zv2gq5vb8p7
WfxrTHri7u0N0yhDD3LYvFm4spjA+QEeQMOA1U2/mi4LRTIFCzUfo3xYZ2mlJ3Uf
QBlexEm5E2fdAJg7P9xnX4/jpjkJqczHH/1F5z6JpljYD+tR0DpIBmNH3QCy42YH
m+MNRvJqWIWB8agAY1AgROzyTiFFs8PXq5fl5LCrbng66XLDVUWwZG3rLAIEI66L
ewnPdAyH7UtnK2nG2gXi00xpuEQfR1zgPqIjmWQsILNWxX1yMBpcm3yx91eIs6sp
pwOAUQzwFIuX+SyN5oYDzev6jcUDQE4vQ8+uXdQasp2jfsGhQZ4Cxf1FXB1v5NxK
8W30v4tFhRH7EwAqG1qIeGpYFjrlfiBr8JC9A14AmvmejTTgXPIkDWi2N0T4Smte
wJuQLfdViMVFHX83j7qlFl1yUp+3m1T64JrEb79v3vqi9itrqgO4k8ECpZ3z0AXm
Rdk7Kb20UwyxnJmUQtmI2EAHlNNj1iweDeIwlkSbqqtu0GKblSEA8hv0Bnz3TC8P
pHtLj3+Uw26W0nfM6av6hmG1SXMXovdCaaHzIzxRzdZaUEkKBChXz61U83JksHmN
dizNwVfsWVsaJ/CXZ/jBktJRdz1k2vV1iLSEpgdG6y3gJi0drroNW9TdgGDua7C/
whPU0zTelPbwYkz8Xdcm
=qdIb
-----END PGP SIGNATURE-----

--80TIu+lzzbJOSSak--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
