From: Federico Vaga <federico.vaga@gmail.com>
Subject: [PATCH] trivial: spi-pl022.c: fix a wrong kerneldoc comment
Date: Wed,  8 Feb 2012 17:23:33 +0100
Message-ID: <1328718213-17375-1-git-send-email-federico.vaga@gmail.com>
Cc: rubini@gnudd.com, giancarlo.asnaghi@st.com,
	Federico Vaga <federico.vaga@gmail.com>
To: grant.likely@secretlab.ca, trivial@kernel.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Federico Vaga <federico.vaga@gmail.com>
---
 drivers/spi/spi-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2f9cb43..286572d 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1495,7 +1495,7 @@ out:
 
 /**
  * pump_messages - Workqueue function which processes spi message queue
- * @data: pointer to private data of SSP driver
+ * @work: pointer to the pump_messages work structure within pl022 structure
  *
  * This function checks if there is any spi message in the queue that
  * needs processing and delegate control to appropriate function
-- 
1.7.7.6
