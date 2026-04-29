Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371F638E135
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436608; cv=none; b=jIwnIhtWnliDNiwHwyfL808MpXGbz7Ha1LEJwrvuUa3p5EGofOTzJpxs1gZnXfZcIs3hHij4DfJMEcEXuw8i5xXbaBGv892kCzVUHTlalSAfDCDYmTrJhUfDMFGCaRqQKMxdgBHq3pp2laW6hrIDJ4abNIYp1QHRBLyQ5jYbiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436608; c=relaxed/simple;
	bh=alFv/kzGEzm5wFtVA/LSPYMgVGkfYBsM6dzteSkR6Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DDf62h2OTIt7/KQDTmM0jciykkIUyS8y11wrjnZB6YLv7y281S8rF/+un1umiASECfGKcKCjU0ZnK0CMaaKa0/GnThxUD78nPHBNcFcHjds9gknS1T24uPTS8EdBrl+DOW45y+z2W84igmpJE+uvzHWGOBOxuVvK8M2vXTS6Bk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LyIZ9I4N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lbr4whqw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LyIZ9I4N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lbr4whqw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T1MF784070669
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FFkJP6SekQvPpwgvevR94ADvSmAgAcnOvXqYXDyrcmQ=; b=LyIZ9I4NNuGJTxE4
	zo3v/XAJDkWAAtiYWIcfToGlIMpJoaDq44q5oo4CDVbL8cDu8yAz138hmtfwj/BJ
	ti3WFHKJIk4bd4DCMmDiluA5H/pLrF/ZQwLskQJoYx9DV6LVNh4mi/z3ThAz6v3W
	MiLMt2b4IvHWBpy7s465JaJSCP3KzoMpyzH7P+Oc7CVhK3fdrE6kc87hjas60bCu
	Ytvtxp77prh4AYfaU2mW+UuIOfpwUdnyLcJlaJvTxd/xvx4IiiWla/RFeNcDPXzq
	Dj2xmJ0bFqbANyhbM2CmT3E12Xy9sbfjULHIXx6S4u29zcLPPZCJu+xfEqSBc0LO
	bcR7xg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjkn5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f71437218so8041724b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 21:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777436605; x=1778041405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFkJP6SekQvPpwgvevR94ADvSmAgAcnOvXqYXDyrcmQ=;
        b=Lbr4whqwOfiaxaqSlfLFwfVpvqZ+9x+2tJr93QdXKuvxt7eCRgm9i8z5LET8aKLAyn
         AByNep9ylzmcNJgFDLrnNL+pPTwm6lEX+4vjwFVt+Xmf5XjADDyhFshmx0sUKXBTOXCg
         YHgc+j39kyuG3Y9eannu+KRpqRbz3temKRVbnWckbCCObGaLi2lZjXsuzc0glMsNrXfp
         y0YWGh5DhjCRkqIy+czT5ujqeqzH1JiNvdbT6lWzvtrNi+YCXaOqeIelzB9QGVpiSDyh
         JNsw3L+/Ec1bAJt+356LujvZaH+rN/h0NSkC6rnDy0zZbmjmxA34OeYvHPoV7W6lU2uo
         zdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436605; x=1778041405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FFkJP6SekQvPpwgvevR94ADvSmAgAcnOvXqYXDyrcmQ=;
        b=dBQL72TWMcuzOcw4uk0dYOXKrPj2HYL0YbaA3c7rZ2NqEWBVxKRrb7QScy6q+b2Tqr
         yjF/F+ctpwbv+MQlDmz8Df8YsMyL9Bf7W2o11WwP5qD4UBicsjyfB9LHN6Rv8op5gT/q
         3FEcQWqD1Y0CwyVsQjvozfPi6dB/TBLsdlYLRe8Z/t419WzpgnHCmxCX4TFVo72FbQa3
         UJIqjUdWBniPLuJFewEjNsQWmpjErbcuvB4TqHuxBTNzA5RHmXDg2RJYOWnAbRjZts15
         AzYZmbS9t3QbL01Fw8Ccqlace1ScYQArWldvaOZ7mRRbgHdcXReQi6/iJL3pBKr6j55l
         c2RQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2wewCdfYVzj7xDZs0OOKaaKwW3IS2mNW/Fq8zdqlr/AkmakruJtASrbCSZ6nJGz9Hs5Qcv1c81eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHWQCSqfp6XbUJ6paerrcwTpBkMFRk2WLdNOX1AixkBQnBvdO5
	OnYfINB/KONzgVy+aYUS+l3UOn9dLAmV786bWqCr2s0yQelkmNoaJES8abB4U/rUHZLZos+2bVz
	OykTX6MZopwekzVBMtJSXozlHtnPxYtCMEgbqYVa1kS/UrqdlgCcaxYHI5UJUeow=
X-Gm-Gg: AeBDiev2uGLnjOEdPoZno8L/s9FW8ZWMKKEpkE3EmYUjZIvrU6sdlX4I2jOU4wcW56Q
	OH/rN3vJOKub8Jkh0vCVuX1IabNX4evowZnWF+iQHGOSOvVbDCeA7ENGR3jq9wVahF8x+pR+3ZB
	g5SgcVDltEWg3w4UV50OUdrDbh0dS9kilpRdLl0MPKicJ2V4dD/1TVxkVN1ADp+6T4Bl3HDkLT+
	ymsY1yBu+xnVaOwLgwjGxk7b7TAtGCqAyOaKgMfffUcVIKxO/o18LtUDN2M45v9gCbmHG6+nuNk
	hn4djuKztvy5rQITVSfO7pt3OKNJQGU5mnYqZyiyWuxlzOBM+QXM0kWj9RleuE3RqqhRPU4MIZs
	pY3YGUc3qIWGqtic4f8owT6HvUJbCu3EmcSxOG7/f4RY3M+aEJEOfpLfCcTOLY0zK0JnU
X-Received: by 2002:a05:6a00:1ad1:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-834ddbecc0bmr6058988b3a.32.1777436605068;
        Tue, 28 Apr 2026 21:23:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ad1:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-834ddbecc0bmr6058958b3a.32.1777436604581;
        Tue, 28 Apr 2026 21:23:24 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5a074dsm602200b3a.10.2026.04.28.21.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 21:23:24 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 09:52:46 +0530
Subject: [PATCH v4 7/7] arm64: dts: qcom: sc7180: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v4-7-73fb1bab03ba@oss.qualcomm.com>
References: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
In-Reply-To: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777436569; l=1402;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=alFv/kzGEzm5wFtVA/LSPYMgVGkfYBsM6dzteSkR6Qc=;
 b=JSUzYGfmnr859ObtZcII/Ah/uduTCRkZQGanPtCqi4M5+Rhyxpjcg67FHkuWXU+oO2hglv4pA
 LTmBpzkNkSMDgwc2ZSk8qU//OIGGJ7/rOtt5QJOGTuGeKLPlYpCRz1y
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAzOCBTYWx0ZWRfX57A/nm0s0uwJ
 jRV2stPkwgTWO5oJwKLInLSlkC/dy4FRqe+dXxULknSNELNhZNowlAnxIaRP3Cjydo8U6hcjv2E
 L+ucqljbweUnT6/XevZKe3lT5RQPdpEiPpgcw80oI7hWPy6zncXZWTh906eOGKcVJHUNIU4i51t
 qS8I6yrrsBGtdUcXKu4z78HhAy3fm6Yfkyt8HTGer4JJD7yScel2rvK/UoCzg1KMseHDEGukIO1
 Yk1Yy5qQDHRagVjGmtwb08kPnwOXqP0k7cLHutzCTWPLx/dBxQCDDM2fLv9SpNFGpGEId4QBIAC
 tM315J1/w0eAQvFVG8HinJfTOIXFoRvE0s60eS+A6U/vPD61Pz0vG1y6ZsBCYLhJ3OvurKXrxVe
 0zBIttXIovNXfOqazxGph/eFYh/6LEXjpQZXkwt4jXhwWoMfRTZgR6Vyxp2/yZ8hmcrrc+CULpD
 Zv8VytAF3HMTe5K+TKQ==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f187be cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=va74t0jcI0ebB8ul8YAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: zB0OaP41QkNFch0gLV-ixJ8m7XTvJ4GR
X-Proofpoint-ORIG-GUID: zB0OaP41QkNFch0gLV-ixJ8m7XTvJ4GR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290038

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without this path, the interconnect framework cannot
correctly vote for the bandwidth required by QSPI DMA data transfers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 45b9864e3304..7515d982b38e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2864,9 +2864,12 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC 0
-					&config_noc SLAVE_QSPI_0 0>;
-			interconnect-names = "qspi-config";
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&aggre1_noc MASTER_QSPI QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7180_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

