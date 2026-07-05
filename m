Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F921DB95E
	for <linux-spi@vger.kernel.org>; Sun,  5 Jul 2026 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272468; cv=none; b=DrWczzJO0i5+dAYEd3plAzE5uWqKbzg7cNA1eMAxsvRVsUmOwDOe4rsiQ9X16oMWRFYvFfLaBqdOzodcK+cYJUXTAAzTz7nHNDvcZ6a6SnHGyZa6xIi9xkjdI7LKitlZBXy5V8SbcLjcDomzwz0B5bhZBWgRBwGTZMjr8NJggoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272468; c=relaxed/simple;
	bh=QRRdS2Pd1ePyydxnjdAX6ngHiu33hJ0WfFQS+mciQbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIXXKJuGJsVs7SBGWrrPENW/PwZo09u6Y073yF41J+7IcXK/xrcie46Sd6QxB87l+woqGyK+96IBvZx7zn5IVqlHVAA91PiiVnK4UZ0afryXefnXEqKO27OeQBb2iy+PMmJVx2V8mVEsyiK2THVQVynFZENwAvr7O+AUMXmEGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDODInpb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=au2sPY3p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDODInpb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="au2sPY3p"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664KXSpE3829704
	for <linux-spi@vger.kernel.org>; Sun, 5 Jul 2026 17:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8sXJH4r1hnd8AQ34MDhpqTfUB/LmT2KkQwZ
	yuUOAR4k=; b=cDODInpbcNaHPfZNNGusM8IgAkBJKdo4rVBBNYKnmmkmm5i9VG2
	1MLNJlXrIEiKttSl5BBEGIUkBIb74v+BEXa8KJbnJZpzUaUf1m/A71GWwQ6FWuOT
	cz9bKlBqcmMaJvR5xMEX+35yZDZgTXQ8S+ZpLxKhccWs3jGqjPWyNZQ16SmlBRqK
	n4UESAuUqP8VhC9TyKIp2ECOeX2eM8knp1/r2quDYcUGQViI/sR9b4fB3ISV1d8r
	aF9xfxPD9Ea356LbA3JAHX2mXqSECg4h7RdmhsoAdhPTKbdYzVSbeVnJSfRztZ1m
	I+uoeD+MVDIbKrhzFTkr5Sab+/c31yN/0ww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txek0t3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 05 Jul 2026 17:27:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e62e3459fso180049585a.0
        for <linux-spi@vger.kernel.org>; Sun, 05 Jul 2026 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272465; x=1783877265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8sXJH4r1hnd8AQ34MDhpqTfUB/LmT2KkQwZyuUOAR4k=;
        b=au2sPY3phPe2S89Bmq5tlEerOa0Hgf4LHkkfeP3sy7Wx2idfbDFGQQQusaG5ZlD8jO
         pRWnEq6qrLuMt9IIZx9Yo9dmuCK1wMmVDWxxOM1AToBUIcokyXwAphYZ9GJwF8D3iZUh
         3t1xWRz6vISMuXcbvtVYA4+UJQehN/VlC5Cm/uQhSiTLVOwj6i3gHMsxVi3SBMCHKzkU
         WlFiEeCQGPqn4CCiDYReQpDnSUQuPctyhWHkFx4CS27TAdvcTfwI8eMZEcV1uqQCF4u4
         CyYf07//hah2Qcih/6itA3qgEFDtN4hb5anAWGt56jpnqhGEhS93uA6U0GBsmKMlSOAR
         dh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272465; x=1783877265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sXJH4r1hnd8AQ34MDhpqTfUB/LmT2KkQwZyuUOAR4k=;
        b=dEOjBFuuZN5h6GEBDQ+nFu7PGHqeDwTisf7kPKoQr5T3PpkbxdCENiBfGQ7NWuanuj
         hTx6t1LUC5pNd88BUCs3rqS560KY7cnOxRbhQZp3U+oMRFEVyhDS/vY1W/X0dekC9T9o
         4Du8PLw36b4nEewn05LAZtLOgpniwM5A+TfGteG0+2aWlcJy/hZsIqppDmSo0eM7s3wW
         FK1NYwqOH0vvyAN0U/3uJr8gMvR4CceRS6gK2oxpGd7+KVnlc+7oknX8+ZLKHGBT/6ZK
         x70pXGw7qWC86dHiIbhyZbasMBNuh0neb27fIWg0H5sAa7xZXGj8gr3jVGWJeLvPRYtt
         Yxgw==
X-Forwarded-Encrypted: i=1; AHgh+RpjemhonrVh81Zvaac00P8ONFyaroX4VPX98oKKEYkm71EQg455/knJp5imiCgqgngOOujRI/rzdZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7kPgXm/Sd0/mUaKcJcv6CyPZsGDA3qtaWsF1Ka7MTahpAuzAB
	X8Vjg+HimTMdJHIwwKIkKUFCmqNzWcIUepP+QHUbMspr5DQ+sLWOvp01FQeLyjFAxNAIlQQQ5iC
	XbotD/JPQY0xwFMuD2nfP8XSnVVF1Sur4hWWUETxKSkTHpPeU94qX0mEWGksgXh4=
X-Gm-Gg: AfdE7ckNnqt9/yJ+6XbCx+8JZysp/TlLpQouH8y8RfyPnKC55I4HX24yQGp4xnyzZ3x
	7A+p6pHa6xVgwl4sxQoFzu89FOQ7BEmfiezdM2wnO0nUnUIjZ/8fGifu22u2I9YuD6FOXebXDkl
	w63f5BFYx9G1d5Vo9PWH5oskKFGyx70uIQYEvTncYOVzn6i//xogf4msQ3L0sQaSsozrQrSYqwO
	yXx1GXIiUEaT+dZ54NKRH6kDohpTackmC3fvsUTZquxdGQregnQlb2oaKwi/9FZRF2WlWtSYgL9
	Qa2kveqFh0xcBNVRy5UMRqOUlzPRo+QLtEOLpqxQGijPGDnUDcRbiUMMgTp0z/dwvyxQ//pOBX+
	Ee40IZRrmuRlZGFGp+jNVljZ855Q=
X-Received: by 2002:a05:620a:17a1:b0:92e:84f0:d3fb with SMTP id af79cd13be357-92e9a35a445mr1072271785a.15.1783272464812;
        Sun, 05 Jul 2026 10:27:44 -0700 (PDT)
X-Received: by 2002:a05:620a:17a1:b0:92e:84f0:d3fb with SMTP id af79cd13be357-92e9a35a445mr1072269185a.15.1783272464323;
        Sun, 05 Jul 2026 10:27:44 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d620sm229444375e9.1.2026.07.05.10.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 10:27:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/3] spi: atmel-quadspi: Simplify probe() with local 'dev' variable
Date: Sun,  5 Jul 2026 19:27:38 +0200
Message-ID: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4164; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=QRRdS2Pd1ePyydxnjdAX6ngHiu33hJ0WfFQS+mciQbI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqSpQJuwzdsMGFY8qxUvKwPtt7754KIgm4RdnVR
 7oZK58quEaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakqUCQAKCRDBN2bmhouD
 19kcEACP7t1ngzzR35UXFvXYOcjkc+8ZZ8myWF5lg5L0gYV4Y6p1uKCaax1EUYAcZ48bHpVBio3
 2BMB30yrz60Yv3mZDh4WBrFZ9M/5dpSKKzrWuRxmbEoR9yTT83TXqXNisYWmFZ/zLzgxWfQBnnF
 YdyPetTYANm5D00KRK8wbVN2PBnvX9FeIPRWe4IgAz9aFH10yUeFC43oVk3QOUdAS/EgWGsTn9w
 nwsfZivUuN2OIC/P6tW7vEzuRsWjJRLVpJoI/cTxw65Xc3RkQupJ88Frxa5NGntfZh0qlJYRbGR
 wu/j31TL40GtKIY8enSZzjGPcfVkuSOl2xaZeJT/K9xkQRbHoDKXwwFnUoVZ9N223a05WXGtDlv
 iGW1i29eEYaSSaINUwDB/F5GX7FtQBTevjE0WlMxOvM9fJgcoBPgYz+J53np3qjVQNHSaDJttvR
 Y13Q3mprXF6X8MRO+NzQCjYOHoHo33forGo6CMQ79/h1R6Ngff75wD0VXU5aSECOGy/ChOEgX/c
 pUsDTrcjBQ3QcRpPlLozEw29BjliZDBlOOFsmlyfUrq/p/C2dj2OIj++b15cE1wMfBG0i8764Bk
 +xU9tczUM/OrnoAvVT32Rzh7pcJN5En38kjYyitAkyDmmF3KF1GEfS0eq3WTxv/XeGPolT08CDJ BuliZBtO1az8eXg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4OCBTYWx0ZWRfX6o6Dqp8RQcKq
 sLhW8tnabK7dIJJzs3zCK6qp20DJ/RLu1u5xyoQGFaQrj/TZZoCsCpQum2fogaPIHG0vQkyoEiE
 vMtN1nsVnL5BRSvrIg01CNf5bAnpeJE=
X-Proofpoint-GUID: NSgJDvozfXnDo2HYeNI3qGZC0oXiPOZr
X-Proofpoint-ORIG-GUID: NSgJDvozfXnDo2HYeNI3qGZC0oXiPOZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4OCBTYWx0ZWRfXxhu+0Na6mQ6n
 7eBmu1+YfLo5fJXiLQFn/i9Pialq+ohFc/CoDp9DPPsaRe8wBpQ73BEydI7MG18mdKzi1ZWlYEz
 WOvqx0R8B2Z5ec378AKXTKqsO0UUPEa+wbg47ekqpMoMo9doNmrD/hYTa7ifbrKFYuesKg2lyw8
 Ai4FGfvAbQjTU2/mk6sEoBmVIAuSI+ZEKmQx5K6TiarnqBIYqZQKLnH+y9YoOT6o/NGvQjt4j1W
 /Bab9B4S9Sbq8/h6a/XbAzHlEaU9C52O8lwQ+rVtA2li076xQj1jWO7QQZMCvPt0jqHWuztvccl
 cFI5sNd4pmFNXspiTidJjDBjZ9pjXAlQu5phNK3fixBRfBvx7/4tRQhyR6HSPVL+izylbRnM+IN
 5qQlcyVN84ies3mZgX82MYj21UnFzwmE5XaOBEQm4+YiQgtHgb/UXcWlEDQwtiyY3+2V0cIRL1U
 B3/HdkpxtckkJAnI70Q==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a9411 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=py1YOEah02oVGpFNBJcA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050188

Instead of multiple '&pdev->dev' dereferences, just use a local 'dev'
variable which makes multiple function calls shorter thus easier to
follow.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/atmel-quadspi.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index aaf7f4c46b22..8d9c77f5de43 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1347,20 +1347,21 @@ static const struct atmel_qspi_ops atmel_qspi_sama7g5_ops = {
 
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
 	struct resource *res;
 	int irq, err = 0;
 
-	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*aq));
+	ctrl = devm_spi_alloc_host(dev, sizeof(*aq));
 	if (!ctrl)
 		return -ENOMEM;
 
 	aq = spi_controller_get_devdata(ctrl);
 
-	aq->caps = of_device_get_match_data(&pdev->dev);
+	aq->caps = of_device_get_match_data(dev);
 	if (!aq->caps) {
-		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		dev_err(dev, "Could not retrieve QSPI caps\n");
 		return -EINVAL;
 	}
 
@@ -1387,31 +1388,31 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	/* Map the registers */
 	aq->regs = devm_platform_ioremap_resource_byname(pdev, "qspi_base");
 	if (IS_ERR(aq->regs))
-		return dev_err_probe(&pdev->dev, PTR_ERR(aq->regs),
+		return dev_err_probe(dev, PTR_ERR(aq->regs),
 				     "missing registers\n");
 
 	/* Map the AHB memory */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
-	aq->mem = devm_ioremap_resource(&pdev->dev, res);
+	aq->mem = devm_ioremap_resource(dev, res);
 	if (IS_ERR(aq->mem))
-		return dev_err_probe(&pdev->dev, PTR_ERR(aq->mem),
+		return dev_err_probe(dev, PTR_ERR(aq->mem),
 				     "missing AHB memory\n");
 
 	aq->mmap_size = resource_size(res);
 	aq->mmap_phys_base = (dma_addr_t)res->start;
 
 	/* Get the peripheral clock */
-	aq->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	aq->pclk = devm_clk_get_enabled(dev, "pclk");
 	if (IS_ERR(aq->pclk))
-		aq->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
+		aq->pclk = devm_clk_get_enabled(dev, NULL);
 
 	if (IS_ERR(aq->pclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(aq->pclk),
+		return dev_err_probe(dev, PTR_ERR(aq->pclk),
 				     "missing peripheral clock\n");
 
 	if (aq->caps->has_qspick) {
 		/* Get the QSPI system clock */
-		aq->qspick = devm_clk_get_enabled(&pdev->dev, "qspick");
+		aq->qspick = devm_clk_get_enabled(dev, "qspick");
 		if (IS_ERR(aq->qspick)) {
 			dev_err(&pdev->dev, "missing system clock\n");
 			err = PTR_ERR(aq->qspick);
@@ -1420,7 +1421,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	} else if (aq->caps->has_gclk) {
 		/* Get the QSPI generic clock */
-		aq->gclk = devm_clk_get(&pdev->dev, "gclk");
+		aq->gclk = devm_clk_get(dev, "gclk");
 		if (IS_ERR(aq->gclk)) {
 			dev_err(&pdev->dev, "missing Generic clock\n");
 			err = PTR_ERR(aq->gclk);
@@ -1439,15 +1440,15 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
-			       0, dev_name(&pdev->dev), aq);
+	err = devm_request_irq(dev, irq, atmel_qspi_interrupt,
+			       0, dev_name(dev), aq);
 	if (err)
 		return err;
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	devm_pm_runtime_set_active_enabled(&pdev->dev);
-	devm_pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	pm_runtime_use_autosuspend(dev);
+	devm_pm_runtime_set_active_enabled(dev);
+	devm_pm_runtime_get_noresume(dev);
 
 	err = atmel_qspi_init(aq);
 	if (err)
@@ -1457,7 +1458,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
-- 
2.53.0

