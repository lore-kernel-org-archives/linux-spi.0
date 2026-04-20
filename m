Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7AC3815E4
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665613; cv=none; b=CthMCfM2gP7mlsM6VvoJKc04Zo2AG+fHArhSiOy5Ip2aKa9nMQAgh74QpXRLy6vyBdGANvXes6puDUy9UU7magtesUQ6JD1GVCRmsOcvXOBAjb+eI5buzPcpNuiHWV1kASsTdhjvkoIskXNZao+VRSvvTZlBlCM5xj1RXnvw82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665613; c=relaxed/simple;
	bh=nX6Y82zzESPqhrrlbQlA1NTD5phO4pdq0SzAisS/ebs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSyloHj+ApVVkCXWf/L/SprUa7xTvHHqUSTS4bTSaaRnGYvlmvUI1+gGDS9bZuh8uqwdwb9li1H6lGaz6Nn4ykl/cwEZvGK7ecQP4vZ1USuAC2L/2qs/RRpPQN4jYAHraj1JVFhbb4WZ0n9+MwzZ4GKDD15jugfFUznZWSf6pWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GngyPDcq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IXeaeX9I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GngyPDcq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXeaeX9I"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JKtQjK294910
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1CecqJt+jxHeudMX3AkxTxuPao/HPi6jAXtF14dccZk=; b=GngyPDcq1Xlv0Z+M
	7i81LMUSUSpiI1gDp/sbGVZcv0j1cXNv2LV8QZeWhhM1Byz/L6Jg10yQDVhhIfMb
	zBHFsJsYYih1GwTBHa3JL1XxVTfZDhoV7Wja7WGosFeLeoiIIw6h4m0yRSQpV4U9
	QzQhcFMdrqJ8h69Vo256BxgpxlLtv5CJOMF7b9Z0VBgu/Hs+hRsy/WMEgHDcdE/h
	/Jg+G0MC85K/twJWOAXgxkvNn2mYRbTU6STKlFWdPaesLQ8C1pegTTrW0iwTv9Bu
	A90C61Yk9aps2fNTvkUDW7pSTlZmUWBWS8RddEgxtwcenbgWiiI8kJZhKTqi0vqa
	GtxbNA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm261vawr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f0f2b2641so1965084b3a.3
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776665610; x=1777270410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CecqJt+jxHeudMX3AkxTxuPao/HPi6jAXtF14dccZk=;
        b=IXeaeX9IWkh7ANez59op0sXPnqj+jDJByA5LRrePmNfYAO5esZTs1QbA0pAMbajMM5
         HpKOENguOf1vEpZ9zfCNnvja6ymp6l2jBGXgMMO0M2HYUNpaTf9SjN2rIahSqPDOxZ7U
         /kxtfXCM//J6SncdZyxlezrPabhI1qK4QIWFAsYMQTNrR9is6Eg3vOoZAT2yhjrXSVWd
         YCSHkxde7xNvgkkqJ09WtccRyY0O4CO24Ex0ZmwnzmiawMF408YAYTgdWkqgo8fPSos+
         yRIRhvS5WwZzkbQ1R3Bvq9k/Ic4wTwnMOBm6tVnxufG6VZzhOgUsJkR3ep+t05BYX343
         +OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665610; x=1777270410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1CecqJt+jxHeudMX3AkxTxuPao/HPi6jAXtF14dccZk=;
        b=N6DJ5MS6i50po4E419GCqI+Y5DenORqqJePQWv7kRxuaR1FDcHo19fAhoDhLnVRq0I
         zbmBITPLO6sCj4to5cbS+JHF1kN0Oezxmt78RD1aw4P9Nh2/ehghS9ml8rdbeLKXLnWd
         LHJ9XSMtx0WLy/6tpZ3f32B9bB3aTdmFZKmAUzF0zasjxMZX+MyZC6NnKnT6F0ySXPS6
         3pOVDMnB7d9lLqnVvAVluHLEWfp9Kj5I7neVnnhfXdcs0U5Ujfq5VefS7W4s3FBS3lx3
         YNsI5+SH/nIosMuNLZ7BF6lnbEeaTCkM+n/D5r3iqQdGOiJrnZe/0Im7A7UP0ssbdetv
         4mgw==
X-Forwarded-Encrypted: i=1; AFNElJ+kDKSq3epGBdMt5Ue4PKO66UqMMaNHQfjy5LdXtzTzVViWj9zPPRHEZ5Pl1gajR+enDuFxthjOpRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlIJoobgIA77IO5ZTKtwsqOXFnIioIEx375CMXustIO3a2/Af+
	R2W/S8ef0w3jNnth136CX4311Sx2bxwqKTrqkRVjxLpE0pfiDi1e+iMtA2yZvbvmYLr0jHAfLB1
	pp4Phwx8PPgUitim9utptJhgH8ZZG61Bi5ZAJop1U29LEfnVbm4Ba6hVVOwOy/1w=
X-Gm-Gg: AeBDietu3ZznbzbaAzbVj2iFc+/1cNrZffwy2eKjnqYrkxhA2QbfP+iJGpdPWuif48c
	s1LcLS2DZCyuKP1XcSQL/tft7TmEooM16e07TIuGxXRwPgVVp8bqdS/pkEGXuWJKwsIcKXld31J
	NCN+TjaLxN8wO3t5r65S7/SswKUk743G3uE1b7unZ/bF9DYt8J5l/U9KEwA1TOK4CPDgYloXMI/
	+kvfZkBMp6cYrLOqi3UqOA6VLqQdrqq7w8dZoABhIspS7wTSiW1bGY0Oz7ZplZHwSckAjK29Fpl
	tXEGamgpDYVmh146yfmzKM2ojQkXgFZr1xI4QS17rzZRRjV5/NCJP5GVF20Li0/4FJUdo0SgfI+
	6C2eF7PHLdut30vQ6MHZ5gGw4Y7o4qkea8K8sRKhHUDYpMWKJpA0WRIkdIEeIdlb8sHY+
X-Received: by 2002:a05:6a00:27a1:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-82f8c82e219mr12829922b3a.20.1776665609557;
        Sun, 19 Apr 2026 23:13:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a1:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-82f8c82e219mr12829883b3a.20.1776665609062;
        Sun, 19 Apr 2026 23:13:29 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm9018034b3a.13.2026.04.19.23.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:13:28 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:42:52 +0530
Subject: [PATCH v3 5/7] arm64: dts: qcom: qcs615-ride: enable QSPI and NOR
 flash
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-spi-nor-v3-5-7de325a29010@oss.qualcomm.com>
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
In-Reply-To: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776665582; l=1047;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=nX6Y82zzESPqhrrlbQlA1NTD5phO4pdq0SzAisS/ebs=;
 b=+Pf5sKpqS+UB+n3HfhmUCJlJHmLgfUeqMoJK3bbIQ07qCTG6SuEdv8fLwUbm0A1NwbRiFjc8z
 qfUWuQvE63NCquTcg7w+m0EiDhz7caXTOFw/ERSpAY0ofEc5thkT+t0
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OCBTYWx0ZWRfX0Ht4MP7PQfgy
 3Cn18gOOOpgzVj7AvG+6D5tv7fyPp6CrUK6olE16B2LtK844+T4I1muNHjIc/GfIYrY2mr27D42
 gfHAC6KiQOAo5MbLtZ4nvSyFzNcOEki965Z7FExjBNYS8ec73kuEWVyhA/QFsV1+P+zZ059AAv4
 CmKF+XM3Y6LD1lsm6k1ABGtv/1erxva27Twto13vd1NCSr6wWOIXbCT6GKBfNraVePfrrPFmrny
 IZ18u0aAcQfdJXTuy1daQ/NufAHLC1006KpNcitth9TmFrnwFOAyTq3/hEFofdmTKiT2ODTtu9+
 f9AGIOAfZEN/2yJaJ2Cee6p7VA6xX3j1vCnZ0/2ziGjLzDplxZnbpVniyLbT4m3dWu029hZ4T4e
 b7FBrd7ajSutzTDbQpErqwtSoPTt8FPSOnDGJTcGH3WRan+hoMmXlun0qiEU3HXRiaKG1TlUTgT
 24ECpUxEcJF8MKuNY6A==
X-Authority-Analysis: v=2.4 cv=dcywG3Xe c=1 sm=1 tr=0 ts=69e5c40a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=eijpJye3pRbVNivL--0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: KUpVZUOm4513DQeDRAIguLReXZ_JUo6w
X-Proofpoint-GUID: KUpVZUOm4513DQeDRAIguLReXZ_JUo6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200058

The QCS615 Ride board has a SPI-NOR flash connected to the QSPI controller
on CS0. Enable the QSPI controller and add the corresponding SPI-NOR flash
node to allow the system to access it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 5a24c19c415e..b096d96ab220 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -516,6 +516,18 @@ &pon_resin {
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.34.1

