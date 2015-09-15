From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 07/16] spi: mpc512x: Call mpc512x_psc_spi_transfer_setup() unconditionally
Date: Tue, 15 Sep 2015 16:26:19 +0300
Message-ID: <1442323588-29642-7-git-send-email-jarkko.nikula@linux.intel.com>
References: <1442323588-29642-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core validates both bits_per_word and speed_hz transfer parameters and
thus the if statement here is needless as it will always call the
mpc512x_psc_spi_transfer_setup().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 1e75341689a6..c3ec46cd9f91 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -302,11 +302,9 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 	cs_change = 1;
 	status = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			status = mpc512x_psc_spi_transfer_setup(spi, t);
-			if (status < 0)
-				break;
-		}
+		status = mpc512x_psc_spi_transfer_setup(spi, t);
+		if (status < 0)
+			break;
 
 		if (cs_change)
 			mpc512x_psc_spi_activate_cs(spi);
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
