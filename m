Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAEA38AC6C
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436599; cv=none; b=Vd2449Y4b7FclQSMFf6ywpjJp2KourGqaPZNCAwBThwKlMVNW8kAe7O0CTQ3f0jvtx161PcZL2nnl/7ix9hQZv2Qs8dcIhBd2Y54J6wgDpxN3JiclmvSluouaaBjqzeVwM2P7O54WLDoqnjY+zAnUHv147V9FL/HZu3a547UqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436599; c=relaxed/simple;
	bh=nX6Y82zzESPqhrrlbQlA1NTD5phO4pdq0SzAisS/ebs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHytZ37c1KVJtdmWZW2Q3tTSVp5spqr2vQjQD2t3/qSp+4cGSTPG2jvn7NHClwbSwBOh2s+LxvvTokqaufWouvTvyCjmp793GM6YvuURHrAYNB+iBRMesyM9umyxWfWd1YPo6gxNPpdPAZMavwzKDGMIwp8qG4lBfnQMXgheT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mG9ZZBc8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZdn5RKc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mG9ZZBc8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZdn5RKc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2gOcm3183637
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1CecqJt+jxHeudMX3AkxTxuPao/HPi6jAXtF14dccZk=; b=mG9ZZBc8xaFTSHs7
	uawGVVKVALJm6deWKW8asQULguFmOXa8eaBqy5bR8jifRu3O+beedz7Rn2I1XGn/
	xprUWOj79TEE1RbJpGQgklPmNCuSCh0AkRuLpOGoaMaK7bavZp9WlPef+k9FR4tX
	CBMBHk+7HmfM+NDyAa3sZJKUCakmnCdGu6nck1/0ZmvJyUFSaRRIkE9m44M0AUrb
	Haq1i2DWQIJwrMZPTgZKDlnL7sS2Xm48QrUPC/8uUVF/zzOBCWu81eVa4M8xEsuU
	ioQhiw6Z70+zBew0ghEwMWFTIjNbzTL36zXthN5WtTwO+TYBa4Ok+xdl+ZA8HI/W
	BBMrSQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du9em08rk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:23:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso5881176b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 21:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777436596; x=1778041396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CecqJt+jxHeudMX3AkxTxuPao/HPi6jAXtF14dccZk=;
        b=ZZdn5RKciV/MBmFsGaM5O1OhRAiIthe8U9vETa2bkyyP1usaeJjhjAnOWB71YPm4t6
         IIQwJVe9diBNyfyaGOfBLJTn/aSXcr8J+Ea8bjAAg06VyyJuP7g+z/gLG4V4c9OGK7+2
         Y71VRweq0uwGLPHMlNf9zzoGUYV1i8dJdjxzEp8MXwNYA2RL6FpnbWTh05rWaHtXcFG9
         1NTHZy2BlGAOqsNEw+xCTftz6BdE2mGtm9CYpY0YrnMVDrxjCDIS3CEIFNYawcSWjKY0
         CXGNZM2o5FxZUxK6QCHFBG4VI0lcXuE/NQnyD419PUzdJZSw/z68FbYpAzF3hgNkJOCG
         DpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436596; x=1778041396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1CecqJt+jxHeudMX3AkxTxuPao/HPi6jAXtF14dccZk=;
        b=AOOsuUN09qqbdDR/rLEXk7aEy8H+PU5PzR+1iOuuDio/yBDniTC3zQ7i0AE7/0jBzS
         eO7oZV6fyUvBsIvdLXn2D4FbNyjO2FX+69QVPUSiC52xIvpuSpCz0ciLAGm2ZUALYrxf
         Xso3T9JZx1mnXtGfrRNXMIdyDlUSNuJfrn3lgEQhtGX9TocjcbQgKu444RiUx+awb1/h
         /3xf1ZyUgpAHsF9oSi3foJ0J2rm07gDplB36W/c1+2BUVX/T2PpAoa8p+uuYHSZY6ZkV
         Ep0tWWQ9vcv8qrh8oC9Mj4cQ5ayP9tOToqucZe1S68yHfxRjw2pjNdwavlJN7dc/AudL
         ZtWg==
X-Forwarded-Encrypted: i=1; AFNElJ+eIMBom2xBy6Wp5eIZAScefdubBzQUVvHWAxABChCgPq65FvLDlQlLGP0ygTOOULI1vB+fpFVxxiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDdvyHYYVAy/J6HTlxZbBF1LHKFTYysfco4PLh/PYZM/n3cSZ
	g7KIE8RSgmJYB+p6ahEzrTTlbZDr33wdZ5qO2symV9TqTPtPPugsVLGfWuzkiVC0yyNN9YZErJL
	ukMVG4hJn+9h5B/TRgpJWTPEwKx+8r+h8j58XDWoaE+HVzQYr5uCz77WsF8oOicwa07vwJz0=
X-Gm-Gg: AeBDiet9tQHKh78KLMaf4o01pR2Ysid1oRLMfKPQ4TOuQMrFQLwu0CW8xg8+efmbkmu
	FjeIcXPC0pi1xY8zTA7chWKAcIvcmJHMDBsfvRizUNr4B78OhnlgW1kMpu0i7DhUOeDcDXnNC3k
	DWRza1JsoiVhADtX9vHyYq2feSLBLFCRXXROSdBu8NTmEIQlqmvubPxJyq3BaKL74xsCruP7s7K
	IHuyx+D/v7NbmV5We+iLoN+ndKI0RF0VTaXWH9YaxR96LD2M3anH6crAdU+Ty3H+rgNrExRa8tp
	pEtAwETeYZBvZgen/+b4O7eKgc7K05pB/3NSz3BLG1pFbGNsV1sNf9o5hlHL86QLQriOwT9Rdxe
	KMu4iZVPjx3K708sVMmvWWaAqw4L0O4+hfYnkWopgAxZsG2YXkAS0Jpko3ok0RDFvSG+g
X-Received: by 2002:aa7:9067:0:b0:834:e605:9927 with SMTP id d2e1a72fcca58-834ea6aa9admr2086416b3a.37.1777436596166;
        Tue, 28 Apr 2026 21:23:16 -0700 (PDT)
X-Received: by 2002:aa7:9067:0:b0:834:e605:9927 with SMTP id d2e1a72fcca58-834ea6aa9admr2086384b3a.37.1777436595701;
        Tue, 28 Apr 2026 21:23:15 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5a074dsm602200b3a.10.2026.04.28.21.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 21:23:15 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 09:52:44 +0530
Subject: [PATCH v4 5/7] arm64: dts: qcom: qcs615-ride: Enable QSPI and NOR
 flash
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v4-5-73fb1bab03ba@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777436569; l=1047;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=nX6Y82zzESPqhrrlbQlA1NTD5phO4pdq0SzAisS/ebs=;
 b=sMA7BYB4QynpISQO1sIELdtNYOj1B2oWgMiu3tyMjknXBVXDD307DrcwT1gomEYEp+v53qQ3n
 FK+Z0GLJm89CxMWZdqemUJd2ZqpmzM1doKzUTGdCqpzwRwrDTPOUg3l
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=bvd8wkai c=1 sm=1 tr=0 ts=69f187b5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=eijpJye3pRbVNivL--0A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Y8lBtlGxHu5YLteXcG6lrFZkmILE0Ojt
X-Proofpoint-GUID: Y8lBtlGxHu5YLteXcG6lrFZkmILE0Ojt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAzOCBTYWx0ZWRfXyrPJK5GCS1eJ
 i8k3DG24Ndzz/7XvMLQj0OgHfFk6uLW39r85xX2bYztDIM+h1Sg9Q1wWoDrR13MnrZy4peQQNea
 VZjRaG7Cih2u8KQtrvudlk3hZtSf4C8hs334lpJwPvAM9LNfHG109H6yz6Q23oYPJm6hndkdyyX
 QZ6jPx9Uh3RM62TkCCf3iMVCDxgt4oogcF/87FbWoWwf+Gl5vrJI5enwjrC7jlmPWk9iyORAMcg
 M9zdrZ5XAgwUXXXIbnClRaOTBjwcEZVcaQ4x3R1L1bLJUUlenYCg++gsaIuosWMYml4em3uFDuf
 oNVOkqryYKr6xOeGIgcqG61SAWkRxlgpn+pTKTuLLrtBB192u0FxX6hSrCFxdrFUjZYku94ZA99
 yse0nrpNTJ1kxdHhtgVW3hisZ1fgg7CrszZ9Pj+AhqGcCbJjlxT7W17Sgs3KKrixUWZwV/3R+93
 xrO1lU+AjPljOzDuPWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290038

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

