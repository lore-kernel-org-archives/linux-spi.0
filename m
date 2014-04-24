From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] spi-bfin: Add missing gpio.h include
Date: Wed, 23 Apr 2014 22:40:35 -0400
Message-ID: <20140423224035.1de64093@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: Steven Miao <realmz6@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	adi-buildroot-devel@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Running my ktest.pl tests on all the archs, I stumbled over this for
3.15-rc2:

drivers/spi/spi-bfin5xx.c: In function 'bfin_spi_cs_active':
drivers/spi/spi-bfin5xx.c:169:3: error: implicit declaration of function 'gpio_set_value' [-Werror=implicit-function-declaration]
drivers/spi/spi-bfin5xx.c: In function 'bfin_spi_setup':
drivers/spi/spi-bfin5xx.c:1097:4: error: implicit declaration of function 'gpio_request' [-Werror=implicit-function-declaration]
drivers/spi/spi-bfin5xx.c:1102:4: error: implicit declaration of function 'gpio_direction_output' [-Werror=implicit-function-declaration]
drivers/spi/spi-bfin5xx.c:1130:3: error: implicit declaration of function 'gpio_free' [-Werror=implicit-function-declaration]

The problem is that the spi-bfin5xx driver is missing an include for
the gpio.h file.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 55e57c3..da8baa5 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
