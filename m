From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 3/4 2.6.23-rc2 + mm2-git-mmc]
	MMC	core learns about SPI
Date: Wed, 29 Aug 2007 11:22:47 +0200
Message-ID: <20070829092247.GA15021@pengutronix.de>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080911.33099.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200708080911.33099.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi David and all,

I need the following patch on my (little endian) System to successfully
read the csd/cid structure.

Sascha


CSD/CID is transfered in big endian format. Convert it to cpu endianess.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---
 drivers/mmc/core/mmc_ops.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6-arm/drivers/mmc/core/mmc_ops.c
===================================================================
--- linux-2.6-arm.orig/drivers/mmc/core/mmc_ops.c
+++ linux-2.6-arm/drivers/mmc/core/mmc_ops.c
@@ -207,6 +207,7 @@ mmc_send_cxd_data(struct mmc_host *host,
 	struct mmc_data data;
 	struct scatterlist sg;
 	void *data_buf;
+	int i;
 
 	/* dma onto stack is unsafe/nonportable, but callers here
 	 * normally provide temporary on-stack buffers.
@@ -246,7 +247,11 @@ mmc_send_cxd_data(struct mmc_host *host,
 
 	mmc_wait_for_req(host, &mrq);
 
-	memcpy(buf, data_buf, len);
+	for (i = 0; i < (len >> 2); i++) {
+		u32 *buf32 = buf;
+		buf32[i] = be32_to_cpu(*((u32 *)data_buf + i));
+	}
+
 	kfree(data_buf);
 
 	if (cmd.error != MMC_ERR_NONE)


-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
