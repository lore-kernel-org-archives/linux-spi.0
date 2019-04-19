From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Date: Fri, 19 Apr 2019 16:18:23 +0100
Message-ID: <20190419151823.GS2803@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QHhm1I6mwQR20oIa"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--QHhm1I6mwQR20oIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> This patch exports spi_set_cs of the spi core to allow SPI masters
> to use when gpio based chip select is needed.

This isn't really what I meant when I said it'd be good to use the core
GPIO code - this function doesn't do a huge amount really and the usage
of it in your subsequent patch for the driver isn't exactly joined up
with the little it does (which is mainly swapping in the GPIO chip
select instead of the hardware chip select) isn't used in your driver
usage of this as far as I can see.  The bulk of the chip select handling
code in the core is actually in transfer_one_message() which your driver
doesn't use as it's got it's own implementation of that; I've not looked
in enough detail to figure out if it could use it.

--QHhm1I6mwQR20oIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly55r4ACgkQJNaLcl1U
h9ABFQf/di4BhVkLLzj0LzAWfq+W3aQXLwjMllikpbSVi4yBAjMMBCiY/hJ694sK
t74oXpOBl1I+nU8XTCCo2UQgwEkIg5nVLHQJqoALeiqtM8W26w9xCeN4I3skqA1m
lftMW84AiOm3Rj8FXw62w8WvnugSHO5D+YMbL1DHlltQw2RBM0K6mVrENcuCu+eZ
3BVN3SzoKeuWgJV0HrZhFklXSPjbYUHKlWESz2gNukz9mmP7O+IPPAx6YJ5qbQac
Ek1vYs20B7Ldl3EmbRDIdoiiiPssmHNAqT7wiG+WDrehx2f4SF2LTEHQknLypBim
/NexZZx63UoROPuN2ifzuZSjJT2bZQ==
=bYUd
-----END PGP SIGNATURE-----

--QHhm1I6mwQR20oIa--
