From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [PATCH v8 3/3] ACPI / spi: attach gpio irq from acpi description to spi device
Date: Wed, 23 Dec 2015 23:25:35 +0100
Message-ID: <1450909535-32138-4-git-send-email-christophe-h.ricard@st.com>
References: <1450909535-32138-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com, broonie@kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1450909535-32138-1-git-send-email-christophe-h.ricard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spi->irq was ignoring GpioInt property setting it to -1.
acpi_dev_gpio_irq_get returns and configure the slave irq according to
the acpi slave node description.
It is now inline with devicetree behavior.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2b0a8ec..f1723bb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1623,6 +1623,9 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
 		return AE_OK;
 	}
 
+	if (spi->irq < 0)
+		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
+
 	adev->power.flags.ignore_parent = true;
 	strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
 	if (spi_add_device(spi)) {
-- 
2.1.4

