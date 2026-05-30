Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3843CF940
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165733; cv=none; b=SRJMqcCf54a+QxoTaZHREWw07QFIK3B4mxcSRnwvWx2ArZ50EiYkbmhbx+F3vO+pqC7A2lG6uXise+lVXL9GDLx+cvtxWOvbTcIkXaJJy3syuBDuzPc5J398yaNtDjWhoLQQ9Y0LRniJPX18y8ckoFwJhzOyPF/k5GWRlQ+HIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165733; c=relaxed/simple;
	bh=rlu63NqzgVZGbDQFT3XHJ2eEFRpxquNj27s2b770qto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gp+J543JFKTLoidefs7MFMGfSu0JGP6xH2oR7PwdbSoLjppISauIkSPDNRzvwzkzYCC17Mn3t9KD41AZCPvMRL7iA9UOiUNBbMcSB5ngrlUu1tCrwHWvcf5pQCpAJS9b9+h5bu9WjY4KUDJ08K3SDWY1I28nvQX+cGXdzYZZ3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdWfRsu4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a+hH4BJI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdWfRsu4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a+hH4BJI"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEP2ss1796288
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Grijfbm0GSs+meDyPd4bXAK+a5thmeqrFJ+N6944pxo=; b=gdWfRsu4Tv2tq5yQ
	KKNYzjhztAjyNy/cbGyBGKjDOI+VPkliaNCKt/zQewwxDiyWkEtmOmxp4BuMov64
	qKxM8z/4zV8nxTdYYcv/lbyPnbDIiAGO4J7Iz5hIGgHBwetmTCQJRphykcd+69p4
	4dVQRH3ZhfFxmbz/x5DdtHuOcvQXry96eqNkxrVtuWKjU3M+dOGLV5LMJmcnGeoc
	Z4rph33joVUKmEwXvyHpfTflwMVNO+0dJDNEVruaX+H6b/QUsi2hrhl6DPyU5xW3
	2AyqslReOtoPg85rMqinB48BUlJMoypDg/BszvWEB6VdhW+1COkLlB7B61ojedS7
	Qpr8TQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efpw7hw79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0532a6588so6553965ad.0
        for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165729; x=1780770529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Grijfbm0GSs+meDyPd4bXAK+a5thmeqrFJ+N6944pxo=;
        b=a+hH4BJI41NiXIPj2XlM7kKJ0w2bvnpDCAb1XtXFxlN9KDpkhk7AJi8cBvZyqC7Crg
         +rkekGN5G1S2sLSEEKyIIt9KYLaQNoFGbU0QV/1TGl1f91J/XYp6ClLlMHeLNm03R36f
         RHTCUKsOnpS1cg2KXzCedqLlCbnEkZ1FLiKZNXOQtyT06yFylwjyKETgU3SG+zsL8Ah0
         mXfarLGv9TIrCvFT6bUxaC6vUZHJV9ZAS+PTbyn3iM/h0x20yCvA7IAnDZsRXI6sARRI
         zGxufOOe351yFn2NxBBKAsFtCFct84GN6mdl9chx/OzDZYb7jwxYWB2Pxifbukpg8eUt
         Q+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165729; x=1780770529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Grijfbm0GSs+meDyPd4bXAK+a5thmeqrFJ+N6944pxo=;
        b=BJ2ggtamBGuYeG9xF+XkdJ2CTEWkTcQK81M8UmCirwW7848u6C6WzYDZZHOsyXyDvz
         OekreQs/eZjKABe4p/dMom+wOn77Tn9F3OOkggxmKKE2RdyWdYDOy4i025vGZmbxcM4F
         Hx6FkOAUoDJmnhFN0Rh1yLOTqE7Q+qQFUXYbd5MrXWscfYxQnUTagumjjWL/KyDvk3gV
         6QBf21QsuMw/e0HWInWA3ntgkLMDWMrZXujdRxEkeBdyeuClnhi3MsuM0GCMWR5t6bGK
         17ppI/RrvvKppsPvkfJ1todmpZa/dLckkPFup6oXsGv1Pn9k0UcUqSFz/seT7LAgfxkL
         HygQ==
X-Forwarded-Encrypted: i=1; AFNElJ8If5aTatnygM5Qi+pcnKTaqk4Mv+aPrVsZlQOFujZE8lXmhlETi5zSdLPzjHC6GXOg0vMgbBzMeMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrWwYrYhXwLqIcIesKi0MSohs9g9EUy3IAwAnI4PpcVcc+q97Q
	1iRhq46N8SaNgu/hOHqm1+rn1hF19tvngnHHMFmKJxIyq4a4wGolwbS0Ppa+bsFo9PeAtsqR6H/
	RQbO9JDReEjGmWXYH96crX/iXy8ilIEIgoINVv6katNdRK58qqClB0WEeiDLDfRg=
X-Gm-Gg: Acq92OFrBWKmZlvseXzCq6Vp9FXS8JbX7lz/ZspVVMjWmzWwqBsIgOJfBZjHZSDUmej
	MSLJ9O4xLPFuJFusK+RAjOjj+dj/bLtldlACTBhsyS9om0w8TSUj9r6Nh5BapwTt1J60s8tmLYH
	lwxJ7oMn66dlAn3CBPLSIjDVvGj8NTIzxDZ+ENcTflm7W6m5NsWYJeiWK7HEJFyzRHQkWPyTIcW
	Cp1Bjt564tqSkhZTgoqKvd1BxRx+YMJRJocerBNp8QoI5Tb/A831eiVzSGIK073U/Qxszv7DC5W
	o8YcNdCSxkrH/Db/ok/pJnRWHg74WuGpw2GvEUFbTcrugXuPx9aGNbEn2kD3Pn/y9I2V50XgoBk
	JTwUk2CORJcEogcTAP6HtTomQom/yok/4j8054Jc1jDMJWU0fgbSUAuoFeBq5klgrng==
X-Received: by 2002:a17:903:124c:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2bf3679571cmr54559535ad.6.1780165729605;
        Sat, 30 May 2026 11:28:49 -0700 (PDT)
X-Received: by 2002:a17:903:124c:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2bf3679571cmr54559265ad.6.1780165729033;
        Sat, 30 May 2026 11:28:49 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a27ee3sm56879635ad.36.2026.05.30.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:48 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:58:25 +0530
Subject: [PATCH v2 3/4] spi: qcom-geni: Use resources helper APIs in
 runtime PM functions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-enable-spi-on-sa8255p-v2-3-17574601bd63@oss.qualcomm.com>
References: <20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com>
In-Reply-To: <20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165714; l=1862;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=rlu63NqzgVZGbDQFT3XHJ2eEFRpxquNj27s2b770qto=;
 b=H4y/JGukGyrEaXtiG0q8jIuFzEudHtHcqalv9AP5Tk1w7MKQOSZQUGodDOlM2SdTuWlCNVMIX
 E/yfI37wg09CvBqbfXZ/7MgQW58hKZDx3I5Rha552v3Sv+YThfpuIfe
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: Tx3aAKHzBUUZ_6zxie0AQ6alC6Sn362S
X-Proofpoint-ORIG-GUID: Tx3aAKHzBUUZ_6zxie0AQ6alC6Sn362S
X-Authority-Analysis: v=2.4 cv=bNIm5v+Z c=1 sm=1 tr=0 ts=6a1b2c62 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=i7xoKaWEWnc8ZE6DH4sA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX0HMHgh13KBzH
 +D8E0a02ZZvsU+x4pC0KeTJnS5WqGoGoHzUsuvEeAnPb9J6MvLsq98yJ85iLECnIjURAJDVYrQm
 VG/FhbiKw7ev9scOlGBCswHIkBcUEoURmyk0gkIZdT9oErSlIJrDzOI/K1xetMwW1kSIiGOIqtk
 0OQUKWbuwElTw7QCDTBX4ZlnKBxVWrlLZ50c3ok4c07O9PUB52Oj3D3I+WnJQcL2WvSOVNRCIcS
 2iae7de7Rka+B/QYIYmdNP/CdO9puuhapS4lMgHDogSSbx95ok5X0rNCrHnxtuaf+BQNEk5Avqz
 LyFVXaiTcmB6LSh6DOP932TyMgyvFe+1+ZbXW/Vq3qVe2BRXylmS48OsvwDxauBJqdIxVPbWPCI
 smCSdK7vbtD0FKdz+VtH11SDqnMJD/PZaEVJB/Dv7r47Hulq+1J8onk3T26BDX4WA1m/J3J/esU
 i/pbMlZn5ocp83p9zKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

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
 drivers/spi/spi-geni-qcom.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 333216df922e..7696412c6e87 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1119,33 +1119,16 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
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
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-	int ret;
-
-	ret = geni_icc_enable(&mas->se);
-	if (ret)
-		return ret;
-
-	ret = geni_se_resources_on(&mas->se);
-	if (ret)
-		return ret;
 
-	return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
+	return geni_se_resources_activate(&mas->se);
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)

-- 
2.34.1

