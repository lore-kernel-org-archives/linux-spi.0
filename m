Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34D395266
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566449; cv=none; b=MYzKmoumoMKOefcD80tCjstUjKY+Nq34fn1iqtkrfqfCJUC9yKPyOYpl6pnZkHLGSX1O6/8ZoBbawWApQPGff4KiaPBvg1wkvNx8Y1fFfz3KeUnc7UIWnEZDERtG+XdfLxSwcSJtFfw31SkWKc4wpx1sInXunPYjufwDBsFk8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566449; c=relaxed/simple;
	bh=iEg5OVD1F5GXb53Zr7ITshBjfFUnQh3uwGa/F9+0QfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KGb4QWnShssn0h453n25gojkH4ks/dcPyWO9QYW54nfrjrnTQ+YuYO39S5CIlFdYenNPkacAUas70SNd1AC8XJSj2/v26k2jaKh2lFKfiIIoH5BAHAnz2MQxV4AS1nDw+8Od3sCIqBYvgJlsuAzlnu0hHKwDwItjBuM0/uqnmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YS8SE85N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UOB+4YhL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YS8SE85N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UOB+4YhL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O992Po1377876
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 10:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=G0TmPJrFxxESNUUTbGxESe
	qBeDyVihupH0UpjNRr/tY=; b=YS8SE85N9vTLlzxfuXPIqUlKXl0bZVqwgG6WXi
	DTpLVT9UyvGQFp0OUQX0WvDmAX0g0eleLbmWe2ORVf+TKNQmenKU2N+2oXfi+bM0
	94TjaZMjJkVok9oddwObXy0zK/JE3lz/SfXZ7RgY40iwwrvjy6kywwF3eHxmy+Fv
	7bnxcdu4TfRx6HTaN9FQOlUrnA0FfbdkI3aMsMIvquyCoabMrqV4Tl789cqv/byF
	a1Q/kOSskbBS6bQCDjDgYjjiispylzy4Bl048slakRB7yaA4Yi/NxigI4eEqnatF
	AhKI7j61KjjHu+C79ZOS6SHFITeUqG2Rx8aUi/dfK84sA0Eg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf0pw4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 10:14:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so61854395ad.3
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787566446; x=1788171246; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G0TmPJrFxxESNUUTbGxESeqBeDyVihupH0UpjNRr/tY=;
        b=UOB+4YhLXD6e4Elc0bjgHW1Z0BY+22e4epL6ok0yTaJAP+hPNTSD+2ve0AXYGmzaE9
         y94Yzx5XcBeNejXWaV1AjAmq2zK2043RXGRo16/BXkRBElbZpaSJsX/WbpsCpsGiZ1l5
         sVC7F5oAyCdyWdmsmwKVpLIA5PWYS1jKkr2+mqoN6R+z+En+OfPaISVHdkSqo0WImBY+
         p0EnaQXFG5Z87iQvr2m6xeT35W4GPSXcrTmQ+njiK6JMRbDfXIPYECL0lT4whHpkECif
         Jxxqr1bplP03VgaAhutPZRgL6Oxo7HV1xDvWrQHl32tK5kKIRMSfQYbzcRXFFo33jYD9
         437A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566446; x=1788171246;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G0TmPJrFxxESNUUTbGxESeqBeDyVihupH0UpjNRr/tY=;
        b=SU2Y3kuh5HBfkNfuwVECh6TWpzhFJNtAAgcfu0M4l2/DBGkKozKSFKZLfpLQY93/db
         W9Qz61ANBLEaK2wk8uySGQG2bhwu2gpuUL2hh/IPkrnoYJF6kEQ3bR7W4MJ8+UQeQzGU
         D/ZDZP9syjCoAFKSH1fY8h5AfFkIjozq4mdOhklcOpS5rHYYUg4AUNUbHIa/yMjPmiFZ
         kTtU93P2txVINQ43btS2iqFK0FuEX+rhlik+ZefWIadZjE+MfN5WlP2NXUMT2VI8WM8k
         8IZ7MY1MdOUuz69UIjNax7EzYOurcWvRVa0EDJqLc4q9ZMhY6pQiAmF+zCewXdg+BSYB
         0euA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4kk83KUJaKeytsyoFCBVHUrOmypz3AtpXd02Mnucy/F4yHNWgi5hAPWEXUsJ2zMnlahmfF9xtIvc=@vger.kernel.org
X-Gm-Message-State: AFuF++nUHbNYi6cLy8uM9CVUaIV4ZKYbij8QcmFaeHCt+CVaXw+dOh6Q
	4BmJWDBvlJYvPxB0KlCQ5WsH4r84EFwxe8L/gFMKY6P106+bgeblDD4rhDkPvPj/peX7ZN+MmrZ
	i8L2OJmPkRZQY2AI0bDXYJvuXTzNGh3p59oIs8N8T1WW8IcyVlYcO+UpgIh/Pe80=
X-Gm-Gg: AR+sD108yFaYHBXSPPjCnmOAg/XDpXKCAL3fuDnXHJfpXm/gfyss+YrBrZJO7OUhPq7
	ke/mgI9So43bUBzk0NePhv+hd+yOeln9tTerQ06zIh20fnbz/29ljCaIaftC5mNStadGjbUe5V0
	7avlpaJNtCTiu/KH2Jczd6Zvm0ek0PZCgBcijSsrvQ2V4bfXPm+HAO35JZ56QYxuQf4aa1S0GWJ
	3x7ih1JOj7khvvQ23aGmeCejNmugxZneFZs0LHODnF9c1QBjCKMtfNmiEIc67rGrG7CoH4i38eD
	MCWMywkUdKP6+2QJwp0G/JREf7kXg+jzj8O54YoB5Gvra4roYuSaZF8JRMpXnbfxgU2VzTUx5Ru
	a8PI+Ufox8b9Xay+ZV7HrMHuay/Wq2flhs6gv
X-Received: by 2002:a17:902:cf04:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2d670cbd304mr20783865ad.12.1787566445742;
        Mon, 24 Aug 2026 03:14:05 -0700 (PDT)
X-Received: by 2002:a17:902:cf04:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2d670cbd304mr20783105ad.12.1787566445333;
        Mon, 24 Aug 2026 03:14:05 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768956fasm15892865ad.40.2026.08.24.03.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:14:04 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 15:43:58 +0530
Subject: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGUZjGoC/yXNQQrCMBCF4auUWTvQhqZUryIuknFSR2wSM60Ip
 Xc36ubBt/nfBspFWOHUbFD4JSopVnSHBujm4sQo12owrRna0fSoWfBJacaJoyA92MU1o/JSN0h
 ImF1xs6K1ZP3Y9X44EtRaLhzk/Xs6X/7W1d+Zlm8e9v0DoL36dosAAAA=
X-Change-ID: 20260824-spi-qcom-geni-cleanup-setup-fifo-params-55c5b814b69c
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787566442; l=2701;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=iEg5OVD1F5GXb53Zr7ITshBjfFUnQh3uwGa/F9+0QfU=;
 b=uFmxUMzZkSBR77JmGkuHxy93EsPknFTFqky3nSUxCAcNtktv7w8ypaXbwLfBYs76uCNjTW8Yn
 wBcQBpH7SBsCxGX25UiAcerGGbk1nH4HHKVLHfbH2uK/sN/vGz/u0mp
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4NiBTYWx0ZWRfXydSW5Hc93v7J
 J51yr+Zs8A1h4bUnK60FpcqgleIwSZcE9jyySs6sy8iQO6B+ic+f7BnvcJF1EClQjT2LV+c8OyT
 zHeFJsmlgyqvcImusa98hfWFA+j4h1c=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c196e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=sOcVE3KtW0qtki6gBMoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: wtIWftEUNyaQhuj-ahUj90KFDDQ__zuF
X-Proofpoint-GUID: wtIWftEUNyaQhuj-ahUj90KFDDQ__zuF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4NiBTYWx0ZWRfX547yCv/v61gu
 JGYr+64RrthLEFC2pyDc0AChXEkZeO5j9t8PJ46JKOnud0j7yveiuaOxIKV5Zkxx88rYPJrMn5R
 1qMSpG1LE/YfUA0e3Rb94Tupe7DF9dt2IFkPIoJgHfl2h8PK8gpica7X02UiCshG/g+wqtm1bDV
 95QaVVklEZwlx7w2ckf9oCyiyE3spwwDsrNuXbxB0SYSr3JiR0BlD2sTwNBR358fbg4+EDVq69t
 H8xO8z5L87zHnCEXHbxhQ8veeKYsGhIDPunvlVb6pN3a49Uloq60czF6nb2MuKlk30WAZmpAXYo
 kQ4xnKBVH5tI53gxJ6gVo29k28hHOTFSKo9bCjmXTQ5oZ0LdCFZQzXQB/ifpoeEq59Od/JtD7LA
 EiJ72j4mJT7zWk44bNuKh6juMP4e/uUrhSLsOy7jWIJqRT2Sn4pbdNzIunfsM2Uvu+HDkQqL1yg
 USL7E0xlV1edipOnohQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240086

The function always returned 0 and had no error paths, so change its
return type to void. Drop the now-dead ret variable and error check
in spi_geni_prepare_message().

setup_fifo_params() is called for both GENI_SE_FIFO and GENI_SE_DMA
modes, so the "fifo" in the name is misleading. Rename it to
setup_spi_params() to better reflect its purpose of configuring SPI
mode parameters (CS, CPHA, CPOL, loopback, LSB-first).

No functional change.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6c57f8309a3b..05abaf18a0f4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -363,8 +363,8 @@ static int geni_spi_set_clock_and_bw(struct geni_se *se,
 	return 0;
 }
 
-static int setup_fifo_params(struct spi_device *spi_slv,
-					struct spi_controller *spi)
+static void setup_spi_params(struct spi_device *spi_slv,
+			     struct spi_controller *spi)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	struct geni_se *se = &mas->se;
@@ -390,8 +390,6 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 
 	trace_geni_spi_setup_params(mas->dev, chipselect, spi_slv->mode,
 				    mode_changed, cs_changed);
-
-	return 0;
 }
 
 static void
@@ -554,17 +552,14 @@ static int spi_geni_prepare_message(struct spi_controller *spi,
 				    struct spi_message *spi_msg)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-	int ret;
 
 	switch (mas->cur_xfer_mode) {
 	case GENI_SE_FIFO:
 	case GENI_SE_DMA:
 		if (spi_geni_is_abort_still_pending(mas))
 			return -EBUSY;
-		ret = setup_fifo_params(spi_msg->spi, spi);
-		if (ret)
-			dev_err(mas->dev, "Couldn't select mode %d\n", ret);
-		return ret;
+		setup_spi_params(spi_msg->spi, spi);
+		return 0;
 
 	case GENI_GPI_DMA:
 		/* nothing to do for GPI DMA */
@@ -700,7 +695,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	case 0:
 		mas->cur_xfer_mode = GENI_SE_FIFO;
 		geni_se_select_mode(se, GENI_SE_FIFO);
-		/* setup_fifo_params assumes that these registers start with a zero value */
+		/* setup_spi_params assumes that these registers start with a zero value */
 		writel(0, se->base + SE_SPI_LOOPBACK);
 		writel(0, se->base + SE_SPI_DEMUX_SEL);
 		writel(0, se->base + SE_SPI_CPHA);

---
base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
change-id: 20260824-spi-qcom-geni-cleanup-setup-fifo-params-55c5b814b69c

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

