From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: fsl: simplify error path in
 of_fsl_spi_probe()
Date: Tue, 14 Jan 2020 15:35:08 +0000
Message-ID: <20200114153508.GY3897@sirena.org.uk>
References: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
 <539a3b82463f64e8055f166c915f0e90f752c7b0.1575990944.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mlvFMpb4NrD3AMcD"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <539a3b82463f64e8055f166c915f0e90f752c7b0.1575990944.git.christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mlvFMpb4NrD3AMcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 03:17:16PM +0000, Christophe Leroy wrote:
> No need to 'goto err;' for just doing a return.
> return directly from where the error happens.

This doesn't apply against current code, please check and resend.

--mlvFMpb4NrD3AMcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4d36sACgkQJNaLcl1U
h9C3zQf/cMvkTc+QF3yMKYXxlmxQDKATcaQNF7uNysSG2s4+eOCqDd8drWV92HRz
AM7/spEm4cUKbeKJNtl5fXAnxI89PdE/e0bDH316EkA5L7NOJAI2dGjHDVJcgKMu
azrTo4dbu1+bt2JXOtHrTO9nIU8IRbQL9QcuLG/52cqD0wB3xWb4LE6ToQftfMoC
+96ALK3iJyYK8dhJI4Ip+oXBQGE2Fu2YU/C1lTvHnsrgqwnolt2u9z+HEXGu8rkE
DGmxnns+uSmLrCbSETb5ooxW3GVnis5IlROQKGBXZ+LDdTA41owEQLdqXIaeaIDu
Fiz2D//oT5xGwJgH7rM8LpEcSnodNA==
=EOzq
-----END PGP SIGNATURE-----

--mlvFMpb4NrD3AMcD--
