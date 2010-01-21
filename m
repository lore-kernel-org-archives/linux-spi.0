From: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
Subject: [PATCH 4/5] spi/dw_spi.c: remove conditional
	from 'poll_transfer'.
Date: Thu, 21 Jan 2010 11:40:51 +0000
Message-ID: <1264074052-2214-4-git-send-email-george@georgeshore.com>
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

The 'poll_transfer' function employs a conditional to test whether the
transmit buffer is valid; in doing so, on a receive operation no data is
clocked out, thus no data is clocked in and ultimately errors appear.

This removes the conditional as the transmit function will be set to a null
writer when the transmit buffer is invalid, allowing the driver to clock 0x00
out to the device to receive data from the device.

Signed-off-by: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
---
 drivers/spi/dw_spi.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 01292da..4f91554 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -408,12 +408,9 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 /* Must be called inside pump_transfers() */
 static void poll_transfer(struct dw_spi *dws)
 {
-	if (dws->tx) {
-		while (dws->write(dws))
-			dws->read(dws);
-	}
+	while (dws->write(dws))
+		dws->read(dws);
 
-	dws->read(dws);
 	transfer_complete(dws);
 }
 
-- 
1.6.6.264.gd0743


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
