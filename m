From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Fri, 18 Jan 2019 19:12:03 +0000
Message-ID: <20190118191202.GG6260@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
 <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Cc: Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: kernel@martin.sperl.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 06:11:31PM +0100, kernel@martin.sperl.org wrote:

> Does something like this looks acceptable?

> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index ec210286567c..677fc5025033 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -288,6 +288,21 @@ static inline void spi_unregister_driver(struct spi_=
driver *sdrv)
>  	module_driver(__spi_driver, spi_register_driver, \
>  			spi_unregister_driver)
>=20
> +/* define SPI Controller states in the state machine */
> +enum spi_controller_state {
> +	SPI_CONTROLLER_STATE_SHUTDOWN		=3D 0,
> +	SPI_CONTROLLER_STATE_IDLE		=3D 1,
> +	SPI_CONTROLLER_STATE_IN_PROCESS		=3D 2,
> +	SPI_CONTROLLER_STATE_IN_TRANSFER	=3D 3,
> +};

Yes, it does!

> SPI_CONTROLLER_MODE_EXCLUSIVE could replace the bus_lock_flag.
> I am also not sure of the =E2=80=9Cconvention=E2=80=9D of memory mode (i.e
> using mem_ops). Is it maybe implicitly spi_bus_locked - i.e
> typically only a single device?

Yes, it does - we're basically handing over the entire SPI bus to
another bit of hardware that will do memory mapped flash access so we
can't really have anything else trying to do SPI operations at the same
time.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCJQIACgkQJNaLcl1U
h9CDdQf+I7iveblkgIuqYYemfISQk+f97Jh7CYalr7//EB65ABrPeVKbeWdEWNEd
O3lQckS5I1XBelmk78Kw1keMvy7yev5LKvadKyXMIS/HPOaCaC8GnuVQ039Zk0iX
tIeK/uCe2Its32BjZ5b0WbDt68JInIEpf7iuqTQs7hVDmvmx2TovvbXdSkoaqkpU
qx8wkH0+sxeLLqBelfzvsy7J3ETSRd+c6Je3gCH9Jk15qYO8x+XdY6PRL+3Pz5zs
U3gVWY8cwTD4v7tORNPNi0W8oB01KoXcrk7cvCUteYS3nSVn2h5GKO05IDrDlhAO
+5qJMOnCzhhWFsctQcfxD0kQI+tBCA==
=0ySs
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
