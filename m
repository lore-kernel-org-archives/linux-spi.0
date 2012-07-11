From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
Date: Wed, 11 Jul 2012 18:49:08 +0100
Message-ID: <20120711174908.GP3938@opensource.wolfsonmicro.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mh8CTEa8Ax54aLHp"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Mh8CTEa8Ax54aLHp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2012 at 09:10:59PM +0530, Thomas Abraham wrote:
> Changes since v4:
> - Includes the missing gpio request for slave select line gpio as suggested
>   by Mark Brown.

These looked OK (and have had quite a bit of review already so we're
probably at the stage where incremental fixes are better anyway) so I
tried to apply them but git am was really unhappy.  I tried applying on

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git spi-next

and -next.  Can you check what's going on here please?

--Mh8CTEa8Ax54aLHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/bxPAAoJEBus8iNuMP3dP44QAI9J1+Tt8gqbU7Atn2qKaCj5
D45FKskEpqQfK3yjtDT5GGRiWXcQd60rAe4eza8HYe2Se2FP6OZvV+OWRzuaCmUK
DNG5rHF7Qzvbs2UZlYumK9tl/8IcItOushKmn+QDGGXoxhWKfXnagvvQbICHzHsl
tgxtCUa7QIBWRVK2X9LyBFSAhnvZtQOyWfPcJrYREtD2oGYwAfDQhj8i3/Xc+gNH
sm8I57gTgwmrU5Q2tLMHq/kNz7PhIFylhfav/hSyT3eqERqKHOVk1pYHQxZtXQrQ
RRQ3hOc99Mgh8Hbp4H0DBI5kzOPGWvVOd5Ni1x6wyBMUqu/y6rpjMfLhePAQzsz2
AqnEtl8HOOduXc+jbluj52p3gg7MUjzjtdQ8Bk22Ozq8x0DWwq4meRyYjlEEqjCa
InXsvmq6YdRupoqdLTJ7aLs8KmPVSmaLOUyhp7Yync71R2MCXhT/8eLNYmGwlYaL
6JRrHH5ADDuVWpvY8TbEMg0oiIVrHtIeQmK/4fHprMzq5gqpAyyhbVTS4pTt+be8
ofPrnrUVPLH8oMn+8ovYnnf2/xpxB9RzVjos1qzitszzaoJCrem1dOQqf9Vl9jao
W8BYQ1c6rRdjxukKZm1fohvNwdbSGbGui9AGZ+ug46QtdNxugwtWu+6oC1O064DH
AKJvmVKDAT6uoKD8CKy0
=CRiw
-----END PGP SIGNATURE-----

--Mh8CTEa8Ax54aLHp--
