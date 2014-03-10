From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/qspi: Fix return from mmap path
Date: Mon, 10 Mar 2014 11:12:16 +0000
Message-ID: <20140310111216.GY28112@sirena.org.uk>
References: <1394447443-9861-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6JfgtCrXn0mFP5up"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394447443-9861-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6JfgtCrXn0mFP5up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 04:00:42PM +0530, Sourav Poddar wrote:
> mmap resource requirement is only for memory mapped operations.
> If the user does not populate mmap resource, dont call return,
> instead we go on for normal spi mode operations.

Applied, thanks.

--6JfgtCrXn0mFP5up
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHZ4NAAoJELSic+t+oim9mFcP/1s5sflBpdP7p7dxXsT/NBB6
O8JP9BYf7TOpQkn/1T+Ejr9Ffw/z0BMPrP/HlZvL7LgZBzyibfc11oeRe7/gumO1
mm5ZK9sfkEX9xGUshsgupYmM/5omw0TsByUSa5x1DRc0RLgkwkeE6hp7aQv6CweB
kfaYd0pkmjmc/af1AXpjq7FnZSp9uUsMB1f3Sg+vlD7yWWD2jpXk0k7ka8m1veHj
0QtHLSASO4t1xeP92gmYI89YdBpt3dNDoRFB67yonu1Q8t9+W7fjlsPdmUW5wezR
8WaDVdAyTvUbMqzaWl+q0wHIEQmgxLEilFn5SzeuTySDqSG/NZFeuEYqtT8XCI67
Ytxu8sMcZoUtqXzHrev0ganIYmWmNQzqCX2/RqnN4632tpbpCcxX+MWIo9+2278C
AcKtBo8f2E/wNn74SmENS1Okh4GA7+drc3OmDutKnXmJSoRcutIBU0NjE2/hdYnu
AE+PUJ6q9jISYMtmgm+Jiov5LApqrSfbemc1nUOkGpv7xJ6jothmC5tgnb8h5M0n
i623xcBWu5EhmAWspDtTSaABPEcd/UEeXBQIpGUjhd3SN1irxwZzXJr4/P/rtCJ1
PvqkyMsrn670g8CO++GLxveA2XjEAkn0+MYQzRrwkqI1sDZeWu5jbQ4nXAMFozsZ
kPQ+iUEM7g6chWG9vXSL
=exVI
-----END PGP SIGNATURE-----

--6JfgtCrXn0mFP5up--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
