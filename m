From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] dw_spi.c can now be built as a module.
Date: Thu, 21 Jan 2010 11:44:09 -0500
Message-ID: <20100121164349.10132.24020.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

dw_spi.c can now be built as a module.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/Kconfig  |    2 +-
 drivers/spi/dw_spi.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 02be3a6..505f1c2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -308,7 +308,7 @@ config SPI_NUC900
 #
 
 config SPI_DESIGNWARE
-	bool "DesignWare SPI controller core support"
+	tristate "DesignWare SPI controller core support"
 	depends on SPI_MASTER
 	help
 	  general driver for SPI controller core from DesignWare
diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 4b5a9a1..754f21c 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -940,6 +940,17 @@ int dw_spi_resume_host(struct dw_spi *dws)
 }
 EXPORT_SYMBOL(dw_spi_resume_host);
 
+static int __init dw_spi_init(void)
+{
+	return 0;
+}
+module_init(dw_spi_init);
+
+static void __exit dw_spi_exit(void)
+{
+}
+module_exit(dw_spi_exit);
+
 MODULE_AUTHOR("Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Driver for DesignWare SPI controller core");
 MODULE_LICENSE("GPL v2");


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
