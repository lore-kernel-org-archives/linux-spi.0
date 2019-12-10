From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: fsl: don't map irq during probe
Date: Tue, 10 Dec 2019 19:20:10 +0000
Message-ID: <20191210192010.GK6110@sirena.org.uk>
References: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcXnUX77nabWBLF4"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--HcXnUX77nabWBLF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 03:17:15PM +0000, Christophe Leroy wrote:
> With lastest kernel, the following warning is observed at startup:

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--HcXnUX77nabWBLF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3v7+oACgkQJNaLcl1U
h9COMAf/atE1JYdFEaDVfUE6vUZQPvvELAUglONPvpzbC2FySvV79fZw5WQj1B1d
bJA23l3E1GBhegHF1bWLzSYE8WtQCrgr9Jh+TNamNySK/Ob/k2xBwubsuJEWg6rF
iV4ELtr7vBD+yqCH/a7QJ4O7HQcqYjpUTezWpUDZw/6Yn5nd3CtPyFgrCmaR4Eiu
IB1pYoLnYJTJnJClH8JGLs25ezTXpigIeEZ4pcuAW2Sk4kC3R1GwdWK8BMI4cEur
mCN9zWv7+09q1JLnvkc7lqwJA1vFwdPKgeSXhBGf9P37GpPH2hnqDnY8bdFTgXIO
khEdKooQ1FU1cNpViuHqHNORPRR21g==
=cg4Q
-----END PGP SIGNATURE-----

--HcXnUX77nabWBLF4--
