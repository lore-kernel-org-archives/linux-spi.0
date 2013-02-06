From: Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
Subject: [PATCH 1/2] gpio: mcp23s08: Allow -1 as a legal value for global gpio
	base
Date: Wed,  6 Feb 2013 18:01:57 +0100
Message-ID: <1360170118-11937-2-git-send-email-larsi@wh2.tu-dresden.de>
References: <1360170118-11937-1-git-send-email-larsi@wh2.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1360170118-11937-1-git-send-email-larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>

Explicitly allow -1 as a legal value for the
mcp23s08_platform_data->base. This is the special value lets the
kernel choose a valid global gpio base number.

Signed-off-by: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
---
 drivers/gpio/gpio-mcp23s08.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mcp23s08.c b/drivers/gpio/gpio-mcp23s08.c
index 3cea0ea..2afb828 100644
--- a/drivers/gpio/gpio-mcp23s08.c
+++ b/drivers/gpio/gpio-mcp23s08.c
@@ -483,7 +483,7 @@ static int mcp230xx_probe(struct i2c_client *client,
 	int status;
 
 	pdata = client->dev.platform_data;
-	if (!pdata || !gpio_is_valid(pdata->base)) {
+	if ((!pdata || !gpio_is_valid(pdata->base)) && pdata->base != -1) {
 		dev_dbg(&client->dev, "invalid or missing platform data\n");
 		return -EINVAL;
 	}
@@ -570,7 +570,7 @@ static int mcp23s08_probe(struct spi_device *spi)
 	type = spi_get_device_id(spi)->driver_data;
 
 	pdata = spi->dev.platform_data;
-	if (!pdata || !gpio_is_valid(pdata->base)) {
+	if ((!pdata || !gpio_is_valid(pdata->base)) && pdata->base != -1) {
 		dev_dbg(&spi->dev, "invalid or missing platform data\n");
 		return -EINVAL;
 	}
-- 
1.7.10.4


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
