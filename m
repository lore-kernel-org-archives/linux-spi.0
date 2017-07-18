From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] spi: loopback-test: make several module parameters static
Date: Tue, 18 Jul 2017 13:42:32 +0100
Message-ID: <20170718124232.24644-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Several module parameters are local to the source, so make them
static. Cleans up several sparse warnings such as:

"symbol 'loop_req' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-loopback-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 0d3c56e2526c..64a1e6f212c1 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -32,45 +32,45 @@
 #include "spi-test.h"
 
 /* flag to only simulate transfers */
-int simulate_only;
+static int simulate_only;
 module_param(simulate_only, int, 0);
 MODULE_PARM_DESC(simulate_only, "if not 0 do not execute the spi message");
 
 /* dump spi messages */
-int dump_messages;
+static int dump_messages;
 module_param(dump_messages, int, 0);
 MODULE_PARM_DESC(dump_messages,
 		 "=1 dump the basic spi_message_structure, " \
 		 "=2 dump the spi_message_structure including data, " \
 		 "=3 dump the spi_message structure before and after execution");
 /* the device is jumpered for loopback - enabling some rx_buf tests */
-int loopback;
+static int loopback;
 module_param(loopback, int, 0);
 MODULE_PARM_DESC(loopback,
 		 "if set enable loopback mode, where the rx_buf "	\
 		 "is checked to match tx_buf after the spi_message "	\
 		 "is executed");
 
-int loop_req;
+static int loop_req;
 module_param(loop_req, int, 0);
 MODULE_PARM_DESC(loop_req,
 		 "if set controller will be asked to enable test loop mode. " \
 		 "If controller supported it, MISO and MOSI will be connected");
 
 /* run only a specific test */
-int run_only_test = -1;
+static int run_only_test = -1;
 module_param(run_only_test, int, 0);
 MODULE_PARM_DESC(run_only_test,
 		 "only run the test with this number (0-based !)");
 
 /* use vmalloc'ed buffers */
-int use_vmalloc;
+static int use_vmalloc;
 module_param(use_vmalloc, int, 0644);
 MODULE_PARM_DESC(use_vmalloc,
 		 "use vmalloc'ed buffers instead of kmalloc'ed");
 
 /* check rx ranges */
-int check_ranges = 1;
+static int check_ranges = 1;
 module_param(check_ranges, int, 0644);
 MODULE_PARM_DESC(check_ranges,
 		 "checks rx_buffer pattern are valid");
-- 
2.11.0
