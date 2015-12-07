From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 3/3] ACPI / spi: attach gpio irq from acpi description to spi device
Date: Mon,  7 Dec 2015 23:39:12 +0100
Message-ID: <1449527952-8399-4-git-send-email-christophe-h.ricard@st.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449527952-8399-1-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi->irq was ignoring GpioInt property setting it to -1.
acpi_dev_gpio_irq_get returns and configure the slave irq  according to
the acpi slave node description.
It is now inline with devicetree behavior.

Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a5f53de..5c10815 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1534,7 +1534,7 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
 	}
 
 	ACPI_COMPANION_SET(&spi->dev, adev);
-	spi->irq = -1;
+	spi->irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&spi->dev), 0);
 
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
