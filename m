Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD07414DC1
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328035; cv=none; b=nQpRPX7WC/oYjxk8BlYJC+X8oYdA6LnScvA9gTU6SYtpcZn0ZnbOCmfG4coHLV5s/uI8+zPWQ2QLq7KNGlG/fu/WOnLJOOxU4YNaDFZSkkNzb2tDtrELrAHl30iyXb1RME+/of/ef+jYUsKFMtsZ40P3L5/Uj5TYSJzpRxhM6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328035; c=relaxed/simple;
	bh=0ufInVUVLfFzq8y2beOLns32ovlcfJNcUR5C24Dtp+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS+W5rdPNBIf5kTf3LvoNRpPJWpI8BbEdqY3YZ1T/TeVYRX/7tnk92hGf2zkwgjV6+//5cNJAMMyYj5cMklpFjutZ59mlE54j0oh3NFofzQoFKK/FtAGDUmn2VMUMWlc0yVey/BVawS0l4PlpULZmkshz2H1W1Z4rEawM6qiD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+SUIniJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=exHy7keO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+SUIniJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="exHy7keO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666852JC4006914
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 08:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3MLeedBrkkia/qCCz/UPFtN7ntKyyH0lh9E88vuT4PU=; b=X+SUIniJ5e76N3KC
	4okub6IeNfLol0638NNvmRBHBEf/yZRoV7W6kmQ3kBZZJ+ReJNEiBVm9nf1zLwZB
	+PpvOUoOg3c4XOwhemASgDzeP+jIikkx4dpfOoPQadY3I+iEGEMGVJS3ElVaFW7m
	up+mxV8NYu5tHP2NWk9ArysC7f1y7gLH3Q+kHeKOtVaqg3fAufJMJEIL2gz4gP7J
	8PcD/NpEjm2KQWn/VkL7/oCY3QKL87d/QHpd44GgyhbUDIXVlT2lHKOzRoSjTwjT
	0C9BC5WVr4cLrm9dMhDKNe8hd9QRxf9qOMoq9xOpCKMAtzzBalq8UoOMqfDgWFE3
	I3BiFg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs86wx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 08:53:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88da04b719so2012571a12.2
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328021; x=1783932821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MLeedBrkkia/qCCz/UPFtN7ntKyyH0lh9E88vuT4PU=;
        b=exHy7keOBcznT31dWTDiEPZbv9WEOYQz7Kl2bmDkfFOIEf4RaSn2/ar6P4FY62UahW
         VfG7Q/MGWRoyEJicOTeh1bkBj1aF7bMvFk9+AHem4vFu2QGTbz7MTSexS7oQwfgdYKi8
         o8xQzOsqvN+dlPTAKhFbF8EQIH2Ud10byEC4XlFFrHuExphbtSJZKHqq7Xen/bw0PPSe
         AFxtTt+zimkez6eDEVS1RrAn0ex4AzaU6q/OewqaO94Hwb1Wop1jmNBmSpWJuUsPgEil
         cjGYJ0rhq3ZTnnZ6OcQzGIhYRWLEmXaELO9Kzc6DgomDeOHffvM5Pa9Um6BFjY9V8gq5
         LP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328021; x=1783932821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MLeedBrkkia/qCCz/UPFtN7ntKyyH0lh9E88vuT4PU=;
        b=Qs6rnzqh0iGOrZW3MH2JGq2nTATT522Bwdhb90QdCBZzsBQvvPtr4ePySX1bWq/BXN
         BxsEGXux3TWgb/uCHJKvctzcRy641f/h9XnrWFD4ZoJJSa0s7neVohgPMsBw2T3lQv/d
         XQ6neUUSqWKphpkczdvpdOM2AqxvTvgBIoHpwZUtadQWP/1mSI5RkqtNdNpKvvIPYlsZ
         eS5fap4ivZZJGNqP0qvcJKbIGT5jxHJw7WXH9Ltq3sZR4cOZVYz0Ij9IYMUoJqY/ig1b
         4AtSH8D6D+aFmlN/g6LFjITU/YpujLwGBLS7TbZJZHJVHUi0JYJJQl5FS73h4g5Lfb3D
         9KNw==
X-Gm-Message-State: AOJu0Yz+tlmm/5BH98ZdkKSixaVYuS65Mok2tQXwU6qiaXg+N4YNl8pt
	hb457cME9iIrv1Wj/IyssRPVAMGnJHYkZafXzw5/VeGLSsyoyBVgMGKGhbqBVCkuY3/V7QPfQq8
	NggMJzhDoxLwvMOQH1yRSyJjgnECe5Av0Uxf5sKvUKvArliObz/eKWcQnRHVbweU=
X-Gm-Gg: AfdE7clNhI1h0Psnl3eYMoTr1Oy0/LEMykmNWXkUezLAAcnYRjtZ5tOR66xFnp60krZ
	AID4pveEU/8+lBG6myuZNfSzguin72pDT5IDeWuVJTHDQcT2kUDFbmiIce8DAllpZdscX4iOp8M
	kjRgqwk5FyYAKeWCPWiYw356nLDH7hf9nNruo6eiuWGBm73pym8gzZ3yeMIf4qdvl+h0D+E8yXS
	ijKhruGMf4SljO1QRT5GinTTrTWoBKrqcNIEdXFY3mp6hvnzcgx6rrXOJxHJbtLfAdYDaQ7SzM6
	f+I8MfSth8VB1RVXd+XvK7yA7xbUWXEsvJfS9OZsmvmbzAxnD1r9cwrzwf4aypJ0kbiOUaGxBoy
	penuHGxKiGk8RuXoH0r3zQBssoZRlJLKWP2GHT9IkkVHo
X-Received: by 2002:a05:6a00:909d:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-847f6d6708emr8249667b3a.9.1783328020965;
        Mon, 06 Jul 2026 01:53:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:909d:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-847f6d6708emr8249531b3a.9.1783328018026;
        Mon, 06 Jul 2026 01:53:38 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9e12csm3411834b3a.21.2026.07.06.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:53:37 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:23:10 +0530
Subject: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
In-Reply-To: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783327997; l=2819;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=0ufInVUVLfFzq8y2beOLns32ovlcfJNcUR5C24Dtp+I=;
 b=Lxpi51lVQh8CfIa0DMGsvzgVX/5WK/vUmhHZ4ROGKQqbLRm7Qj+Ah9siSBj3Pxzi85bbp/reV
 PsSrkkU61iYAUyDE5ufd+3sw/mfgU22Cj97wfFqxnnPNeiq1qCBJbVQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: veHwizoC5mSJT1pr4KsoWiwge5BfRO-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfX778PkJ8UC15F
 L8nQcEQK5H/mYO3zWK7yCzG2ojj7xAHq6bjLRHviAvpq+c//7x90QiB+3UiS8UXcxQZErluysXL
 8qW9t3GgrsR7cfHefMGrKQYKXWfD/EJUs+yA4NZJ0fuE01kPImsNFefF4Ofpy56Lsom6JmyX/EC
 iuZalxEsCbc+vUwfGZmPyA1lpbjHDaeuTaSGPm8dAYGHLu3R501+51digCdweKoWeTGQnQyjIGN
 GUBPy2ZBU729UbPTmc3y4lBmYeIJRCfL3mzH3L2GYbtUmw5tzdP21aWzCYEWSdZgq74/M6Amrc0
 ncEz85Xn3ioakEnZL0KVMTSNUSeloHWNWt6GIsR0bf8s2zGDlbsNfyyNQCa/8NOzOHIUJHdhuaR
 HmBdaYJIL4xDDqO8F7Y8/0KWxbFAkttNz72wpD4effLR2WgSpNBzg/wxRPPqblWTsoVhB52t5Mb
 4++Z17HgQUnt7hjFVdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfX1UpAUUJKfAVD
 X+IjHomoOi6D40YL/dMlOAN0r+bqZhlchbAzxOFSbopeSlzPUID+B2ERV2vbs3rXSuKn6dloJiL
 nRNORyqzmwotBMO2FvmSfVcD0RvBqPw=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4b6d15 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rPJgdety-6tgKaoqdU0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: veHwizoC5mSJT1pr4KsoWiwge5BfRO-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060089

spi_geni_init() calls pm_runtime_get_sync() to power up the device
before accessing hardware registers, but never checks the return value.
If the runtime resume fails, the function silently proceeds to read and
write hardware registers on a device that may not be powered up, leading
to register access faults.

Fix this by replacing pm_runtime_get_sync() with the
PM_RUNTIME_ACQUIRE_IF_ENABLED() macro and checking the result via
PM_RUNTIME_ACQUIRE_ERR(), propagating any error back to the caller
immediately before any hardware access occurs.

Since the macro handles its own cleanup on failure, the out_pm label and
the corresponding pm_runtime_put() call are no longer needed. Replace
all goto out_pm paths with direct return ret statements and remove the
label entirely.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..392accfd8515 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -613,25 +613,30 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	u32 spi_tx_cfg, fifo_disable;
 	int ret = -ENXIO;
 
-	pm_runtime_get_sync(mas->dev);
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(mas->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret < 0) {
+		dev_err(mas->dev, "Failed to resume and get %d\n", ret);
+		return ret;
+	}
 
 	proto = geni_se_read_proto(se);
 
 	if (spi->target) {
 		if (proto != GENI_SE_SPI_SLAVE) {
 			dev_err(mas->dev, "Invalid proto %d\n", proto);
-			goto out_pm;
+			return ret;
 		}
 		spi_slv_setup(mas);
 	} else if (proto == GENI_SE_INVALID_PROTO) {
 		ret = geni_load_se_firmware(se, GENI_SE_SPI);
 		if (ret) {
 			dev_err(mas->dev, "spi master firmware load failed ret: %d\n", ret);
-			goto out_pm;
+			return ret;
 		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
-		goto out_pm;
+		return ret;
 	}
 	mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
 
@@ -664,7 +669,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
 		} else if (ret == -EPROBE_DEFER) {
-			goto out_pm;
+			return ret;
 		}
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the
@@ -693,10 +698,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
 	}
 
-out_pm:
-	pm_runtime_put(mas->dev);
 	return ret;
-}
 
 static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
 {

-- 
2.34.1

