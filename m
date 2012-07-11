From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 5/6] spi: s3c64xx: Remove the 'set_level' callback
 from controller data
Date: Wed, 11 Jul 2012 12:47:17 +0100
Message-ID: <20120711114716.GF3938@opensource.wolfsonmicro.com>
References: <CAJuYYwSi-1nBM40SWt359W0Lr2n_yVX5tvWfOS77bmLQRt_9fw@mail.gmail.com>
 <1342005359-748-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342005359-748-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2012 at 04:45:59PM +0530, Thomas Abraham wrote:
> The set_level callback in the controller data, which is used to configure
> the slave select line, cannot be supported when migrating the driver to
> device tree based discovery. Since all the platforms currently use gpio
> as the slave select line, this callback can be removed from the
> controller data and replaced with call to gpio_set_value in the driver.

I don't seem to have patches 1-4?

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/WeRAAoJEBus8iNuMP3dGwEQAJeFvttWX9MTCOa3HcGGlyiI
ECBDv8UK64zxyeGyy1gxjSMDuPdAlszLOMvv+/Eh6H1Ge5AXvAWy2BMfb5p706OD
v82ii5gDymdoYiSESmA7oGkEinvWYnZuNKZoU5du4ShFOVIAWvdcqBPGjVrzsl5H
stQqXl8tmzT3BvSUhy3ey4Q7ZTU7e6rB1rCNvYBWvM+bE+ZFP2kJnYpgpfFJBtqT
6JVgdx3WELJCYTsIw9kyCCllC5GOx8DKA7bt89ZESkxhcCojkZfMBnk+dcfSGDu/
TkfT/iGrFBkwT3Sa9k04xFnAYIto2e4/NTgpIp1w0YiedE9Pi/UOKMGEijbrwMdD
EjlFurIyiIjdYxcLVwpqnarZFcRgNB3uLqqWerK8thU27/NnjmEy4+QdE8fpm69a
/KUXVLBxms+rTVb34aLOsKjGxPaBSOCg29wmHCSTFTdKp/5uOy9Ogt2oafORuyyM
bUCv2Wie8uUdyG+8a7aEdxNbz6JOAfUADJ8y7fxb0K+sTZn0c7AnXQqpIehE89Lw
NwZZgF+/sB4t4Xtkjfgd4lB15wT6Vd5qd8cAHE/ql+WUTYEg+rOrfOK7n1CyAipd
uVYVhox7JTi82d0PFPb2/etLTm5vL4d27e6kCnuZVw/xH7CjphecFXP1r8X3SBIR
bo0clLqy4JiM0Kkfdkif
=FGys
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
