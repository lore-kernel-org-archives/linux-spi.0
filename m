Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517713;
	b=D78z3MvGBvHHezJO+pJVLfZrn3Y7jLq6PXT2g/ecx2Fa7NU0/4Exnkv3AyDBoDX7BAiB
	 jkqLY+ar8knNy8V6yArF86k1H95/fRsN4qJwiBA7wz7un3q46KFjN9ExT7N5paZ6I6/6o
	 +RS7ddYmtj/CMuClY8f0TGTqGqxMDzuyrSs6WBw/pJBsNpjiBQni83qGv0OcNl38+7y+K
	 2jiBxFurpDNcaC2n78qntnEF7V1/lIs9ygO5twkamw8qZucMU04CXDDYRjs1Ip7Vq5v+G
	 ZilTqgF6r5kk/1PKmk9diofbRmOkKgFCczLgktcF7IqwMDGC9bBNR2Qz1h5EUPdX42w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517713;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=x4JvzfQWnfY63emsL/cHPtwzBAs/PLs9EIzNEkVR5A0=;
	b=0RFp1nr+PA+yc1qHtycjV33vT+neRcY4a4NTTpHIKXTCW5/JW3vGx5cV9V96Mi2KEVtF
	 21nRkfxOEnVYMB+ZW4fFHTg4Fqfc9BBrUxc/em+BViT9szbb2ApdW5EVbEHp8gifIwMsK
	 nZd4ZWSdWST+hhnnIblQAk3vSRL8Ou3FHSON7q5jwvszlun1MHowLusmm6NBuHaOUsFpS
	 i9kQlWMawM0otZzaLR8VKXf6t8pMuoQgk4tCyke911emJ3con0Jqksy4YCcoy8jlK8iiK
	 bmExVuGeNiXGeHXJD9XjPmR/LyIfsj0ScvwNjQ2JfSo8M56/0clJH0MyOpN9p7Xcmyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DdjEfdUL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YBYTndrI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FE606A333
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 10:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965FE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DdjEfdUL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YBYTndrI
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8Z5lf3850977
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 10:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=x4JvzfQWnfY63emsL/cHPtwzBAs/PLs9EIz
	NEkVR5A0=; b=DdjEfdUL3QdRaml9UextpTbMDaGlSn2LGb+Ovmgk3q08ZLfZ6ki
	ZeXLani3YjCNTNQpstjrWEKquHYu7QMQwIflQY3W4sMOrUv88JJMgh6awnsENntK
	2OTpD7b45Yr2RSVymTy3TToR5oUAflabDbjQMzwIuQiA9vJaL470vZa8xEDvoBZd
	0BEZLyLtOd9V8qzMXHXOg6VZZnY3umf+4EonHphe975C0CvvneIvIRCZctln9u0a
	cbp6AUEuLIL3kA2ibTmYV6cu7//eb7B2Wy02b5at+hJQ/c5z/N/x7uejLwuQakYs
	I7WIVi9uZ4zURUcOufjiyCr0JeJr3IposAA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb2b5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 10:55:11 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so4282186c88.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 02:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795517710; x=1796122510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4JvzfQWnfY63emsL/cHPtwzBAs/PLs9EIzNEkVR5A0=;
        b=YBYTndrI00vbsUOllGH8s2MyYWC7c46fvyyzgJQu7wJsWoGRtyY3opA2kUmbcHVR5e
         E9lAoXPkBrtS2C7QTi6OUq8enYxL6cc6VsGWm17VE1zj3mEk1cuLdK1CyofEzAuY1c5E
         tf/Dr2kabc1hpkHS0g8fFSPZvDCshUfTW8d3UAvkftGfD1EaQjzaNc/UU3dDwhiKOGAz
         myOa3VAkcEuP7AanIGDE00F3tfSEsTfJ5wn9ifSY70O60PdVjwXPbi9LzKMlZXhi5r3x
         u0svxOzr3QkUUSfhodFS1WwCvH0ZsM/J7MINTUkrDQNNMVptT2qtlJFjhGsxvFEg7waZ
         G+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517710; x=1796122510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4JvzfQWnfY63emsL/cHPtwzBAs/PLs9EIzNEkVR5A0=;
        b=F0TD/Uo0okWfH1CiNEgHqO7q/ATyAF5iGWxUrutIPq8HAD55BP+nG3H5gyZXpzq+w8
         HIJZIvHmNWGHrAsfl3u49TxeAi0+E4s0YsHQEYqe9yuI68qiTzo3P7knEnpzN3UICDdJ
         V8xEZPj/y1ulE+gTIhtGfzLU1K1mOb8T2JgVKCxzccTWWPnxiiliPLMDAxxTMFqA0UmD
         rEaJC1ZBG/dFVQdPMkA1HKZb+sCMHWNW0RM+Ny/kBN7v/Cz9ZIJ2B/jH2DBakWP6IShH
         gNIqUNbvtCAyU2ARmESZW4Yofoy753xEhkLVLVSy9P/FJuI/OYeRsUUGa+75h+p2RFnh
         bfFQ==
X-Forwarded-Encrypted: i=1; AL+hErFCpAZf1Sipx6I0g6Dt7D2WTkENWq0EtrpOukmn6ySu/CwKJ05/FuYcfb5wSsOnAztvluvAAsb1rDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cp766zef0sRHEz2mJxLumv9Hma6vI0XU658bbrxaw16Zi/rpV
	q5y7OV94sT/DsWXnKOkWyD0W084i55G9WwuReuJL/Bi/rndk86X0TaZ9FRuI128nEcYy3IHUhHZ
	btglpp0kl17YlyLieBomHf9MPq2ST6oTftSgVzTUFQf4uPTeOQlsrgJ0i5rkTd0nBBQDeHgA=
X-Gm-Gg: AZFdTZcScxFGRVfa7I/Lbkf9l+Dwooj6ed7beYSiqygb3cx8DLOVkSy0UKioF7ndUfG
	0RT/atr+UeigC5qPvB0Zn/nil83wdLaT9n6sNaw4X7wsOY49aZziFH/3ddH/Y/K5D5VSGRkhriB
	ZSVxAy/52lD95ur3GlHUZm4agHdirfpnW0VEGNGIY/zp8RozSIY4kAzEgIbCaBgJx48y1DJdt+3
	O0UgJB0q+ZxxFQyb1jgmrEASa1fOAiQBZ+hkRBfzrQwHMf7EHoyiUd44Mfh/jBL+uUg8WUNy/+b
	mvrgpMR8frUuFJCkkE2Cc6nSpnnDpio0/Gl9Rv93/txvg3pjAt+6JmRJjNeaNmw9HUdFL12O+VJ
	FGwFOhivG0nMA/IqNDiRDgu0VVPcW+YB7CR1iyNA+ZPJeWgWG53egHQyWD46eJb0InHc1GoX9bw
	sJolDI7p/qKHoOPqAVOEKqVQGtitABpRwBIfC4r4SINVB2MnCS3Ps7aJvC
X-Received: by 2002:a05:701b:204f:10b0:1b3:a05f:892d with SMTP id a92af1059eb24-1b556903388mr14536968c88.40.1795517710379;
        Tue, 24 Nov 2026 02:55:10 -0800 (PST)
X-Received: by 2002:a05:701b:204f:10b0:1b3:a05f:892d with SMTP id a92af1059eb24-1b556903388mr14536943c88.40.1795517709757;
        Tue, 24 Nov 2026 02:55:09 -0800 (PST)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm38075275c88.6.2026.11.24.02.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:55:09 -0800 (PST)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: Add compatible for Qualcomm Seca SoC
Date: Tue, 24 Nov 2026 16:25:03 +0530
Message-ID: <358f1284a656582ef0ea0e2b7bc07224372f9fdf.1795517702.git.yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b056d0f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lHObh2IfMKzVuqTG74EA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 991cePnQNy51bgkU4hhoWjKpuSBCFKKK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX7Axg72k3+ziz
 /D5knjPvQgNN/3ERKunGajov9xref4D3tAHBc9Go+5NPLzPlv3e1IsycJJYpq0DCm+oKuiglYdo
 D7xAfijvDSgobCXHkWrRhqzvnBBvLaU=
X-Proofpoint-GUID: 991cePnQNy51bgkU4hhoWjKpuSBCFKKK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX2QvSrIU075ct
 0Cj/R04U1zV4+nLsZO7otnOe8HgUdcamBcvvQiNDOrFSkJ8WD/HR2/Mv0/33QlHtSy2ucx+w/Uv
 LI5jMIFHR5sWlT6EUs1LVus5bHytUf/VujfpWA4qLZ2n4JxRk8oigdCpZ4+mnn5N1Ss2zbPZ8u3
 l3QUFIaObm7AR3TKcO+xyusWytlTvMJ2ALGk9TxnRDLJYeTU0eOhNzHOBBXwoUCovi45mG1Owi9
 zCUYM8CF6gQBehAq58lEzDPmZWXRBBRWTRqhUFERkeu0dYo65Shj0P1pjuaoSjP9DETF8Ezk9Ya
 TAUWQAoYGtHfv8C8XbZ5Zo5KhC9Qa+U23CifVvDEuTIQoCapMcCmI9u1jvaoCH51Odg6bGa0jaF
 y9a6SS2LSjpkjDdEtRTcU2oMN3j43rl4r3OrLmemKa9rs54tgPWwO50nzxJljTFtzlQVpQ32Hi9
 GCkJUbjFrqw05QR4I7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240042

Document QUP GENI SPI controller on Qualcomm Seca SoC which is
compatible with the SA8255P controller.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
The Seca SoC device tree using this compatible will be posted as a
separate series.

This series was prepared with help from an AI coding assistant
(Claude). It assisted with review on the device tree, bindings and
driver (formatting and alignment fixes), rewording commit messages,
and running the validation steps (checkpatch, dt_binding_check,
dtbs_check and W=1 builds). All changes were reviewed and tested on the
Seca Ride board.
---
 .../devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
index 33eddb395a0a..7eb8b02253f1 100644
--- a/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
@@ -16,6 +16,9 @@ properties:
       - items:
           - const: qcom,sa8797p-geni-spi
           - const: qcom,sa8255p-geni-spi
+      - items:
+          - const: qcom,secaau-geni-spi
+          - const: qcom,sa8255p-geni-spi
 
   reg:
     maxItems: 1

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.43.0

