From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drivers: spi: Allocate bus number from spi framework
Date: Fri, 18 Aug 2017 12:15:29 +0100
Message-ID: <20170818111529.hmofc2eawwbl33t3@sirena.org.uk>
References: <1503035020-4347-1-git-send-email-sunil.m@techveda.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtkfmnriwsypfz6g"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        karthik@techveda.org
To: sunil.m@techveda.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503035020-4347-1-git-send-email-sunil.m@techveda.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--dtkfmnriwsypfz6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 11:13:40AM +0530, sunil.m@techveda.org wrote:
> From: Suniel Mahesh <sunil.m@techveda.org>
>=20
> spi framework should allocate bus number dynamically either
> via Linux IDR or spi alias for master drivers. This patch deletes
> code pertaining to manual allocation of spi bus number in spi omap2
> master driver.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--dtkfmnriwsypfz6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmWzFEACgkQJNaLcl1U
h9Dx8wf+Lb3/fJsJuR64at7LERphkwdzimdD+/rvbz0taOLQjiSZyAuYWiWFaJio
R508KAoswVrBqZ+flRpVRIIUgrKrDq+q8H0Dm84060NKsDQ0nZiscjVTBOMoICZJ
FGXtEyUTaTWzc2dlMQoZ1mZXlqTeSGF4zdqJDkCTDtBBjWd1QXDG9z54QzXNxvrU
ZRXiAopYF9cvjZcS4Mm/UQ4mPY02k+WicQtF+SqAYJQmFMvPJxCqkutjZ/WJBQu7
86srSRgpcq3qSTtYKVFev88WuX9ZWczBYcUW2FnxKZU4UyYl+k4xdACDsjkn6zjk
vn+jy9DXG6MT6BUZJTOZwlKfSL+9wA==
=a7Ha
-----END PGP SIGNATURE-----

--dtkfmnriwsypfz6g--
