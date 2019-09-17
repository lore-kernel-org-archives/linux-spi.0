From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM
 SoC
Date: Tue, 17 Sep 2019 16:36:50 +0100
Message-ID: <20190917153650.GF3524@sirena.co.uk>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916113255.GA4352@sirena.co.uk>
 <466b41c1-3d65-0bf4-6db7-d3b3e06b107b@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
To: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <466b41c1-3d65-0bf4-6db7-d3b3e06b107b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 10:11:28AM +0800, Ramuthevar, Vadivel MuruganX wrot=
e:

> *=A0=A0=A0 spi-cadence.c* in *drivers/spi/*, which supports very old lega=
cy
> cadence-spi based devices(normal)
> *=A0=A0=A0 cadence-quadspi.c(drivers/mtd/spi-nor/)* : specific support to=
 SPI-NOR
> flash with new spi-nor layer.
> =A0=A0=A0 all the API's in this driver purely on spi-nor specific, so cou=
ldn't=A0
> proceed to adapt.

Are these completely separate IPs or are they just different versions of
the same IP?

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2A/ZEACgkQJNaLcl1U
h9CyIgf8CTzBHfnl6ab2KtgUkLdtcsjko33jDsWaIjRogAUFSRsdNX6r7vpmaPBO
qfrx0rskry+jdBRHt5EYiTmvUIsxLeDzXz0WLtSawdjxG/mG1zKdM8sSk50eNdES
8Abj/5z0s6xNx6gpE0Rb7X2Z/peg0msPqIaJDGrVUWEATB+qih7K/vMJUzvQ4snS
zX+/SOl1PTFJl65fLm7H1DNurJTaokNrV1TNdSpzavnIWu2zaMfkPSTc8x+qIMOr
M8ApiHjcmr8Fjdf4UrHA1msXxn98rQvemS9KBYgzWE3TgnTCg0/NfJs65W6WYAor
XZljVmIteJ/4/Pk0nxzlmCgWd6UeoA==
=v5W8
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
