From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: [PATCH v3 2/6] regmap: Add support for device with 24 data bits.
Date: Thu, 15 Mar 2012 07:43:06 +1100
Message-ID: <1331757790-10583-3-git-send-email-marc@cpdesign.com.au>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1331757790-10583-1-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add support for devices with 24 data bits.

Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
---
 drivers/base/regmap/regmap.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 62ef0df..880e3a0 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -122,6 +122,15 @@ static void regmap_format_16(void *buf, unsigned int val)
 	b[0] = cpu_to_be16(val);
 }
 
+static void regmap_format_24(void *buf, unsigned int val)
+{
+	u8 *b = buf;
+
+	b[0] = val >> 16;
+	b[1] = val >> 8;
+	b[2] = val;
+}
+
 static unsigned int regmap_parse_8(void *buf)
 {
 	u8 *b = buf;
@@ -138,6 +147,16 @@ static unsigned int regmap_parse_16(void *buf)
 	return b[0];
 }
 
+static unsigned int regmap_parse_24(void *buf)
+{
+	u8 *b = buf;
+	unsigned int ret = b[2];
+	ret |= ((unsigned int)b[1]) << 8;
+	ret |= ((unsigned int)b[0]) << 16;
+
+	return ret;
+}
+
 /**
  * regmap_init(): Initialise register map
  *
@@ -240,6 +259,10 @@ struct regmap *regmap_init(struct device *dev,
 		map->format.format_val = regmap_format_16;
 		map->format.parse_val = regmap_parse_16;
 		break;
+	case 24:
+		map->format.format_val = regmap_format_24;
+		map->format.parse_val = regmap_parse_24;
+		break;
 	}
 
 	if (!map->format.format_write &&
-- 
1.7.3.4


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
