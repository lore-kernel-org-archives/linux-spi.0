Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EEE49C4C4;
	Tue, 29 Sep 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701281; cv=pass; b=MESb6fUmCdV/7gdVro+gRAcWxPFe5hjiTEH5UvexmURqSr5usTdxzqGHrCiPlUxXxYJh4cDtFW5HAa0/O1VHuTNtwJ8jkdo/cQW4KYUB3SxX/Y2lPfG5Nv7puqDO8tN59NQQc4uVeVzvp7X3GVuSLAb4P58jPSRxPg/6bO1/8SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701281; c=relaxed/simple;
	bh=NEO6eN6wS0lPN8V/79gLlvdQ8qhVcM1fQpGV/gBb6rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWURECP5NID/Sqrf5fRqhkQ2zbYuX9oMbrBxm8FEpGd+Nvu9RMbXCcZquEoxf6BwtyF6LzhOZPj66fQUiTBqlUBx+eSi72r1wCmOsCdgTADvdJDJlD9onKiW1zsTVIThXy5VH/D05E6lslW/k/zYHZ0abA54nFbm4oqs9YJ8DFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=P0ZLNd9/; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=C0OvlziK; arc=pass smtp.client-ip=185.56.87.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="P0ZLNd9/";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="C0OvlziK"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-ccx6.prod.antispam.mailspamprotection.com; s=arckey; t=1790701279;
	 b=aQhPKFRdwnffR+4bXq4Byw6oWOV+BmDVjJoM8GC8BKvLuHRu0UHfB88k/maxQ18jGCECX33s43
	  w7cS9X9x3CNuWYDu6dR9/RmPF39nQbO9llx136/hnh6v+IUMWn21hkURQ1KmXC9YjefGDSApwi
	  YDUOdk87VctQ+p9pX+GS0We1Jgx50RWjOydNwbYZL2p8RBZX6JaKt+1sftsFk+Pp66w2hj02t+
	  yhPMJ8ujGxty6v0kdNS1ZYsilLYYrMxG59oy2PsKhVj6vyLzXY/gBynYibNM0R0xwdxMwmUsGU
	  qwfQznw0MPhrVI6YF8+nlaUSR7jJb+o8EjNB5GsOuZgPfQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-ccx6.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-ccx6.prod.antispam.mailspamprotection.com; s=arckey; t=1790701279;
	bh=NEO6eN6wS0lPN8V/79gLlvdQ8qhVcM1fQpGV/gBb6rU=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=XEXfVzo8OItxVAM8vUKuFXcf09sz9685vLOjZ0noHcH8Jqb6n4qfQCwHU2f6/dZ/i7B+RMpF/t
	  F/DCHuKA2Zy7t9/rPKcU9HCGKltPXOLqNxS8Xrr0Alrua6LmM49l9yZjuyaIidJbOqNvPXFnKA
	  JiDrNhu472VRoRI8/b4SAByTfoVNXEtXRBZ36gNzgTzWWkBoptCVSFiYhNJZEojTW5WdYTvXxZ
	  Zv8Xcdy/RC5oCcibEd+awJYtlSFLKxwQzUxN1bvQASrS9JicxLuqbA3DRPEaPlvZPUdhDGPsfS
	  WvPns2WDMN/zNJV34WNWCLBj9wU/uvk/lH5lbqUMQ2SXmg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=GZnRLTX8nqK922cINDfyYF7LUeobLxPNi6zQddqL96w=; b=P0ZLNd9/8y2pIT/cfU5U5JKR6B
	6oQF3+bdhHdjyZBpTy2YmHCa6swnA9gZkVkYo0nxS8VlEwFkcXvz08T6pgmEoHMDnFSYi5+WfWZHx
	uDCcTQJ2nk5KxUlXLA5FzakTC/CVUDQxR2PXynSDK9RMakwcYVoDwxdrTGCQ0C/zcHIs=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-ccx6.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBauh-00000000RGz-2mp0;
	Tue, 29 Sep 2026 16:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=GZnRLTX8nqK922cINDfyYF7LUeobLxPNi6zQddqL96w=; b=C0OvlziK0x75uMAV1h1PiXonjd
	Fr4GQnyaJ/Xvvngq4KrpN2iJ+e0qsrS6+0dJTtHLjZDGjc9hgfRtOU4m3tx6AN9j1Xu1dcaIrcq+B
	UR+qb0cCBVT4mhk5Cjtkk4D+cJvMjxHjcN14Y8ZuQ9mzohVP9ycaL3SE6by/b8N/82Dk=;
Received: from [87.14.44.235] (port=61710 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBauc-0000000058o-2w5Z;
	Tue, 29 Sep 2026 16:42:38 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 29 Sep 2026 18:41:55 +0200
Subject: [PATCH 1/2] dt-bindings: spi: add bindings for spi-virtio
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
In-Reply-To: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=francesco@valla.it;
 h=from:subject:message-id; bh=NEO6eN6wS0lPN8V/79gLlvdQ8qhVcM1fQpGV/gBb6rU=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFm7X1XPNfFK/nbpun+WSs3a8kjnrQm103iMXF28l2xY8
 X+zu+vxjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAii18xMiyt0eIJ8BUx4Wdh
 r33ummq75pGY9Unf9XJ5NprPE/8kfGNk2NsZxTzv4aPJIobZvacFUu+1SBf+99RoWJL24OiXvr5
 jjAA=
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
X-SGantispam-id: 132c8cd9f1c7a1454edd65c9008c4892
X-AntiAbuse: ID - 132c8cd9f1c7a1454edd65c9008c4892
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBauh-00000000RGz-2mp0-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ccx6.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add bindings for spi-virtio based on virtio-device, reflecting what
already exists for gpio-virtio and i2c-virtio. A node using the bindings
is not used to instantiate the device, which is registered by the
transport (e.g.: virtio-mmio), but to define its properties and
establish dependencies with other nodes.

Add the new bindings inside the MAINTAINERS file.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 .../devicetree/bindings/spi/spi-virtio.yaml        | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
new file mode 100644
index 000000000000..5b8639dd2e1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
@@ -0,0 +1,53 @@
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
+description:
+  Virtio SPI controller device, see /schemas/virtio/virtio-device.yaml for
+  more details.
+
+properties:
+  $nodename:
+    const: spi
+
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
index 360977678f70..f91340fc6e7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29062,6 +29062,7 @@ VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml
 F:	drivers/spi/spi-virtio.c
 F:	include/uapi/linux/virtio_spi.h
 

-- 
2.55.0

