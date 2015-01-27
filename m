From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] spi: spi-fsl-dspi: avoid preparing the clock two
 times
Date: Tue, 27 Jan 2015 13:01:17 +0000
Message-ID: <20150127130117.GU21293@sirena.org.uk>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-5-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/OvG/B6si4M0/khi"
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422356244-15629-5-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--/OvG/B6si4M0/khi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2015 at 04:27:21PM +0530, Bhuvanchandra DV wrote:
> regmap_read/regmap_write will expect the peripheral clock
> to be enabled before accessing the registers of the peripheral.
> Since the peripheral clock is enabled separatly, avoid redundant clock
> prepare (with devm_regmap_init_mmio_clk) and use devm_regmap_init_mmio instead.

What's the advantage of this?  The clock API is refcounted so there
should be no issue with this and it seems like it's opening us up to
bugs if there's a path where we interact with the registers without
enabling the clocks.

--/OvG/B6si4M0/khi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx4wdAAoJECTWi3JdVIfQw8YH/iEK6t+Ejl4tZ5JzfBddbN3a
WBiO72ZhuLGxqXiZjXg1e2D4jmjdeDb+M7tGLENo7gXFu9dlvOmAIcjnDrIVl/Va
r/6nEumdyaSxttAYRc7d39MUAcgocCCbIqYWcG/00Y9OhCkbj+tE5m3RzM4Jc840
ipzujqekVLxZPXZ3KqbxYOk2huQJFGYkwfZ9RpcaBANkdaif+Qa3ZA6CLpPpvTaQ
CkjaKryfsLGFBTdFAjELKRBtK66KeTPKN+2B7/iBBaWUlTfQ32f+9ChYWF0vMENq
iIlXTinFFfbj6B3k4CwIHJKtAunZ3apI8LNK6M81oN/6Oen0yEuupz0AICxi2OQ=
=Oedd
-----END PGP SIGNATURE-----

--/OvG/B6si4M0/khi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
