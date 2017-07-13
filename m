From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 3/6] ACPI / property: Don't evaluate objects for devices
 w/o handle
Date: Fri, 14 Jul 2017 00:36:19 +0200
Message-ID: <5bb94a3e70e38b5a40933878dc52d8b5deeb6ae6.1499983092.git.lukas@wunner.de>
References: <cover.1499983092.git.lukas@wunner.de>
Cc: Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1499983092.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fabricated devices such as LNXPWRBN lack a handle, causing evaluation
of _CCA and _DSD to always fail with AE_BAD_PARAMETER.  While that is
merely a (negligible) waste of processing power, evaluating a _DSM for
them (such as Apple's device properties _DSM which we're about to add)
results in an ugly error:

    ACPI: \: failed to evaluate _DSM (0x1001)

Avoid by not evaluating _DSD and the upcoming _DSM for devices without
handle.

Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
 drivers/acpi/property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 9364398204e9..27a9294c843c 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -338,6 +338,9 @@ void acpi_init_properties(struct acpi_device *adev)
 
 	INIT_LIST_HEAD(&adev->data.subnodes);
 
+	if (!adev->handle)
+		return;
+
 	/*
 	 * Check if ACPI_DT_NAMESPACE_HID is present and inthat case we fill in
 	 * Device Tree compatible properties for this device.
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
