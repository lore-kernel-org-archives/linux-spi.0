From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Date: Fri, 19 Apr 2019 16:22:08 +0100
Message-ID: <20190419152208.GT2803@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnDjx0H/VpusRTEI"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--pnDjx0H/VpusRTEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 02:30:28PM -0700, Sowjanya Komatineni wrote:
> Some SPI slaves expect bytes to be in least significant first order
> and some expects most significant first oder.
>=20
> This patch adds support for requesting SPI master controllers for
> least significant first order using SPI_LSBYTE_FIRST mode.

This is byte ordering as opposed to bit ordering which the core already
supports.  Do you have any examples of devices that need this or is it
just being added for completeness?  If devices are going to rely on this
we probably need emulation support in the core I guess given that this
is a pretty unusual controller feature.

--pnDjx0H/VpusRTEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly5558ACgkQJNaLcl1U
h9ABdAf/VSTPgRMQCRuu5mKG7sETGap2gcwbgefEWavIGVVyUwfycisAdwMX7fnz
o9BCutybIvNC09o6dTuMEwJEVfYDMDQGdLY337ofB/O1lOKbFNp51bOC5knj69Rn
rX1O0T5DP9pHAbAWle473JCt4QXoLjw6bfasqZww/g6GQBQVFTMFw5RAI6Tbdwci
OSEmszHN/b8s6u5oty9GmPjc0kn2SPoahgM4myTvTBNFrzabvsfyXhV7XeaHOox8
kmMRDhZ2X8hrOkBpno4nFW63ZmVzKgqKkcrNoERIPmzw6awYpNCaWmvIA88Ba/es
TMw7K+3CDCo+OOrDtOWR/CQ2VCUNAw==
=00zp
-----END PGP SIGNATURE-----

--pnDjx0H/VpusRTEI--
