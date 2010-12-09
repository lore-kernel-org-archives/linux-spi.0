From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [RFC][PATCH v2 2/3] spi_bitbang : get nsecs delay from cs during transfer
Date: Thu,  9 Dec 2010 15:34:55 -0500
Message-ID: <67270e44ec792d1a684d6052f7aebbc8c538a6c1.1291925752.git.bengardiner@nanometrics.ca>
References: <1290205185-11956-1-git-send-email-bengardiner@nanometrics.ca> <cover.1291925752.git.bengardiner@nanometrics.ca>
Cc: linux-kernel@vger.kernel.org, Michael Buesch <mb@bu3sch.de>
To: spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1291925752.git.bengardiner@nanometrics.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When users have elected to enable delays in the spi-gpio driver, use the
cs speed to govern the time between CS assertion and beginning of data
transfer on the bus

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
changes since v1:
 * none; new in v2

 drivers/spi/spi_bitbang.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 8b55724..8707133 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -269,6 +269,7 @@ static void bitbang_work(struct work_struct *work)
 	while (!list_empty(&bitbang->queue)) {
 		struct spi_message	*m;
 		struct spi_device	*spi;
+		struct spi_bitbang_cs	*cs;
 		unsigned		nsecs;
 		struct spi_transfer	*t = NULL;
 		unsigned		tmp;
@@ -281,13 +282,15 @@ static void bitbang_work(struct work_struct *work)
 		list_del_init(&m->queue);
 		spin_unlock_irqrestore(&bitbang->lock, flags);
 
-		/* FIXME this is made-up ... the correct value is known to
-		 * word-at-a-time bitbang code, and presumably chipselect()
-		 * should enforce these requirements too?
-		 */
-		nsecs = 100;
-
 		spi = m->spi;
+		cs = spi->controller_state;
+		nsecs =
+#if defined(CONFIG_SLOWER_SPI_GPIO)
+				!cs->nsecs ? cs->nsecs : 100;
+#else
+		100;
+#endif
+
 		tmp = 0;
 		cs_change = 1;
 		status = 0;
-- 
1.7.0.4
