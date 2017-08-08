From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v9 11/16] MIPS: lantiq: remove old reset controller implementation
Date: Wed,  9 Aug 2017 00:52:42 +0200
Message-ID: <20170808225247.32266-12-hauke@hauke-m.de>
References: <20170808225247.32266-1-hauke@hauke-m.de>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170808225247.32266-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This code is now replaced by a reset controller in drivers/reset/reset-
lantiq-rcu.c. The old code was never used anyway.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
---
 arch/mips/lantiq/xway/reset.c | 68 -------------------------------------------
 1 file changed, 68 deletions(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 2dedcf939901..5cb9309b0047 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -194,74 +194,6 @@ int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
 	return 0;
 }
 
-/* reset a io domain for u micro seconds */
-void ltq_reset_once(unsigned int module, ulong u)
-{
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | module, RCU_RST_REQ);
-	udelay(u);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~module, RCU_RST_REQ);
-}
-
-static int ltq_assert_device(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val |= BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_deassert_device(struct reset_controller_dev *rcdev,
-				  unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val &= ~BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_reset_device(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	ltq_assert_device(rcdev, id);
-	return ltq_deassert_device(rcdev, id);
-}
-
-static const struct reset_control_ops reset_ops = {
-	.reset = ltq_reset_device,
-	.assert = ltq_assert_device,
-	.deassert = ltq_deassert_device,
-};
-
-static struct reset_controller_dev reset_dev = {
-	.ops			= &reset_ops,
-	.owner			= THIS_MODULE,
-	.nr_resets		= 32,
-	.of_reset_n_cells	= 1,
-};
-
-void ltq_rst_init(void)
-{
-	reset_dev.of_node = of_find_compatible_node(NULL, NULL,
-						"lantiq,xway-reset");
-	if (!reset_dev.of_node)
-		pr_err("Failed to find reset controller node");
-	else
-		reset_controller_register(&reset_dev);
-}
-
 static void ltq_machine_restart(char *command)
 {
 	u32 val = ltq_rcu_r32(RCU_RST_REQ);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
