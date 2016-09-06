From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: dw: round up result of calculation for clock
 divider
Date: Tue, 6 Sep 2016 11:53:52 +0100
Message-ID: <20160906105352.GK3950@sirena.org.uk>
References: <20160904020535.2bb2ab68@vm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aglTZS2R0flMmvQN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Seidel <kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160904020535.2bb2ab68@vm>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aglTZS2R0flMmvQN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 04, 2016 at 02:05:35AM +0200, Matthias Seidel wrote:

>  			/* clk_div doesn't support odd number */
> -			chip->clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
> +			chip->clk_div = ((dws->max_freq + transfer->speed_hz) /
> +				transfer->speed_hz + 1) & 0xfffe;

Can we not use DIV_ROUND_UP here if that's what we're trying to do?  The
above probably needs a comment if not, I'm finding the intent rather
confusing looking at the code.

--aglTZS2R0flMmvQN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzqA0AAoJECTWi3JdVIfQlCwH/0CMYdWut1ZP2cLCzCh5WQGY
pqVYyd8HlErVvhoxWJ5wWiQItZwJ0VYChEWwZbXshPV36aJ0o04nAAlDAg7y2d9y
/p0G8fneyNIVueNxCXzUL8/bv1thbJ6AXGWYlLFsGFYoBiqiU9IXkmqP2VjHhAbU
VXOv86lVvOyes68/nrjlnESDp8bhINu6A8mrXC4qsM3iLwb/3fo8c1xPYDihwJy2
kyue+x/zajmeYLkldPRfXJwSwhtaTyfg4FVPQYqYkY+Bwlg9h6wG6nOb28mM8s3q
8GhXpjLX/QLQOw96jcXDhuGWWI7kck4qmS55uC6b43zFW8XUODzwuQYylOAhLDk=
=y2h5
-----END PGP SIGNATURE-----

--aglTZS2R0flMmvQN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
