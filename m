From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 14/14] spi/of: Add OF notifier handler
Date: Mon, 24 Nov 2014 22:33:42 +0000
Message-ID: <1416868422-22103-15-git-send-email-grant.likely@linaro.org>
References: <1416868422-22103-1-git-send-email-grant.likely@linaro.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416868422-22103-1-git-send-email-grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Add OF notifier handler needed for creating/destroying spi devices
according to dynamic runtime changes in the DT live tree. This code is
enabled when CONFIG_OF_DYNAMIC is selected.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Signed-off-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
---
 drivers/spi/spi.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a3557c57d4f7..bf1cab0fad66 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2317,6 +2317,86 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 
 /*-------------------------------------------------------------------------*/
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+static int __spi_of_device_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+/* must call put_device() when done with returned spi_device device */
+static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
+{
+	struct device *dev = bus_find_device(&spi_bus_type, NULL, node,
+						__spi_of_device_match);
+	return dev ? to_spi_device(dev) : NULL;
+}
+
+static int __spi_of_master_match(struct device *dev, const void *data)
+{
+	return dev->of_node == data;
+}
+
+/* the spi masters are not using spi_bus, so we find it with another way */
+static struct spi_master *of_find_spi_master_by_node(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = class_find_device(&spi_master_class, NULL, node,
+				__spi_of_master_match);
+	if (!dev)
+		return NULL;
+
+	/* reference got in class_find_device */
+	return container_of(dev, struct spi_master, dev);
+}
+
+static int of_spi_notify(struct notifier_block *nb, unsigned long action,
+			 void *arg)
+{
+	struct of_reconfig_data *rd = arg;
+	struct spi_master *master;
+	struct spi_device *spi;
+
+	switch (of_reconfig_get_state_change(action, arg)) {
+	case OF_RECONFIG_CHANGE_ADD:
+		master = of_find_spi_master_by_node(rd->dn->parent);
+		if (master == NULL)
+			return NOTIFY_OK;	/* not for us */
+
+		spi = of_register_spi_device(master, rd->dn);
+		put_device(&master->dev);
+
+		if (IS_ERR(spi)) {
+			pr_err("%s: failed to create for '%s'\n",
+					__func__, rd->dn->full_name);
+			return notifier_from_errno(PTR_ERR(spi));
+		}
+		break;
+
+	case OF_RECONFIG_CHANGE_REMOVE:
+		/* find our device by node */
+		spi = of_find_spi_device_by_node(rd->dn);
+		if (spi == NULL)
+			return NOTIFY_OK;	/* no? not meant for us */
+
+		/* unregister takes one ref away */
+		spi_unregister_device(spi);
+
+		/* and put the reference of the find */
+		put_device(&spi->dev);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block spi_of_notifier = {
+	.notifier_call = of_spi_notify,
+};
+#else /* IS_ENABLED(CONFIG_OF_DYNAMIC) */
+extern struct notifier_block spi_of_notifier;
+#endif /* IS_ENABLED(CONFIG_OF_DYNAMIC) */
+
 static int __init spi_init(void)
 {
 	int	status;
@@ -2334,6 +2414,10 @@ static int __init spi_init(void)
 	status = class_register(&spi_master_class);
 	if (status < 0)
 		goto err2;
+
+	if (IS_ENABLED(CONFIG_OF))
+		WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));
+
 	return 0;
 
 err2:
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
