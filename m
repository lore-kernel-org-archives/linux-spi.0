From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 1/2] samples: move blackfin gptimers-example from Documentation
Date: Mon, 26 Sep 2016 12:40:01 -0600
Message-ID: <4d0970e837856d1e4a61e7e2772b6b2b84093a43.1474912582.git.shuahkh@osg.samsung.com>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-spi@vger.kernel.org
To: corbet@lwn.net, mmarek@suse.com, akpm@linux-foundation.org,
        keescook@chromium.org, dan.j.williams@intel.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, jpoimboe@redhat.com, tj@kernel.org,
        aryabinin@virtuozzo.com, nikolay@cumulusnetworks.com,
        dvyukov@google.com, rostedt@goodmis.org, olof@lixom.net,
        arnd@arndb.de, hans.verkuil@cisco.com, nab@linux-iscsi.org,
        mchehab@kernel.org, broonie@kernel.org, tglx@linutronix.de,
        ecree@solarflare.com, davem@davemloft.net
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1474912582.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474912582.git.shuahkh@osg.samsung.com>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Move blackfin gptimers-example to samples and remove it from Documentation
Makefile. Update samples Kconfig and Makefile to build gptimers-example.

blackfin is the last CONFIG_BUILD_DOCSRC target in Documentation/Makefile,
hence this patch also includes changes to remove CONFIG_BUILD_DOCSRC from
Makefile and lib/Kconfig.debug.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 Documentation/Makefile                    |  1 -
 Documentation/blackfin/00-INDEX           |  4 --
 Documentation/blackfin/Makefile           |  5 --
 Documentation/blackfin/gptimers-example.c | 91 -------------------------------
 Makefile                                  |  3 -
 lib/Kconfig.debug                         |  9 ---
 samples/Kconfig                           |  6 ++
 samples/Makefile                          |  2 +-
 samples/blackfin/Makefile                 |  1 +
 samples/blackfin/gptimers-example.c       | 91 +++++++++++++++++++++++++++++++
 10 files changed, 99 insertions(+), 114 deletions(-)
 delete mode 100644 Documentation/Makefile
 delete mode 100644 Documentation/blackfin/Makefile
 delete mode 100644 Documentation/blackfin/gptimers-example.c
 create mode 100644 samples/blackfin/Makefile
 create mode 100644 samples/blackfin/gptimers-example.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
deleted file mode 100644
index 8435965..0000000
--- a/Documentation/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-subdir-y := blackfin
diff --git a/Documentation/blackfin/00-INDEX b/Documentation/blackfin/00-INDEX
index c54fcdd..265a1ef 100644
--- a/Documentation/blackfin/00-INDEX
+++ b/Documentation/blackfin/00-INDEX
@@ -1,10 +1,6 @@
 00-INDEX
 	- This file
-Makefile
-	- Makefile for gptimers example file.
 bfin-gpio-notes.txt
 	- Notes in developing/using bfin-gpio driver.
 bfin-spi-notes.txt
 	- Notes for using bfin spi bus driver.
-gptimers-example.c
-	- gptimers example
diff --git a/Documentation/blackfin/Makefile b/Documentation/blackfin/Makefile
deleted file mode 100644
index 6782c58..0000000
--- a/Documentation/blackfin/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-ifneq ($(CONFIG_BLACKFIN),)
-ifneq ($(CONFIG_BFIN_GPTIMERS),)
-obj-m := gptimers-example.o
-endif
-endif
diff --git a/Documentation/blackfin/gptimers-example.c b/Documentation/blackfin/gptimers-example.c
deleted file mode 100644
index 283eba9..0000000
--- a/Documentation/blackfin/gptimers-example.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Simple gptimers example
- *	http://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:drivers:gptimers
- *
- * Copyright 2007-2009 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/interrupt.h>
-#include <linux/module.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-/* ... random driver includes ... */
-
-#define DRIVER_NAME "gptimer_example"
-
-#ifdef IRQ_TIMER5
-#define SAMPLE_IRQ_TIMER IRQ_TIMER5
-#else
-#define SAMPLE_IRQ_TIMER IRQ_TIMER2
-#endif
-
-struct gptimer_data {
-	uint32_t period, width;
-};
-static struct gptimer_data data;
-
-/* ... random driver state ... */
-
-static irqreturn_t gptimer_example_irq(int irq, void *dev_id)
-{
-	struct gptimer_data *data = dev_id;
-
-	/* make sure it was our timer which caused the interrupt */
-	if (!get_gptimer_intr(TIMER5_id))
-		return IRQ_NONE;
-
-	/* read the width/period values that were captured for the waveform */
-	data->width = get_gptimer_pwidth(TIMER5_id);
-	data->period = get_gptimer_period(TIMER5_id);
-
-	/* acknowledge the interrupt */
-	clear_gptimer_intr(TIMER5_id);
-
-	/* tell the upper layers we took care of things */
-	return IRQ_HANDLED;
-}
-
-/* ... random driver code ... */
-
-static int __init gptimer_example_init(void)
-{
-	int ret;
-
-	/* grab the peripheral pins */
-	ret = peripheral_request(P_TMR5, DRIVER_NAME);
-	if (ret) {
-		printk(KERN_NOTICE DRIVER_NAME ": peripheral request failed\n");
-		return ret;
-	}
-
-	/* grab the IRQ for the timer */
-	ret = request_irq(SAMPLE_IRQ_TIMER, gptimer_example_irq,
-			IRQF_SHARED, DRIVER_NAME, &data);
-	if (ret) {
-		printk(KERN_NOTICE DRIVER_NAME ": IRQ request failed\n");
-		peripheral_free(P_TMR5);
-		return ret;
-	}
-
-	/* setup the timer and enable it */
-	set_gptimer_config(TIMER5_id,
-			WDTH_CAP | PULSE_HI | PERIOD_CNT | IRQ_ENA);
-	enable_gptimers(TIMER5bit);
-
-	return 0;
-}
-module_init(gptimer_example_init);
-
-static void __exit gptimer_example_exit(void)
-{
-	disable_gptimers(TIMER5bit);
-	free_irq(SAMPLE_IRQ_TIMER, &data);
-	peripheral_free(P_TMR5);
-}
-module_exit(gptimer_example_exit);
-
-MODULE_LICENSE("BSD");
diff --git a/Makefile b/Makefile
index 1a8c8dd..de5136a 100644
--- a/Makefile
+++ b/Makefile
@@ -926,9 +926,6 @@ vmlinux_prereq: $(vmlinux-deps) FORCE
 ifdef CONFIG_HEADERS_CHECK
 	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
 endif
-ifdef CONFIG_BUILD_DOCSRC
-	$(Q)$(MAKE) $(build)=Documentation
-endif
 ifdef CONFIG_GDB_SCRIPTS
 	$(Q)ln -fsn `cd $(srctree) && /bin/pwd`/scripts/gdb/vmlinux-gdb.py
 endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e2cca5..ac15feb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1857,15 +1857,6 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
-config BUILD_DOCSRC
-	bool "Build targets in Documentation/ tree"
-	depends on HEADERS_CHECK
-	help
-	  This option attempts to build objects from the source files in the
-	  kernel Documentation/ tree.
-
-	  Say N if you are unsure.
-
 config DMA_API_DEBUG
 	bool "Enable debugging of DMA-API usage"
 	depends on HAVE_DMA_API_DEBUG
diff --git a/samples/Kconfig b/samples/Kconfig
index 85c405f..d67b4b7 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -99,4 +99,10 @@ config SAMPLE_SECCOMP
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
 
+config SAMPLE_BLACKFIN_GPTIMERS
+	tristate "Build blackfin gptimers sample code -- loadable modules only"
+	depends on CONFIG_BLACKFIN && CONFIG_BFIN_GPTIMERS && m
+	help
+	  Build samples of blackfin gptimers sample module.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 1a20169..e17d66d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/ connector/ v4l/ trace_printk/
+			   configfs/ connector/ v4l/ trace_printk/ blackfin/
diff --git a/samples/blackfin/Makefile b/samples/blackfin/Makefile
new file mode 100644
index 0000000..89b86cf
--- /dev/null
+++ b/samples/blackfin/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SAMPLE_BLACKFIN_GPTIMERS) += gptimers-example.o
diff --git a/samples/blackfin/gptimers-example.c b/samples/blackfin/gptimers-example.c
new file mode 100644
index 0000000..283eba9
--- /dev/null
+++ b/samples/blackfin/gptimers-example.c
@@ -0,0 +1,91 @@
+/*
+ * Simple gptimers example
+ *	http://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:drivers:gptimers
+ *
+ * Copyright 2007-2009 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include <asm/gptimers.h>
+#include <asm/portmux.h>
+
+/* ... random driver includes ... */
+
+#define DRIVER_NAME "gptimer_example"
+
+#ifdef IRQ_TIMER5
+#define SAMPLE_IRQ_TIMER IRQ_TIMER5
+#else
+#define SAMPLE_IRQ_TIMER IRQ_TIMER2
+#endif
+
+struct gptimer_data {
+	uint32_t period, width;
+};
+static struct gptimer_data data;
+
+/* ... random driver state ... */
+
+static irqreturn_t gptimer_example_irq(int irq, void *dev_id)
+{
+	struct gptimer_data *data = dev_id;
+
+	/* make sure it was our timer which caused the interrupt */
+	if (!get_gptimer_intr(TIMER5_id))
+		return IRQ_NONE;
+
+	/* read the width/period values that were captured for the waveform */
+	data->width = get_gptimer_pwidth(TIMER5_id);
+	data->period = get_gptimer_period(TIMER5_id);
+
+	/* acknowledge the interrupt */
+	clear_gptimer_intr(TIMER5_id);
+
+	/* tell the upper layers we took care of things */
+	return IRQ_HANDLED;
+}
+
+/* ... random driver code ... */
+
+static int __init gptimer_example_init(void)
+{
+	int ret;
+
+	/* grab the peripheral pins */
+	ret = peripheral_request(P_TMR5, DRIVER_NAME);
+	if (ret) {
+		printk(KERN_NOTICE DRIVER_NAME ": peripheral request failed\n");
+		return ret;
+	}
+
+	/* grab the IRQ for the timer */
+	ret = request_irq(SAMPLE_IRQ_TIMER, gptimer_example_irq,
+			IRQF_SHARED, DRIVER_NAME, &data);
+	if (ret) {
+		printk(KERN_NOTICE DRIVER_NAME ": IRQ request failed\n");
+		peripheral_free(P_TMR5);
+		return ret;
+	}
+
+	/* setup the timer and enable it */
+	set_gptimer_config(TIMER5_id,
+			WDTH_CAP | PULSE_HI | PERIOD_CNT | IRQ_ENA);
+	enable_gptimers(TIMER5bit);
+
+	return 0;
+}
+module_init(gptimer_example_init);
+
+static void __exit gptimer_example_exit(void)
+{
+	disable_gptimers(TIMER5bit);
+	free_irq(SAMPLE_IRQ_TIMER, &data);
+	peripheral_free(P_TMR5);
+}
+module_exit(gptimer_example_exit);
+
+MODULE_LICENSE("BSD");
-- 
2.7.4

