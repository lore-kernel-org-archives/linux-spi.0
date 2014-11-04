From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Fix CTAR selection
Date: Tue, 4 Nov 2014 10:52:33 +0000
Message-ID: <20141104105233.GD3815@sirena.org.uk>
References: <1415089218-2011-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0VNbQffo0Gc48lc+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415089218-2011-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0VNbQffo0Gc48lc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 09:20:18AM +0100, Alexander Stein wrote:
> There are only 4 CTAR registers (CTAR0 - CTAR3) so we can only use the
> lower 2 bits of the chip select to select a CTAR register.
> SPI_PUSHR_CTAS used the lower 3 bits which would result in wrong bit values
> if the chip selects 4/5 are used. For those chip selects SPI_CTAR even
> calculated offsets of non-existing registers.

Applied, thanks.

--0VNbQffo0Gc48lc+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWK/xAAoJECTWi3JdVIfQARMH/ifs9jDmSwOjrBfYck9+Xhi5
n8W0RHxJl/wNQP4/E/xB6PgFtng4PpXp6zBpjFgKJu0csuku8mw+NX75WqC1vM3V
8OOWsRnt3nwiYt2Bb6OHChCbhtTscJtZXDWI18V9lehYGq6PNTZcZfNDlc4FipCV
BueanYUn6oGwLzKcDxac7h77J78bfO174EJk+aabHRZV6ySaRQirVq9cVF+X9arG
eoO8T+CVKMZvRsrDdL/8grm8drMqM7JI+b9loRioh4h2nPJXYn85jZHksZyaQPbY
CfQWACDkzASrzNFYeYIz2Uy1SOINymqTC3FZLjCa6Mr4CYkYlMp1DdbdSOH4mi8=
=BGPW
-----END PGP SIGNATURE-----

--0VNbQffo0Gc48lc+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
