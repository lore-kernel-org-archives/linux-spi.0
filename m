Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B13DDAEF
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190364; cv=none; b=LsLhY9gP4hIExzHmR0rerlVsQeVBR1l1pqSD0iEoVeYSfPHvcBXXdOX+seg9I2j/lmqLzLr/YhSwKbytH52C400ut2yA9XsUga+bxodk20FZ1s5knlnTPDJ2lM9HhPQ0kqQN5CINYJwXYy4ic3G6Voc20/9Y50oxfDuABJzVww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190364; c=relaxed/simple;
	bh=xJdaMkFW1cVtFVzX2p09Ua3QSXX7bhAva4Yt8G7Mzvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tT6xhVI1ehaqmAJogZCMelvtrIDR/cBTZ5by9PJLw5YstskyIwyQB/C9X5OnCam+6ndLtV/welXTW8wOk2kYLyeATfrLzkhoZ4du3n7QUjgJMy0JQY45Lav/j9+ayeEKPntSbd4bU6eKTa/DPEP2qTpX9/II35OkD6kAMV4KKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n2cPw2y8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VszcUL+R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n2cPw2y8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VszcUL+R"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DP8r2193464
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 08:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g7+97sYPHf/REKxCri8Zte
	0tjNuRDeLsOFBDiJ7Adw0=; b=n2cPw2y8EKjHKN4I/UEmKoT2kGagS/XQFTu2Hf
	6ZZ1RzTVt1sNVwjWG16OoY1RD6qGWHZ7zLyFVV1X/XyWPYptkkU1ryBYNRo1vinD
	e+L714fKeChls0SCR9U7x9GmkI4dZ4d7G4h2S/xTuXvtiMA+7TPCbt3D9HW3eKGI
	p7WW7TUK8InzNPM/8d1Oy+QCmNfQ6c7nHlw8ZzwAm0WOMnYFHl32sLgd1PeUFHE5
	hpOKHbrDdymKryN/gaJ71pGY1xvyVohgf4X57K+cULYcwJLLWiUSE3xZxcec2jqG
	tYP4Fvoge3k/UAfbQFcTUaNb26lWHT4L9akP3PDGRDbR2vnA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf0bgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 08:25:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ca5d2474c7so80989995ad.2
        for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784190357; x=1784795157; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g7+97sYPHf/REKxCri8Zte0tjNuRDeLsOFBDiJ7Adw0=;
        b=VszcUL+RlUr8DWlBfz62NNBhNCRPM3AjsjNKhhJQZq6P1d2HAXAnHAkJl/VS7Q8aHf
         NDSLvp/UQz7s0A7P7koKjX1F3ZrzG5QztSYGl0XElq38VTYH/M85zeASs41RAyeLgTBg
         1iBbwXSz7RJdxWbNYim2tzLNSIV1jZlNBwno7TJxAq7diTZGVmsqbTjeUpMrKFUsp7nA
         3cUlaERrM0iMjXVi9qeHRtDjwnChyhrSicvmpYioBFXfq5nByJlJs4xRPzlAXHrcpVed
         aIjUOcFEDXvW566KKt/2OPYr/b+XNaW/nqJTbY4IrAUJqMCMJhVOKW+l3oYs5Iu6kxuJ
         FZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784190357; x=1784795157;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g7+97sYPHf/REKxCri8Zte0tjNuRDeLsOFBDiJ7Adw0=;
        b=OxDM7iqgMCVIysDDjQwIb5DE2QCoKWVQnCvz+U563d8y9Q0FqPaRibnMrY+BezGC34
         TVRu5TQUMHFYRITcHevT/iHrSEGuZGiFip9Lkzhuvtux3b5ax+rxiX1rxuZaPwleKoAD
         N1/ag5WqxupK7uvHjiRpFFkNpAXWVhKJ+Gy1tEH4shMF8qnjPl6qDS60DFu4qZvd9hov
         eCgzs0JltLP3kHI6qXBMTjQ+PskdXMOnfxtJqpBGefhSsjPQJ8V+LIAhkEcqJ7Tf8Jle
         6GqO/TFPs9g1bZvWeeGYQ6XRkPZ3skiqG5JI8aLErcDS8LAzHiZLgSyORI6lSeVckcaF
         JA2w==
X-Forwarded-Encrypted: i=1; AHgh+RoxWWlEwbMXxb1KaShWgyRCKr1b/VKgHr5xIwoRps5IMaQKQ3nQ9Lyr5wEMfzlSHt/7ifqryFmnvSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mMOQXCspTXAxHvJFEPvmCGQd09VFIpR+Pz38sN1SKv2obEDk
	yQj1ycqDpkWKKhHLqQr7/vDnhF6sYIfgGR+0Q5RG6qGIDb00xqCWbiZ3T9ws9cla0ViYrwSuaMu
	oX90udKfaDK4MQmZn0YO5XuDjPLUJP/CQt6kDuvF6mENApN6CgyguDRCvA2TTbuY=
X-Gm-Gg: AfdE7ckBtqV3C5aXJRX7erjm3pyLodHEzG8E1SR0tN3TvdAXlW40o5G+DRg2X9p99X/
	1RPmc2ssLxjKZjrzkarFPtBWyo76ty8rPZtp4MmCcoaCrbQX7Kxf1iakaclhJ4PcLKIMyP4JVmP
	regqeY5vDuleDQfLs1B7swlL3+Q38pL1BYuIaQWSnkacf+HEie9Ghm6FEHVp4kFJtJz8L2eUeDP
	gPQefEi5eqeaTKsQIpPo3LAC2JMDzV1Nz/XmV/KmrBKfORoFo+hpyAgeNVadVh4npNJbPRFWyjw
	BChdjTIWSGMHea7K/xNa866u8ZEnCGchsMj/4FR3wJYc0Ka0X8SP552qfl10LDRuHObZlIGBEG/
	n3zkDxeHsfGgybTyqNobhTG3gqmGBY41u2Q==
X-Received: by 2002:a17:903:4b2d:b0:2c9:ceb9:865b with SMTP id d9443c01a7336-2ce9eab3aeemr181247855ad.21.1784190357163;
        Thu, 16 Jul 2026 01:25:57 -0700 (PDT)
X-Received: by 2002:a17:903:4b2d:b0:2c9:ceb9:865b with SMTP id d9443c01a7336-2ce9eab3aeemr181247525ad.21.1784190356618;
        Thu, 16 Jul 2026 01:25:56 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf10701ab0sm16004655ad.77.2026.07.16.01.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:25:56 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 13:55:45 +0530
Subject: [PATCH] spi: geni-qcom: Fix sticky ret causing wrong return value
 on invalid proto
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIiVWGoC/yXMUQqDMBCE4avIPjeQBInUq5QSNBnb9SEpGxVBv
 Ltp+/jBzH9QgTAK9c1Bgo0L51Rhbg2F95BeUByryWrrdGecmnj3gmWV5CGSxYccoaIZunvrrI5
 6ovr9COrw1308/y7rOCMs3xid5wX+eG5jeQAAAA==
X-Change-ID: 20260716-fix_return_error_code-d1a794620d0f
To: Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784190353; l=1782;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=xJdaMkFW1cVtFVzX2p09Ua3QSXX7bhAva4Yt8G7Mzvc=;
 b=1hiq+J0QFWo69KapXa0xDO3G5FfGitWMZFPsf+7QFi8atjrXvweHdU4WjTx/FWVx2Cz9mEj/l
 JhqBzXvuLu3BtBw988eSKYPerZdVT1yQb0kV0TGXx26y1XKLWsxKgdr
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: su5SwoxA9AslQCBw4FVUnHv6QIDCfDfU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4NSBTYWx0ZWRfX2ca0MK790gJw
 QCCR5rzhUAB9XrtcMw0I/0T0m09kFkpvEOYmrdSIjsl/hTOWqPxI4EXh2MpLsMT7vzG5BFHl5ZK
 D2yB8dFwZmZU9eSw58sW3YFcBWe88CVk1k3ZzCc8/zFDFibN1Ir4IvQlJe5rsAVJhGAI82GJGJR
 0/pkRfdxREqWVVLV5sovuHF5T6HpUrOLdRtnem/6BHvFDF2A2et81QrX1TxsgcRtIQfgYGGMr+c
 nnHEU9b8zJa3chfcbFjIecZ92BJXXsIlyKBZVJY3MH3gjlVdqt8KJd60SP6cPrp409bGY7OZ2wD
 QJJY2CZtmOrhCd5XpMka3mwNzlJrBEnoX2XSBSfyiYfSnH0qUYVRZRAZvY6J8gupyZkKAGo/GNK
 ADQmrgKQmnVMNeSB0jqYvXk7pF6oywE1A/zQgU6KO8quoyNXEVGQK4BsNCbeuMcQlS/N3qZ+T7i
 uaQmUD08CRYGQjosW5Q==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a589595 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=bNqgN5VNr5uoykOApbYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: su5SwoxA9AslQCBw4FVUnHv6QIDCfDfU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4NSBTYWx0ZWRfX8/TLnGgD7BAS
 oPgksQtOrS6L3teWDHxMg0rWSb2LAS34jWAcFXnEYe3iZoqzdcEeK4iToKnFoZ7F2QUAHwIZT2b
 flpPiYYxi83juLBbhaPkMvAevx6SF78=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160085

spi_geni_init() reuses 'ret' after it has already been set by the
runtime PM acquire check earlier in the function. When an invalid
protocol is later detected, the function returns this stale 'ret'
value instead of a proper error code, so it can end up returning 0
(or some other non-error value) even though the protocol check
failed.

Fix this by returning -EINVAL directly on both invalid-proto paths.

Fixes: d8e9ea989acb ("spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202607122241.qzP3QAXF-lkp@intel.com/
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 2914d781dbf5..d262206ed663 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -634,7 +634,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	if (spi->target) {
 		if (proto != GENI_SE_SPI_SLAVE) {
 			dev_err(mas->dev, "Invalid proto %d\n", proto);
-			return ret;
+			return -EINVAL;
 		}
 		spi_slv_setup(mas);
 	} else if (proto == GENI_SE_INVALID_PROTO) {
@@ -645,7 +645,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
-		return ret;
+		return -EINVAL;
 	}
 	mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
 

---
base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
change-id: 20260716-fix_return_error_code-d1a794620d0f

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

