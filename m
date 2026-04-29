Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1821413259
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482132; cv=none; b=pHVO091hVyjAY2l+aJY2HlQncSiynKqyMPM33yQIKtHKR2ZK1+rmjn0i8vtyYKPtJP2SFnCmGp8y8C+iFRG+e4FWtkFPBOD5lTecOpzp3mXZ8sbclMUr9LngJwu3uqfybJ96wbEZFakElp/fVYzcujQQaqPl2TeBUt2e23gRRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482132; c=relaxed/simple;
	bh=zM5H7x1nhNKHbvHQlqVkDFr5Jseh8BFRxY3VO73Fg8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSc+0KQNBAUFbR6jnTkDf9QzNU9enTc8Zeaf+PTxtpgfmyE9lS5xIw9hcXz1ty+f7hoNNnkQsWTe26kYutXvGl2uJNAGSP3oruu/VaLCg6NGJUapA8c/QS859JMOwORP5feLvJTRx0VWv96dFYRvLjeBipO5heO0t96P77T5u2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KqJy3wrq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HncX/jsd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KqJy3wrq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HncX/jsd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFPw4I2094252
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SuAkd5HB8v47fIX0UR5Y9goEpziAitcg3uHmsmwCTGQ=; b=KqJy3wrqZF/HOZ7f
	73IJBc9LVDIJ+Fv5dvzCufNNIgYBEvqQmxd/V/Iorb57uDQTJ8HcH4ryk9Lk9Er5
	R5RHfMEvBxBAeGV/vA0iegLtMLd0UbDLeC9MWXFAIvUw6vpLJ1QDvyJ24+u/zyx7
	5ZsuJTspFRSfIAeTKw/zRhGWrI5GuKnFw/49Ta9DlEx+lWdESiq6OwHUDjxnZIBG
	jy9SQT65eCIDA79fVXSczTeO2v0ERA+xcsloQRFIA1TIWk8mXGN6mze/m5F3Dz2Q
	zCm/u0JFnj+THncH43/1CSRa5PfT0j6Vkl5NCMEaFDfTd583Gbynfkr6ott8qZr0
	qNUakQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3tdfm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:02:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b465bf993cso155665ad.1
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777482128; x=1778086928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuAkd5HB8v47fIX0UR5Y9goEpziAitcg3uHmsmwCTGQ=;
        b=HncX/jsd0+OWXszSvgssUZ8KzPdQxOClLKQr+IROgNjBrIb0dD6gFHtWoldktSyvef
         UQcn9n/j0TSLNAiiM6hE17n/rcPVngin3B4oZyzTPbV+kWIW54j5hpz16OvWKFLHYidm
         GZBMg34Sr6tAlSHUowPCelIGaCtnMAdffGGFOScIxZyFqtqJU1/CneXtfFfr4HLR5ET1
         Vh67/2iKqys0T4iYWZ3f3HAerDyrgci5+EzMVAiZqn7iNsXw3HlXwoHoOgqthVTTnVYB
         iAlwLBmbSO1BC9lyO2gRsV2kMWtmHonCrMkdUFCzFzN9kDYbk1P8TRqoj+9HGNUyeDq/
         GxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482128; x=1778086928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuAkd5HB8v47fIX0UR5Y9goEpziAitcg3uHmsmwCTGQ=;
        b=pLAPkqymEZLjxtxPXhIQKZnY5FjsOpApC7SQ/syeZk5NkSL0zpZsKpLrtk5iee453X
         X11BXfgczpa1pbJdBb6XreFLxlP2qos9xMGWfivz4UUd7S9e2DRjrspsKVRg1dT8Zye1
         Izd14LJ+V7c7vKPVBW3C7bMT2b8P++uQzddo8Aw+kYFexYiwMDTA+E/GvLMcPO0srQS+
         hGJ8gcyrqGmaLerxWNHmyCWSdoYWq3rbTF47QvASUzohN7RDrJjUNJO+eSfFtmPZA+tF
         //5WJcWLbIoaIOEKBq15tWxvpUlxLlsDMd16Q7pBQ6iwc+teX84r1HXt8Cg9GQY4RNsZ
         0nDg==
X-Forwarded-Encrypted: i=1; AFNElJ9Xc+w0FpiF8/P/0U1Ms4IbNXReMct/a4BowIU3niWPLqrAu4weLLLa8Vrod4prvunMc/VfF5DiY6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOda4jj2smEoqluaLSntiaNq5wxGz+CJVEZyToCHINM6+pch6
	lMAeG2jeMJUe2KIgaVnyFZY+NWCn5K4Kf5veNA5VS2uSHAll/gwtqojY30/QYnsNshLXzNs9fIq
	qOmTOhcZdl6jZ6W6K83kdPRQ6Al8XdUKtdpSIyujN4rjnNWQKW0lQb8bHfaKlBI8=
X-Gm-Gg: AeBDievKmeX1mu4BHK4bJdHPv9TbO2srzvUiELhhyDr6o353fQT9Ik6spehyZjVb6QH
	y+GX+W7QQkwLvF6mRO7BPIMKDofgu+elJnX4K0PlG4WZe8H63HRtC94McmRIQ/7YF5A3SPhFxKC
	PqZ7j0MXDCyplNef2KEku1KYBa2YNqA2vHFKozergyTgUwlYc1bebFIt1sjwith4LpvCPVrUhwn
	2+enDN8oePbxTCiG2UKM0gYqezX72ZlZbi81rDGW020PQjI96EJ/iYYJYJ+oglPIzvKu28wTW2e
	GRhhw3WitzUJjfiEMbz4nYHG9SUBwHXR1u8JXf0sJpvhlU/Mr5iyBqhfN3oHZhut50Ny+Ta/4u6
	xzX0NJdnsOPAl/rxc0i6OVxcDSR6FZdF0S84aIIuabTeEuZ7JpitmD7p9pBL3ySQRNs1s
X-Received: by 2002:a17:903:4512:b0:2b7:beb5:3002 with SMTP id d9443c01a7336-2b987332915mr32350865ad.12.1777482128486;
        Wed, 29 Apr 2026 10:02:08 -0700 (PDT)
X-Received: by 2002:a17:903:4512:b0:2b7:beb5:3002 with SMTP id d9443c01a7336-2b987332915mr32350455ad.12.1777482127939;
        Wed, 29 Apr 2026 10:02:07 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887853a2sm29530195ad.18.2026.04.29.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:02:07 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:31:40 +0530
Subject: [PATCH v5 5/7] arm64: dts: qcom: qcs615-ride: Enable QSPI and NOR
 flash
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-spi-nor-v5-5-993016c9711e@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777482100; l=1047;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=zM5H7x1nhNKHbvHQlqVkDFr5Jseh8BFRxY3VO73Fg8w=;
 b=otVlZ6Kfxfk/TW0HeMZ5y7/NzfCzzzE2y/vrPPTeGgL/+dO+8//RJ612OZi0WFOXyaSqP6+oo
 M7S9Em7HTSWAGStUfzEfLS8ZbgJnci0rbssXQQBBaywzxungU3qzld1
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: KWeE85DgSFsGJrFGobXoL5CqGwPQN-z3
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f23991 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=eijpJye3pRbVNivL--0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: KWeE85DgSFsGJrFGobXoL5CqGwPQN-z3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3MSBTYWx0ZWRfXxTBQVxgCC0/M
 LiU8nhHjHnI9P79+liW/V8jv5c8yFmxITKCj2NexGDiKKlVPylkmsEuVjuy5dJybkbqV7vLsE56
 wmo6vxkFjf6F7EZOB6Tunh4LbQ2g3G5CerQKNEJD8mUwaPw8NOzvbr5nE+cuga2EhdnlDLLjcFU
 DIAhIyCogJPkvyKi1aNbdFjMfu9WNTBIPv0VePmVH1PI0C273IW+DD2VfDR6IrD8QoG65Sh0HTB
 U1Ur9BLFsGPduDI0GRQTfTzXR6S8B+WgK+98MEnFH7Uv5xRbfAmJsCQPquKZw9i8vhNuzsAK5SO
 rlzGhodmVB/9V9HKfVs97bwOHT3fFyznqvWEFrM4T6W8s5vMEaaDHOn/RA330pezbc/+TqGITMn
 cLk211sHBu7hca3wYGCg5ye2bkxIO+WoL4kxuDjcdaQmX41+D+6rt5LgWJk6ksCC/ugmcn1QUiw
 RaXQnH2jdjnFwUZxhPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290171

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
index 7e05f873194a..59252d127322 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -498,6 +498,18 @@ &pon_resin {
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

