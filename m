From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Date: Mon, 28 Jan 2019 12:26:31 +0000
Message-ID: <20190128122631.GD11699@sirena.org.uk>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 10:05:29AM +0000, Yogesh Narayan Gaur wrote:

> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index e23ad9ef028e..adc3c0e14f38 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)

This does not apply against current code, the above file is not present
upstream.  Please do not submit patches to out of tree code upstream.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO9PYACgkQJNaLcl1U
h9Bc7wf+PzfVYK47sKb7gYCwrFPhskxTV0PfgznGOSHdzhtJmhuLjfDzsgLC+PH5
T25AIY5kF5IKbod3WbKT8atM1uQCDHDae81MTD0m6da0uNCpqPsGBquyU+WPiwJA
SOEpzPRyV0GSI/TQW5fKWnWVUxLVKdMEzTBZnvu9I7EvOpv+eiS0udKenqsE8iVp
U0EgQng2D51VRhvVOmRY4bmvtby54bzZXjt/4TYsdvNux2ar00OzH8FOJ2XTKnOO
JdDZlmY/K0NSgjE5T1JYHT4CDn8LLL1wJQ4g04CN/WAKdbGU1GgSMcnxK8OD0C2i
t3E/tHBlG4R/WC4KdDO76rZk6mCTTg==
=DbNg
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
