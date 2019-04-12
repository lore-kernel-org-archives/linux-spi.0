From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST
 mode
Date: Fri, 12 Apr 2019 09:32:48 +0100
Message-ID: <20190412083248.GB6909@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
 <20190408062819.GJ2803@sirena.org.uk>
 <BYAPR12MB3398CC43DC1F78A10BC51DE8C22F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398CC43DC1F78A10BC51DE8C22F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 07:58:33PM +0000, Sowjanya Komatineni wrote:
> > On Thu, Apr 04, 2019 at 05:14:10PM -0700, Sowjanya Komatineni wrote:

> > > Some SPI Master controllers support configuring Least significant byt=
e=20
> > > first or Most significant byte first order for transfers. Also some=
=20
> > > SPI slave devices expect bytes to be in Least significant first order=
=20
> > > and some devices expect Most significant first order.

> > > SPI driver declares mode and mode_bits as u16 and all bits are used.

> > > This patch changes mode and mode_bits to be u32 to allow for more mod=
e=20
> > > configurations.

> > > This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to=
=20
> > > choose LSByte order or MSByte order through the device tree property=
=20
> > > spi-lsbyte-first.

> > Please submit one patch per change, each with a clear changelog, as cov=
ered in SubmittingPatches.  This makes it much easier to review things sinc=
e it's easier to tell if the patch does what it was intended to do and mean=
s that if one part of the patch casues problems it won't hold up the other =
parts.

> I split changes on SPI code side and SPI Tegra side as separate patches.
> Do you meant to have both changes on SPI core and SPI Tegra together in a=
 single patch?

You are expanding the size of the mode variable and adding a new mode in
the same patch.  These are two separate changes and should be in two
separate patches, as soon as you start writing "Also..." in a changelog
that should be a warning flag.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywTTAACgkQJNaLcl1U
h9ASVgf/YJl1oQzWArLRQHn7PzVwQ4QsUKLnP+dbbx8RWVhM93Whw0IURubE0Qkj
zHIRDTu88rSP4hQMymsqJwcN9ZSWA/QgWW/950S+kZQ23a7d2hmSfC5LEXZACawm
gJ1MFuHKf5zA1nHTeSu1aXVR6QdABMaAvu0Bk+VPplAZPuLI5k7vvLxcxGZ7G3e8
S5Xwyo3Prv9T4J8pMiD/5eg4jc/o05MTw26M2kFRE2IV9STQ25DaSIQjtMhTq8c2
kaBMQKAfEnQ+roNYcqNKMo4SPCCmNrR8MljdRf/bmIqaLIhyj9P/qRFOrjeC19eM
ELTmw4Unue23lYbVs5FVE3JuWWbQgg==
=0IqI
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
