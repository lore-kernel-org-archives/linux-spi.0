From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] spi: s3c64xx: Patch set to fix and simplify the s3c64xx
 driver
Date: Tue, 18 Aug 2015 23:03:58 +0200
Message-ID: <55D39DBE.4050207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch set fixes and simplifies the s3c64xx driver.
Tested on a Odroid XU4 (Exynos 5422 based).

Heiner Kallweit (3):
  spi: s3c64xx: simplify probe function by using local variable for &pdev->dev
  spi: s3c64xx: fix runtime PM handling
  spi: s3c64xx: simplify suspend/resume handlers

 drivers/spi/spi-s3c64xx.c | 84 ++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
