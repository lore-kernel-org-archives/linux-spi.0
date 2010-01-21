From: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
Subject: [PATCH 5/5] spi/dw_spi.c: conditional transfer
	mode changes
Date: Thu, 21 Jan 2010 11:40:52 +0000
Message-ID: <1264074052-2214-5-git-send-email-george@georgeshore.com>
References: <1264074052-2214-1-git-send-email-george@georgeshore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
To: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1264074052-2214-1-git-send-email-george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This allows the switching between transfer modes between 'transmit only',
'receive only' and 'transmit and receive' modes. Due to the design of the SPI
block, changing transfer modes requires that the block be disabled; in doing
so the chipselect line is inherently deasserted and (usually) the attached
device discards its state. Consequentially, switching modes requires that a
platform-specific chipselect function has been defined so that the chipselect
is not dropped during the change.

Signed-off-by: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
---
 drivers/spi/dw_spi.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 4f91554..a1c195f 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -537,6 +537,22 @@ static void pump_transfers(unsigned long data)
 	}
 	message->state = RUNNING_STATE;
 
+	/*
+	 * Adjust transfer mode if necessary. Requires platform dependent
+	 * chipselect mechanism.
+	 */
+	if (dws->cs_control) {
+		if (dws->rx && dws->tx)
+			chip->tmode = 0x00;
+		else if (dws->rx)
+			chip->tmode = 0x02;
+		else
+			chip->tmode = 0x01;
+
+		cr0 &= ~(0x3 << SPI_MODE_OFFSET);
+		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
+	}
+
 	/* Check if current transfer is a DMA transaction */
 	dws->dma_mapped = map_dma_buffers(dws);
 
-- 
1.6.6.264.gd0743


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
