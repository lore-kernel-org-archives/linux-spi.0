From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spidev: Enable the Liebherr's BK4 board to work with
 spidev driver
Date: Tue, 2 Oct 2018 14:09:50 +0100
Message-ID: <20181002130950.GB6338@sirena.org.uk>
References: <20180927223152.24990-1-lukma@denx.de>
 <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
 <20181001142219.GB19099@sirena.org.uk>
 <20181002101120.0f92f296@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002101120.0f92f296@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 10:11:20AM +0200, Lukasz Majewski wrote:

> > As documented in SubmittingPatches please send patches to the=20
> > maintainers for the code you would like to change.=20

> I'm using the ./scripts/get_maintainer.py script to obtain list of
> relevant people.

Your patch went to the right place (and I applied it yesterday), that
was directed at Jan - the reason his patch got missed is that he didn't
send it to me.

> Please also document in the ./Documentation/devicetree the introduced
> compatible -> there are some examples (ge,ahca) in the misc directory.

Good point.

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluzbh0ACgkQJNaLcl1U
h9CCLAf+O8ovcnyt7n217i3PNbpBCy2tXuBEjw9QNZgqhrb5w4odEBh1nvZqHnH5
N0Eh0Ym6BFKxJoNu9u9478neqSNOo7EIy+jMOQ3JYRLDiuzmMRBz6KMeSpE5LqZm
PGt9xy4D1XwuCj1qLdjN875BIqS2gWAsbQUXFbVw7Bk8R0JTwjHb6A2w05lhu2nD
zCI9Hpzcqe0MzQAsQqvg1DVAXUNFBcI1vVdIFqBxDfjoCrAhM4dPgLAx3CteU1gt
xl7/uUCVEtnThIjp21wvaqs8rdsP0nWZDJULMLj+XfHxD5htLeep6MRbo8jFDttl
eFwV0QBMtC4i3Efe1+InfR9K+7mnUQ==
=mBMW
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
