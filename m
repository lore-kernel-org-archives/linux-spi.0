Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B991401A08
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482136; cv=none; b=rWbZ2TF9w5MBZGbjWJSkLNSN3IELk8hBAIErjdBgfepLyXA6MENbg9ae8S6uQuCofF2aX7CjzO+MdlDYd5shtQlUXGOJuZRojz/f6WVyF2ZbQLBrL7KUfUUAKoPvUOqogi2dHG3w4t49eDpyCk+Jr/elm8lnlz4akurbmUlwQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482136; c=relaxed/simple;
	bh=nGV1Vleb9T9SpqQBREvA0YZlDOG0M8fVTNUv3Cn43/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2H1MEKZJpGOCfvdBzAoUr/8rQl+QPIOr6UTU4b2lTBFVQuvW4Ut/pZFiV4NXH23xtLH6gnttdOlEj4aFJ7usB56JRI2ip6gK3hiTnO4EZQStc4R24y/uap8HrJX4spzGNIRyD5qkH0FKHG42oS3gDR5jQSfdhJILUTOknp4hXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPBAdXmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FC4+M9C0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPBAdXmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FC4+M9C0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF425l963216
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EAqVn8rmQhGBuk9O9Av1mtCrWPGHtYzR712NYUgJqpI=; b=hPBAdXmGCYoPKw7B
	d1T/Cb2kSeM9+rYCy54YAhlPfUqvRQQYIWGMhJCaf4WcMQGhsujRN0MKZULjkFVY
	y59+K714s2/SYUddJVVvO/zqPjsWzk/S6XAav4omng7yZGSclt4d2CwS0zcsY8kI
	z6ZVO9RhGEov56C4ER23ujwzCzqBlt9rs4L8i6WCYThGUU/NDCZkWQAxmnt4kWg9
	8OszhK5LUZoHZgeBFtfdep7+LqBwbmScs5NlinYZp4c/0OuGQrTIKzLImi3so/iu
	T6a86qHySU648dnK+fDFduc8wjtIpJydW1cPNLu7/RZTHC23X7GkqYSc0HDVRPia
	NbVC1w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4vgnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e06219cbso60595ad.3
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777482133; x=1778086933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAqVn8rmQhGBuk9O9Av1mtCrWPGHtYzR712NYUgJqpI=;
        b=FC4+M9C0nzLbEPkQMX5jd2W1jfXAwlQJ8oqqfhmil+D9cI2nu7Vr1gbFz/0t0m+neW
         i6LzzhVizl/iyjb/POQZYPhvbNXABuTAqGm4AHQXL1my9SLqjVQMX8j5prQ7ltilSS0W
         3RAJOiXLm4G6mfGMfW+jAOiU4A34ZNFb0Sy6PX2+tXPd3Gr5a46b5wtTcfJCNpXaVUAC
         R7fYkwvCi7xCEolycS7dG/yiJGwuZ2lR74HovPrvV7PA7CTDxg11X/uyVWKpDLUGCOyg
         AAjUYgAmBw+3uAPPfKtFaljixWUT57B0h/f2GQq96KFbJeUi09TOvLLIKMzB/Q4vK2hK
         vksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482133; x=1778086933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EAqVn8rmQhGBuk9O9Av1mtCrWPGHtYzR712NYUgJqpI=;
        b=FxvGxiZoyCuCPG6FBpVhUNoElRqNeDdFJpCkOCEhSICgiPPXBXWcyinDT7XgtcGoXn
         qsp4aQcfK9YnX2FLg+Qsv5B+QOApS8mrhnBtT8oKcElCtV5NPw2lJSgS96pgPXNALs4V
         aImRPiFzEkxiBJxTrcMpchNImoORblrBD9tbCFYPPRPYVCt5rdQhhB+VbQR5g1SqO4pS
         JuUvGa3dK0sJ+PZagHPk1cVdBoRHLIXZ4rEEL8KzrNSFtN3+Q4Cbra3xmsR9/fS04PfX
         zdUJlJtbVEmb6dlvfM02zO5TO5sBiuzA97TyVRrylQdN7c6T8ssk63Xars5NOtadudKa
         1cWw==
X-Forwarded-Encrypted: i=1; AFNElJ9v9NAWRhcSdb0vw8EKpYJfvEoibIg+RUjB5UlpNr5hfwA0/zKyNjqtRGjiBht00MNnusWom3TnmNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/2H8iZ2KADDq6Y7692sise3X8QRk+nLiER6CueeM1FfXryn2
	ghADL7jGeUJMHcxhwY3MC+EMyPFwcI7MbBL4TqDcMpvv97PyqxCsGcItM2JvNAPP8SqPo8xfgnY
	BLt9r3iM+VZnNgX4jmmLcX4O1kddIBnRS+/DXEoCN0uZGCb/V8hrj1OFctHuqJv8=
X-Gm-Gg: AeBDievA9B2RdBJQDZsP0563TzFRhRY1+wlnVKjma/1zGZoUE/j6kmb6KHSyXGTR/p4
	p2+cOEKszeZvYdbFwAJWMkWfEBKkPOPVZQ+xaqWtdt9vkCHTGpP6g249NDOawDKIPwqtMS/SqiG
	KpuJj6p3CLTNwRbjkZMG/0rxj4EzmosmyX01ulDLogGhTiOLnVWz59TSQSwR2qrvTc1Lo5/DIff
	606ZZhGbwuz+Br40nEmbQVkCT2dhKEmt3rAPn2DR6TX5fmZaLiN2llT+eFAh2oLlqUPPazXcv/k
	HTrO28SqjyIhHtZHuJ4TMgPuWaYU/WnUV574FYEPA4+AP2VSfAn76BzJAolHo8EOJldPMNRXLiE
	b/oxEUDJSAoZcq6yrzyVCt/xMz+BDoGVVymsS5xOdIt3b/HtTnDnvauL6aP5sacs/zz2N
X-Received: by 2002:a17:903:124d:b0:2b7:88d8:efde with SMTP id d9443c01a7336-2b9872f85e0mr43422675ad.7.1777482133227;
        Wed, 29 Apr 2026 10:02:13 -0700 (PDT)
X-Received: by 2002:a17:903:124d:b0:2b7:88d8:efde with SMTP id d9443c01a7336-2b9872f85e0mr43421875ad.7.1777482132511;
        Wed, 29 Apr 2026 10:02:12 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887853a2sm29530195ad.18.2026.04.29.10.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:02:12 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:31:41 +0530
Subject: [PATCH v5 6/7] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v5-6-993016c9711e@oss.qualcomm.com>
References: <20260429-spi-nor-v5-0-993016c9711e@oss.qualcomm.com>
In-Reply-To: <20260429-spi-nor-v5-0-993016c9711e@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777482100; l=1377;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=nGV1Vleb9T9SpqQBREvA0YZlDOG0M8fVTNUv3Cn43/A=;
 b=PZ9lIx7B2mK4TnJ+F7r8qBxvCpXA41gTeFcIFD+HDSVS529yym05f8H3WOUVrH81Akfehi8DO
 kfa52Nnwg0TA5Tdx1MJ2ExYQOfDSixDHvQPJax5+C7rHoqMhdFb3gXs
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3MSBTYWx0ZWRfX6w28RV8o6+1U
 GqWky1IHnLTncp/3BMJheXi7v4OSSDPgT01T28K1BLSO/+847lOSw61esjpwpOH3rfIeZAd+jXa
 jlJp7Z3/a0v+igXOVWbVMZVW3Wz/tHstwCaWkdxc+IoHVtOnT5aMSHBQMniG8tn1dmtoFsxgrEZ
 ZARYBlPVRSYKRNbGMvKBv5g4FxoTzGVqcBwNXSuODYe2LVW4x3MtKs+R/ZMvEn9GukJKyU/cLqN
 liLL2/PXEkEFgb/5up5S3qfU3jMq9ZnU+l98rOGz9tzF7OK6Yj+YKDIq1E54R9MS5DZOXFcwz/y
 UfOnfRLe0yCJB4eIO8AeqJzLKkzsOukFVXLvCBCGbpa7UkfEbtWpIO4w++mFVTQeFyBL5fLxMhg
 gXWw8JVad6wCPYYGGj+YOfc0mDd7AAzFiB+tYJeJf4u6ofryT7WGYb5mgPUfZRcmVQzRbq4DDUt
 sng/k6tiq2muvgkHcww==
X-Proofpoint-GUID: GdbU08ANtpaoNVo4KRtLiejI6QkZMz1b
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f23996 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=DDoZI6XnaA0zmnrO1bYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: GdbU08ANtpaoNVo4KRtLiejI6QkZMz1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290171

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without it, the interconnect framework cannot vote for
the bandwidth required by QSPI DMA data transfers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 988ca5f7c8a0..2dbeb15c84b7 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -4418,9 +4418,12 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC 0
-					&cnoc2 SLAVE_QSPI_0 0>;
-			interconnect-names = "qspi-config";
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc2 SLAVE_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&aggre1_noc MASTER_QSPI_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7280_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

