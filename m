Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B1342CA7
	for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972551; cv=none; b=AMIesTIJankgUlBAPwpMEXEA0PEqrocUHFRgBhVC60ruADxndBQghzUwQASw6VqEoF/4DXNAp7bfvDrnYF/6SmpUJtwtSk6fQ8wsMMwOEg/0wzqhc1hygJn2neb9mC0iW8wVLdkyj1KitJOyZjiQ+9dyX016R0ish+YRAXGT8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972551; c=relaxed/simple;
	bh=ABJeyst78FLFzl9Ct3p5szQOsed4/LKHB3A9jqiuHok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMRVs6vEm3iI6UC+Wewqqzg1NJzidTnc8JHvb8V8VqJ+Xu3DPX1DA33ZzbfW/4qx/4q3nN41gli612rCugFS+8+9Ftjpe1JfE3bnKULZetWPP4CKcBFrjaBwO2DMr1Z699TfHC/DnhwhB9d8agD03P+3GDsiadqhCSgkKBXDOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YF8umf35; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ill/3Gex; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YF8umf35";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ill/3Gex"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KhOK2917728
	for <linux-spi@vger.kernel.org>; Thu, 2 Jul 2026 06:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z4c11rFRRdg9DIaHq3/L5hXGchxFnFdVy3MEIWfSpE0=; b=YF8umf350ugwReW8
	WLyKw1fYhj7iweUtFyEQGJfItQJwpaBqBEi8dPBk7p6eoHvNVqjHsFhFBaFz4NUJ
	mSvlqDFgnhiJtEsgZusvHdtSeU4hUc4ZQWdQa4rUx5fhLhPBqTy7ow7NkQQGU4os
	AuOXUNvTAKBJ3hDPRVCEGqb/pMiYJaLFNwdOWiW75cgf0f8fd9YxfCSThh3omQ0F
	MP5lK6PLNDjyWT+tOeBapcu6hHByLW7+15T36451FsT9P+TJ+cgB+l7bMNma/BBo
	cfMbJL+tuHm1qkJ+Yvzq/pG4BPDSd69MXJMgPdIoZEml8xRGV/vCEhxoatiUk0Vv
	gS8lcg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q0bc3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2026 06:09:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9f452d260so24952865ad.2
        for <linux-spi@vger.kernel.org>; Wed, 01 Jul 2026 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782972549; x=1783577349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4c11rFRRdg9DIaHq3/L5hXGchxFnFdVy3MEIWfSpE0=;
        b=Ill/3GexwTi/ebrAcAeaPTwczPP5VvnpyXEGZ5DJegVVH90oDb6KrRzzMVVCb7YLdi
         sLYdjhxlRK70oQybVre871exLJ0yuK1lfTmyh48QGTGu9M85EurgdE+fFj4G8mg+5BXr
         HfNt+GSTfHNaE+l+3vg7NnOdi68/eclFzCDTNl1ZNTcbNDTPuyXCvgAA3XJiceUj6ost
         VHwWgk6jOKuSQ8UWt2DcLxz8+6rBmpAfvUqnChCtY1+TZXNXhG736eoW/yHt5GZEW4Vn
         redPBePx894xMni1CpuE4928l6fFjRxNMDNPWmMgE0QYOOcbNgHlJbuIGAFxuJw1fO/Q
         aE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782972549; x=1783577349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4c11rFRRdg9DIaHq3/L5hXGchxFnFdVy3MEIWfSpE0=;
        b=J4XR0GQ8HyS6z6nacILtXNOATCKI6oDsKBHc/GWuJPsnqQdCjIy2xnkExHSeYyOqLT
         6uKjCE5B2vJexeCRT7/hWBldDYQKS/q+8NODYymuaTun8zayS6rK5aq1x2ZVQy63sf1v
         SPwdPHu39UQbXqzfA3I2rqz2m3eatKrTC1P8mZompS3BVIe1/UeUrxThqpvJ9vHYRp5E
         XctHU0NIyjRD649jEH2hfEbpkHjOLrMTQ00TqtJGdyTXnQZ0HI8fBGG9zP8dFwIlvReU
         LPL2ngn7bChiZnEpLMIrdVeEZ0lXolJOWl76LwisVKI/v8k8SpZ4yqibgcQTThjP299f
         slbQ==
X-Gm-Message-State: AOJu0Yx/3gCnIjaqyL62oLC6RGAcMK7GJWLRCRgh6xu2rns3HBOSqfSZ
	+RQ5YhQ8qei3s53DD2g208/MTmadH0QW9iUs+iB8UOeCLg061cT4AijyrLt98MRLJMkeAXMreov
	Yk9ucScUq+n6Q5RCMUZBKUbOQb9PnARbKsZiBrS8ehWCTC17/mJGLULWM740PVcU=
X-Gm-Gg: AfdE7cnGq73ABPtfDuR4RHCPAdOVkMc1Uw5T0LTJEEzmAgBkNH/m9Y9TCTlMDiOAY7a
	1NKd/vl26KOJ1iYaWNvp1L1I0ni6IFAergP3vDCpD69pKIQOsm/fdwp2CZLBnHldi7ifaY0U8cS
	LJlXOejcK4qfSPvjyRW62q2wFdSHQBOKC4uTV5yzR/1Av6cqDU4N4aKFl+msPWsyhE1EQ7AltVJ
	KAGuUxbjSEyz6y5RLmfZjbRw5VIVgSmgDXQjYy7XQvM078kpqV91HMQ17hwLVrmMhglcfszUmYo
	jtw7aJ2PYeOKyQ9BGjeOdt5r0bJe/PTaTBUkvMTC+wU7PZD0sLXn1H2b+1uGBi2w/EEie9YDHX4
	gPuiUW/dU8boJpZS7sjXfvQxEotxQkSkZ12ves9umfZqJ
X-Received: by 2002:a17:903:944:b0:2ca:68b1:b64c with SMTP id d9443c01a7336-2ca7e75d694mr46456265ad.20.1782972549334;
        Wed, 01 Jul 2026 23:09:09 -0700 (PDT)
X-Received: by 2002:a17:903:944:b0:2ca:68b1:b64c with SMTP id d9443c01a7336-2ca7e75d694mr46455805ad.20.1782972548669;
        Wed, 01 Jul 2026 23:09:08 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa00970sm8176325ad.71.2026.07.01.23.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:09:08 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:38:23 +0530
Subject: [PATCH 4/4] spi: qcom-geni: fix sticky -EINVAL after PM runtime
 resume failure
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-4-6ddc317011c0@oss.qualcomm.com>
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
In-Reply-To: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782972515; l=1226;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=ABJeyst78FLFzl9Ct3p5szQOsed4/LKHB3A9jqiuHok=;
 b=pTmMgvbP8fxitvKl8gNaFpnEQsYhWQcIaXWMOE1lpf+pt3wEj/I/dPGuaDCXim6fhgCF2LWpC
 gUViEoKW7tJDmktroj3cQarFJG9LkP5v+iztS0gK1GCq18Nn0VBrgrG
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a460086 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=r-mwoWhorYt2bIR64zIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: WwMSWKf-MYI4b7n0N9o-WcuTcLN-HJAb
X-Proofpoint-GUID: WwMSWKf-MYI4b7n0N9o-WcuTcLN-HJAb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX/m+lrG+jWS/Z
 /o9Fyq2zq0pGtnl1EYHkH1Go+eOQC6y2ZvIZIwmOhVNMUoy8Q6Zf87GpmOBO0oNUFABjemFoJlw
 smCnmSPQnUrEmX6Nkr2r+HzN1AT9ZBw84GgjNDCM/WhWtvSdV5A0h4nAVW9Du/PeCcUYrpiYgQk
 pGpNgtLMeJovPaJDOscr5fgaPlkw2TUW6+ycXGs9trS5i/AutNjoCJy8d19M8tyndo30aNqSGZe
 Ro/QTiiebCfL4wthl7+jqKYQTM6LBDxNtIb4NWeV5cQgyG87dxWTiDTWfDTKgKRPJyJ1c6tuZn5
 SW/lXVebmXrfzHHTm6rWHSKBubBjFoz+mCDSHISp16jwKwtIHi+uUsrSUQifIm8j/+4VJg/febO
 Gg2Lln7rdqTq3WbNFylrZjGJcHus07fYu303NVb0eLCVQIaUllKVaThBTBmw59/454A0XfAT0Rr
 PPrJUoOUuhYB6Chjibw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX90/qwXCGRoCo
 hLiXOYCM27iwpyD5z9bkXTXDA5IMgAdBmCWosXlMfOWk4D3BDaEuF8/4rqq6ZdNYNw8K79YNI5C
 qQkbbA3+3tyBCWbmUVYXjvIPUmL0Fz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020060

PM_RUNTIME_ACQUIRE_IF_ENABLED() in spi_geni_init() calls
pm_runtime_resume_and_get() internally. When the resume callback
fails (e.g. -ETIMEDOUT), the RPM core sets power.runtime_error on
the device. Every subsequent PM_RUNTIME_ACQUIRE call then returns
-EINVAL immediately without attempting the resume, permanently
blocking the driver even though the underlying error may be transient.

Add pm_runtime_set_suspended() on the failure path to clear
power.runtime_error, allowing the next attempt to re-enter the
resume callback rather than failing immediately with -EINVAL.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a55a3afc0ebd..5f65e6d0d08b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -616,6 +616,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	PM_RUNTIME_ACQUIRE_IF_ENABLED(mas->dev, pm);
 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 	if (ret < 0) {
+		pm_runtime_set_suspended(mas->dev);
 		dev_err(mas->dev, "Failed to resume and get %d\n", ret);
 		return ret;
 	}

-- 
2.34.1

