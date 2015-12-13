From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH] spi: Add builtin_spi_driver() to avoid registration boilerplate
Date: Sun, 13 Dec 2015 15:53:57 -0500
Message-ID: <1450040037-28334-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
better support builtin boilerplate avoidance") we introduced the
builtin_driver macro.

Here we use that support and extend it to SPI driver registration, so where
a driver is clearly non-modular and builtin-only, we can register it in a
similar fashion.  Existing code that is clearly non-modular can be updated
with the simple mapping of

  module_spi_driver(...)  ---> builtin_spi_driver(...)

We've essentially cloned the former to make the latter, and taken out the
remove/module_exit parts since those never get used in a non-modular build
of the code.

A similar thing was done in commit b4eb6cdbbd13698704863f680c643c569909e1c2
("PCI: Add builtin_pci_driver() to avoid registration boilerplate").

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---

[I've a drivers/video user of this in my personal testing queue, but
 obviously I can't submit that until builtin_spi_driver makes it to
 mainline.  Since there are no drivers/spi users of it (yet), this
 change is sent to the spi list/maintainers on its own.]

 include/linux/spi/spi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 075bede66521..1458f2f21dcc 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -272,6 +272,17 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 	__spi_register_driver(THIS_MODULE, driver)
 
 /**
+ * builtin_spi_driver() - Helper macro for registering a SPI driver
+ * @__spi_driver: spi_driver struct
+ *
+ * Helper macro for SPI drivers which do not do anything special in
+ * init. This eliminates a lot of boilerplate. Each file may only
+ * use this macro once, and calling it replaces device_initcall()
+ */
+#define builtin_spi_driver(__spi_driver) \
+	builtin_driver(__spi_driver, spi_register_driver)
+
+/**
  * module_spi_driver() - Helper macro for registering a SPI driver
  * @__spi_driver: spi_driver struct
  *
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
