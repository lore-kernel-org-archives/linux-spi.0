From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: s3c64xx: move to generic dmaengine API
Date: Wed, 17 Apr 2013 15:46:37 +0100
Message-ID: <20130417144637.GW13687@opensource.wolfsonmicro.com>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-30-git-send-email-arnd@arndb.de>
 <20130411165536.GO9243@opensource.wolfsonmicro.com>
 <201304112242.03252.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7rykKtsZvepKFKR"
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	Padma Venkat <padma.kvr@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201304112242.03252.arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--c7rykKtsZvepKFKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2013 at 10:42:03PM +0200, Arnd Bergmann wrote:
> The spi-s3c64xx uses a Samsung proprietary interface for
> talking to the DMA engine, which does not work with
> multiplatform kernels.

Actually it seems that this patch is causing issues for bulk SPI
transfers on s3c64xx, especially when they're driven quickly one after
another.  I've only just found the problem so I've not been able to
debug yet but a revert fixes it...

--c7rykKtsZvepKFKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbrXEAAoJELSic+t+oim99AAP/RdAeszwwW1PpsUnQSv2oCKj
xFmUUIhOsZLWes0/FutEIZiriu5OOXpjsUnF8efnOw82uz4W68IHlyKDwKmjTluN
Af2azRFigkd7L4BLJpBl5M9Q1uBJ4oXAw3Z/FtSPGDT7a5hkH0+DU4MYLCV2vRp0
dKI8AD0B2jQL0HrEShnFpYw2NulgzMemrWcK8hDZU4Ya4AdRxue2bBfoO4+utkBJ
vZndujoun+YHymAYbO2+oZx0SeCkRZWzd9V05QWhqkGpMFIZIWhviFOrip0ajYFy
B+47dJWHPqxifui0Ni0Q64j7XUxjzfpQvdsypX1Wl5PQYQW/DFqqOSwbQHFhOY1v
4849GsKs1yzy10VHQ6sKJiTwq8148+KPrTL9EIZtL5s65pqM5uH4TF27R1eOsS+a
w2UvIWE5rjWnCVGUm3HiTF4pbhnXq3s1C7CZBZeaFv9+cTf9bQ8BXzaJCScyDoMe
yYSIjxq5N6hURl9WyOMtY5YejO7ERIvHpxZc1JkY1PnLUXyc9+vkUBNU3KTVDL2j
Q3OM7q4gMARrqj+k5weK15E2eq1AFKarpLK8mWFj8frOLW6ZysMQOufNSqOoibZV
/yfcT0s2+NiGSXCN13nt2QOyUIkZn6/JZsRtE6lUzUJDyLbB5O1zohd2xd//WtFz
pjNsLG2usYvdWS+ps9iM
=roxK
-----END PGP SIGNATURE-----

--c7rykKtsZvepKFKR--
