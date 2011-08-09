From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 4/6] spi/spi-pl022: calculate_effective_freq() must set rate
	<= requested rate
Date: Tue, 9 Aug 2011 16:35:21 +0530
Message-ID: <abd4dbaedf226ad29461775bcd969810c87c305d.1312887860.git.viresh.kumar@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vipin.kumar-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org,
	bhavna.yadav-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org,
	pratyush.anand-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org,
	shiraz.hashim-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org,
	deepak.sikri-qxv4g6HH51o@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cover.1312887860.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There were few issues with calculate_effective_freq() routine:
- It was returning first rate found >= requested rate. Now, if system have spi's
  rate as 83 MHz, with possible prescaled rates as 83, 41.5, 20.75, 13.83 (as we
  can prescale with multiples of 2). If user has given rate to be programmed as
  22 MHz, then driver programmes it to 41.5 MHz. This looks to be incorrect, as
  user might have given the upper limit of the device, and we are programming it
  above it.
- Driver finds the first satisfying rate and programmes it, but with other
  values of scr & cpsdvsr, it is possible to get more closer rate.

This patch fixes these two issues, with some reformatting inside the code.
This also creates a macro to calculate prescaled rate based on spi's rate,
cpsdvsr and scr.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   98 ++++++++++++++++++++++------------------------
 1 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 452952b..e0cfb8c 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1791,67 +1791,63 @@ static int pl022_transfer(struct spi_device *spi, struct spi_message *msg)
 	return 0;
 }
 
-static int calculate_effective_freq(struct pl022 *pl022,
-				    int freq,
-				    struct ssp_clock_params *clk_freq)
+#define SPI_RATE(rate, cpsdvsr, scr)	(rate / (cpsdvsr * (1 + scr)))
+static int calculate_effective_freq(struct pl022 *pl022, int freq, struct
+				    ssp_clock_params * clk_freq)
 {
 	/* Lets calculate the frequency parameters */
-	u16 cpsdvsr = 2;
-	u16 scr = 0;
-	bool freq_found = false;
-	u32 rate;
-	u32 max_tclk;
-	u32 min_tclk;
+	u16 cpsdvsr = CPSDVR_MIN, scr = SCR_MIN;
+	u32 rate, max_tclk, min_tclk, best_freq = 0, best_cpsdvsr = 0,
+		best_scr = 0, tmp, found = 0;
 
 	rate = clk_get_rate(pl022->clk);
 	/* cpsdvscr = 2 & scr 0 */
-	max_tclk = (rate / (CPSDVR_MIN * (1 + SCR_MIN)));
+	max_tclk = SPI_RATE(rate, CPSDVR_MIN, SCR_MIN);
 	/* cpsdvsr = 254 & scr = 255 */
-	min_tclk = (rate / (CPSDVR_MAX * (1 + SCR_MAX)));
-
-	if ((freq <= max_tclk) && (freq >= min_tclk)) {
-		while (cpsdvsr <= CPSDVR_MAX && !freq_found) {
-			while (scr <= SCR_MAX && !freq_found) {
-				if ((rate /
-				     (cpsdvsr * (1 + scr))) > freq)
-					scr += 1;
-				else {
-					/*
-					 * This bool is made true when
-					 * effective frequency >=
-					 * target frequency is found
-					 */
-					freq_found = true;
-					if ((rate /
-					     (cpsdvsr * (1 + scr))) != freq) {
-						if (scr == SCR_MIN) {
-							cpsdvsr -= 2;
-							scr = SCR_MAX;
-						} else
-							scr -= 1;
-					}
-				}
-			}
-			if (!freq_found) {
-				cpsdvsr += 2;
-				scr = SCR_MIN;
-			}
-		}
-		if (cpsdvsr != 0) {
-			dev_dbg(&pl022->adev->dev,
-				"SSP Effective Frequency is %u\n",
-				(rate / (cpsdvsr * (1 + scr))));
-			clk_freq->cpsdvsr = (u8) (cpsdvsr & 0xFF);
-			clk_freq->scr = (u8) (scr & 0xFF);
-			dev_dbg(&pl022->adev->dev,
-				"SSP cpsdvsr = %d, scr = %d\n",
-				clk_freq->cpsdvsr, clk_freq->scr);
-		}
-	} else {
+	min_tclk = SPI_RATE(rate, CPSDVR_MAX, SCR_MAX);
+
+	if (!((freq <= max_tclk) && (freq >= min_tclk))) {
 		dev_err(&pl022->adev->dev,
 			"controller data is incorrect: out of range frequency");
 		return -EINVAL;
 	}
+
+	/*
+	 * best_freq will give closest possible available rate (<= requested
+	 * freq) for all values of scr & cpsdvsr.
+	 */
+	while ((cpsdvsr <= CPSDVR_MAX) && !found) {
+		while (scr <= SCR_MAX) {
+			tmp = SPI_RATE(rate, cpsdvsr, scr);
+
+			if (tmp > freq)
+				scr++;
+			/*
+			 * If found exact value, update and break.
+			 * If found more closer value, update and continue.
+			 */
+			else if ((tmp == freq) || (tmp > best_freq)) {
+				best_freq = tmp;
+				best_cpsdvsr = cpsdvsr;
+				best_scr = scr;
+
+				if (tmp == freq)
+					break;
+			}
+			scr++;
+		}
+		cpsdvsr += 2;
+		scr = SCR_MIN;
+	}
+
+	clk_freq->cpsdvsr = (u8) (best_cpsdvsr & 0xFF);
+	clk_freq->scr = (u8) (best_scr & 0xFF);
+	dev_dbg(&pl022->adev->dev,
+		"SSP Target Frequency is: %u, Effective Frequency is %u\n",
+		freq, best_freq);
+	dev_dbg(&pl022->adev->dev, "SSP cpsdvsr = %d, scr = %d\n",
+		clk_freq->cpsdvsr, clk_freq->scr);
+
 	return 0;
 }
 
-- 
1.7.2.2


------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
