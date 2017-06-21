From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/3] ACPI / property: Don't evaluate objects for devices w/o
 handle
Date: Wed, 21 Jun 2017 20:05:53 +0200
Message-ID: <6bb1bb5ed13c03610da3458c35c3a658f868019b.1498044532.git.lukas@wunner.de>
References: <cover.1498044532.git.lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1498044532.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fabricated devices such as LNXPWRBN lack a handle, causing evaluation
of _CCA and _DSD to always fail with AE_BAD_PARAMETER.  While that is
merely a (negligible) waste of processing power, evaluating a _DSM for
them (such as Apple's device properties _DSM which we're about to add)
results in an ugly error:

    ACPI: \: failed to evaluate _DSM (0x1001)

Avoid by not evaluating _DSD and the upcoming _DSM for devices without
handle.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
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

