Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F13D79FE;
	Mon, 17 Aug 2026 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009581; cv=none; b=Wr7cHkkZrd00JLbgGpnnXAAC76p7KNwKMQgxlqOLFwpYcOdbV5LhxLaXh8XKkGEtPkgIE37RP+kwPvo93iRRC3StrUF1733mOLant4OWeDF8Lrdr9jhNc3Stj7v/Gjs7zZtGUw0yjq5n1EtxyaZ5IR0IOtp11oCFABLJ6OfgRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009581; c=relaxed/simple;
	bh=7ykLVTWGG7i1kHJ09Tghic52YmrMic6dAf+5F2GJ62g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0EzINdqCGPdbheCLUEseNR0jfE4ko6AI1S3+JfRO9fCi58a+BGi0Ih9ykwVVDSLG1jaind8R4cStvCCnWSf9HQeukoqJVBmp1Fnl8pjSvwd2GwsbzXzOpnn6BeYFftPOns4f/PKoRPzIe3LwX5+rESbc8e3R6zBAj3QcmhKWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cYYleMaX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cYYleMaX"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLraY81197627;
	Mon, 17 Aug 2026 19:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QJhJJ
	5StkcnMLTxPbXRefngUlCdGxdNyVJ37S8SiqCk=; b=cYYleMaXhEA/WGawhopHV
	KZhYBqT9Iy1i/u9lJ1qNFKW0a79HsuwLcvXuMWPiXNBqhgPTTGnKFp5dG2/GPGVr
	xx+tzXp+ztC8u9d0yNblHOH2dGBNsYRQhrMGdL0MVKInB6FHz+D4KlxxCNl+7JnW
	xDEjJ1tIB0GEHpKB6DuZzTtNAx0/R4znjCrUEXKY9AlI1994rIMLoV67l2O5Gzjb
	mVdFyFwgISuvSGqBY2xUtoekIIZH0GFSV0+bQf3gr/gMMzu3oveiiLh64ANRcZ6i
	4kP8BvkIeaYUHeOGDnIdbhwvFpbSeD+78uwI3/B/FVV10i34md3XDvVyZYuMVmqq
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g2n0xj6yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:32:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67HNWq1O025176
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:32:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:32:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:32:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 19:32:52 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67HNWdlv020590;
	Mon, 17 Aug 2026 19:32:42 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 1/6] dt-bindings: iio: adc: ad7768-1: Document multidevice support
Date: Mon, 17 Aug 2026 20:32:28 -0300
Message-ID: <d19a27738ac13307191dd09cd4a3ac5df7f7ba32.1786973376.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786973376.git.Jonathan.Santos@analog.com>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: v64jUkCSncnSamc03TC04ywOLQyFnThB
X-Authority-Analysis: v=2.4 cv=BaToFLt2 c=1 sm=1 tr=0 ts=6a839a25 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=zIG_72r1yhliRd-3ghwA:9
X-Proofpoint-ORIG-GUID: v64jUkCSncnSamc03TC04ywOLQyFnThB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfXxoSWQmmibqpu
 F3eXg8YCr9rxr3OKdKxIrYLquzyPgA0prahDLC3etnwUyCijjIjb2fS+lrg49zuZ+q2Ubn94ZlB
 9sAr3f3jOm6gjkW3K6cTQLEty4ro/CzlYIO2sO8cLQJOPkEEyOVT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX8Wv2GXFjS+Vw
 6SYJbfsLtJ2ebSjU0DE0kruv4pTSP6hCAvVVzA2HG1HvWNWVV5zjBXP0oHd7q8RJ+g9QoggLKo2
 VRxeymtWPwzp+VJDtJujKYEOmn9vVrLBGQTeMc4e1qfzbSgO0KJOEj0nwcE0TU5kDDdBX2WL23s
 HN/h5FEymEmdC+rx34QL68VNNPxeZw6U5l+4tVQR/zLzY4a8YdOIvoa4EFj67Uvrc31xGy2wUvW
 lPC48uRInUVo8fG7zNSCb1sF7RpsdfbAlfU2ZTa5Trk401sLftwJI+FDIJc1izC8hzbYodqauKm
 IjGqyUW9f1X48UMozQIwuKQj/6ScKOp8VpSeJlw9T1szXjgsgw7BqpGR0Iy42CxPoa+t0d/Ae4L
 HigZaMhqQE/YAZbtoGaTgSZehKmbEeBAaVIAnT+oXTmA84jy//2iejT01Wj9laZ4egbWsLlSSNz
 aWlTccozvnuozmYHd0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170180

The AD7768-1 family supports aggregating up to four devices on a single
SPI controller, with each device occupying a dedicated CS line and a
single data lane.

Extend the `reg` property to accept up to 4 entries (one per device).

Add `spi-rx-bus-width` property to declare the per-device lane count.
Since each lane is bound to one CS, the number of entries must match
`reg`. Make it required when `reg` has more than one entry.

Add an example for a four ADAQ7768-1 aggregation, with shared DRDY and
SYNC_IN pin.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* New patch.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 78 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index dfa2d7fa9fb3..804793a56d1d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -26,7 +26,10 @@ properties:
       - adi,adaq7769-1
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+    description:
+      Chip select number. For multi-device setups, one entry per device.
 
   clocks:
     maxItems: 1
@@ -109,6 +112,12 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  spi-rx-bus-width:
+    description:
+      Bus width per CS. For multi-device setups (multiple reg entries), one
+      entry per device must be provided. Required when reg has more than
+      one entry.
+
   spi-cpol: true
 
   spi-cpha: true
@@ -203,6 +212,15 @@ allOf:
       properties:
         pga-gpios: false
 
+  # spi-rx-bus-width is required for multi-device setups
+  - if:
+      properties:
+        reg:
+          minItems: 2
+    then:
+      required:
+        - spi-rx-bus-width
+
 unevaluatedProperties: false
 
 examples:
@@ -244,4 +262,62 @@ examples:
             };
         };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/adc/adi,ad7768-1.h>
+    /*
+     * Four ADAQ7768-1 devices aggregated on a single SPI controller.
+     * Each device occupies one CS and one data lane; DRDY and SYNC_IN
+     * pins are wired together across all four devices.
+     */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,adaq7768-1";
+            reg = <0>, <1>, <2>, <3>;
+            spi-max-frequency = <2000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>;
+            spi-cpol;
+            spi-cpha;
+            vref-supply = <&adc_vref>;
+            pga-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>,
+                        <&gpio 11 GPIO_ACTIVE_HIGH>,
+                        <&gpio 12 GPIO_ACTIVE_HIGH>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio>;
+            #trigger-source-cells = <1>;
+            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+            clocks = <&ad7768_mclk>;
+            clock-names = "mclk";
+            gpio-controller;
+            #gpio-cells = <2>;
+            #io-channel-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                label = "channel_0";
+            };
+
+            channel@1 {
+                reg = <1>;
+                label = "channel_1";
+            };
+
+            channel@2 {
+                reg = <2>;
+                label = "channel_2";
+            };
+
+            channel@3 {
+                reg = <3>;
+                label = "channel_3";
+            };
+        };
+    };
 ...
-- 
2.34.1

