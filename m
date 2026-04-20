Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FFE38236A
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665622; cv=none; b=PGAAHcLQHZSIS0HBTb54AcICdmkSwhjYRfi/VwOjCQCte2/6ixpHpFzK+hoaYvaF6fvj5uLBnVv/ssZht4HzpS9gq8IcugEBdww72ou+1VztTKD2w7D71EcthET/qcZl53R8Klh+iPoRBPrzofgLk9A4yxBddaYDxwtvnDXjy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665622; c=relaxed/simple;
	bh=Wf4eoT8CejtfLR/935yK88aKHtjDjhsg711zXr8huUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYfpzN/CgHuzeyA1nGOaXimx0tGEONwiXd6ee+Emwdk7XyWEFa0AIrMDmbPW5YbsfSn7dWqs7B+Va4VB7HHm1ltyVN0IXOs6MX7HNi1x8lgBxCuu1pOr7Uk+2vwf2q2FyN+KFpdEsGzCXuYQ9rVXsrX9kbjlUyNxVQph22h6Ll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKvV8oFO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmsclRMJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKvV8oFO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QmsclRMJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JNUQaa601266
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7AnPSWOf86A1fqAksVkU/F+AvJQfOIsEXvB48sq4Z1g=; b=CKvV8oFOaUMQpb2m
	6LvMiwH4uW+iQBa3docolhqZzl111edN1sx2vV1TTSFTs81EC1kstlwifCExbtJI
	HLcYH8EzlkIBBZEcEXqHcI2onJmeJv/ZQxmPgtStU0F31B16Ls+mlaTp1BXQB4Sz
	EryP4xj52BLzjVPDIWijoHJYhAYZ5Fwxjj7+BLZUS5GBnGD0/3exonmIQ0jkb2B3
	AtVkes16yhTxROWB9fgBhTLajvDr3ADKwq2RSB/nUE7pkEWWuhaMas0QBlMualHl
	RsEiPb3zKCsjOHISHUax8PJd8wV+TQ07+qRXcc9MnG/XiAX3/hcD4tVNkYbQz5jz
	pTxmVg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm261vaxd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:13:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c797e31a9b7so2095877a12.1
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776665619; x=1777270419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AnPSWOf86A1fqAksVkU/F+AvJQfOIsEXvB48sq4Z1g=;
        b=QmsclRMJPYsWHpPedFERINs60oINS6pmJSeRpIOs4CorKh9qQzgE25BsyPJM5Skuko
         D89MtHkCiYF1UMXt4hBWTY3CWhTY22M6ewVF0vu+j7fF4ohYUfItkD0h9GhSxEC+brf1
         B2cmIFacZHbGKQWMR/8vjrT5z57PMJllj5V8wx/ICrrOgLK5xnztJX2qUST4FoXBIUjL
         f19Etjnu9jPOr/j6lEoAY/htYRELLr0/TgvhlcIhG7sPuJG3ufyUOfy3wIyYNLfKovJj
         UkCy0lDcnAiSRLeLXgzJ05d78R/zSJvTs76xwb8QRvZFElGdXLmGErtxinAL2Tko/tOK
         RoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665619; x=1777270419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7AnPSWOf86A1fqAksVkU/F+AvJQfOIsEXvB48sq4Z1g=;
        b=m0kN7KQNXdWPacikfo7/isnAnTzbtS9nJabpElaBU4wWe4/I4yfXNM3TT0Z5hRvzeT
         mzs9fWeEZFvc+J6TscrTpF0uCZDEFdDazjaL1jlGiUIoXfXVTWUlPkrBsL6cEjbavO/Y
         nKbK/MHEBieYT1eC0iiszdDxUPSIw7On29HQeshjU7zPLFD0OLPpecqiBsSjglGJPgmu
         Sm6+FwVegsUU7AqVrxWrGpDvsTwT+/SCQHMCwKBQGa5bhyooY1yj/z6PmF7P1kTr3wKF
         /fSRQknJ66JIK59SsLlNDICCa78EP8z7VaM5oKNnM/0uXbQNUpmX/2mfoqYLOIdKoZVZ
         lBpw==
X-Forwarded-Encrypted: i=1; AFNElJ/7p8US8frxzFYpTjSwvA9uCOXbalztBDbFl+qi7tQuDS4B7ATCyVYtzvwI5tEiOgrQmyTyp9r7x8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZeOe35BQMOwLn3J/rWrkFG3TjJw6ivzeOrh6mltPoGPZ5AoJ
	Q5R6F8hwjt1Zs3NNkaNmFOOlDiI93fBmllIF+AYJjHFyG+8OpTvXHN8lfK+A+g5ivL8Iz/00Ofv
	o8jUciwimP+YCmD1oK0pbC9CC9mrvrUruAN2FnuYSeJaVKWudEl0xqoA/qxBRbbyDE/SaVp0=
X-Gm-Gg: AeBDietu2eX9KApWdtUBDgG1jh53aFA2ZxZzzDQwLXABYX/g0HRszRCMAanutC+70v9
	JOHpwgyj1SLUyE9TBKKuXCN6cU/JyPxtciViXNEt/f72ZVz6+xjFUGj1RRezy+vWAUpXEDeyNLY
	EBkQW5Tt7FMwijNYdxOwlqFS1/wNiRQ8aDHmRCkz3A8SoxtKXZvPC9MWQQ3zTSw3fFineabJ4dT
	gZ/OJ1S13RqSt4DtJR9HGkOcbqABjfeCovnCSUx28bqXEz8Bk3QblIBcbdoVzQj3uHKwgKGr2sQ
	uHnvqGEk37Bzbz11PONKsaZ88LumL0xS+R4QcHTl3+iavF0V32LBjfXlGlWzdk9wBIoyhxXuD3H
	wZ406WIhjp2T3tVbuJIhRgT4hPFGkVvpPViow4pTZcpddWe4ZDC1vukHjMvyo9YttVGFv
X-Received: by 2002:a05:6a00:929b:b0:82c:7335:4f71 with SMTP id d2e1a72fcca58-82f8c8e8d78mr13418542b3a.36.1776665618756;
        Sun, 19 Apr 2026 23:13:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:929b:b0:82c:7335:4f71 with SMTP id d2e1a72fcca58-82f8c8e8d78mr13418511b3a.36.1776665618298;
        Sun, 19 Apr 2026 23:13:38 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb28sm9018034b3a.13.2026.04.19.23.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:13:37 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:42:54 +0530
Subject: [PATCH v3 7/7] arm64: dts: qcom: sc7180: Add QSPI memory
 interconnect path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-spi-nor-v3-7-7de325a29010@oss.qualcomm.com>
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
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776665582; l=1341;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=Wf4eoT8CejtfLR/935yK88aKHtjDjhsg711zXr8huUg=;
 b=SAwSWLIeWNAXNjiXxnGpHx/1U/G5POQn5aYBtIoSaWPAkRUZJpewt86/zz0dcgsYSEIsvnArT
 mjTXs4YLXRQC6mkKWAt2iv7+xdV0CWNwg7fNHWJROY+sxs7y+XZnKwO
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA1OCBTYWx0ZWRfXxwWcnCDkWQ+l
 9bGDt0KG+n4MA5Od82Ycrt/cCV2RYHZ4/QeBA/EHkL3HYde2MnALcLN2IOsPA3nAhsoM7uVWXOM
 8JZvXmLxkHjzaMkMHLNI6p+RI6uAM5W7aK994rVMm2tz+ktbDHLKyAPyTC4AurnmQIpHm55rveI
 pNE52N7TkfljPoKxKJHYHcK6MhDdh1TgNhS0yVxHkmJgkn1eDXiF/HHlxQbfKasD280VA4kjjlZ
 yVH+MkTmgHfcAOjHvK7eRIzp36VzYxOekkJHHQDmlmLFEvwXgydzw+ys9Y705KWY+XqAU3GKBG6
 gx55Qw5kmm3pvVDII1YKb4jiA0mpE8XHVmc/JC1dFLYtQzUDp9AyxoM7ZnZ8Lu99chrioAAhN11
 Iu3hveYiWTeUoaZ+WByFDEkSbxhyQpW7w2x2Nke991C5XIB8loyy7Z0IbDP7PvQFqCvWDdjt4jW
 S/Yeg59sYQwvOjSOuLQ==
X-Authority-Analysis: v=2.4 cv=dcywG3Xe c=1 sm=1 tr=0 ts=69e5c413 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=va74t0jcI0ebB8ul8YAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: OrpYvQbY7GIlxCN0SNWhJjRA6XJTbtKk
X-Proofpoint-GUID: OrpYvQbY7GIlxCN0SNWhJjRA6XJTbtKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200058

Add the missing QSPI-to-memory interconnect path alongside the existing
configuration path. Without this path, the interconnect framework cannot
correctly vote for the bandwidth required by QSPI DMA data transfers.

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

