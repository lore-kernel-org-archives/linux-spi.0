Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793086028;
	b=aQLr6NvUNcp2ppvO3XDhONuWIMkWTe5kQe7dLBhuTAOt2fANqZ8PVtuerAJPYxKf5vbZ
	 SjrNcv+K8meeyA5srhLvZwLzuTI12hMHi784WDwaVx+AMHLUUCPrmGJQEaCtI6Hedw+Br
	 LMUvatTLF/MDVJ0sdWIcBkpYVPsaL6uHT30lPcU7j1gaMP7y+oXdVaiuB1XRFxjegNxUz
	 XZOvqhuIiGEkABqPNep0JagUGUlrmbwhC9fP3msmAwEZe8SGsxqucIO0gEB8H/miQmdfO
	 XRtuIlfh95RJbE72nyKd3pj6a/oOTiUF9aWQ6gCbs5NNlWrP9MJoMZr4ys+sw6eRCbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086028;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=pNrCuIc4nI/9b2HUfvsMvC1mEskTl5Io94M+bohlWuA=;
	b=uhROPEIhoswB7TRhmcq+hKeyJySVITAIytzCxXAVcrNKQ/UTGBkfGNCGBCnNP8M4l5mw
	 /hdsUNai6Sscaa19UY0wnFeSFeq91LELFgInKBy5/vmH4p0xdK0pKd1FR7R5nDWAcaK+S
	 stWsUHGGg+/5WQWzB86Kihbqe1Ey6/uXQvlImt1DQx6c2uyAPOrMepsKogd1zMKN18/2H
	 afZoOltJtPUJfDMm/zE9uvamsptDp3uGmMLOvgBc2BkC93XjJOnGm04c+itvLnpmyFfuW
	 SSxJiPlX5re27YfuJs8gQpq6rrbevPs9dlQmnANP/WUHMUdi0FBQ2jTVmTX/KcERrdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=IGEuXV+h;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Oed2ALse;
	arc=fail smtp.remote-ip=185.56.87.1
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B914606A326;
	Tue, 27 Oct 2026 07:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B914606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=IGEuXV+h;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Oed2ALse
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com; s=arckey; t=1793086027;
	 b=MwTcUvFxHOOHNjBJWpgk1TGvFdz///IIA9DIGcX/aKp22dM0NIkTz5n/YLP2sw0RgNbsqIx2HP
	  6eKD/WgCOQrJ7u7wJWjkeh5DhoK36x8Vk83JIOijltwgN2kUWQcIHTUOH9lA/+BjEOR8ClSUnK
	  DKXTIFBdkpOa/tYxhNYPrBUSQIxU2NAYrRd/Mj1rWmMGBEybDWvJIvGGcqsbWUwBhqBlSTyBjv
	  eqsqkcRQiuxZioWb9BeMvhTeJ1CPWUtu8IzBQsdJCo4CHG9A7w7kkmc+sONUsJyXLrRS4Sefrr
	  34YNTn6734Jy8AkgXhBsIQ4oTUpvrueMZyZi3VZcymsK3w==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com; s=arckey; t=1793086027;
	bh=LDK4LugOQZXd6u5/d174ARNfTIWaTg73VhRuc2QL5ek=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=h+HWf5btdX1Iw2T6TyAAiW+yjET83mpd+eFh5EgPDRLFH88iTUCNbqN3gkOY1l3XKyCltO2mpt
	  yVMxk+B9sYmoey2LEiQRchu7EfkycpQ+lMlJ0unVFaV1DoYk0EaU2KneW8Zma8ViJKfJxGnnod
	  owbSr4wPiha4eDrNDU8Kawod7ksFU414qm3dvzyOC25uw4u7naCouMhxMmcrzRc8dZTWs5lSxQ
	  2+YbA1ohFtpk7GgrcIwrOugFdz1hpYdTqpfAABVZCpLpXEEl22tj9rrK8+dxV0Gjmp+PvQVqZq
	  BO9u9EHJ8HjWQD8rO7uc8pX0mdJ6sRmSErJyhWZXmrj+OA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=pNrCuIc4nI/9b2HUfvsMvC1mEskTl5Io94M+bohlWuA=; b=IGEuXV+hETjH/Oa/xKDsyA3Ugh
	dhP++Z+39NrPc7ymE/qb7zwbFYsKyExlcJIRCk93wCJC+p0TWIE1kyTJ60W8AYTmmr7BiFuceXSXv
	PICf+kDpypVPfJBG9/uU8lobdNvUynO5mAViPoc4afcL1c7Fw2+e4ziIe7uwdrj/DkiU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLbaF-00000001QSH-0Svw;
	Tue, 27 Oct 2026 07:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=pNrCuIc4nI/9b2HUfvsMvC1mEskTl5Io94M+bohlWuA=; b=Oed2ALseIjUH49kWwbydqZ2kYy
	abWprFTLqJF5kool4AYE4TnE4sdyR8DbTZ3KzdzuNAkjIs1ZsZoIHMfyLTB6bprc3YN1QI6rD8PVO
	PJKxJKkiFrXfTn2nScycsiRVzApxdPo4boVWUfvrmA/H82sCCSkLwtZQKKM5SPor9rXM=;
Received: from [87.16.26.129] (port=61474 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba5-00000000J9d-0gu3;
	Tue, 27 Oct 2026 07:26:49 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 27 Oct 2026 08:26:33 +0100
Subject: [PATCH v2 1/2] dt-bindings: spi: add spi-virtio
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-spi-virtio-bindings-v2-1-67927b24b9d4@valla.it>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
In-Reply-To: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=francesco@valla.it;
 h=from:subject:message-id; bh=LDK4LugOQZXd6u5/d174ARNfTIWaTg73VhRuc2QL5ek=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkPgsz/aMoXTavtuyfE0phhOeXp/YTMRrlpKtfeJ4Ws/
 in6b19iRykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjARh+uMDD+mPY+QXKYq2115
 w+m05MZnhSlBRldFxHZ5n7NKlYu1aGVkWHfMubOWMdRymt2Hq+58j8qUnUuPeGWIzNQwY/jVvVi
 bCwA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 70bfcfd00f2f559be35532f19e221e1e
X-AntiAbuse: ID - 70bfcfd00f2f559be35532f19e221e1e
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xLbaF-00000001QSH-0Svw-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add bindings for spi-virtio based on virtio-device, allowing proper
validation of SPI controller nodes declared as children of virtio
transports (e.g.: virtio-mmio). Such nodes are not used to instantiate
devices, which are registered by the virtio transport, but to define
their properties and establish dependencies with other nodes.

The compatible follows what the virtio framework already searches for,
"2d" being the hexadecimal representation of the SPI controller device
ID defined by the virtio specification [1].

[1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
new file mode 100644
index 000000000000..5fc04a9c62cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio SPI controller device
+
+maintainers:
+  - Francesco Valla <francesco@valla.it>
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+properties:
+  compatible:
+    const: virtio,device2d
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        spi {
+            compatible = "virtio,device2d";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            sram@0 {
+                compatible = "microchip,mchp23k256";
+                reg = <0>;
+                spi-max-frequency = <20000000>;
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 03649f08c7c7..5724645bf703 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29675,6 +29675,7 @@ VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml
 F:	drivers/spi/spi-virtio.c
 F:	include/uapi/linux/virtio_spi.h
 

-- 
2.56.0

