From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: add reset controller dependency
Date: Sat, 21 Feb 2015 18:44:58 +0900
Message-ID: <20150221094458.GM6236@finisterre.sirena.org.uk>
References: <4553005.HBquOfbqXe@wuerfel>
 <20150219094155.GA3198@finisterre.sirena.org.uk>
 <7767301.zaEX63gvjp@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7767301.zaEX63gvjp@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 19, 2015 at 04:01:29PM +0100, Arnd Bergmann wrote:

> So the stubs are provided for all functions except device_reset() and
> reset_control_get(), and drivers using the API need to either call the
> stubbed-out _optional() versions of these functions or have the explicit
> dependency.

In that case a dependency seems wrong, I'd expect to see a select - it's
a bit obscure to have to grovel around to figure out what magic options
are needed to make things turn on and resets feel more like a utility
thing than a control bus (which tend to be the things we depend on).
Dunno, perhaps I'm wrong?

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6FOZAAoJECTWi3JdVIfQ3xcIAIAej5IMuvnim/zMY1OXtRvL
m5bGHTsG4A7m9y7m05FWRCC86pYf59FuPGbwvHGy5bA4K9kjLTzDeM1We2+KE/i5
yL38ZCSLfAwTYIDfNj8Zj4TWLefqowg733RMdo0KNc+/vdoeQ7VZ3FsiEQbw8bmF
k6LQrjlp832jGEGXk8vmzlJkvpbRMLj6tpgwtfZ5yhU1vhs/bXPExiB2z34iwxkb
zyMklnuDpLtvQnZ3HbpDHKYjrCOlnR4VWZk3E+Tr4aEYcNtxN44q+tskMNj3Z0ya
svz4l3hTOPcqn8UpFwiCWrW2Js4dRjFqIpf62idg0pRmdKKqrGCV07IY55Bez7o=
=W8gE
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
