From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add ls2080a
 compatibility string to bindings
Date: Wed, 21 Aug 2019 12:06:40 +0100
Message-ID: <20190821110640.GC5128@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-next@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@nxp.com>
To: Ashish Kumar <Ashish.Kumar@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 03:53:09PM +0530, Ashish Kumar wrote:

> There are 2 version of QSPI-IP, according to which controller registers s=
ets
> can be big endian or little endian.There are some other minor changes like
> RX fifo depth etc.
>=20
> The big endian version uses driver compatible "fsl,ls1021a-qspi" and
> little endian version uses driver compatible "fsl,ls2080a-qspi"

I'm not seeing the corresponding code changes anywhere?  I'd at least
expect to see the compatibles added, and it sounds like some actual code
updates are needed.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dJcAACgkQJNaLcl1U
h9ALWAf9FuOa4W9/UQrIJZeOZ/BujLFsH5QKFVBvWEBDKZF/EXSWLrYORXZxko35
l4tKWlUnJd4XbiikYKCJF+d3HWK8f6ZBgPKKMi5PYX9HeUtBF6fJ8mjn2Tz/xh6h
sG7ZNP9OCu+i7HviwHWORMPBCeOplTwNShinPGIAMxCqM92AppySQfbSbFXl2u5i
dDwGHh6zPt7raw0Jetq8zjOePmNxwgb8MyF4htJv/W62zF6InmY0XoXeAH3pVNpU
e0R8Mp/hbYHKEql5s5GTgiBd1toZ5RiSsxWj0it+J66/nWKzQTsihCv0HVJUlGNu
rdUYox05ntwGBCd4uTGuECa8E4cwrQ==
=E1Em
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
