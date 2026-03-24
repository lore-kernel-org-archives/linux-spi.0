Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EC3F9F39
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358050; cv=none; b=TvkrfpNwMzwsWUsSdTsY2AX7gTcCprRjmanuDOCkiY9cW/Fq1SkmCTtmrIQEmEKzVtaOlnzo5GOARbJX7GNSNDtxLqPQAIlQHw/xZkqug1kRkGJ1vTgEsOVfFmQkUbAXhHTNvTyUwIsxREEpBjRkK/8ikoD37VwgUahLMEZQSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358050; c=relaxed/simple;
	bh=A0IQkyvp9VZJjwmAmBglvF2YtSzqW/Om3BUQHbt+9PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dMlBOZ5jUh61V8wc/+QuqqiJpClvq7HIMffWsY7xP7MdJw+vF1w/bzZ7O4FxYvwENk40b4lZ2n3016VJoJ5Que4xJx2HVryk9X89K4gbQ/aywOYTYCyLJdlVgFahLqulAPa8FIrI0AqY8ODcHXX+rjFt04PyfnO2xR/sAcL6ERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HR4b3+2P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RsaW0L21; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HR4b3+2P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RsaW0L21"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9UnjJ3903725
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p49DQ9JYh9TPZn7lluAR8uoK85UpgfGic+fiunj6Xfw=; b=HR4b3+2P4gKKefGr
	xyShQ1hJ/vEW7utNLGRNfCoocYVUmJDLJ6+g23HRO0T13hb3f28D9H+zp24iWTHk
	Tql5ZLWwbEy+2rMpxv4tIQx3xf0AOIFIp8/cs4A22XYBuePjYvPVXU1ULJnSpOZ7
	AgUnv9RnNcc0j0arpshTYwO63JSh5R8pTNNlE5aJL3VxlKbYed1jhAuiuVxW6IHT
	62UiKkrwTT8dNEj+D0kBEHLeMtLH5FsbGglYajc/IcsrMO+m6XMkhIgVAyn/73sp
	1IF6GxMXzWjtWEifHlStpLKgXJX1akLb8RvB6TX6JWvVxzFPcKWFyrxPs3tdYP0G
	OkqikA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0j29p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c613194caso520432b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774358047; x=1774962847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p49DQ9JYh9TPZn7lluAR8uoK85UpgfGic+fiunj6Xfw=;
        b=RsaW0L219XzTUFKaRd/NP1q/12Va4A3uyi45VKX97fRUypVMLpmYsYs2u3ktuczBCU
         /StwyyCoojvXeSeeaOKLZEwnAvesmBz/fhpuf/YytJIEkQ3HUzkV66eUrcrBQK748nHP
         0Jj4JImjebbZ6mDE/llj2i8Z7MtDMaccvXDl0koXaT6D8fI4JiFErJTtY+DiETsPyuwX
         Wa8ym3NAWiMlMNGYFQ0qpQc2Rd0Y20B8spMD/kt5yRKp9FU3g2ZdN45WqkTElOMTe9BX
         ezVbwpRm8N7drgrlyTwMHQv9dkIzMppZtPHtApBqlzqN0n2Mi0tnhBVdyqtYeckLWZgc
         25Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358047; x=1774962847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p49DQ9JYh9TPZn7lluAR8uoK85UpgfGic+fiunj6Xfw=;
        b=JznrtoxYttExE2UPsy7pv2mJv5mBc4KDhmvGH4PWss17CpYAGsZLtQoxKpucEsp51t
         wpWAqzsj9eZNhimuVxTWkza0DH2X6KCrbpXFGlY92B+HZN4YJXzMSUj8qutbt1TDdWIM
         QDOTwdm9BKcvmk2AQfpdG4yDs93/gvd3K6uBOeXNX+cPrVCw1c5joqe5I8M9ZMSb1Bek
         I6YcvK30eoiKAyul/NIcdu0poCECyWpj4sk88zvw2urQ08l/CTDC0v1V0qq2GLlXdb/K
         I8FdfUEifhcY/zcvRPYYfGyt8u8fnHZ+I/dSfGFZqXgR1awd+6qJ3zljrdv+1pugKSbM
         i0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUo4sjvv4yeTcTm0D9A5nJydfizlAKZVBheEFA9R0dtu0iSGcPl5JB75s6gi2fJbMYnp1WExK+3gbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0tFKlu9qkhVE2qm5bceNxnkMnIcuV/sfB07AndnjyUITFAdv
	+gTESyZIIZAcYEZYexpLnmmZPO276iJt8gNsVublXY6TeGitrlFy4FNcQkkzA0D9+RMoca9j2I6
	2GH3GyAcikbpKZoB6y3r7MhBYN7/8jTgFwGZzMorEg3K3eV6E6XD2EuYb7GbP9VU=
X-Gm-Gg: ATEYQzyK3Q+n+SrZ2NMfmriGCEZU62XeNp/+rPLVDu9alnJSAltfUdy5yjSj+onV6RY
	AtQf+6RFSdmSWmC40zlouUjOnEaiDcii9WVl79VmQOpik+Onv8jaVYlw/0DiHWC88/IQ/U9ZlVv
	SLnIK6KK+s9oCAW1loHO4y+LD2E1XF9qLZy7icmR2Ab0Gj6QBvOGv/DcGiw0B1HvaYFJuWhjZoV
	N7lq5R2HayEkNqTL3ULEnJPG9tYQVbM+ijFkFR3hnkfp8pbRoLBcRzR6VlTd18OLkOY//yPKIkB
	0HViX0hmetBfdy6Y8KUbpjQAEEfHxnDb64d/22JiKGRJ6avsF6TVGhsz/OUhhcoZlP7U4hb406o
	sTWpEYk12xxUfHSK6JN0Mk9ne3u7Uk1YLRzBukp2FaLotTh3J1OJDKH6XuA==
X-Received: by 2002:a05:6a00:3021:b0:827:32d7:6690 with SMTP id d2e1a72fcca58-82a8c247b32mr12915548b3a.13.1774358046945;
        Tue, 24 Mar 2026 06:14:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:3021:b0:827:32d7:6690 with SMTP id d2e1a72fcca58-82a8c247b32mr12915516b3a.13.1774358046441;
        Tue, 24 Mar 2026 06:14:06 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be3396sm13517528b3a.27.2026.03.24.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:14:05 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 18:43:22 +0530
Subject: [PATCH v1 5/6] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-spi-nor-v1-5-3efe59c1c119@oss.qualcomm.com>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
In-Reply-To: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774358020; l=1216;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=A0IQkyvp9VZJjwmAmBglvF2YtSzqW/Om3BUQHbt+9PA=;
 b=4XndccXI+zSN2z8Oy7LANASK9ox/cowRjbMa+de4SmBbO7qZSU/bgr3Pa93WWU73f2MQaIZO5
 hfD2tVEEqyqAtTeysI7pogjR5ugjlWMG29C5n89CvHGIpjmgMlSkO08
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 4BPOeuuv04MwzAQs51yYO5BQ5BA5Hk0i
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c28e20 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=L5xbH5DL_T0GcX1SYtwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 4BPOeuuv04MwzAQs51yYO5BQ5BA5Hk0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwNCBTYWx0ZWRfXwQTC65Mp9UbG
 osXDRaGw/GGTJ9WpL/Mrn9WPSYbnS1qSoSIdzRnEvlBE4IobpHRiJXVRciN9Clvr/NlOx+NlEd1
 QSpTY6uex08FwGB5vqCo/7TPFZgJ00F4RXdsFmIUmbW63Vf21TAWaCqImil8PWIB7+Pp1JSndmT
 sjaLrlr/MncV9AJnh7IyjiXU7M6ioSHREY5R5oetgH5mHBRk1YKPzriBvAg5tCBioOO6xLVTz1d
 UdlkijDl5b0+O0aiXH1qiQ0vu4fIaYyZL6xfBIHBSGyvWHtDopDbHADFik+EguK9tJRvIeGG7A4
 +vPJeOJI2vWPGn6eiQITHXZukCFBFSHtgUus/Vk5ZOTRK3jc6tzsHucSuPOIPEJ0R8F+SaOsUxd
 SdcmWcCvt3UbU4cI7zKZ+rzkRaSC4fPm2qy4BIr88R5FmdjI/EHggF3hg2t1KFcUcx/rvgziUmj
 5FmnWEZJu5GO9fiR49w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240104

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without it, the interconnect framework cannot vote for
the bandwidth required by QSPI DMA data transfers.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 6079e67ea829..9a44bb3811a7 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -4312,9 +4312,10 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC 0
-					&cnoc2 SLAVE_QSPI_0 0>;
-			interconnect-names = "qspi-config";
+			interconnects = <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QSPI_0 0>,
+					<&aggre1_noc MASTER_QSPI_0 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "qspi-config",
+					     "qspi-memory";
 			power-domains = <&rpmhpd SC7280_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";

-- 
2.34.1

