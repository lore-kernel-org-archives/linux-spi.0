Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299C3C73DD
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165735; cv=none; b=nbdo8EvJaTzhK5kaGdaunv933+7eLwMkZJi1XdEo0sC7UejRos/qDQtZwdbO6B0Hrz0+qhrwz4K8OLIGvLtzqXUZ0nrUzwCkNjhSfA5SvG9dV1qUIfjzHbP2BZdKzeX+/mTGYtRfZvffA1EgD9Ud+01iGag9y1MD/B2cf3hSPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165735; c=relaxed/simple;
	bh=V7MkOBUR12odsi7KOXU5pkJkgmqrQKIHXeinc3zf9y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERMxlFnWDPQ39KWYdCPibH1MyG464LRnEhMguI/cLSsJ2GqxCPiGW1JOLeDP5I6lJdwplPQEdNrvLtAYNQlbAbKaHOb75Uedx8GPlQs2//5OQnF23YblNhqxAq7zyiUg3cP4IgjNhmxJG9jU52jDru4xntwbn1Y6pNsoIl9CFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DE94gqAj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JJ8RUfhU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DE94gqAj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JJ8RUfhU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOZR2250176
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vr8YiZpN0OyBIFNURSbGh0cFsGwvnUNEPGlUDKpGzd4=; b=DE94gqAjdThWcu18
	uGQjgcwkGcUpWtjQsZShmNYFrPfInk/deWmpZT87efslTPQqtUk2xQtgKrE+OocX
	uvMERBCB1OAxSNnf0K72rrrQI2UgHFILBs67J3YVpc3/Knq6d7jDOiibssIyRoNf
	/7LyggpuxRtdq2XSTq9IZ60hLh1LF7HP2Cbg3yvQKsf9b4UQGs5sNOJmGrSDq+wz
	sqZ517U7cK1lsu4opInACKC/6wMzvQIDUdXgEPzFManNjD8olSFAZhL3gUVnw+Ei
	1zURFR0VMVUwgAD97R8pZw4N+iepL6OsDRGiGMWgZCKfPMZcDOoQ8o7uDGRR28R+
	bmWYsQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux519nu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2beb9002a00so78481925ad.0
        for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165733; x=1780770533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr8YiZpN0OyBIFNURSbGh0cFsGwvnUNEPGlUDKpGzd4=;
        b=JJ8RUfhUhvPVZkZhp2KApR0KTyAU/Ud7OgGRZtwTgXp8/LtBr+SE10aMVrOpawg7Z+
         l4zoCEedMEK/x2lXB2mESRiFoYvSKh171E6GEbTJkGpSVJTnXo+PWo7oysiHWFQDtQjj
         suMByWZwk8w8vuUig4i6UfX7lz8XH86pBWsgMAIXNFVz8D0erCic3zMHPuuzYAf55Zlb
         3RjvZODfeGzBcWqOQx/I5BnEkBtBCCPKELU3FYTkcRhrKFPNpCVA86jn3/LPYwRTYzbm
         BgZu/1EAled/a7FD0N6GqGVaLcGUgaLnOxOGD8vaGFYT2RI9ypOnaeanrG2M7AJR2Xph
         Md+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165733; x=1780770533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vr8YiZpN0OyBIFNURSbGh0cFsGwvnUNEPGlUDKpGzd4=;
        b=cKXCGVgo4sWACGiRyOhpTtrke39eQJ6GVOcWX5QoWbLTaQZYYqrjlyssOiq2K3H+kz
         OWnPxocpbuFF/3lg7eXfpoFJifHoaM2q6UBNfwT51RkilhNoWGKNekCw1lmper2hOOrs
         hMQYAYmkRIKU5bytDpuSk5owm3T7raBUEPxb73yzSEDq4MIYrasVL9z4aykTDynf4e2C
         6iHnCLveCZjJPtbES6XjlG2pEsCOJzmWf8T9KTSJAatu6ea+If9ZjQueeWij+nI8jocr
         HHbiQCCoqBfjc9Cys9DOoOR7FABuWfAuzaBEfAZmluidDQFQJafhUt3tJVAghS+prJtN
         Upsg==
X-Forwarded-Encrypted: i=1; AFNElJ/lnNOTL4Ab6O6D/g5n1DSX3iVHEYSfbw4CkJzwi1iqta3bFuSbZ/S8VrZEqFPJZbotCrvql9wJDi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7g6FadKGrd5/eu5kXrvjeSK3K4PcJCDp9DrFC8UbCucb+AnUT
	C2fLsMrjrN7NMWT9gHK4LHzbUbTe/AjySCkhLKI/3lWMQDb1XveGOpgYPce7MONUxBByHaiLeb9
	pCox5VWXiStoQmJW2EeGDv2ySy5kq7s+AZcYOw7UOLrWyNCSQ8vJd6Q2oXv/OlCI=
X-Gm-Gg: Acq92OG2PrSKD1QEvBUTfskqPLgOUsvwwLMF0Cy3eK6utDtS8OD/G6xtlXK/RokfF0p
	VxfIMXhCl6qjbWwnhFMfWh4WxkoMRtfoysHhdOTDPjGREoehQ7hlYi/Yu3HQoHDiMxJclcZlgYI
	5rMwNH/18CYsvGKa2NWpAelODenztc5GaoSl0puS5uZ9VvEnsUERhVHQAVn+iNUj/p7NTyThY1v
	3kW9/WcOc/UjyRUx69UezFZmEd3VsE8Pz3p8hGNHOzTKHssXdth5PtPRgFNfzg4XRjonqukl9Ze
	sX/dQKXzt505NmS78pylkQKy+eIYK2q9LqzlOYUhPq90VQ0y2GT2F732E3MK6PGkNXxgrSCh5Fj
	y9pvdtzog9W2lxBCQM4IjDDJ3Kr6EX+g9B1LuRzCNHLCAlbFqg5CY1fNTQ9xrLYlc3g==
X-Received: by 2002:a17:903:2305:b0:2ba:7881:948d with SMTP id d9443c01a7336-2bf367b214fmr52562185ad.1.1780165732933;
        Sat, 30 May 2026 11:28:52 -0700 (PDT)
X-Received: by 2002:a17:903:2305:b0:2ba:7881:948d with SMTP id d9443c01a7336-2bf367b214fmr52561815ad.1.1780165732323;
        Sat, 30 May 2026 11:28:52 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a27ee3sm56879635ad.36.2026.05.30.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:52 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:58:26 +0530
Subject: [PATCH v2 4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm
 platforms
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-enable-spi-on-sa8255p-v2-4-17574601bd63@oss.qualcomm.com>
References: <20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com>
In-Reply-To: <20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165714; l=4685;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=V7MkOBUR12odsi7KOXU5pkJkgmqrQKIHXeinc3zf9y0=;
 b=M+M3zBWjkBIXobrL2H3UEToreY0uiKZokaUZ1qWF/yo59OKaz5ARh4oxes0oNLBXul8VkfRL1
 Z8HogbPVcshBlGFSRl3UCKFi0ftLZtoyOEfFO2hWoOJ9SKx7NGIoHtq
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: Un0Zh-j98BUyjxSOafleG9y_e_VoqDDW
X-Proofpoint-ORIG-GUID: Un0Zh-j98BUyjxSOafleG9y_e_VoqDDW
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1b2c65 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pXSUDizEog3tsSCmG3cA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfXyHm1y6/zgtWR
 j4O64314xELfrDfyWddp2M4femYzsMv2N02FPwIbl8I/Ba6MEMeiNyw+HdF+b0q5FrICJlj/did
 MWR429ueXFXhXPKU7j47bRtmkAbKYZGushxv+F/9bZDvoF/zzA9dpY7B6g/uY0s8AXs8SqMXNrl
 HuzfrnLPuGYg7WRI310srJ8ns4oJgWi1eb16ruzkN2BNVlTq5cXJfz8UI4m6Kb1fclW0wLeq4iX
 i2LPeco2WTNSdCKZX8Z/t4NpSXHW9CP2E4eMDO+TSOVmxL16PH6XvrNs9KYXqc5+0HT6tBQcsTf
 WBlUwLLKpb99XdVE1KCqsmkiS95e7M2PGqbh+pjFbUnO2gk0Z9LASxDks2bTY8RYGisnz+TCInq
 ftliS0VDGBsnaoiQy2n/+mHY/kf3Yf1mO2FV6yJKj8i9sgr5ecjtT87iaHfhpQ3HKiixYERCxY1
 kl9hlAn77ck/rgwLSUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

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
 drivers/spi/spi-geni-qcom.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 7696412c6e87..98e34e58fae2 100644
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
@@ -1128,7 +1140,8 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
-	return geni_se_resources_activate(&mas->se);
+	return mas->dev_data->power_on ?
+	       mas->dev_data->power_on(&mas->se) : 0;
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)
@@ -1169,8 +1182,21 @@ static const struct dev_pm_ops spi_geni_pm_ops = {
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

