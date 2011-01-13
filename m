From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] amba-pl022: fixing compilation warning.
Date: Thu, 13 Jan 2011 17:24:22 +0530
Message-ID: <59c94a951abb44f6d1fa02f4a0425267053bc4f1.1294919408.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: armando.visconti-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org,
	Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
To: <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

clk_freq is used uninitialized in pl022_setup routine. This patch
fix compilation warning for using uninitialized variable

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/amba-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index fb3d1b3..3903ab9 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1799,7 +1799,7 @@ static int pl022_setup(struct spi_device *spi)
 {
 	struct pl022_config_chip const *chip_info;
 	struct chip_data *chip;
-	struct ssp_clock_params clk_freq;
+	struct ssp_clock_params clk_freq = {0, };
 	int status = 0;
 	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
 	unsigned int bits = spi->bits_per_word;
-- 
1.7.2.2


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
