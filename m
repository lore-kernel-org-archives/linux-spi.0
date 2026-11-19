Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082812;
	b=aRparVxCTcN/NCXU7Rfsv2OFMOtq5IWN0CZtks6m9ZXPJYQCYOgj3jWOPkus8J3z5FMq
	 eF4EqltfNZ/29APJfAoEbhFwQohVXO+7DdZ+Xbz9YtKTe28I/p1o+zhWsVELr01VfnE2V
	 Nrq7x5PorwYjZDIwpmfQcjaGQueswslvcoDauno3FsNkKDnjbAvZYT/Tm95i4SEiuJ5Jq
	 byhlXcyPvGYmSUBjXC2P0KDVatAWPaolpDrCyxP/KICt/sR5Yk7QI3eGGEi0y8RYlPEPd
	 ELMcnqtWrlZpBvA6+nfw6ixoOy2/2knszcrWyimT05TNaoWncf9GxGGh1U/a44Yyk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082812;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ayZ4CQfE+X9Qlf/55z/xcn0wqd+hmZN9PBU08jmFeW0=;
	b=DTTlubJfXffLlJDjONamHotZCqEQCp6bwgp33p2VRRVq0CfI416fiMRW25URx2Dp4Hho
	 9AIaT1G3B0t07B9iemgv3BNdqmTsDkyKEvyFv7vaJTpIpnsXGPGy6rcG4vbWWiSxALZxQ
	 ++8TKJWtxHUVVAPVupOEU28YwVWWGSUjiknfPORmN98NQ3yygsUM/JGQ/Wrdm7KCVHuCX
	 JcUfMGG2MTI+bGKlvF6O8OuET2Uc/ICahhdgzXAgEBQAbrMfls/QEo4r2xtUCPoYM9Xzd
	 lYFNrUyczMRODsmzmOqcVZpC/lfdP95AGvua63Plg5s4x63mhpI02RsG/cb/4onc9Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=gJriSWMO;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=A64D5nVZ;
	arc=none smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF8606A32F;
	Thu, 19 Nov 2026 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3FF8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=gJriSWMO;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=A64D5nVZ
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9QwNH1362298;
	Thu, 19 Nov 2026 02:06:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pfptdkimsnps; bh=ayZ4CQfE
	+X9Qlf/55z/xcn0wqd+hmZN9PBU08jmFeW0=; b=gJriSWMO0OrLcmgT3L72QT8o
	2nlMum6hr4iSGO7OahSDsuQ2Wa3nIITz1KQtBTNBI6Mt5nXLU/WGA2yX8L4UU56j
	Lo9ZPfshCXmtrgWcqV/YpjxHxNuM0oc2DgWoYdVHSMNWf6c2+RPRT0cyVqlMIlQu
	Y1Zv+bZpnxSliX9bNZKvLgI4hfr9N5RTTyPTKIe49ysZ2lwyDlErRyBz2ozFEYIl
	5pJQ/oj63LvdFuLzhpb4Y3GOdBmqRsjeNA95oKsSIZvgUSqebFqdy9Z5YY/Wc79M
	lhgk0BVxCwVFKXCmg0N5ZF1KV8pFw5McEbWBAc6D8nsbB+NgfGRGYUdWKlFClw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4j1p42jx37-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1795082802; bh=ccVn8TaTydQF9x1jeY4S4y4f/JsaitSWG/OeaF0yN3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A64D5nVZE3FWnQZgbGEOfwM5E8lhFrTpgd3OtJOXPQ99+8uIGiOBtujYmCz6L6tfj
	 7iNLyW/eyJ0VIPgrFC9h8fM4WpGwK/kLnp2Da9PZoxSCDZXvwaaRaGZaO1q71WGL/1
	 ct/tyGc74B/q+apEOlzVL7HnYmtMGONy+4h//9PTu2OXHvh7pPCbXmuIQfFU0xKSrS
	 8vF7soqox+wi4hMyN8cMupuX0imC0HY9CQIqBu2wJ8IC1c2yNvmQVeHTkmc4M80Rca
	 Mlxu45rtQCQNK3Z/ODWVEXwu60CYoRY05qDTnXyS7KhjBk+igvuWVXHDVKundsN4cf
	 GMHBNBbWbk4XQ==
Received: from mailhost.synopsys.com (eudc-mailhost1.synopsys.com [10.213.161.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A8B0440B0D;
	Thu, 19 Nov 2026 10:06:42 +0000 (UTC)
Received: from prakriti-VM.internal.synopsys.com (unknown [10.150.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id D5FCBC17D3;
	Thu, 19 Nov 2026 10:06:38 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: [PATCH 5/6] dt-bindings: spi: Document DWC SSI XIP properties
Date: Thu, 19 Nov 2026 15:35:12 +0530
Message-Id: <20261119100513.433044-6-prakriti@synopsys.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119100513.433044-1-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
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
X-Authority-Analysis: v=2.4 cv=Zv94uN7G c=1 sm=1 tr=0 ts=6afeca33 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22 a=jIQo8A4GAAAA:8
 a=09aJQSSnLaRrio0I-XEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX6f4A2mnwANi1
 HSDAMHa6WC3Q2/o2oDfeGpEb6TBr3Qm8QLnFQaPyBcpBrDMPmjpT1brFZRhGgrXoKNK68bLiVZM
 rkdU1nl2XDFuE0Wsze5IieGY96cOvEPv0JKSnkPB4dBm4F7zmsY4YPiFBkt7xfm7vxsT0osJzlA
 Q6B/ZIXW8ewpVSlZHVycxCWKVXRST7icLJCAsh5TT64lmCIIljwMO8rPHKj5I1BJ+BZWcqiF6dO
 qr02FD2bY/WC+i+HGtsRlB0P2E2cBXu1uQxKoMFmvXEpa+HIswJN626bhfbijgyFucEG8ChUgd3
 EWrJH5kH7ugzOPTrGUUMwLPP7vLWWqYT+ws/OHUEr6Qe8/81TH38eZUrIbmv0R47H5YbNnjN1GC
 wpbcDchnyKMuJc8Uq1SeJPDHXLmdAV/aIYlVYuRgtu7qe58U7c9/ZPs04mPGWHfibCKBtnDinEY
 5G+f9dBNePc/eJXlQfg==
X-Proofpoint-ORIG-GUID: CeeuM24pgEZtieCI2k8ANmaZoyLbtjXx
X-Proofpoint-GUID: CeeuM24pgEZtieCI2k8ANmaZoyLbtjXx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX4Ri18VLKrs93
 dS7QVdxTZK/jdkmaNhWbhB9ITFpSFNp4dLbKlxGStnyqj8FDBg/65w+9BXrEsCBWdRkbaK0cphL
 +37+icxcmx3YRNrm8ojr23viQUT4F1Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611190040

Document the optional XIP memory region and the properties that select
execute-in-place, continuous mode, and prefetch.

Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>
---
 .../bindings/spi/snps,dwc-ssi-2.02a.yaml      | 59 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml b/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
index 7cccd627f809..efbeb59313fa 100644
--- a/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
@@ -23,7 +23,18 @@ properties:
     const: snps,dwc-ssi-2.02a
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    description: |
+      Controller register base and optional XIP memory region.
+      - First entry: SSI controller register space
+      - Second entry (optional): XIP memory-mapped region for direct flash access
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: ssi_base
+      - const: xip_mem
 
   interrupts:
     description: |
@@ -93,6 +104,48 @@ properties:
       of the designware controller, and the upper limit is also subject to
       controller configuration.
 
+  snps,xip-enabled:
+    type: boolean
+    description: |
+      Enable XIP (eXecute-In-Place) mode for direct memory-mapped access to
+      SPI flash. When enabled, the controller's XIP region is mapped into
+      CPU address space for zero-copy reads and writes. It requires the
+      xip_mem entry in reg.
+
+      XIP is used only when this property is present and the module
+      parameter spi_dw_g2_mmio.xip_mode=1 is set. The default xip_mode=0
+      disables XIP. Runtime control is available through sysfs.
+
+  snps,xip-continuous-mode:
+    type: boolean
+    description: |
+      Enable XIP continuous transfer mode. When enabled, the controller omits
+      the command byte on subsequent sequential reads from the same chip select,
+      saving 8 SPI clock cycles per access. This improves throughput for code
+      execution from XIP flash.
+
+      Requirements:
+        - Flash device must support continuous read mode (e.g., Fast Read Quad
+          I/O with mode bits)
+        - Must use consistent command across all accesses
+        - Not compatible with mixed command types
+
+      The controller automatically re-sends the command when CS is de-asserted
+      or transfer type changes.
+
+  snps,xip-prefetch-mode:
+    type: boolean
+    description: |
+      Enable XIP hardware prefetch mode. The controller speculatively fetches
+      the next cache line when the current access completes, anticipating
+      sequential reads. This reduces latency for instruction fetches during
+      XIP code execution.
+
+      Best for: Sequential code execution, linear data reads
+      Not ideal for: Random access patterns, small sporadic reads
+
+      Prefetch is only active when XIP direct mapping is enabled.
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
@@ -121,7 +174,8 @@ examples:
   - |
     spi@20100000 {
       compatible = "snps,dwc-ssi-2.02a";
-      reg = <0x20100000 0x1000>;
+      reg = <0x20100000 0x1000>, <0x60000000 0x10000000>;
+      reg-names = "ssi_base", "xip_mem";
       #address-cells = <1>;
       #size-cells = <0>;
       interrupts = <0 42 4>;
@@ -131,6 +185,7 @@ examples:
       dmas = <&dma0 10>, <&dma0 11>;
       dma-names = "tx", "rx";
       rx-sample-delay-ns = <3>;
+      snps,xip-enabled;
 
       flash@0 {
         compatible = "jedec,spi-nor";
-- 
2.34.1

