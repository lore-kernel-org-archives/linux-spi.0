From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 + mm2-git-mmc]
	mmc_spi host driver
Date: Wed, 29 Aug 2007 13:00:04 -0700
Message-ID: <200708291300.05562.david-b@pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
	<200708290959.33584.david-b@pacbell.net>
	<20070829213905.71236d24@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070829213905.71236d24-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
Content-Disposition: inline
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

On Wednesday 29 August 2007, Pierre Ossman wrote:

> Could I get that patch instead? Pretty please? :)

=======	CUT HERE
Small bugfix for an issue noted by Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
whereby a buffer length was the passed with the wrong size.  This also
includes a minor cleanup, to eliminate the error-prone +1/-1 stuff.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/host/mmc_spi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- g26.orig/drivers/mmc/host/mmc_spi.c	2007-08-29 12:53:41.000000000 -0700
+++ g26/drivers/mmc/host/mmc_spi.c	2007-08-29 12:54:24.000000000 -0700
@@ -882,11 +882,12 @@ mmc_spi_data_do(struct mmc_spi_host *hos
 		list_add(&host->early_status.transfer_list,
 				&host->m.transfers);
 
+		memset(scratch->status, 0xff, statlen);
 		scratch->status[0] = SPI_TOKEN_STOP_TRAN;
-		memset(scratch->status + 1, 0xff, statlen - 1);
+
 		host->early_status.tx_buf = host->early_status.rx_buf;
 		host->early_status.tx_dma = host->early_status.rx_dma;
-		host->early_status.len = 1 + statlen;
+		host->early_status.len = statlen;
 
 		if (host->dma_dev)
 			dma_sync_single_for_device(host->dma_dev,

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
