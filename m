From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2] spi-imx: Remove duplicate spi_imx_data definition
Date: Mon, 26 Mar 2012 16:10:02 -0300
Message-ID: <1332789002-31159-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Structure struct spi_imx_data is defined twice.

Remove one of its definition.

In order to do so, it is also necessary to move spi_imx_devtype_data 
structure after the definition of spi_imx_data.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Changes since v1:
- Explain why I moved spi_imx_devtype_data location
 drivers/spi/spi-imx.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 31054e3..f1f6700 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -68,17 +68,6 @@ enum spi_imx_devtype {
 	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
 };
 
-struct spi_imx_data;
-
-struct spi_imx_devtype_data {
-	void (*intctrl)(struct spi_imx_data *, int);
-	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
-	void (*trigger)(struct spi_imx_data *);
-	int (*rx_available)(struct spi_imx_data *);
-	void (*reset)(struct spi_imx_data *);
-	enum spi_imx_devtype devtype;
-};
-
 struct spi_imx_data {
 	struct spi_bitbang bitbang;
 
@@ -99,6 +88,15 @@ struct spi_imx_data {
 	int chipselect[0];
 };
 
+struct spi_imx_devtype_data {
+	void (*intctrl)(struct spi_imx_data *, int);
+	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
+	void (*trigger)(struct spi_imx_data *);
+	int (*rx_available)(struct spi_imx_data *);
+	void (*reset)(struct spi_imx_data *);
+	enum spi_imx_devtype devtype;
+};
+
 static inline int is_imx27_cspi(struct spi_imx_data *d)
 {
 	return d->devtype_data->devtype == IMX27_CSPI;
-- 
1.7.1



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
