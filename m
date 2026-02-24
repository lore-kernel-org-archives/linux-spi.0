Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C383803F7;
	Tue, 24 Feb 2026 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933944; cv=none; b=dDKwkpFXvCywWE9jzBO+XjnEP3fETNelhWZz0slgdw2xKTtyIoN8LPR2UISkidYv+hx6wFke77rMj6c0v8vd/jaLLr7N4KcrVZ7gwm6iXNG7oJfhIZJQ/Qikvvn6C7GnvnvHGOU+onXsjeWHRTkYSTcIF4gy7T8oRe/NiC6DgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933944; c=relaxed/simple;
	bh=TlBht+3quR6+PU5VUY5tVHdyAa1AFWISZUf2mYC9zXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9WY155d24+9U4nSsCRc7MW2SKMLK+/dmA/rQg25w8gn8Ti6KFHNhHUrAQ/5gldqwm+49ZI8J5LJlP7wK/lJofmp2ih90rGKB5BiBj2ADwQMnag1mtzjYPAqH9Kjm6SPJ2wboVpWDdAhk6piKlXb9HFrZ6g1GuGhENEMAsLbDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnK4IxnN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnK4IxnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771933943; x=1803469943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TlBht+3quR6+PU5VUY5tVHdyAa1AFWISZUf2mYC9zXE=;
  b=lnK4IxnNfeY8jN/TjOdAf5aAj1BZhWTM3XC2yR6HsWDp+AkCR0EgCF5h
   3HbLGctnJY1W1OWS73ZF0faFBgMM3l6/gP3pW9bMAJcFkL28g+p6JNq0c
   EdgE9g1NGcWRkSCDcR0nkkbm8OSqBb6pN5COBIubaEou8b2BrtwOSrgzm
   7o2oUAHFXgKkS5icR/gj8uwrNNIUq0aC9R3Wo9HMR7nFzCw/RJAaVjLcd
   wJQ2hCLl7MI3RpAeeLxDAev0mD/jkb+goVGYM3PbUSYfRm8/7lhD7yaX7
   hNYWY6V2YCFpXyExe+96XZNbB2fsarINgRjoDvJYiitWoO2FknsUh2Hbk
   A==;
X-CSE-ConnectionGUID: Wz7PdDygRkefdhMPKZw2Ig==
X-CSE-MsgGUID: Ken4qc4sTZ6+nUazXENZiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73008194"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73008194"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:52:22 -0800
X-CSE-ConnectionGUID: T8E1PuRASm2w8CL7fZ6Xeg==
X-CSE-MsgGUID: gGnxJZUsRSm3840rt+kPdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="238862137"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 24 Feb 2026 03:52:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5C57198; Tue, 24 Feb 2026 12:52:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: dt-bindings: snps,dw-abp-ssi: Remove unused bindings
Date: Tue, 24 Feb 2026 12:52:18 +0100
Message-ID: <20260224115218.3499222-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated in the da0a672268b3 ("spi: dw: Remove not-going-to-be-supported
code for Baikal SoC") the Baikal platforms are not supported and
the respective driver code was removed. Remove the currently unused bindings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 31 +------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 81838577cf9c..8ebebcebca16 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -22,21 +22,6 @@ allOf:
       properties:
         reg:
           minItems: 2
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - baikal,bt1-sys-ssi
-    then:
-      properties:
-        mux-controls:
-          maxItems: 1
-      required:
-        - mux-controls
-    else:
-      required:
-        - interrupts
   - if:
       properties:
         compatible:
@@ -75,10 +60,6 @@ properties:
         const: intel,mountevans-imc-ssi
       - description: AMD Pensando Elba SoC SPI Controller
         const: amd,pensando-elba-spi
-      - description: Baikal-T1 SPI Controller
-        const: baikal,bt1-ssi
-      - description: Baikal-T1 System Boot SPI Controller
-        const: baikal,bt1-sys-ssi
       - description: Canaan Kendryte K210 SoS SPI Controller
         const: canaan,k210-spi
       - description: Renesas RZ/N1 SPI Controller
@@ -170,6 +151,7 @@ required:
   - "#address-cells"
   - "#size-cells"
   - clocks
+  - interrupts
 
 examples:
   - |
@@ -190,15 +172,4 @@ examples:
         rx-sample-delay-ns = <7>;
       };
     };
-  - |
-    spi@1f040100 {
-      compatible = "baikal,bt1-sys-ssi";
-      reg = <0x1f040100 0x900>,
-            <0x1c000000 0x1000000>;
-      #address-cells = <1>;
-      #size-cells = <0>;
-      mux-controls = <&boot_mux>;
-      clocks = <&ccu_sys>;
-      clock-names = "ssi_clk";
-    };
 ...
-- 
2.50.1

