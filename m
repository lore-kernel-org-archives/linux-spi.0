From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Date: Thu, 19 Sep 2019 14:31:13 +0100
Message-ID: <20190919133113.GK3642@sirena.co.uk>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 09:04:32AM +0100, Gareth Williams wrote:

> Gareth Williams (1):
>   dt-bindings: snps,dw-apb-ssi: Add optional clock domain information
>=20
> Phil Edworthy (3):
>   dt: spi: Add Renesas RZ/N1 binding documentation

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.  This isn't
even consistent within the series :(

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DgyEACgkQJNaLcl1U
h9CySAgAgDnSgZkYFNYM2rEOjD3mK2F8DU/d10qh1tJqQkX5Fo7DqE0mxuvcJfAM
kdtdWxCG5DRh2q3iM2T7k20iU9tQOjiW3E0dL4W4pUSObgat68DxlTXe2ag/fntc
VwC6D1+AIoNFnOXTYKYPt8Pp+NqBlgNxHByHW7KXxbbSDgslBZESYG9fLQBf+KJ/
FrMgo8aRnez6Sv1adY2aCSGwZxK643tL5ZgVBdv3+KjObqdlSex4EbphqkEO8mVY
eoGKz7X3EDv/IeJfHNoy3O3Y3w064iEnv8ioO6+XTKDiVkntQV1xxmDjnQs6fNy/
A5PqKEMRpy36c5gNU3JP9C72+3PjxA==
=73/l
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
