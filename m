From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: tools: move to tools buildsystem" to the spi tree
Date: Wed, 26 Jul 2017 15:18:15 +0100
Message-ID: <E1daN8h-0003w4-O2@debutante>
References: <20170722214740.57322-1-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170722214740.57322-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: tools: move to tools buildsystem

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f325b73dc4db9d6c2393805b4f468e82d730764e Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 26 Jul 2017 12:59:29 +0300
Subject: [PATCH] spi: tools: move to tools buildsystem

There is a nice buildsystem dedicated for userspace tools in Linux kernel tree.
Switch spi target to be built by it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 tools/spi/Build    |  2 ++
 tools/spi/Makefile | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 tools/spi/Build

diff --git a/tools/spi/Build b/tools/spi/Build
new file mode 100644
index 000000000000..8e8466033d99
--- /dev/null
+++ b/tools/spi/Build
@@ -0,0 +1,2 @@
+spidev_test-y += spidev_test.o
+spidev_fdx-y += spidev_fdx.o
diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index 3815b18ba070..aa9517260715 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -1,6 +1,58 @@
+include ../scripts/Makefile.include
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
 CC = $(CROSS_COMPILE)gcc
+LD = $(CROSS_COMPILE)ld
+CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+
+ALL_TARGETS := spidev_test spidev_fdx
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+
+all: $(ALL_PROGRAMS)
+
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
 
-all: spidev_test spidev_fdx
+#
+# We need the following to be outside of kernel tree
+#
+$(OUTPUT)include/linux/spi/spidev.h: ../../include/uapi/linux/spi/spidev.h
+	mkdir -p $(OUTPUT)include/linux/spi 2>&1 || true
+	ln -sf $(CURDIR)/../../include/uapi/linux/spi/spidev.h $@
+
+prepare: $(OUTPUT)include/linux/spi/spidev.h
+
+#
+# spidev_test
+#
+SPIDEV_TEST_IN := $(OUTPUT)spidev_test-in.o
+$(SPIDEV_TEST_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=spidev_test
+$(OUTPUT)spidev_test: $(SPIDEV_TEST_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+#
+# spidev_fdx
+#
+SPIDEV_FDX_IN := $(OUTPUT)spidev_fdx-in.o
+$(SPIDEV_FDX_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=spidev_fdx
+$(OUTPUT)spidev_fdx: $(SPIDEV_FDX_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
 clean:
-	$(RM) spidev_test spidev_fdx
+	rm -f $(ALL_PROGRAMS)
+	rm -f $(OUTPUT)include/linux/spi/spidev.h
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+
+FORCE:
+
+.PHONY: all clean FORCE prepare
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
