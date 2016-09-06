From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 04/18] spi: fsl-espi: pre-allocate message buffer
Date: Tue, 6 Sep 2016 11:58:33 +0100
Message-ID: <20160906105833.GL3950@sirena.org.uk>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <cabc3522-8ca9-516a-e0ef-5a2ed9ad8507@gmail.com>
 <0e60b4b5-5016-e1c3-d29d-b81a41f64f48@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgiPvHqStUXOBTSF"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0e60b4b5-5016-e1c3-d29d-b81a41f64f48-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mgiPvHqStUXOBTSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 04, 2016 at 09:58:02AM +0200, Heiner Kallweit wrote:
> Currently the driver allocates a 64kb buffer with each single message.
> On systems with little and fragmented memory this can result in
> memory allocation errors. Solve this by pre-allocating a buffer.
>=20
> This patch was developed in OpenWRT long ago, however it never
> made it upstream. Author: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
>=20
> I slightly modified the original patch to re-initialize the buffer
> at the beginning of each transfer.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

When you sent this previously I asked what happened with the signoff
=66rom Gabor.  A little Google tells me that he did in fact sign off the
copy that's in OpenWRT.  Please don't drop signoffs, they're important
for tracking licensing - see SubmittingPatches for details.  If the
modifications you made really are slight as you say then I'd also expect
Gabor's authorship to be preserved.

--mgiPvHqStUXOBTSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzqFYAAoJECTWi3JdVIfQKUEIAIHpLgQ9hXHiWrSg0l8PpCPr
1YM21GGnOLsODApx1WEVBMwfLHbr36FYMGE5C+0kMHssTqKQ16uBIWunIBuCuXsu
P0f5fFTD7Mex55mCihH3AKPnU79BBQ6sI1wGyqsZVGQ77XH715Iap8G4/n8scFcm
yam/19oyPVqLRQHDB27m5esPcltcrKR1NcuAloypNjER5Fq8a6gy1zT1J/cb3RHi
VaBzd5fFpt7MmpueJJA0R+TAg6S+qb/yGJ9c+smLvQwJwyc3mMC/WsoYLZMVrZqv
m9vY4wTxLAjtZX8pMaCyREFn0tdyB5KZuC4SDpfkrAlr/iHu1bKAOFLIYwo0Im4=
=oIu1
-----END PGP SIGNATURE-----

--mgiPvHqStUXOBTSF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
