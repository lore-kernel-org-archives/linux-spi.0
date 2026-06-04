Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA03D9041
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555876; cv=none; b=Yx0qW9IfaJkO0b5LbcIT/ALEmLxR3rM/0dbpm6+1O3GuR06WYhUxzsuc0X5sjW+cRTLakQmvLcnrY+ae+bkntuiNlb1erNwsJkyFBD3zUQ61cKCAzuz82AmiHStY6wjv52QMrzCZUBjpN7qBzj2LGuevU4FeAF6Ir3XP2jzscys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555876; c=relaxed/simple;
	bh=W/YrZ50I3AwtE19t9pzTiT0xdnQWey3D03tHPf2lno4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbzBvArSKUq/D36TcHQx6JW3dmABt3v+ScqLZNAj2xflSoEHIgNfCZcTk+gR/ZA5jJhzHd+6nw20/zrm7dWVqCUxtEhrfxLqncCKjeDmmmQY+GrE6cNu7MI/+tlNqYYLrUFNuN5m8fL+LuUyL9giv2agxTqNKhidPLahFO9DX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ke3SEQaf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z8mGexmo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ke3SEQaf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z8mGexmo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6542ucmi3552292
	for <linux-spi@vger.kernel.org>; Thu, 4 Jun 2026 06:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XB9Q6X09k8YWO7HfZ3onZiDHCRdqw6sxvgxO5l7nA8k=; b=ke3SEQafDKF7RYnn
	JVGnr9etkTU2DWxdrm2M+kwdDvGEJVI9FkAomUPZIZEA4Q9RBDiy1ZZ/nVfHUzZc
	/+rI5xSC18EphqQSZ3ykNU9gpAm2sic9ke/X9OIrej0X7f1LalJhwBdZfosZ0xSW
	6DOwzQAH4VoRiPqUsnGuIoYEjDpg5GMtL5mQfy5ydPCRJ5aQ9Cv7B1DIG8jRoD6N
	p6WqfBmUwOlP1wg+xE2nWGHkMah9jStpI7i41yUkICiD9lwJt3iCvXR7xnlLt3EH
	q2OsMnzafF0lcb/o05yGhm4reO5Z9BQFOa/xDKNjl4SbPUAEUbNdZ4vGT8Mr5Vdh
	l/sydw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj9mvdh3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2026 06:51:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8525f0807aso623096a12.3
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 23:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780555873; x=1781160673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XB9Q6X09k8YWO7HfZ3onZiDHCRdqw6sxvgxO5l7nA8k=;
        b=Z8mGexmonM719btMsu8bz8mTmiZ8IWlWRjgO8NUzuQQC5hOGaq9G6likxMyhx1VZAb
         sNifCr7bxkgj606TWKvBKiz3DEM/6LDMqWugAib8E8Y8njk90RZkSOEO0rwPNTxgWYty
         /pnoDzV8zR332yXwa21F6ZwrQd1Yncfibda37CAR99u7PP8RbcdAE8NBCWrcsdslX/td
         1dEQIma19ZOzBxuGc0hd6x8q/CckbFzex/dMgvl2oPbNIeY66Zn1Oru13uPwBDCQQ5Ps
         MN0jN49wZRXspN5EoLsOiOAAPm7L3W/GGXHKV0ll67JPdC7+MXD5zEUArRah+e7IBaBL
         Jftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555873; x=1781160673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XB9Q6X09k8YWO7HfZ3onZiDHCRdqw6sxvgxO5l7nA8k=;
        b=mX/OD5md62MJsTRygE9pubrjB4YunOtiRGVHbERXLQp6h4zF6gItNESD3+O49jRL3A
         PYpzFSMq7HpJxTZ4WPTdfz7AFEKFHBfXpqiYWlkFMfQ8NK15pJG3frz0MMhL9iva/Gos
         tfV/UySe7Y2UZQK4CcRuSRCCTXgJizfxehdfYdevYDODSt0mbGQidzebg1qJcBBYrR/z
         KJi8MgdBld/WwkdPF3soG99N7A9V0HaMIlSXPhoPq/mlCpgZ2K/wo4YbcRhxPatetOOo
         PE9uUxxDcDnQkghRalbl58vC0B6JDWIdE8LpiRZA95C1IIq7AT8SX1rMun54JlAJSd8e
         xafg==
X-Forwarded-Encrypted: i=1; AFNElJ9uwE7WppLwYAZgkXT+SwQE82rlk8a3E55X4OL1zSLKNIzKAFMazJh/WYGOumn3OM6TPj4SpNWr67Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoMwmHoqVbE/owlkVFU5ibqTD/nM8YLkZz3J46H042Id5QngM
	LXvZ05XBU4H3B7ceFo8FEsT96pnYW9HcadC1kEE3fuVoYvZOVr91NcXGk+tgv4O3CqIEDqHdQck
	fuO4P/BDl7zfb7AKVGLIz97ANLdHtbPOs/ZLFMisqfUXjDpF0GcS544aA/pRuf8w=
X-Gm-Gg: Acq92OEBJJfxG9XvgqeTXh8Pyv7iDa86NRewVvMlNqFRiR8/splx9yfkZ52fedMGwm1
	p4wRyDpbq7TszKFhrGFzDPoi3pn3f6rO0iz6Ytxqznvf4jIVT6/Rbr2jnzZrAscirHqpltZz5tk
	UHgWU2dr/ssWX2yEJi0lgiCWSUFJOrBDHI4IjjBjPy9LyUZiS9b+FVrcQGeU8JwglFwJA1zwQUq
	drFIANL/KIYFKCmmrsIFH+gJiU6BWZIRAx/UpHwtta6rEHHaETpESAMEZzHskNRvfMO2YoJOa6K
	U4iXJHV9vIgIq0X/gMH/sN05TIe/vJGeCBtsOvoIpOO5CiJKDv/gGjnCS9yHzKq/uPieyeYnnqG
	kfBXjCfxnfEqju6pZnk3aQ45EUfJXFeWSp3YICgjaWHiK8s8JPfozkvb4f1ERWxBbtA==
X-Received: by 2002:a05:6a00:218c:b0:842:65c1:468c with SMTP id d2e1a72fcca58-84284dcf4dbmr6811664b3a.7.1780555872847;
        Wed, 03 Jun 2026 23:51:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:218c:b0:842:65c1:468c with SMTP id d2e1a72fcca58-84284dcf4dbmr6811635b3a.7.1780555872344;
        Wed, 03 Jun 2026 23:51:12 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm5365894b3a.15.2026.06.03.23.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:51:11 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 12:20:36 +0530
Subject: [PATCH v3 2/4] spi: qcom-geni: Use geni_se_resources_init() for
 resource initialization
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-enable-spi-on-sa8255p-v3-2-43984eac4c67@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780555855; l=2636;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=W/YrZ50I3AwtE19t9pzTiT0xdnQWey3D03tHPf2lno4=;
 b=ewjUJ9QKdBe0LIdL7sEmglT5sWBrEP+JxB6TfNuTourwIG1xcImR8fe/gNJJSHDiomNV2fY6M
 k1xT8JFyf7mCsZ4+n/5sW0Kx/rTi0usWiNKlEGlXXva5LFU8mlecYpP
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: cnVG81S6lkhJZH0zjXFyiyQXQLT0b9yI
X-Authority-Analysis: v=2.4 cv=XK0AjwhE c=1 sm=1 tr=0 ts=6a212061 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TXo2QnZ9t29hVJcr6pMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2NCBTYWx0ZWRfX0ugjq9qgCb7p
 044T/KZZwKqyPLPNWACJr17AZclGbYR7saT3WKVoQ/uLn44P+kOn/lP1KnuUwSn1ndIDW64Se86
 Fgmc3Nu0LAeX2WLNAHpDsoB2LJopmVvPgIgpg3GmooOSH8JhGF8cwxPoHIpCmVNJctFE0ED6wYn
 hdmGli0xTwrRRyYtPwY4ypIjQClKTJA7WOGUmikAfUkjWrp+LmuGuwOHgPYadu9TbvEzTqubB1l
 xUXL86ZmUGwpcnnOofJvWJCqE1frYyqMooLD0gkMcCwBX0z4xHb9jOQux9LvaMfOt7sDA7yFELy
 KwQrMv9fKPUF+E+2cq0J/gjNmQ0cmftOvfNTLT2RuH5qeXD4Hq6sOeZjF/LmE+Pr5OLrAz0L6hu
 yWPNtWkVxdFpk/Su8BVaPRsGrXuff0Yp47C1QHqVlRVodvHADIi9+vYWUcoS1bf3DY09Fand/vW
 x/pGyfjlZZ3H3tkahfw==
X-Proofpoint-ORIG-GUID: cnVG81S6lkhJZH0zjXFyiyQXQLT0b9yI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040064

Replace resources initialization such as clocks, ICC path and OPP with the
common geni_se_resources_init() function to avoid code duplication across
all drivers.

The geni_se_resources_init() function handles all these resources
internally, reducing code duplication and ensuring consistent resource
management across GENI SE drivers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a04cdc1e5ad4..333216df922e 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1034,7 +1034,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct spi_controller *spi;
 	struct spi_geni_master *mas;
 	void __iomem *base;
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
 
 	irq = platform_get_irq(pdev, 0);
@@ -1049,10 +1048,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(dev, "se");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
 	if (device_property_read_bool(dev, "spi-slave"))
 		spi = devm_spi_alloc_target(dev, sizeof(*mas));
 	else
@@ -1068,17 +1063,10 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.dev = dev;
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
-	mas->se.clk = clk;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = geni_se_resources_init(&mas->se);
 	if (ret)
 		return ret;
-	/* OPP table is optional */
-	ret = devm_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		return ret;
-	}
 
 	spi->bus_num = -1;
 	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
@@ -1104,24 +1092,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (spi->target)
 		spi->target_abort = spi_geni_target_abort;
 
-	ret = geni_icc_get(&mas->se, NULL);
-	if (ret)
-		return ret;
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
-	/* Set the bus quota to a reasonable value for register access */
-	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
-	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-
-	ret = geni_icc_set_bw(&mas->se);
-	if (ret)
-		return ret;
-
 	ret = spi_geni_init(mas);
 	if (ret)
 		return ret;

-- 
2.34.1

