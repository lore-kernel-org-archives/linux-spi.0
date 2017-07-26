From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: tools: add install section" to the spi tree
Date: Wed, 26 Jul 2017 15:18:12 +0100
Message-ID: <E1daN8e-0003vE-CR@debutante>
References: <20170722214740.57322-2-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170722214740.57322-2-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: tools: add install section

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

>From e9d4650dcc59092b8cc35e6e7a54184d6f124173 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 26 Jul 2017 12:59:30 +0300
Subject: [PATCH] spi: tools: add install section

Allow user to call install target.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 tools/Makefile     |  4 ++--
 tools/spi/Makefile | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 221e1ce78b06..616e7722b327 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -91,7 +91,7 @@ kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
 all: acpi cgroup cpupower gpio hv firewire lguest liblockdep \
-		perf selftests turbostat usb \
+		perf selftests spi turbostat usb \
 		virtio vm net x86_energy_perf_policy \
 		tmon freefall objtool kvm_stat
 
@@ -101,7 +101,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install lguest_install perf_install usb_install virtio_install vm_install net_install objtool_install:
+cgroup_install firewire_install gpio_install hv_install lguest_install perf_install spi_install usb_install virtio_install vm_install net_install objtool_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index aa9517260715..90615e10c79a 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -1,5 +1,7 @@
 include ../scripts/Makefile.include
 
+bindir ?= /usr/bin
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
@@ -53,6 +55,12 @@ clean:
 	rm -f $(OUTPUT)include/linux/spi/spidev.h
 	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
 
+install: $(ALL_PROGRAMS)
+	install -d -m 755 $(DESTDIR)$(bindir);		\
+	for program in $(ALL_PROGRAMS); do		\
+		install $$program $(DESTDIR)$(bindir);	\
+	done
+
 FORCE:
 
-.PHONY: all clean FORCE prepare
+.PHONY: all install clean FORCE prepare
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
