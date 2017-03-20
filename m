From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH 3/4] arm64: dts: amd: Remove nonexistent property
Date: Mon, 20 Mar 2017 10:57:20 +0100
Message-ID: <20170320095721.6724-3-borneo.antonio@gmail.com>
References: <20170320095721.6724-1-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Viresh Kumar <vireshk@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Antonio Borneo <borneo.antonio@gmail.com>,
 Mark Brown <broonie@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-spi@vger.kernel.org,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, linux-kernel@vger.kernel.org
To: Brijesh Singh <brijeshkumar.singh@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170320095721.6724-1-borneo.antonio@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The property "pl022,hierarchy" is not documented in DT binding
and doesn't exist in the driver code.
It has no effect and can be removed.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
To: Brijesh Singh <brijeshkumar.singh@amd.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts | 1 -
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts | 1 -
 arch/arm64/boot/dts/amd/amd-overdrive.dts        | 1 -
 arch/arm64/boot/dts/amd/husky.dts                | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
index 8e3074a4947d..399baf4040e3 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
@@ -70,7 +70,6 @@
 		reg = <0>;
 		spi-max-frequency = <20000000>;
 		voltage-ranges = <3200 3400>;
-		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,com-mode = <0x0>;
 		pl022,rx-level-trig = <0>;
diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
index ed5e043f37aa..be60accbcaf7 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
@@ -74,7 +74,6 @@
 		reg = <0>;
 		spi-max-frequency = <20000000>;
 		voltage-ranges = <3200 3400>;
-		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,com-mode = <0x0>;
 		pl022,rx-level-trig = <0>;
diff --git a/arch/arm64/boot/dts/amd/amd-overdrive.dts b/arch/arm64/boot/dts/amd/amd-overdrive.dts
index 128fa942f09e..940cc33f3a69 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive.dts
@@ -51,7 +51,6 @@
 		gpios = <&gpio0 7 0>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <7 3>;
-		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,com-mode = <0x0>;
 		pl022,rx-level-trig = <0>;
diff --git a/arch/arm64/boot/dts/amd/husky.dts b/arch/arm64/boot/dts/amd/husky.dts
index 1381d4b2bf1b..e4a6a9122671 100644
--- a/arch/arm64/boot/dts/amd/husky.dts
+++ b/arch/arm64/boot/dts/amd/husky.dts
@@ -70,7 +70,6 @@
 		reg = <0>;
 		spi-max-frequency = <20000000>;
 		voltage-ranges = <3200 3400>;
-		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,com-mode = <0x0>;
 		pl022,rx-level-trig = <0>;
-- 
2.12.0
