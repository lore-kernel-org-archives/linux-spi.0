From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 09/26] spi: tegra114: dump SPI registers during timeout
Date: Mon, 1 Apr 2019 14:39:58 +0700
Message-ID: <20190401073958.GJ2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-9-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666207-11414-9-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:30PM -0700, Sowjanya Komatineni wrote:
> This patch dumps SPI registers on DMA or transfer timeout for debug
> purpose.

This is another non-bugfix patch which should be after the bugfixes.

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwE0ACgkQJNaLcl1U
h9AVFQf/d16Dknk5nchZgdinfRmqX2qop7KAFn4NZjfrdCCCFC2Me03rw4qkiVlK
jbOdswTT6UH2uG7PBn5EmSA8SFNl2ggsJUM7DuYODcZ0QRlXh+Kew5lmjcPmj6Ff
tu8eXz4kkhJ0+zk9VKQkMy77ojeqhrs/gsZfJCqOnh4axHuB7hyHHyKNuyR36Y8i
hicRY6UyyMS1fYExK49osxllpkKWbvbHL/RMuXIYVx1wGtcxBU5yjkYTcFy40Nwy
7rKpNE3MjDIzqnqmuojyuRb8+mCpkEieVsREf5eVlFL27uhdVJVrUbzT7PMq75A8
uP5uTaBXwFJCqff97ZsUrl75tzYapA==
=f+WJ
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
