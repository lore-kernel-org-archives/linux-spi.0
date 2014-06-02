From: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] clkdev: Export clk_register_clkdev
Date: Tue,  3 Jun 2014 03:46:19 +0800
Message-ID: <1401738379-4107-3-git-send-email-chiau.ee.chew@intel.com>
References: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
Cc: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401738379-4107-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Allow spi-pxa2xx-pci with common clock framework support to build as a
module by exporting clk_register_clkdev.

Signed-off-by: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/clk/clkdev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index a360b2e..bb48348 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -310,6 +310,7 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 
 	return 0;
 }
+EXPORT_SYMBOL(clk_register_clkdev);
 
 /**
  * clk_register_clkdevs - register a set of clk_lookup for a struct clk
-- 
1.7.4.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
