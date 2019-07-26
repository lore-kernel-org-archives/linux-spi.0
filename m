From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/7] drivers: Introduce device lookup variants by
 ACPI_COMPANION device
Date: Fri, 26 Jul 2019 18:18:24 +0100
Message-ID: <20190726171824.GE55803@sirena.org.uk>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
 <20190723221838.12024-6-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190723221838.12024-6-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 11:18:36PM +0100, Suzuki K Poulose wrote:
> Add a generic helper to match a device by the ACPI_COMPANION device
> and provide wrappers for the device lookup APIs.

Acked-by: Mark Brown <broonie@kernel.org>

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl07Nd8ACgkQJNaLcl1U
h9AP6Qf/YGrw0TyOSSQSBXyPk+b+NdGM3zToNrnX22MlqJOqIoR1Cojj3bSvlBPh
X0GCuxCUvGTjhFC0Hrg4YvdCm68TiZwOyi8e8s7bwZfJQxz/Z7tDrCsumy62WuzF
qKxfi2q4CAm7FIRT4J7Q8AKVroxHaWs6mS2P/LzMkNUBOfXrMu4VNbObMaXkVt92
y1rqdWxtykM3LKPyO11gmxjRzlgtZsNuFLvgqUzJL6xTCvNPsYVilqr2TdlsSVtk
iyb9Bepc0jZslrKB9t/goFvPZ0hjB7o/WiCwXkPhcuIe/YgPZzIKapao7AGZruf4
Egk3xu2RdzcnwJMfkHYFGJzU5OaLwA==
=DtTy
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
