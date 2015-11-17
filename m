From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH 7/8] tools/Makefile: minor whitespace cleanup
Date: Tue, 17 Nov 2015 07:24:27 -0800
Message-ID: <155366ac799345f42c8c342609ffa11b2df529b0.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447773299.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 tools/Makefile | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 9a617ad..428fb4d 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -80,10 +80,21 @@ turbostat_install x86_energy_perf_policy_install:
 tmon_install:
 	$(call descend,thermal/$(@:_install=),install)
 
-install: acpi_install cgroup_install cpupower_install hv_install firewire_install lguest_install \
-		perf_install selftests_install turbostat_install usb_install \
-		virtio_install vm_install net_install x86_energy_perf_policy_install \
-	tmon
+install: acpi_install \
+		cgroup_install \
+		cpupower_install \
+		hv_install \
+		firewire_install \
+		lguest_install \
+		perf_install \
+		selftests_install \
+		tmon \
+		turbostat_install \
+		usb_install \
+		virtio_install \
+		vm_install \
+		net_install \
+		x86_energy_perf_policy_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -112,8 +123,20 @@ turbostat_clean x86_energy_perf_policy_clean:
 tmon_clean:
 	$(call descend,thermal/tmon,clean)
 
-clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean lguest_clean \
-		perf_clean selftests_clean turbostat_clean usb_clean virtio_clean \
-		vm_clean net_clean x86_energy_perf_policy_clean tmon_clean
+clean: acpi_clean \
+		cgroup_clean \
+		cpupower_clean \
+		hv_clean \
+		firewire_clean \
+		lguest_clean \
+		perf_clean \
+		selftests_clean \
+		tmon_clean \
+		turbostat_clean \
+		usb_clean \
+		virtio_clean \
+		vm_clean \
+		net_clean \
+		x86_energy_perf_policy_clean
 
 .PHONY: FORCE
-- 
2.5.0
