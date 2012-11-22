From: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] spi: sh-hspi: add CS manual control support
Date: Thu, 22 Nov 2012 14:37:27 +0000
Message-ID: <1353595047-14558-2-git-send-email-phil.edworthy@renesas.com>
References: <1353595047-14558-1-git-send-email-phil.edworthy@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1353595047-14558-1-git-send-email-phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The current HSPI driver used automatic CS control, leading to CS
active for each byte transmitted. This patch changes the driver
to manual CS control, and ensures CS is active thoughout a whole
message. Additionally, it uses the cs_change field to determine
if CS is disabled between transfers in the message.

Signed-off-by: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-sh-hspi.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 0ca18c8..592e236 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -68,6 +68,16 @@ static u32 hspi_read(struct hspi_priv *hspi, int reg)
 	return ioread32(hspi->addr + reg);
 }
 
+static void hspi_bit_set(struct hspi_priv *hspi, int reg, u32 mask, u32 set)
+{
+	u32 val = hspi_read(hspi, reg);
+
+	val &= ~mask;
+	val |= set & mask;
+
+	hspi_write(hspi, reg, val);
+}
+
 /*
  *		transfer function
  */
@@ -105,6 +115,13 @@ static int hspi_unprepare_transfer(struct spi_master *master)
 	return 0;
 }
 
+#define hspi_hw_cs_enable(hspi)		hspi_hw_cs_ctrl(hspi, 0)
+#define hspi_hw_cs_disable(hspi)	hspi_hw_cs_ctrl(hspi, 1)
+static void hspi_hw_cs_ctrl(struct hspi_priv *hspi, int hi)
+{
+	hspi_bit_set(hspi, SPSCR, (1 << 6), (hi) << 6);
+}
+
 static void hspi_hw_setup(struct hspi_priv *hspi,
 			  struct spi_message *msg,
 			  struct spi_transfer *t)
@@ -155,7 +172,7 @@ static void hspi_hw_setup(struct hspi_priv *hspi,
 
 	hspi_write(hspi, SPCR, spcr);
 	hspi_write(hspi, SPSR, 0x0);
-	hspi_write(hspi, SPSCR, 0x1);	/* master mode */
+	hspi_write(hspi, SPSCR, 0x21);	/* master mode / CS control */
 }
 
 static int hspi_transfer_one_message(struct spi_master *master,
@@ -166,12 +183,21 @@ static int hspi_transfer_one_message(struct spi_master *master,
 	u32 tx;
 	u32 rx;
 	int ret, i;
+	unsigned int cs_change;
+	const int nsecs = 50;
 
 	dev_dbg(hspi->dev, "%s\n", __func__);
 
+	cs_change = 1;
 	ret = 0;
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
-		hspi_hw_setup(hspi, msg, t);
+
+		if (cs_change) {
+			hspi_hw_setup(hspi, msg, t);
+			hspi_hw_cs_enable(hspi);
+			ndelay(nsecs);
+		}
+		cs_change = t->cs_change;
 
 		for (i = 0; i < t->len; i++) {
 
@@ -198,9 +224,22 @@ static int hspi_transfer_one_message(struct spi_master *master,
 		}
 
 		msg->actual_length += t->len;
+
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
+
+		if (cs_change) {
+			ndelay(nsecs);
+			hspi_hw_cs_disable(hspi);
+			ndelay(nsecs);
+		}
 	}
 
 	msg->status = ret;
+	if (!cs_change) {
+		ndelay(nsecs);
+		hspi_hw_cs_disable(hspi);
+	}
 	spi_finalize_current_message(master);
 
 	return ret;
-- 
1.7.5.4


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
