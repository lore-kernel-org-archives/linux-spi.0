From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH 2/4] ARM: SPEAr: DT: Remove nonexistent properties
Date: Mon, 20 Mar 2017 10:57:19 +0100
Message-ID: <20170320095721.6724-2-borneo.antonio@gmail.com>
References: <20170320095721.6724-1-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijeshkumar.singh@amd.com>,
 Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org,
 Jon Mason <jonmason@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Antonio Borneo <borneo.antonio@gmail.com>, Mark Brown <broonie@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>
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

The properties "pl022,hierarchy" and "pl022,slave-tx-disable" are
not documented in DT binding and don't exist in the driver code.
They have no effect and can be removed.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
To: Viresh Kumar <vireshk@kernel.org>
To: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
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
 arch/arm/boot/dts/spear1310-evb.dts | 6 ------
 arch/arm/boot/dts/spear1340-evb.dts | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index 84101e4eebbf..e70f78b7eaf4 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -358,9 +358,7 @@
 					#size-cells = <0>;
 					spi-max-frequency = <1000000>;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -391,9 +389,7 @@
 					spi-max-frequency = <12000000>;
 					spi-cpol;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -407,9 +403,7 @@
 					reg = <2>;
 					spi-max-frequency = <25000000>;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index 6565f3cb866f..f31d2e83fae5 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -451,9 +451,7 @@
 					spi-max-frequency = <12000000>;
 					spi-cpol;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -467,9 +465,7 @@
 					spi-max-frequency = <1000000>;
 					spi-cpha;
 					reg = <1>;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
@@ -501,9 +497,7 @@
 					reg = <2>;
 					spi-max-frequency = <25000000>;
 					spi-cpha;
-					pl022,hierarchy = <0>;
 					pl022,interface = <0>;
-					pl022,slave-tx-disable;
 					pl022,com-mode = <0x2>;
 					pl022,rx-level-trig = <0>;
 					pl022,tx-level-trig = <0>;
-- 
2.12.0
