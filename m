From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: s3c64xx: Add fix for crash in spi suspend/resume
Date: Wed, 7 Nov 2012 09:23:25 +0100
Message-ID: <20121107082324.GA12323@opensource.wolfsonmicro.com>
References: <1352268612-9671-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Cc: linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	naveenkrishna.ch@gmail.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352268612-9671-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2012 at 11:40:12AM +0530, Naveen Krishna Chatradhi wrote:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
>=20
> The SPI driver makes a gpio_request during initialization. The requested
> gpios need to be populated as part of the s3c64xx_spi_driver_data so that
> they can be released during suspend and requested again during resume.

Applied, thanks.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmhp1AAoJELSic+t+oim912cP/2QLMcOzK+yeI1jIGgJXnv88
5SsIAXEclAW/vjNhivrJ79zWawjI5W8FoojX7DC1VAlWTSeu5zwGWLJn2Ms+MPMz
YSoc5s/kjU6XpffAzL2dyEnKz+UMpaaBGWEjSMW2+VI8Z4eY/fgnB1ir/m1WA7OD
LDulATBgCup48AwMF6JzkJ5igUfHmPxAcS3OCDBZEBBMflAcljX56DsvPEOPBKJ4
EManIMVGAaWvxoJzkz6M8CvYFq1W/Mebv3VaFUCshjqeTunwPkMsMGS3eehS9Yed
0fbHVxY7pKebqmc3tMIUFdPD+cphZ0/EJ0x5/MTAbABLPkU3tCjr8DZRfuujfiRI
mBBpLywEcpqD+MKNkE/FLJ541gRXzuueiyBkJ/qme0vjUhC9UUCuBBsf+kHzplac
FQBCFBCACk0/IZTq2nXHihHrweNmECMN2WPMIJrQxCtDfsuSCZmN0ITBxUcrpFva
qos10xDTll9ypWu9R1BSi0Z/w5e3qPCNSHNjw1k/JPrnthR2B1H+YZEXOK+sfJkq
C7AWYsGMxfRHWz1pheaLRGiqtohaJSYaG/oGch0rd5jPQSXRx+X9sggDKKqremCJ
fEtG9y0rOfDDbNh1Ig533iFR4Rko02Uv0bsW3ifLQwAno4cllMhVZ9zqMbo+SEyH
qaK4FEbmnLvJP3INStyb
=31kz
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
