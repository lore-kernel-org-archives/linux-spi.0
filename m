From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/qspi: cleanup qspi remova path and error check.
Date: Tue, 19 Nov 2013 11:31:25 +0000
Message-ID: <20131119113125.GZ2674@sirena.org.uk>
References: <1384858703-30938-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UEW5kU42M6+IO/TD"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384858703-30938-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UEW5kU42M6+IO/TD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 04:28:23PM +0530, Sourav Poddar wrote:
> There is a bug in qspi removal path, as a result of which
> qspi cannot be removed when used as a module. The patch
> solves the bug and qspi can be removed cleanly.

What is the bug?  The important bit of information is what's actually
being changed.

> Also align the runtime error path check through out the code.

This should be split out.

--UEW5kU42M6+IO/TD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi0wKAAoJELSic+t+oim92DMP/i2ZZhYfsr9oHALTMxtJh+Gr
8etV74h8bpMlhpzBrgliz+Q/JCfujdoJHg61Ko/5u90lifGVwvGfZSMb0SjRYbko
emwLG8OAHx+i3duRSGhrxepSkdxLUdxcDuj9CNOcwP/lWZcDZzCjPms8rwAMeVhY
7dqY4KDu0nLLAyYayHLJobpLjSsCB44WXpLseooq3bgfebHtNDt8vW0/HlaZHE79
EvmAtJptr6UUhYT5ZdRPngkhUEVF+iz0uspQ/9u0xBeBQ+KeK2fooIGFsAwoFVbZ
BuxcvvaIsT8oeH+ZmCqtXMbGIRLTkvE1D7ZjrXOouLJHC8+ZTLTsCS1hMi8dHHZz
1SsQZhMFL6J5ypNEuymYOT8rFaLGUpUzNPrywzNLtxls7qMIuQNLfh4xr0KePZut
835nRhQB6/TrWYyyBmHEiqK+IzTrKGtSAYtuVnnoExSn/a5baelJcj+PJehBqN3R
lnaFHisi9nSYL4oX0iA1gQVNYLbQxdCyE2wDAuelxoz8nvBSwOBP/ExWLsf9R0iN
R/Cm09KGlba7fycEES9WPdF3KCOfs/yfRmDR7qOGQAz3RU1oDYlvZaFFkicVKW/M
A71aeEg8o4EEwLkSBHwsgBV9ODBeJCtRiJSOhGXOpQyISx5gLH4Ra9dRYgvYsuv2
cPHEGlpYl3AbWxXMhC4K
=GUF3
-----END PGP SIGNATURE-----

--UEW5kU42M6+IO/TD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
