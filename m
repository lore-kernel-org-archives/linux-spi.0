From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Move spi code from Documentation to tools" to the spi tree
Date: Mon, 23 Nov 2015 14:54:24 +0000
Message-ID: <E1a0sVc-0000NJ-QX@debutante>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Move spi code from Documentation to tools

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

>From 5eca4d843f9f0c3140a8657ba2f8217ee6c08c11 Mon Sep 17 00:00:00 2001
From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 18 Nov 2015 14:30:37 -0800
Subject: [PATCH] spi: Move spi code from Documentation to tools

Jon Corbet requested this code moved with the last changeset,
https://lkml.org/lkml/2015/3/1/144,
but the patch was not applied because it missed the Makefile.
Moved spidev_test, spidev_fdx and their Makefile infrastructure.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/Makefile                     | 2 +-
 Documentation/spi/Makefile                 | 8 --------
 tools/Makefile                             | 7 ++++---
 tools/spi/Makefile                         | 4 ++++
 {Documentation => tools}/spi/spidev_fdx.c  | 0
 {Documentation => tools}/spi/spidev_test.c | 0
 6 files changed, 9 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/spi/Makefile
 create mode 100644 tools/spi/Makefile
 rename {Documentation => tools}/spi/spidev_fdx.c (100%)
 rename {Documentation => tools}/spi/spidev_test.c (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index bc0548201755..1207d7907650 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,4 @@
 subdir-y := accounting auxdisplay blackfin connector \
 	filesystems filesystems ia64 laptops mic misc-devices \
-	networking pcmcia prctl ptp spi timers vDSO video4linux \
+	networking pcmcia prctl ptp timers vDSO video4linux \
 	watchdog
diff --git a/Documentation/spi/Makefile b/Documentation/spi/Makefile
deleted file mode 100644
index efa255813e9d..000000000000
--- a/Documentation/spi/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# List of programs to build
-hostprogs-y := spidev_test spidev_fdx
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
-
-HOSTCFLAGS_spidev_test.o += -I$(objtree)/usr/include
-HOSTCFLAGS_spidev_fdx.o += -I$(objtree)/usr/include
diff --git a/tools/Makefile b/tools/Makefile
index d6f307dfb1a3..0528aa13ccb4 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -17,6 +17,7 @@ help:
 	@echo '  lguest     - a minimal 32-bit x86 hypervisor'
 	@echo '  perf       - Linux performance measurement and analysis tool'
 	@echo '  selftests  - various kernel selftests'
+	@echo '  spi        - spi tools'
 	@echo '  turbostat  - Intel CPU idle stats and freq reporting tool'
 	@echo '  usb        - USB testing tools'
 	@echo '  virtio     - vhost test module'
@@ -48,7 +49,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest usb virtio vm net iio: FORCE
+cgroup firewire hv guest spi usb virtio vm net iio: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -109,7 +110,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean iio_clean:
+cgroup_clean hv_clean firewire_clean lguest_clean spi_clean usb_clean virtio_clean vm_clean net_clean iio_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -134,7 +135,7 @@ freefall_clean:
 	$(call descend,laptop/freefall,clean)
 
 clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean lguest_clean \
-		perf_clean selftests_clean turbostat_clean usb_clean virtio_clean \
+		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
 		vm_clean net_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean
 
diff --git a/tools/spi/Makefile b/tools/spi/Makefile
new file mode 100644
index 000000000000..cd0db62e4d9d
--- /dev/null
+++ b/tools/spi/Makefile
@@ -0,0 +1,4 @@
+all: spidev_test spidev_fdx
+
+clean:
+	$(RM) spidev_test spidev_fdx
diff --git a/Documentation/spi/spidev_fdx.c b/tools/spi/spidev_fdx.c
similarity index 100%
rename from Documentation/spi/spidev_fdx.c
rename to tools/spi/spidev_fdx.c
diff --git a/Documentation/spi/spidev_test.c b/tools/spi/spidev_test.c
similarity index 100%
rename from Documentation/spi/spidev_test.c
rename to tools/spi/spidev_test.c
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
