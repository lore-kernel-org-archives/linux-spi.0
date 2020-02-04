From: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] spi: spi-geni-qcom: Let firmware specify irq trigger flags
Date: Tue,  4 Feb 2020 11:12:04 -0800
Message-ID: <20200204191206.97036-2-swboyd@chromium.org>
References: <20200204191206.97036-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200204191206.97036-1-swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
should take care of this for us. Just use 0 instead so that we use the
flags from the firmware.

Cc: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-geni-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f3d64a1a2b3..46e501fc87f3 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -585,8 +585,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	ret = request_irq(mas->irq, geni_spi_isr,
-			IRQF_TRIGGER_HIGH, "spi_geni", spi);
+	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(&pdev->dev), spi);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-- 
Sent by a computer, using git, on the internet
