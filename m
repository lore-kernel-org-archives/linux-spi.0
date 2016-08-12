From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/PROTO 7/9 option 2] spi: sh-msiof: Configure MSIOF parent clock
Date: Fri, 12 Aug 2016 18:38:43 +0200
Message-ID: <1471019925-29083-8-git-send-email-geert+renesas@glider.be>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471019925-29083-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Change the clock rate in spi_master.setup() to accomodate the desired
maximum clock rate for the device being set up:
  - Change the clock rate if the msiofX (and thus mso) clock rate is too
    high.  Failure to do so is considered an error.
  - Try to change the clock rate if the msiofX (and thus mso) clock rate
    is too low to achieve the desired performance. Failure to do so is
    not considered an error, as the device will still work, but slower.

Results (sequential operations during probing):
  1. msiof0 (and mso) set to 30.8 MHz, 15.4 MHz after internal
     divider,
  2. msiof2 kept at 30.8 MHz, 993 kHz after internal divider,
  3. msiof3 (and mso) set to 20 MHz, 19.5 kHz after internal divider.

Observations:
  - As the requested rate of 30 MHz is rounded to 30.8 MHz, which is
    higher than 30 MHz, an mso internal divider of 2 is used, leading to
    a much lower rate of 15.4 MHz, and thus lower performance than
    expected.
  - The parent clock frequency cannot be changed while the mso clock is
    enabled. This is tricky, as the MSIOF modules are part of a Clock
    Domain, hence their clocks (and its parent clock) are under control
    of Runtime PM.
    So the parent clock may still be enabled due to asynchronous
    runtime-suspend not having disabled it yet, causing clk_set_rate()
    to fail sometimes with -EBUSY.

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
Not intended for upstream merge.
---
 drivers/spi/spi-sh-msiof.c | 74 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 656eaa4d03ed497b..0b69643936cdb941 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -584,7 +584,8 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 	struct device_node	*np = spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
 	u32 max_speed_hz, min_speed_hz;
-	unsigned long rate;
+	unsigned long rate, req_rate;
+	int error;
 
 	rate = clk_get_rate(p->clk);
 	max_speed_hz = rate;
@@ -594,6 +595,77 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		 "%s: master speed min %u max %u, device speed max = %u\n",
 		 __func__, min_speed_hz, max_speed_hz, spi->max_speed_hz);
 
+	if (spi->max_speed_hz < min_speed_hz) {
+		dev_err(&p->pdev->dev,
+			"Parent clock rate %lu too high for %u!\n", rate,
+			spi->max_speed_hz);
+
+		req_rate = spi->max_speed_hz * MAX_DIV;
+
+		error = clk_set_rate(p->clk, req_rate);
+		if (error) {
+			dev_err(&p->pdev->dev,
+				"Failed to set parent clock rate to %lu: %d\n",
+				req_rate, error);
+			return error;
+		}
+
+		rate = clk_get_rate(p->clk);
+		dev_info(&p->pdev->dev,
+			 "Changed parent clock rate to %lu actual %lu\n",
+			 req_rate, rate);
+
+		max_speed_hz = rate;
+		min_speed_hz = rate / MAX_DIV;
+
+		dev_info(&p->pdev->dev,
+			 "%s: new master speed min %u max %u, device speed max = %u\n",
+			 __func__, min_speed_hz, max_speed_hz,
+			 spi->max_speed_hz);
+
+		if (spi->max_speed_hz < min_speed_hz) {
+			dev_err(&p->pdev->dev,
+				"New parent clock rate %lu too high for %u!\n",
+				rate, spi->max_speed_hz);
+			return -EINVAL;
+		}
+	} else if (spi->max_speed_hz * 4 > max_speed_hz * 5) {
+		/* More than 20% lower than desired */
+		dev_warn(&p->pdev->dev,
+			 "Parent clock rate %lu too low for %u\n", rate,
+			 spi->max_speed_hz);
+
+		req_rate = spi->max_speed_hz;
+
+		error = clk_set_rate(p->clk, req_rate);
+		if (error) {
+			dev_warn(&p->pdev->dev,
+				"Failed to set parent clock rate to %lu: %d, ignoring\n",
+				req_rate, error);
+			goto done;
+		}
+
+		rate = clk_get_rate(p->clk);
+		dev_info(&p->pdev->dev,
+			 "Changed parent clock rate to %lu actual %lu\n",
+			 req_rate, rate);
+
+		max_speed_hz = rate;
+		min_speed_hz = rate / MAX_DIV;
+
+		dev_info(&p->pdev->dev,
+			 "%s: new master speed min %u max %u, device speed max = %u\n",
+			 __func__, min_speed_hz, max_speed_hz,
+			 spi->max_speed_hz);
+
+		if (spi->max_speed_hz * 4 > max_speed_hz * 5) {
+			dev_warn(&p->pdev->dev,
+				 "New parent clock rate %lu too high for %u, ignoring\n",
+				 rate, spi->max_speed_hz);
+		}
+	}
+
+done:
 	p->dev_max_speed_hz = spi->max_speed_hz;
 
 	pm_runtime_get_sync(&p->pdev->dev);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
