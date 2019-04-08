From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST
 mode
Date: Mon, 8 Apr 2019 13:28:19 +0700
Message-ID: <20190408062819.GJ2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 05:14:10PM -0700, Sowjanya Komatineni wrote:
> Some SPI Master controllers support configuring Least significant byte
> first or Most significant byte first order for transfers. Also some SPI
> slave devices expect bytes to be in Least significant first order and
> some devices expect Most significant first order.
>=20
> SPI driver declares mode and mode_bits as u16 and all bits are used.
>=20
> This patch changes mode and mode_bits to be u32 to allow for more mode
> configurations.
>=20
> This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to
> choose LSByte order or MSByte order through the device tree property
> spi-lsbyte-first.

Please submit one patch per change, each with a clear changelog, as
covered in SubmittingPatches.  This makes it much easier to review
things since it's easier to tell if the patch does what it was intended
to do and means that if one part of the patch casues problems it won't
hold up the other parts.

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq6gIACgkQJNaLcl1U
h9DuHwf/ZtMyHrfW3WzW3cRTFF1ocpo6CZNO/MsgbS9BbngjgkNeCST7eNBKSUIx
PRhkYretkGShqbxWzCcImUTUuMcJfD4ssKG9DGWiYAtAs8kK0YRsPgrmWEjKNwDm
tUf5RsjgebZukSQo/Ba53PNmWosGCg1STb2gs8ZWE8HO/zxCGH6DFPSgMuRZk/iB
bTwVJGKKXuNW2UMMCRwvv6b5+Zm8E/HWGwlfXBOeI1X9WXKNhWUQfl0bIv0qps59
ViMc+YMFcSD1JRE1471cWONSKbcMWPx7TQFUaQBBszdRn+asko27l0hHcvH7chDt
K7/zgtAI3QFNjfN3Oc1UPzMrfk4c3Q==
=XP4S
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
