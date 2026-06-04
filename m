Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF63DA7D6
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555886; cv=none; b=N+fwapDb79/6oNdH/6HkbAp9+itj18HWnbpfsM6olK7Rgkz/PU5MH6f74zXvaaneSYmA1Luj8tI00SKw2oJB7nl0ZkcDfjj3JQhrPZEexFdoF5IwizFbsamfsmsK+wz/4dgI0w6haJG3e6v3OyhcITL2SoI2iRQdonkTo5pqLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555886; c=relaxed/simple;
	bh=QrJa6QmmVo43BgQCLwXV/uHCInZpAJ510TCi/NxzQ2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hgi6FE2RPSJxZnOIjJTJbWM7ZKGb1Xq9yDptfSPM37k0AmgshGQgTLvOY4SzygK8HWdIZ2m18m6LoZ/2bQ5cmZvYxGLeWS3ilO42sdENy9bCuTA8O1iB75G1IyLBNA0b9ylJXYrlSD8E7aOYieata5eS1MzOBkwjGO4ncHkGHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z6bp/Iyx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ETAeVR39; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z6bp/Iyx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ETAeVR39"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6540uKnI598640
	for <linux-spi@vger.kernel.org>; Thu, 4 Jun 2026 06:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k6/s/Ll2pjRqqTLT2vU5HLBxfu7d8ihaQntI6L6D3aY=; b=Z6bp/IyxDMGZ1QPL
	JbAyHzWhmWo4VCYjqWtaKFNk0M1B2SPQ1o/2T01EKz6T9CtljeABoUSdG3LYvX1Y
	3v1jPLVz6CfmMsqupXsGNcnMnE2xG+qVBv1Zt8nCS01hw/eI6h5XJ3xWBcWCBfu8
	Ft+1dWNU1xBY2dbv6WCx4GDqbjS+LeH9i4zv6vdtq7BORstVgQUE5JmGrhBGvYBu
	vWeDstYhv4cUgm3lPpNuyRMWi7wZmVhFgqYHrX4iZ2xS1vPSsnE4cYz2P5d612MN
	ibJxuEI0cuks8sFV28FS4BY1et9SO6nJ+0oAMi3k1nPIZ4+3h85JBM0+8V5/uuLN
	qlvuIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy8m11h3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2026 06:51:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85a298cd62so311462a12.0
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780555883; x=1781160683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6/s/Ll2pjRqqTLT2vU5HLBxfu7d8ihaQntI6L6D3aY=;
        b=ETAeVR39bXvd3mJz8zNzAL0lC1Br3tjjjT9LAXNxsMS6OB5KjOVixRaz1kmhlAhCVr
         VuEpxTMxIMBN6wD2/DtSMF3aTDMzxsFk8qtUk/WpzxEtC7c4LahVRf2WKVx/JCrQtLn3
         R/R/edjvTKX7eOqb21u0vgxVuNEySXlt9/5wpSNfniggQKJ4sn0WKtTbicy/Yl/tdS62
         46TtdYnvlbUfgUajcy2vgffy35gfaA0k1KWPbjThtvDLZpIWT0wjy23ZNoLctTmoOUhD
         rDCG7LysmL57O66lEK2vY/ouNmGFileFvIAOLYboMho01IkliMBZynE9mo1OAE1aJf/i
         +m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555883; x=1781160683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k6/s/Ll2pjRqqTLT2vU5HLBxfu7d8ihaQntI6L6D3aY=;
        b=HwkKfpnhfUGJHMbkSH3VRqQH682wf6931+vHfCP911vCARH47ymahl3x2wucmjxSOT
         XLbcKxBYU5HZMSeZUDlkjd/r49LqJejLYIRehEPsIFpuVtJanm2OaxF7whsor2RTtTUI
         arpDwGyZWu3+1lUuAF+e4b9avUcWlFNWUfXqt6kzdEDe9/RrCilX9e0nfTuQYAKIpyEZ
         jr6q9zrArEOiOKnURwD8FZzXdmFLs+M8BUlb546M9KSnQZLteesIVhE6hFweVe/cvpt+
         gBY/TszKY3BhpwhgzcSDqJnm2XdrzJ4O5S3ykl+Zvi3Nfr5zqdnSRXHMKOaBxpdz2lbw
         HFIA==
X-Forwarded-Encrypted: i=1; AFNElJ/OcbbLJHTB7TIoSnn/NMXZiYzEMTEFHUuH+gFBT5RfafixQWIhHCGz782FAN5FwZY1aUCuzL5VBjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYl0mtRml1E41a1e3BtbZn4f0CqxWfnaCXBxoewDX94BYzPV7K
	2tmdTUT87W+xnzrJtCjeqPvHz6Kx/VSBczxy1p1UR/HijZUJDCDW3w+o9D9A2/khHsaT+jZLL3Z
	9N6j+/nFZhXhEPIdE+PlC3GFO1vpUPC1BHFVEhkyLmBF2MFq26FwlrVrKiPt7WqY=
X-Gm-Gg: Acq92OE1d/rIEh1YY/u6tJ5OUdlNfZNMCnd5581aXRA0qvWsLa5+0jtciEUECp1hdh8
	N1VAILfmPma77+poxIPYnuwtQVxFkGkf5AI4lLt9VqHV0VNbFx/W6hg37FBgCJXbP45gS7ehW3y
	oF7zkUXGZykfQz0FnhpHAXt1HX3NfdGuozBOlX0vwbvNAVNAnMcSwm8Ru6W7U5WNxsZHCmjL2T1
	RSjFniFnVjXlMq/dQF2YdRSGE1TWDtWgnSh7NOEpJlSA08ciqNW5DG8aTIfX2tv6UMJenFs7/M4
	Ua/c+F5jVtl964xcVSXabhH4MTKht+mMu/dClnedPJy23hm7fw+zF5sNxX/7xKvud1cbGxgf3T9
	w5zLTEdUdDlOgquHFYtf7J+EtDrIa4wAKqmvCWk3Cbid8vgFSTNeXf4NOv/EosEaERg==
X-Received: by 2002:a05:6a00:4508:b0:842:6a3b:60c9 with SMTP id d2e1a72fcca58-84284f5fc0amr6035152b3a.24.1780555883206;
        Wed, 03 Jun 2026 23:51:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:4508:b0:842:6a3b:60c9 with SMTP id d2e1a72fcca58-84284f5fc0amr6035112b3a.24.1780555882616;
        Wed, 03 Jun 2026 23:51:22 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm5365894b3a.15.2026.06.03.23.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:51:22 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 12:20:38 +0530
Subject: [PATCH v3 4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm
 platforms
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-enable-spi-on-sa8255p-v3-4-43984eac4c67@oss.qualcomm.com>
References: <20260604-enable-spi-on-sa8255p-v3-0-43984eac4c67@oss.qualcomm.com>
In-Reply-To: <20260604-enable-spi-on-sa8255p-v3-0-43984eac4c67@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780555855; l=4719;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=QrJa6QmmVo43BgQCLwXV/uHCInZpAJ510TCi/NxzQ2c=;
 b=lwPiOOh3IqZUDjL+lepayZg6zcoWUToaF9SOWtOuc4HJ+XQ/C6yzEFNV1n7md+nBIjEASB/Ru
 SPlmNW6H75xAAvQYb+2lacnWRvDYBtE25gAAyI7qaFH1/tNO5rTTFKW
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a21206b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=L4oeRUVQnX-q_C5JrjwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2NSBTYWx0ZWRfX4RAr/Vjenrsb
 Dq6O2Z0VOvMtqKGiIE5ZRQzpqtiKZlwtjMSKHwz0Q9WDF1BJdEurVrFfbVWGikvUDrgxHk7Xdbm
 tZsCCiFmSsulL1Ts+ZjecrqQ0fwdWt7imA22b17diXIySuW6uPG3NVvBPaP491URKdLlL2P1Qwr
 YzvpyDLE1EqHZiQzQK/f/yE0F2+HA5bKs4reNUwjJyXoh0ukTfbe7va+PKjb9tVBT0W6K9v3eb4
 jrZt0Y5E0MHqJBc4YZkshYGQhCyLRYSi6YSAiY2jjzuKlgJY8t03VwBOk23rmc8VHQrAi8BVKoK
 V2TOq8AoTmpTSHzZdJSzZo/+sCcQDV4meBnIvOdJ1CP9guKN1GQw0fB/ti3JcildzQX3MXoaU86
 GKILdHZdlbJ08ByNpO3HURBWJFyThBMu1KR/f3jTbrnqDOg8daGJQG9tIw1to9ZRKb+gV15v8D2
 BaK5qwN1e9WxZjGuq4g==
X-Proofpoint-GUID: g2ZlnarcEWHqa5LlvAXafseMypzOf9iD
X-Proofpoint-ORIG-GUID: g2ZlnarcEWHqa5LlvAXafseMypzOf9iD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040065

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages SPI frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate.

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 420534937695..1b92fb1bd8bf 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -78,6 +78,13 @@
 #define GSI_CPHA		BIT(4)
 #define GSI_CPOL		BIT(5)
 
+struct geni_spi_desc {
+	int (*resources_init)(struct geni_se *se);
+	int (*set_rate)(struct geni_se *se, unsigned long clk_freq);
+	int (*power_on)(struct geni_se *se);
+	int (*power_off)(struct geni_se *se);
+};
+
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -105,6 +112,7 @@ struct spi_geni_master {
 	struct dma_chan *tx;
 	struct dma_chan *rx;
 	int cur_xfer_mode;
+	const struct geni_spi_desc *dev_data;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -305,11 +313,12 @@ static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 	writel(word_len, se->base + SE_SPI_WORD_LEN);
 }
 
-static int geni_spi_set_clock_and_bw(struct spi_geni_master *mas,
-					unsigned long clk_hz)
+static int geni_spi_set_clock_and_bw(struct geni_se *se,
+				     unsigned long clk_hz)
 {
+	struct spi_controller *spi = dev_get_drvdata(se->dev);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	u32 clk_sel, m_clk_cfg, idx, div;
-	struct geni_se *se = &mas->se;
 	int ret;
 
 	if (clk_hz == mas->cur_speed_hz)
@@ -820,7 +829,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	}
 
 	/* Speed and bits per word can be overridden per transfer */
-	ret = geni_spi_set_clock_and_bw(mas, xfer->speed_hz);
+	ret = mas->dev_data->set_rate(&mas->se, xfer->speed_hz);
 	if (ret)
 		return ret;
 
@@ -1064,7 +1073,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 
-	ret = geni_se_resources_init(&mas->se);
+	mas->dev_data = device_get_match_data(&pdev->dev);
+
+	ret = mas->dev_data->resources_init(&mas->se);
 	if (ret)
 		return ret;
 
@@ -1120,7 +1131,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
-	return geni_se_resources_deactivate(&mas->se);
+	return mas->dev_data->power_off ?
+	       mas->dev_data->power_off(&mas->se) : 0;
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
@@ -1129,9 +1141,11 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
 
-	ret = geni_se_resources_activate(&mas->se);
-	if (ret)
-		return ret;
+	if (mas->dev_data->power_on) {
+		ret = mas->dev_data->power_on(&mas->se);
+		if (ret)
+			return ret;
+	}
 
 	if (mas->se.has_opp)
 		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
@@ -1177,8 +1191,21 @@ static const struct dev_pm_ops spi_geni_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, spi_geni_resume)
 };
 
+static const struct geni_spi_desc geni_spi = {
+	.resources_init = geni_se_resources_init,
+	.set_rate = geni_spi_set_clock_and_bw,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
+};
+
+static const struct geni_spi_desc sa8255p_geni_spi = {
+	.resources_init = geni_se_domain_attach,
+	.set_rate = geni_se_set_perf_opp,
+};
+
 static const struct of_device_id spi_geni_dt_match[] = {
-	{ .compatible = "qcom,geni-spi" },
+	{ .compatible = "qcom,geni-spi", .data = &geni_spi },
+	{ .compatible = "qcom,sa8255p-geni-spi", .data = &sa8255p_geni_spi },
 	{}
 };
 MODULE_DEVICE_TABLE(of, spi_geni_dt_match);

-- 
2.34.1

