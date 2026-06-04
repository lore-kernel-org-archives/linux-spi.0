Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4D3C09FB
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555881; cv=none; b=rvf6jSWmidOKVOLLiLr7D2XZbI6dC08Ok/NeDAPIDd9YrVd8VuQ/Vtbja0PIGfw/U/1ndZbVibZnvfr6F2mQ/XrtPsBd0X1J7vAkX2i4RW9d9W43tVM9keopAS5lMui54iW8N+86jPywlOKeJ1SUZHIQm6R4h9yui33AUGMaajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555881; c=relaxed/simple;
	bh=fpy686p8ddKfyBsPF5CtRR1fnIjNugEqnWE+etuOQjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKhA0RvDJ5XnYjxMWscgSV1AvwYTROKIffGdqqg2JjEMZ7zQYD2sMiMG40dKIzOwiedBj31nxqBe5n42U/pKDlVGS7io65HbiL5FiKPWDc6n/+EtzHHEtQToM/Vykps5wb/QWbPoEVfKqZzc8rTwfB4SS8g3IoTXrTmKJdPZCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WjQ7e68W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjOIUrVK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WjQ7e68W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjOIUrVK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65424qTF2368077
	for <linux-spi@vger.kernel.org>; Thu, 4 Jun 2026 06:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2088GKdH+0zCG19DSxc84/cxuUQLcsZtoIjUnM9OSZk=; b=WjQ7e68WNO+wU0zV
	dGUp414Hr7HAL5YpWcHuOp9E6BZWI+kZS3dHY9KnC+hV6a/k94rLrm+e2m0dv7Sn
	wNRdON9ssESYFfiK/JLAvwEVdtX5IxRQzuLnZrUTA2I61xYFgz9NBSXLniQJ9o6r
	PW3QRYxhXA6q6KG+x1bnRIUvKJLkVnGpNVmWAhMPZr8eFsWPeYV2F4M+1PdzTNd2
	bu+x3nLGXpWscvNDjGIaahQZKQbtxCWUysoQxXRfsr+RjhwfcPcuRdvm0s0hBcCj
	coyn90pWlCFpWBKGMqG8yXnnCFF28GrUyB5vMko4YEyKw2Wf754zoLOcs9VVPL4k
	+A436A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj3gmdvb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2026 06:51:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8423efbfb61so279411b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780555878; x=1781160678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2088GKdH+0zCG19DSxc84/cxuUQLcsZtoIjUnM9OSZk=;
        b=OjOIUrVKU3exK8VyPOPM77y3/X1TVowMMdU/CKYCHl9o+e6P2J8+wP/9i+bHw7hVMM
         O5/EhGniUdXUAV1eBq9KqDEQDgM2+UVwE5WXIi2Eb3JCtCCXZvk+jV4K4ENEvg3wdmpx
         dlilu9iEe6lyZ4ZGJaHw13b9fUB8RCzjn2+UmgU+YIRVd5aa+6BmtTIHtycqF4CRO4eE
         97KgYlBdTFMk/15JTVisDPxCvvZ7P6mpmzNkNGYWKzk/AlGlg/pIwSQiKHW29YYlE9h+
         cUN89ZJrIbLIPqtoHsi0SxMZEr/gCNPjfEgIs78Y3/fzK064znlUR/afjfbAmLuoGef4
         MugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555878; x=1781160678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2088GKdH+0zCG19DSxc84/cxuUQLcsZtoIjUnM9OSZk=;
        b=g/qtej0sPuaRgAZAS8vADennXyqJ+0AHQAijLvxIk/jHGYQ8738MHeHrNenOMw89FX
         6OUoPa4K2shhODntzXGNsXy4ztNQVIlSAprRIe7hqsjeFWXyRZIuwzQjgPvv0VQzrnKn
         tJRgSn2ncLwOUgjvrL9QxamwwDIzgO661kzJhILDCaz2IdQkrUlbSBGavkHxVCT75HVh
         8sVKToLw4T9GkJZy9/+Nm8L1iuTTLnj4RBtMmbMBw4gM6b+fc8g7kGaNlI/c/Ll0y2H5
         EqvcI/AKwwKsiVUjdL+b4YEQWLyWlBqbHbTPUqlDdx9730cNkPMPGShA0Ujw5mierOtG
         LJeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZhJ65hy8hF+OHweraTqE5gGZJ8dXrPCtgmd/hDxRe9zjeYU5zFAtP2YyPh1NJWs+KQv2l4yrLoHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAzKzAlOOrPZyAAfv6JitZR277DsS19EBIW7LYSmMpUC4p1lV
	dWL6iywhD106l4fDJjuH9fUmobeIcWNaNx2ubokQbMYEd2O8K9okRrkZwnKPwHgt3CDAa8xdNQ7
	Vn83Y3sHXQUj3soHjeVleDv0lQnaDdNj4erQg+pGRzkKt/ewzczH+NLi1IloiZ2s=
X-Gm-Gg: Acq92OFmD6+UnADBZltX+S3GuKHqYiH6DVNlpqFIHXneoDWX3oUPs5NwBhmWwifJTOa
	U5hgwwEB6vLrXl/GP3UHk8YncOX11QF+zX0Svl47hvSGdgPZVtuc4cTkG2+Szz90NOAUceSpeQD
	5X4KRp3eIMzt7/AVYd7NG5w5WPdFU8khhEe0CGNGykArPRXt8cRg81GuGWMJrTi0XHFz3VfELxI
	0sS3fnL9cEZkQvhDUBQFa6q8b462eV1BMP2t5TQP9GqpaxqxgWfsGtIdE7VrR4TC/MpOE719Qk1
	dfbhziAqiKuyqlhrKYgMKJkGmlT3AquiGlQ8aCIeg0+LUZF3alb+hLyHDaVRhABVKKRBSZwEB30
	5fGH5t/2R5GX9gw5qitE/L0jp9Kvv+SUa9lB8HD4IUvMcge9mGlV/R4ahtsSItkCF1A==
X-Received: by 2002:a05:6a00:451b:b0:834:e092:2631 with SMTP id d2e1a72fcca58-84284def9b3mr6399201b3a.8.1780555878109;
        Wed, 03 Jun 2026 23:51:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:451b:b0:834:e092:2631 with SMTP id d2e1a72fcca58-84284def9b3mr6399171b3a.8.1780555877584;
        Wed, 03 Jun 2026 23:51:17 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm5365894b3a.15.2026.06.03.23.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:51:17 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 12:20:37 +0530
Subject: [PATCH v3 3/4] spi: qcom-geni: Use resources helper APIs in
 runtime PM functions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-enable-spi-on-sa8255p-v3-3-43984eac4c67@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780555855; l=2060;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fpy686p8ddKfyBsPF5CtRR1fnIjNugEqnWE+etuOQjA=;
 b=pcA7p5YWDG4hCeq130/J37d67EimO2DpnPJYKmiICTCw7KfXE+tSrz15gtNbpWrvc3bYmqQKC
 iIz46UvSQCWBQSxL+lk22jcwjFD1DdvyMn/DvSa3ZNwPE5d/V5VnbE/
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2NCBTYWx0ZWRfX01JEvjpdWAWa
 VWRa8TzbBolmYnleAP5uKpBNXUbFiMPQb9BXgrSiTGvZjW2hmTv+ig2l5uptt5+P3yu0ugvfoXE
 TXNWs09V190QR0HiFyUPglWfq1d8loK2yf1Hd7yUeygH3DoV/k2E3oHJ3GpvwhY8XQY0y8d3Gfo
 52tGj85P6cW/swWEmh0npABkPb369RoAMERaS9RhCp/YRGQEP4EjumtWKkrdgDez5ucqyzM0s3D
 51jKRSlVhiW9hNkP/LqQw+tano2x2xB+rTSFb3s5JiywBw3qdSLc7512Y7HIn6sv0w+PgQ88ZzU
 fVoj09GSlJhhAI+hV5AQ3ZiIJcyBe3kZ1w1wD9Q0k06GScXcja3y7qPa2o3P2oxxiCdjRButHI7
 zzi9Ux9HY+WuM08DV5K/jmgwtbpnXQBKkV6Qb/n41kvupBFJblIIdO+oOkHdrJWL21fjtzzBzwW
 okmtZluNkDs6lhh0tFQ==
X-Proofpoint-GUID: mH0EsI7SO7ZAdBOT0B54OqRbX4uKqZhz
X-Proofpoint-ORIG-GUID: mH0EsI7SO7ZAdBOT0B54OqRbX4uKqZhz
X-Authority-Analysis: v=2.4 cv=UvhT8ewB c=1 sm=1 tr=0 ts=6a212067 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=i7xoKaWEWnc8ZE6DH4sA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040064

To manage GENI serial engine resources during runtime power management,
drivers currently need to call functions for ICC, clock, and
SE resource operations in both suspend and resume paths, resulting in
code duplication across drivers.

The new geni_se_resources_activate() and geni_se_resources_deactivate()
helper APIs addresses this issue by providing a streamlined method to
enable or disable all resources based, thereby eliminating redundancy
across drivers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v2->v3:
- Added the OPP rate restoration in resume callback.
---
 drivers/spi/spi-geni-qcom.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 333216df922e..420534937695 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1119,16 +1119,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-	int ret;
-
-	/* Drop the performance state vote */
-	dev_pm_opp_set_rate(dev, 0);
-
-	ret = geni_se_resources_off(&mas->se);
-	if (ret)
-		return ret;
 
-	return geni_icc_disable(&mas->se);
+	return geni_se_resources_deactivate(&mas->se);
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
@@ -1137,15 +1129,14 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
 
-	ret = geni_icc_enable(&mas->se);
+	ret = geni_se_resources_activate(&mas->se);
 	if (ret)
 		return ret;
 
-	ret = geni_se_resources_on(&mas->se);
-	if (ret)
-		return ret;
+	if (mas->se.has_opp)
+		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
 
-	return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
+	return 0;
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)

-- 
2.34.1

