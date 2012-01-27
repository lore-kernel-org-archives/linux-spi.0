From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 0/2] S3C24XX: remove some spi left overs
Date: Fri, 27 Jan 2012 17:15:32 +0900
Message-ID: <01b201ccdccb$d6923680$83b6a380$%kim@samsung.com>
References: <201201082222.11305.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: =?iso-8859-1?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>,
	'Grant Likely' <grant.likely@secretlab.ca>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <201201082222.11305.heiko@sntech.de>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Heiko St=FCbner wrote:
>=20
> This series removes unused setup-code of the s3c24xx spi driver.
>=20
> It has no current in kernel users and also no development activity tr=
ying
> to change this. I also checked the upstream git of the only board inc=
luding
> the spi.h file (the gta02 at http://git.openmoko.org). The setup call=
s
> are also not used there.
>=20
> I recall a thread some time back talking about removing the spi-s3c24=
xx
> driver altogether, but as current linux-next still carries the driver
> I'm not sure what became of it. So this series does the next smaller =
thing.
>=20
>=20
> Heiko Stuebner (2):
>   S3C24XX: remove unused spi gpio setup functions
>   S3C24XX: move spi-s3c24xx platdata out of mach
>=20
>  arch/arm/mach-s3c2410/include/mach/spi.h     |   38 ----------------=
----------
>  arch/arm/mach-s3c2440/mach-gta02.c           |    2 +-
>  arch/arm/plat-s3c24xx/Kconfig                |   20 -------------
>  arch/arm/plat-s3c24xx/Makefile               |    6 ----
>  arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c |   36 ----------------=
--------
>  arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c   |   38 ----------------=
----------
>  arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c    |   36 ----------------=
--------
>  drivers/spi/spi-s3c24xx.c                    |    2 +-
>  8 files changed, 2 insertions(+), 176 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c2410/include/mach/spi.h
>  delete mode 100644 arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
>  delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c
>  delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c
>=20
> --
> 1.7.2.3

Looks good :)
Applied in my cleanup-s3c24xx, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
