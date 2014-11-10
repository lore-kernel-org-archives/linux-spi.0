From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-mxs: Register the irq with the device name
Date: Mon, 10 Nov 2014 19:37:38 +0000
Message-ID: <20141110193738.GM3815@sirena.org.uk>
References: <1415647524-10962-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="odGbPdm3VVQrBQZi"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415647524-10962-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--odGbPdm3VVQrBQZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 05:25:24PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> Instead of registering the irq name with the driver name, it's better to =
pass
> the device name so that we have a more explicit indication as to what spi
> instance the irq is related:

Applied, thanks.

--odGbPdm3VVQrBQZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYRQCAAoJECTWi3JdVIfQLkEH/AvaiI3B4DySzrutLQpr1he8
QY7SHt+Pvt3m8bOwdPQa3ENZYzuPMvZEILh8q8PTk/KUOgAz1/MQ/VQZnzHOyNDY
35lK40Vj67ejeZKi5YjcOJEh8eVxbH6b+BZRm2ZXXh5xMMKEqPUNObilG/64Svu7
7hOYcd7XGk3Z+D9yYFNGi5sGQBnwiph/tT82Wa8rTEW55iZZEeEgwDa2iNlIZt4S
6RvwBhddEnboCVZlF43bseFsCBzPJQ+I5rJejHCGPjRaBBi0tCT4RG3JhoESE/df
5fUF2YurQ6dHdWoyvYsQ6Fwkydvqryj7LVgcR8dRgI4ebqTt4ERTcyekfqb2Dd4=
=t6Qu
-----END PGP SIGNATURE-----

--odGbPdm3VVQrBQZi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
