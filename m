From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 1/3] acpi: Rename acpi_gsi_get_irq_type to acpi_dev_get_irq_type and export symbol
Date: Sun, 13 Dec 2015 12:15:53 +0100
Message-ID: <1450005355-6633-2-git-send-email-christophe-h.ricard@st.com>
References: <1450005355-6633-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450005355-6633-1-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

acpi_gsi_get_irq_type could be use out of gsi purpose.

Rename and make it available as a resource function.

Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
---
 drivers/acpi/gsi.c      | 21 +--------------------
 drivers/acpi/resource.c | 26 ++++++++++++++++++++++++++
 include/linux/acpi.h    |  1 +
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index fa4585a..ee9e0f2 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -17,25 +17,6 @@ enum acpi_irq_model_id acpi_irq_model;
 
 static struct fwnode_handle *acpi_gsi_domain_id;
 
-static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
-{
-	switch (polarity) {
-	case ACPI_ACTIVE_LOW:
-		return trigger == ACPI_EDGE_SENSITIVE ?
-		       IRQ_TYPE_EDGE_FALLING :
-		       IRQ_TYPE_LEVEL_LOW;
-	case ACPI_ACTIVE_HIGH:
-		return trigger == ACPI_EDGE_SENSITIVE ?
-		       IRQ_TYPE_EDGE_RISING :
-		       IRQ_TYPE_LEVEL_HIGH;
-	case ACPI_ACTIVE_BOTH:
-		if (trigger == ACPI_EDGE_SENSITIVE)
-			return IRQ_TYPE_EDGE_BOTH;
-	default:
-		return IRQ_TYPE_NONE;
-	}
-}
-
 /**
  * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
  * @gsi: GSI IRQ number to map
@@ -82,7 +63,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 
 	fwspec.fwnode = acpi_gsi_domain_id;
 	fwspec.param[0] = gsi;
-	fwspec.param[1] = acpi_gsi_get_irq_type(trigger, polarity);
+	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
 	return irq_create_fwspec_mapping(&fwspec);
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 15d22db..521b5ac 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -23,6 +23,7 @@
 #include <linux/export.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #ifdef CONFIG_X86
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
@@ -333,6 +334,31 @@ unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_irq_flags);
 
+/**
+ * acpi_dev_get_irq_type - Determine irq type.
+ * @triggering: Triggering type as provided by ACPI.
+ * @polarity: Interrupt polarity as provided by ACPI.
+ */
+unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
+{
+	switch (polarity) {
+	case ACPI_ACTIVE_LOW:
+		return triggering == ACPI_EDGE_SENSITIVE ?
+		       IRQ_TYPE_EDGE_FALLING :
+		       IRQ_TYPE_LEVEL_LOW;
+	case ACPI_ACTIVE_HIGH:
+		return triggering == ACPI_EDGE_SENSITIVE ?
+		       IRQ_TYPE_EDGE_RISING :
+		       IRQ_TYPE_LEVEL_HIGH;
+	case ACPI_ACTIVE_BOTH:
+		if (triggering == ACPI_EDGE_SENSITIVE)
+			return IRQ_TYPE_EDGE_BOTH;
+	default:
+		return IRQ_TYPE_NONE;
+	}
+}
+EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
+
 static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
 {
 	res->start = gsi;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d863e12..c14db41 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -299,6 +299,7 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
 					 struct resource_win *win);
 unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
+unsigned int acpi_dev_get_irq_type(int triggering, int polarity);
 bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 				 struct resource *res);
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
