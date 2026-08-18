Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70786456DF1
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049974; cv=none; b=lP2kmK/LCV/FnKiNiRaZxkuCjmpFsUqVYo+FKHfXs2x1XMhrOD31SnS5SyOihAI9rHHy3aPFHVUInYM6wEJMNQRoNIhMIzCJ2bLVrFjLt2dkOMG9K3+Us9f2Ovf1nmbpAzf4VFDMtn2FbjoRRWQ7z91nYJfEe6tPbiv1gi7j+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049974; c=relaxed/simple;
	bh=dFfg+yi5CHzTc26iZLvWQGYdkQ4fnddTpoVHGJmMkSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlRwIGzkkGsQllTeo557WdPIn11MHeuz81TG2zcjCs1lOIJGQH+TVWQSnjtxfGJvi1ID4zBEMqFlj2VbF4h/rdlyCRyUM9UZAV9tByIH9qjy1lM2UC4EUJ5zqCl8EQRna3nVV8hK1G8NiUHaUuqgD+n1HprxakV1V8ysUOlAMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NqcHeBUW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CAoTF0vx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NqcHeBUW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CAoTF0vx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABWiB1021650
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 10:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SosYBOSUJqYzgFFI2VlCZ6y4w4ywG1iaTvH3S/tqiq0=; b=NqcHeBUWj7tPC+Gu
	1w++ZMfamb6DV66mYqnv9gHuWitrHBThd6Ut6kElZI7gZxNfATOE+mHiEcdK2wgw
	Kn+U8ZJfrWtKIQiTZsq3nc8FoSAumVBJrDyFYmyMvCEUXMo/YRfUqZ/juxbSqlwF
	6OgFh39Kn+RIhjL7X5IGbCavEMUT7++/poS8P0juXqeKPDI7Kk2MjA5RYCN4V7jr
	YzPQtwhL0ids1QjbDWs5qRDjETIM5wWEmv2PNPOgZTwux17w0JwGZMKocwIInzdQ
	1ibvpnbRZkec0dhxG8PGinsckICNdQuh3tC0pznGnzRTA1Jb5TmISHwvHj13c1oB
	R5lc7g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0u8tv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 10:46:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so105003615ad.1
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787049970; x=1787654770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SosYBOSUJqYzgFFI2VlCZ6y4w4ywG1iaTvH3S/tqiq0=;
        b=CAoTF0vxUJFNaXiaHNtVmqwLSSwPT+o4WV3+34XF60zYZDZTOn9sExN3rYOBr6K9xB
         Tuh7hp+rZlIv0zK44L9LHSB+DgwLTfVLkaU37zjUatyw2HXUt7+o0VXIXUusr6J4ClZa
         AzTW8PUduDi5TmPAayz1UYCBVdxK4tuIizyOM79zvb8U3r25QMc0xFk2nZAs2vVWO0RI
         ZsWDXdndsh59Yi/55S1p/OwCkfcwfdtYr8CLFGWjJYSt7Jqvu2h0/BePdpWq5O8I4EE0
         opCXOtiPLW/OcgqrPWP+dpFi09/dJCYp++arg4yquytDCwEjjNAF/VRFXkLE8h9jD6JA
         ARIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049970; x=1787654770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SosYBOSUJqYzgFFI2VlCZ6y4w4ywG1iaTvH3S/tqiq0=;
        b=d6ohFmH5W2AkNfGSOO3XdmurTC4VKFvW959xoyzTxDxxcYrki7kiZzJI7idbQQ6rpR
         q+DyuVCqyIj9YE4Ycit3Pb7DXjtjGgvacAxeWviAdfZFP+WSKGoSzu1itERefJftIB3k
         sVeKpRytGzdvd/FlaW1UinZmY/V+K8MSkYl2nVts04e2/lVm4taFYaPVSOlrdtV9UOvB
         FNY38h5/1NrzF41XyyAnnNHYN6k9iMY7IYwbO2xkP0R8zC152GLyXK5z47ryF/tBP48w
         6wB1YrIKMNCPyMSdt9SlbXcIfUiy+HwaqHnmvyyfxcqClFnlf1LU8bkc14I1tcKQJi1i
         wWHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqh8muafTjaQa6uRqdGwO8Bd1bHUAQWC/MX+e73uN0VYK2JfoeC51Diu1oXRo8rUWqiAE1Nhk+Ude4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPCdoAoyaPjw2rFG2ETZhYK9rQ8GCUN5Iu2bKBD7zYfue6Pcl
	Wop+oR6IpQCtN+vmJgIF7iXsR11/0mTAdsaLFeUXtTkJi3A5EOJ2Oowab+iEgxCzzr7IhiMbQb8
	Z7wFUK3LnR9sbJ9esz5ON2r2NdOHuObfkMOyKcZc44HPPuAdgvsdJXVVEYh8PVYxOYFMssEA=
X-Gm-Gg: AR+sD13I46np7DHN8BpU1Cwq+cpDZsQNWzZpNYkwvo43TPVy1/aL5YGdfYx+p2DbrsY
	JOoc2E/ZKxqRMDHbBeCe5v/50yp27omhvhjYYGwppYdIs9/BMIkQLn3HTiP/UvPflluqyIH2aUL
	tfRWx5MPutYWmfnFd36GE3JaxnBhlFFd8CfhIeIqO/81sn+QH+PLGg2K0zNpU7SyKOh6DjxbUFK
	SV9WPsfdCzd8vmYPvnDec8jnUMOGIIeLeSFAk+oFVg1vg/1tDtrI/SD3jnjpxZIpjYj7koHshV/
	kpLrllI9cRLtdAuKXYGh/Xr98Nmu5fBUrIp4TW+baphiCrKxVRmqcquPD6vZgegAmKpyc7lmEE4
	8W4SYwxHJungqK1W0FWaz1sCJWSInUwMAig==
X-Received: by 2002:a17:902:ea0a:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2d3b08987dfmr301062185ad.10.1787049970235;
        Tue, 18 Aug 2026 03:46:10 -0700 (PDT)
X-Received: by 2002:a17:902:ea0a:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2d3b08987dfmr301061805ad.10.1787049969782;
        Tue, 18 Aug 2026 03:46:09 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ef9b3esm12877935ad.79.2026.08.18.03.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:46:09 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 16:15:54 +0530
Subject: [PATCH v2 1/2] spi: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-add-shutdown-and-panic-notifier-for-spi-v2-1-eb25d56634a0@oss.qualcomm.com>
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v2-0-eb25d56634a0@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v2-0-eb25d56634a0@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049963; l=1573;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=dFfg+yi5CHzTc26iZLvWQGYdkQ4fnddTpoVHGJmMkSU=;
 b=MYT+AqL/5TOBXPcB8c5nXOH1xClkB9g1lwkPmjQjSHwqLpIlWFRcdkqZZKbTstNJVSgVBZREC
 tkz0hfmjV5QDt5LtNsmmUHIlnjW8//QKq7XuoXkI906tr8ww2wVMrI0
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfXwH+tIaFosciQ
 nRg8PBBuoSsM2CJnPTG7Q4jquWgdiDq5KD9Iqk+rVlm1o8Ju37SgULNrqwC1aGlJ8fZBgEkGAJX
 bxCczgvtL7ZrmO9mGAUndQH3Fb+3jh8=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a8437f3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Bb2fkNEn-BfLECvCvWMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: tGIGk5ruFx4kD8iyMjScZF57SF3pGffw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfX+zejzFe2xDrE
 plglM99rLu/S+sKY5PxnH/SR8iUXJXY8J6bJ5lqjXpRWUt0is8m/sSwesYDQwFhoK1ycyJc33MG
 p3CMFrzqfNqM+TFr77bKKjMSW4WOqdW/DjkGZQj7HRASRZm89skRwW5xnsUuIx2dLbiNuPtwN7t
 q6qdvNM3IPQH7dR2Rv/jxuQJH1nssA+G996iwJGiZugak1wHY8tjjlfGO2ThoVuYxcNVuK/rUf8
 a4rsfu3DnHXlRS6oU3BuRX/S5Ejp948W26GC2TR6Wi2XxsCbKSXg21CfC2WP9O7Pl1q/zRU6ZgG
 7kUN5t13/jvyaMyASBmALO1q9NWxUhRi5CDYVgOdPw4JjARkQ6YfCuIss+beeqnOKmwO0CvIsTJ
 6RoZ4KmU3wNDzzUNiOIfEVjdubs2963NPENQdTFXbEzDwvqZreACVpqdQzabdvgnoqrLR97aGOG
 XzT78HlHf2Kl/eUDosA==
X-Proofpoint-ORIG-GUID: tGIGk5ruFx4kD8iyMjScZF57SF3pGffw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180078

During system reboot, an active SPI transfer can leave the GENI Serial
Engine in an indeterminate state. On VM-based platforms, if a DMA
transfer is in progress when the VM is shut down, the SMMU can raise
context faults as the DMA engine continues to access IOVAs that have
already been invalidated during VM teardown.

Add a shutdown callback to suspend the SPI controller and abort any
in-progress transfer, ensuring the DMA engine is idle and all IOVA
mappings are retired before the system resets.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6566975eb24f..39d67f19244c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1066,6 +1066,13 @@ static int spi_geni_target_abort(struct spi_controller *spi)
 	return 0;
 }
 
+static void spi_geni_shutdown(struct platform_device *pdev)
+{
+	struct spi_controller *spi = platform_get_drvdata(pdev);
+
+	spi_controller_suspend(spi);
+}
+
 static int spi_geni_probe(struct platform_device *pdev)
 {
 	int ret, irq;
@@ -1242,7 +1249,8 @@ static const struct of_device_id spi_geni_dt_match[] = {
 MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
 
 static struct platform_driver spi_geni_driver = {
-	.probe  = spi_geni_probe,
+	.probe    = spi_geni_probe,
+	.shutdown = spi_geni_shutdown,
 	.driver = {
 		.name = "geni_spi",
 		.pm = &spi_geni_pm_ops,

-- 
2.34.1

