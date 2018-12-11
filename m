From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: lpspi: Add cs-gpio support
Date: Tue, 11 Dec 2018 14:26:11 +0000
Message-ID: <20181211142611.GF6686@sirena.org.uk>
References: <20181204062313.28942-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204062313.28942-1-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 06:24:59AM +0000, Clark Wang wrote:

> Add cs-gpio feature for LPSPI. Use fsl_lpspi_prepare_message() and
> fsl_lpspi_unprepare_message() to enable and control cs line.
> These two functions will be only called at the beginning and the ending
> of a message transfer.

> Still support using the mode without cs-gpio. It depends on if attribute
> cs-gpio has been configured in dts file.

Why is this not using the core support for GPIO chip selects?  Note that
you can't just implement chip select in the prepare and unprepare,
drivers can toggle chip select within a message so the code should be
looking at the individual transfers to see if cs_change is set and
acting accordingly.

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPyQIACgkQJNaLcl1U
h9B2swf/VYU6sQbbpmrPoL0HsQRH99qUTf1tXQ6eoxj1gQV3T8Cir05pDhfjwOMX
uzNvGECzeszzYfcKi/fvlJIbpIjHqFwE//pZHcvFaFROM2ir/VacYzz5V/+LCU2E
CvU8rcxkNFsxPetafRX5c3O3kc6zixC7sfndIF/jzvtdUCjp+JWS18kA3RBif81Y
5IZ5Q75SFckDPN+yHx2lx0Unf5PckD6fEygU8kYc+CgTHGj+C2wwkRVUbiTt0MTS
lK30/mQ2u+i21wS1i1TKVLsCjJZDqF7nHKSCnYw5PEG16Z7tKOPSWVIuN9402rX4
6AT+9x3/YQVyfchjU8s9yMUkRMXoFQ==
=B20T
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
