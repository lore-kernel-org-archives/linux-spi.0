From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 23/57] drivers: spi: Use bus_find_device_by_acpi_dev
 match helper
Date: Mon, 3 Jun 2019 17:04:29 +0100
Message-ID: <20190603160429.GC27065@sirena.org.uk>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-24-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-spi@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559577023-558-24-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 04:49:49PM +0100, Suzuki K Poulose wrote:
> Switch to the generic helper bus_find_device_by_acpi_dev.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Acked-by: Mark Brown <broonie@kernel.org>

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1RQ0ACgkQJNaLcl1U
h9CQBwf9H09l78szJ3SsaQn6PSfi69VPGAAQ3ow2xP765ppwg205GOWZSFh91i/F
S+GgszqbRJl/KiEwrPBe8nOrIAIXrBryWxDELZ4tI4h+nQnu5BoHq70B8rhGuZln
U80DQsvKrmTXSpgal77fz/OWr3+An9Bz+NQSmTfWkJRDSXasypcBOIowJ39CzvCh
DQdiFSpYkUXkX5ohtkRR1sWagTgbIvj2CtAyI74VcRPU8qT0f5ag46p7rJ01qmqr
Pbeb6wvubWgO2tPPiZ89bsR712tSXhxJ3dKCJ+Hg/ORBAVkqYl48hpov0PU0lJFh
kdzI6tgsUFi2fwHzKWdwoSnCby1C1g==
=9Tow
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
