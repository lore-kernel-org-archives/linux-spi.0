From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times
 as necessary
Date: Thu, 5 Mar 2020 12:12:02 +0000
Message-ID: <20200305121202.GB4046@sirena.org.uk>
References: <20200304220044.11193-1-olteanv@gmail.com>
 <20200304220044.11193-8-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200304220044.11193-8-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 12:00:39AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
>=20
> When dealing with a SPI controller driver that is sending more than 1
> byte at once (or the entire buffer at once), and the SPI peripheral
> driver has requested timestamping for a byte in the middle of the
> buffer, we find that spi_take_timestamp_pre never records a "pre"
> timestamp.

This is a fix and so should have been at the start of the series to make
sure there aren't any dependencies.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g7JEACgkQJNaLcl1U
h9Chiwf+On3bebnRG/0bCvM4m9UoJ3euPVdOY1kKcGGzF0tOUWjGenpRsTQh+vsp
vAE31eCPdss6Fv5wvgdS3KtJGvcXjptXipSFu3KSrKBoBls23CXGD+c8IpFRvdQ8
tbvLtb3jelZt45+TVASwIKlUXplBRqcpxOKo4wi+9LWYjwK+5HRYJLT9RyS8sTRM
e/2YTw6MMpqAaSTh0S6BOHgg/MNQT9aB2rzDigkO+JbfI84w9eiAzDAN9J/OuT0Z
8j1upFtnkq2vQ4wfg0btLD2ZgWUvr6sr7qC7uyuTw5/D594N1/GPGqg9xIsT5Ayp
dV9ERzRx6f85sqEtI5VbchtOOYN9eg==
=WVjV
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
