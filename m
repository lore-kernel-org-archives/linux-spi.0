From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v2] spi: s3c64xx: fix inconsistency between binding and driver
Date: Fri, 10 Feb 2017 11:20:19 +0900
Message-ID: <20170210022019.12340-1-andi.shyti@samsung.com>
References: <CGME20170210022028epcas1p11030d5037df9f9f43f20ea3e2e22be84@epcas1p1.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andi Shyti <andi.shyti@samsung.com>,
        Andi Shyti <andi@etezian.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Commit a92e7c3d82a1 ("spi: s3c64xx: consider the case when the CS
line is not connected") introduced an inconsistency between the
binding, where the disconnected CS line was marked as
'no-cs-readback', and the driver.

The driver is erroneously checking for that attribute with
property name of 'broken-cs'.

Check for 'no-cs-readback' in the driver as well.

Fixes: a92e7c3d82a1 ("spi: s3c64xx: consider the case when the CS line is not connected")
Cc: <stable@vger.kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changelog v1 -> v2
==================
v2: https://marc.info/?l=linux-kernel&m=148645493529741&w=2

- added more tags (Cc to stable, Fixes and Krzysztof's review)
- reworded the commit to make it more clear where the error lays

 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b8cd356d8d10..b392cca8fa4f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -969,7 +969,7 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		sci->num_cs = temp;
 	}
 
-	sci->no_cs = of_property_read_bool(dev->of_node, "broken-cs");
+	sci->no_cs = of_property_read_bool(dev->of_node, "no-cs-readback");
 
 	return sci;
 }
-- 
2.11.0
