Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A73B2BA
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186542; cv=none; b=I+QyqRuFZTyfsqjGHkjRhRK4vZt3I3vvNOx+zt70Hu2rDUhEQ1DSWDhhDMbgy9O/QH6uN0ZxWAFzwcjQ1NTFQyhn8sJxSwKb6Sh+ewEK0i+GYRMEUCrKJ8Wd7RyUkGMUHND+Uc/xJJYenToakez9A1ey/EyVDw3HpYIQ3hDUTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186542; c=relaxed/simple;
	bh=yjWF3977KeB9UwLgArSZ0PNz6JLgNJ9i5nBCtXTUO6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MgeY5W+FEzMB4KsDpCBbS156Gex8CNfm5VHFR5BrQII20aejM3L6grR1rqVvjhZKNdIJv3E0ET7ABi0wxaz0wWKiXB1K364kdAczyALUJgb+s5q3Br4sjK7CGoSsDG+KqcNfdQdp2uI18AtR5u2Okw4tKGKRhSBTDVMOuUdsZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqQoaaOP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Plaf8Xo9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqQoaaOP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Plaf8Xo9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBwtRi395269
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptbWTUhwItH4k1Q9IlbO0pxaLn/vNObDRW/fdQqP5RA=; b=jqQoaaOPTTuNYWI/
	O9EvWVfASPxlfPRd9RvSsUs7cBVwUFeUoihy09cxe0Cgg/TLFDMe+6upwNw2aW1F
	4yfb56lwAT5ojWdPHRY3+1eCVJKrzr98Lk64vzzPJVLHzdqAW8oA3esub8o+nND+
	8i/2Y3QCN2bhws6Vl0Wgzy3kT0idTExXDQ652bF57Joz5BpkT3KAN8IhaFBj0OoX
	PaZb34Wc5X8UEjRZTn7HRntheiiKsUhkoepTUmfaYxAymFfAvoFYDN1aBTDZYElm
	lNJD9aRut5DUCBWnhrFlYJwtbupgKy1AiG0l6PqbqNDnfrixqOrua1Ulw3Y19Z+s
	eQBVYw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870uqs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:08:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so44328575ad.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776186539; x=1776791339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptbWTUhwItH4k1Q9IlbO0pxaLn/vNObDRW/fdQqP5RA=;
        b=Plaf8Xo95bn7ms1hM2BGCcUoGsa6fwhkOZBT6lmHA916O2pmc8g7K/QmoPT/H1ap+z
         ZEYEuGD2kRDTzROjmiQNqfHofssPs7ZfJLwWwAlgcR6KXNZGLmGkekj3L963Hk5zg8UP
         vymCYxtN54IvfXoSu9VIi9VZq70Tb4xLdo2tzvpShdgSOJAdePKIZBF6s8Lpk9Kxhil+
         24X1b/gqjqcHOGMjf96R8RmCPT+/BEaszeF4yPIQmohK0luBUIRmEjwMDvnqu30JKuyW
         189Rwb6WY157kY/bB3YGpWNAtgSDIpIFWVb6cNIzgR4AkHeYkXaUHU+IdISi58G6KxTp
         jZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186539; x=1776791339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ptbWTUhwItH4k1Q9IlbO0pxaLn/vNObDRW/fdQqP5RA=;
        b=g89/IUk9BrX8lIeFB8PRFen47oOxCD4mLB9HzruweaaV4+E22xylH9nI/5uLjYctrN
         nqD/OC161P3BHgdUPI/5lsMt79mluWgU6+eQrH2jL4ScFjg6hdLMd+eNToLluHlFRZKT
         zpSc9eCIlazrIp/H7ZW94RtCO2sWD16S7sKKeeKWGvg8Kr1FgPfWa+fipx3tiFMpD3Tg
         75+70HeV2xyHntPVjQMbc0q/37P3M5patlIOs47GCBiXW7DTDKkA1fR1DH/3EvUau/ca
         48tXNBWCS5myqSrikS5yzgLuoSVmF5CYFiZ/UFne4dgLe+cJ+Z0d2BVvXA0tyd6FIraL
         mtMA==
X-Forwarded-Encrypted: i=1; AFNElJ8lupRkDboH6Ij907kZC7YtH5hmBazt8FgrwCFi5T6XouOdr4p35uj4QXmdipbP3dZbgQ/of0Q5Ezk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJzOoEsZng7mfZCIte8bO6RJRVi9IYlZAs7PCtX/T6MQ5HSIQ
	UgzoBVvL4aWiC51hbN7jKPhugi3x2bqM6zAMrEyGOlePGXZILU864Ns8f5GO07gTUnJWwPaRzOH
	E3MpvyxM0EyJus7KWfC3S5FTexbf0vQl9UBldmyXEJpYKLrA0IbV4Vkrcv3RMNoc=
X-Gm-Gg: AeBDiesZWkJbW9eRqK5YPZD/ILQOr4wnhBqV8yJSaQ48hAVeQWqST2buxH3+Ce+O/C5
	UiQvCkBDHqr0KusigMt/yJWwud2x5sHSpS6INJEk1B9hIM0EzuyLPeQUK5zOjYGE2NHZennAVqR
	09wKHm8DyQ/KY1H09N1JwzjJWDMdG5jOX5gPyPRRV4MhppK3ReZqdmQGA68LUBVjG+RYhmhEsJy
	YsLcelU6XG/gkOepiAiwDXsYHDywzBFzVjXAgO0x5HzOhzvXoCHCHpXCNXQ85xN3LtjgmapZgO+
	0Ba9acCZPAIXP/7nRu84wmMmnlRfRN7aN2ZjE3p54y+MdUKO5HAvQryZILEBJbzsirJrsmqYeiX
	rk2cR/DwyQtixo3ZsP95rQy8PziD/TuA6OQJ/NN8CUURxVr9tv9w9FnYNHKnmLUuhQ90C
X-Received: by 2002:a17:903:22c3:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b2d5a6e6f2mr176877775ad.37.1776186539015;
        Tue, 14 Apr 2026 10:08:59 -0700 (PDT)
X-Received: by 2002:a17:903:22c3:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b2d5a6e6f2mr176877345ad.37.1776186538419;
        Tue, 14 Apr 2026 10:08:58 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm97535225ad.40.2026.04.14.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:08:57 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 22:38:23 +0530
Subject: [PATCH v2 5/7] arm64: dts: qcom: qcs615-ride: enable QSPI and NOR
 flash
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-spi-nor-v2-5-bcca40de4b5f@oss.qualcomm.com>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776186510; l=986;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=yjWF3977KeB9UwLgArSZ0PNz6JLgNJ9i5nBCtXTUO6s=;
 b=cQjhB80hDdufSNv/al+IZfmvwhJSjmL/Ee+XgRVB/frebQveTWhIohKw9dUX8L+BhUUiInCfv
 zuhsmSqOLaoAtcAeGVHlkV/0IyJWc8C3cvs8jc/CrRtuYco9YI3USG2
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 3IsSS-JPMqdoH3GUobQlT0mF2_FbAX70
X-Proofpoint-GUID: 3IsSS-JPMqdoH3GUobQlT0mF2_FbAX70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MCBTYWx0ZWRfX//CQ5qgVO7uI
 lg9k4oRqUytZ3Szs06CEKaYthuVF+yriIEUzIeb7zAOPK8xC9RRjSZEZvoFV1qXD8QSARLwhENf
 VML+ypnuxMD+ky4nz1Y+MgIE4Hcho3l0JcApY2gDCf4K08gmEUDXt05vN2AwS2Dso88dLBGugkg
 Vya6AEgGn1H1CrtDSvYpLFkkrkIqqYQ3MRMQFQmRbjbq02yqbCcRTkGtXyzO5WoMwymPVKZQ2YI
 jS8YJ+C1q7x0pA36dJr5HeiHFdn5oY5Y3Q91VPYxJPXHoCbI9GXN/C7gnhbJEUyip+Fx2YDv+M/
 /XYTx3ChMN1sGhe1YTcFJyBsRV9s7cPzmHalk8xklvQKfVePBze7MMrWjGl0PXYpDrCmU6zWRMD
 j0pL1RUlXsBbhp7NnVntrrIDaBq3/YSUElwdQBdHWyUsZZ69J04cRS42kM+7op3h5i6rTHGaX5Y
 5k8uFFhSPtPeR7w7ZPQ==
X-Authority-Analysis: v=2.4 cv=MK9QXsZl c=1 sm=1 tr=0 ts=69de74ac cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=YmYAkDX_6c-Kr4-_JJQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140160

The QCS615 Ride board has a SPI-NOR flash connected to the QSPI controller
on CS0. Enable the QSPI controller and add the corresponding SPI-NOR flash
node to allow the system to access it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

