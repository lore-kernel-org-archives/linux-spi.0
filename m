From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: img-spfi: Limit bit clock to 1/4th of input
 clock
Date: Tue, 7 Apr 2015 12:19:34 +0100
Message-ID: <20150407111934.GK6023@sirena.org.uk>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MbiMhNjKwMZ0Kn0G"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428355747-16822-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MbiMhNjKwMZ0Kn0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 02:29:03PM -0700, Andrew Bresticker wrote:
> Although the SPFI BITCLK divider supports a value of up to 255, only
> values up to 128 are usable.  This results in a maximum possible bit
> clock rate of 1/4th the input clock rate.

Applied, thanks.

--MbiMhNjKwMZ0Kn0G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVI71FAAoJECTWi3JdVIfQcTkH/2xRDx2QG93dct6n+U3SmLzr
A+l9B8GWLJgLpXkNWEYc1z30yaPnvyPuwh2hQbW9MiZ+KMJAJ6THDGM3lP7pVJZi
net2VIC7iiPFrMvJXE+Y6nP8lspgIB/geGxKiz5/nEfsNSjf15Ub4aCGPtiI20jR
HK5dIPrbWW/7KI51xSMBZFCHs5MW6x2sJ9oShktRoWNBIlFiE0bOftkHgAWkwHic
9/YLmhU68eX9yV9JfD7VrEPEAbYtnp4+vp5S4x/l/xfuZlCgw1Q+s6CZzfJCptFV
fnHf6lyIeMDBPURX789KJhKSpGEwMxD9I+WyYZKghrA/cQxPnKy6Gf/yIN7eEoA=
=je+L
-----END PGP SIGNATURE-----

--MbiMhNjKwMZ0Kn0G--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
