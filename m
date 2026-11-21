Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795246376;
	b=NpCR/vffFK3qRuuWhJqSPlSFxhrvgahDkXOuXdAVcCQPC49bwDYgavdxYHclrv/gadl3
	 HQbzi/HTXd8t0sm7krPsoV0lRfctxTUVgcVe/jz0a0qMama5FN8JhHHeWD0Kswz8m6rOs
	 LC5iahVsUPJgo82SM3RQ6vwRgi4frolnvQexys/EUBEpNSRH1/f7N/Hh59SXxjgzzGFaK
	 VppaNg2rIHsxv83FdrK9xQyDVkqj8gPApAkJ/+3YJr1CpEN+QX63VHJkBOpWuYKBs/lhU
	 LLUKGloOtEmrkFvg7alTFK2GVjjUi5m0SosBCWnEFh9oQ0ZaJdGHMemVtFXID6780bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246376;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J+dcPkcXZ3s3MrRG1MQfLHmivGBQKC1Xk8mvOi8nCLY=;
	b=AK1Vzwy7baLy3zk12xKfW++5OoE/+EH9Z28dowSg59UWPDrPQ6H4ekgg+SJxiX8fGlUU
	 45yqGcbvzfy+brPqpt7gtnN/WJJOzDO2dCy82AJuEEm7+2ihI6u5douQlItaabpMDOXCq
	 YPubjztL2Xl3BHpr+PylAh9zVl22/L9WttcYkx8LbHHtRIsqyG+eXCgfac3gsGP7i3nq6
	 tfAQv6M6MJ8+nnvjzREkEJeOzD5bqQjWHaxs90czi5t0P6/45fN43pOKTa1SOPCOLU1kg
	 7vk6tdypOEOmvSwFtXPPgIbl69byJftU/98VFJfcRtZfaNFoMeRPoyjj7C4xWya3p7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=cdVaEk5e;
	arc=none smtp.remote-ip=203.205.221.209
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9BF606A334;
	Sat, 21 Nov 2026 07:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB9BF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=cdVaEk5e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795246373; bh=J+dcPkcXZ3s3MrRG1MQfLHmivGBQKC1Xk8mvOi8nCLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdVaEk5eAIPmIOk5+F6iMsEjzv/6emr9/7h2mxKPmyKZLAUvRxaK4ZINgaScYjX8E
	 5qUruKO6tpmBZ7BiX5sgmPmY+nvwdXQFxI/bgQlLEoRTS5Fgrq/bhFwCU6eLTzD69j
	 ZWwlvXhWWmreQC3PGSWE87ou6cNTxlG5wW/cmTEg=
Received: from jerry-PC.lan ([2408:8249:5f:7101:71a:8713:56b4:5043])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 830284BE; Sat, 21 Nov 2026 15:32:48 +0800
X-QQ-mid: xmsmtpt1795246370tpq3bznqd
Message-ID: <tencent_E24973E955D1A26CF5A4F983929F8F8B0006@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uL2TWbxEEsFmnEnc19DykXbomcd2rucq3Q6VPPxwPpOeHB46Rxg
	 npusd0Ly+Fokip3MjyxvihICinj3t8vmi16KbS+EOadnd+Pendf3RXwhFo7NgyNQ2bNs1H/C+KMw
	 mVGG7wUFNhi/kv01GV2CUaCFeFj1FH9zUoPrE8TomhHlG/jx1Z7bMJbkV6dsxYoI8fZE9H5FQ/un
	 W4il3/9nuVDr1++Js9FwfFTxFofpJiKcb0eMNNZ/O+Hc00Lh6xc51JRm/IpJN67BMeD+wTvjpPVR
	 OKmcs6pGNAzBqRsosgX/UOFCJM83v6nNtmPx67Jbvh8vjOtLKJYmXECPmCGS5eiC0RrT+ryhBkiR
	 BV/clgdO53uRIr5ppUPA1RGgLgLaT7x0qU47/6pk247M+3sLAFF19/wr4IozDoahbm6csbcg1WWJ
	 F3GhZHviwUT/DNBTv4mbW+qLUj/4jaobcMu+78J0RogRxxMBt4AlzgofwAeLUcqS7UpAfu+7c11p
	 mYLKVOLzDO7Lpkw/6m8cekqwfDZs4qvP/hnT+Gm21YdCv//eAbBgjgPsxX/b4TVLxDz7Ik0m/5An
	 4y/V3J2cu02gSUBq411+z7aFIwEjSxL9NwXtH1H6nPMMCo2SVen7wH1FwLRgo6GNqXYbtgwwP3qp
	 UWcfdBh4Uc0o/seo/OhrLgk7sWFsyQfjkKsGYt9cCeXDlYrTQ15nlqkzjDVSXHr3AoPnJyLabg/Z
	 2O595qusTXNq3sG8wtDaHeyN9vCFCVqS/KPWRV85Vr6HN4Nj3u4qkDySk85w192Pr5md2E/iTgEJ
	 piEiue83T/I9qW7B4XvsBKgXO2FZZ4FvrQRlrzcOksliwCzxNjIlDFSccFIAlo7RYKVkxYaj15J1
	 D/nRnNybZnL86uEs8ILw1GE21Jw9a43FGVcChcVt++IJp3vrSHR1RbgXotjixOHpBRiKj+ebx+H3
	 Edgg9Y0RiR4/FUi31QFHviFszp8+Q+rjuruPKhct5Pky53qHrFBkohkO+8VmGqePK7Q0Pt5mUSOY
	 m5d+V3na/Yspj1jjf751kzbRrXkTIEliA/YC6cDXQyJHFSIDKUHi8ZcEfTSWtqv0pDGAoFoA0RFe
	 KB7byoRic0F++fgksk+yFnEZC/tQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: ZhuXiangyu <1194781887@qq.com>
To: Mark Brown <broonie@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhuXiangyu <1194781887@qq.com>
Subject: [PATCH 2/2] dt-bindings: spi: rockchip-sfc: add RK3506 support
Date: Sat, 21 Nov 2026 15:32:46 +0800
X-OQ-MSGID: <20261121073246.1233736-2-1194781887@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121073246.1233736-1-1194781887@qq.com>
References: <20261121073246.1233736-1-1194781887@qq.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the RK3506 FSPI compatible with the generic SFC fallback, and
the rockchip,grf and rockchip,max-dll properties used for the
power-good handshake and DLL training.

Signed-off-by: ZhuXiangyu <1194781887@qq.com>
---
 .../devicetree/bindings/spi/rockchip-sfc.yaml | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
index ac1503de..428740c8 100644
--- a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
+++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
@@ -13,13 +13,27 @@ maintainers:
 allOf:
   - $ref: spi-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3506-fspi
+    then:
+      required:
+        - rockchip,grf
+
 properties:
   compatible:
-    const: rockchip,sfc
+    oneOf:
+      - const: rockchip,sfc
+      - items:
+          - const: rockchip,rk3506-fspi
+          - const: rockchip,sfc
     description:
-      The rockchip sfc controller is a standalone IP with version register,
-      and the driver can handle all the feature difference inside the IP
-      depending on the version register.
+      The Rockchip SFC controller is a standalone IP with a version
+      register. The driver handles most feature differences based on the
+      version register, while SoC-specific data such as the power-good
+      GRF offset is selected by the SoC-specific compatible.
 
   reg:
     maxItems: 1
@@ -44,6 +58,14 @@ properties:
     description: Disable DMA and utilize FIFO mode only
     type: boolean
 
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the PMU GRF used for the power-good check.
+
+  rockchip,max-dll:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Maximum DLL cells used for delay-line training.
+
 patternProperties:
   "^flash@[0-3]$":
     type: object
-- 
2.47.3

