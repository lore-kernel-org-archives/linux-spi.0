Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F83F99DB
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358046; cv=none; b=cnyslVjx53jlUAw7tp8MbYMFtDMw0gQ1RfiXyo55LARBak3O/vWpkBI6FsjSuLYyb+5KOA0oT3plwGAtvaBhiMH1LkokjGl0T3plbRPy6S11zsjB5xY0sF53EwA6trm/ly+p/vV+lhHz13q6OQnwfKi8bD9IXtdhYMCusuUMtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358046; c=relaxed/simple;
	bh=eF5XHvabBc9LBykA0FGksNSDFueQYcnoVPKzmT91Vnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhhZnmQZv9CvLiQedfN9d0LAvvJtTt9yVszfZmkLyDxLGTeRpERHSI8z16TkAp+a5U1H9SPB6wtG59aIYXVhIoL12PSt6XcI0juthQydWYyzswM6uKOPnu29gbBQNfkE/J+dCRmNNLdbdoQj7H146aI8VJosgo9O1EI+ZbWSsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fH8QbbFV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OGH10Mur; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fH8QbbFV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OGH10Mur"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8xxB42323595
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7tPC2bQE9RijAHIYt6BKlmxIIWNy/+QOYhBdjLBo+xQ=; b=fH8QbbFVxa02Z//r
	6Cn2nodHZNzyN3LEbfdWaqNovMoOfiFUhTxNrtJqk23+/icwEBkajpwgNYwqL9Rg
	f6g5qHlRMFx6JzhrTrIVIi8aNc+RWcv8zix39MIVL91ZdW1pebtZ1i8ojWYyT/jX
	sF2P+nJV1Zrgg39xwDs2O7GtAvCSmZT6NIXny3mZfeMIWj5I5/B0Fnh073B/EpYt
	LiAbNv9pRbDuJoSE2VF16t7xSTvTjwgMgXlG+sdaoZhn6fHaQelU38dYdfle2KcK
	yR3DQ1h+cY22OJBr6DODnc62rmt6eV2w6uq5/lr4+mHOmk9N8H17tqUoE7kJdeH8
	luVkXA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qkes0h9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:14:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8299499d587so978758b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774358043; x=1774962843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tPC2bQE9RijAHIYt6BKlmxIIWNy/+QOYhBdjLBo+xQ=;
        b=OGH10MurMiJsQGcmcFbnqGBErhNqrEbM9j0mwUOSr3FDYzcK/NbWDP9uFNgFnvE3c0
         Wdlj2iBSI6Sq+aGfWk6CVCuP4PBV7asWl1MV5AdO/fv1KGOBGYdIillaadIPpsQbppXG
         5QeOLcNCPBa9PQ4a4ubwrQZ6iRlPxO3glmWk9UVbSFFJXEa9ESeIobTbtznrXyzRVpa/
         syKQu6uw0gcwLxPy8OQFxoo44eyNXTJY1/af78Bxw81L5uz5SDIF13S2F07USEy1xHeD
         BnDD6/9CYPd4R2wTfY8Un5F58uK3OXqOfbErAzS8JvPt+QiWvpEwn4zynr1wjQh76Bg3
         GGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358043; x=1774962843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7tPC2bQE9RijAHIYt6BKlmxIIWNy/+QOYhBdjLBo+xQ=;
        b=bBawIOtLn2ASJgbS6dD5GKe6AT9dyrFwR0ibnINrfib0cAerCn+M1ltp2XurPv1fOx
         Fv/EkDdfR57nsjay9yzItDaDdEy8JNlUO6JzjFqyih6J3B1oMH1EHzxbepn/5jTYYgBF
         kJksbfD7GJgzCh9Bk3+14z32yZ3wf0K7A6uf0Cgr+dVuJkEH4uufi5JrWcaU82KBiJ0z
         xPoKPKviWx3hNmaVfV9UQK85MEEkoIC0k8lRv+xhGCL3H+bpmPDom2WKFYJAOjE2INjW
         O+2e2CbyOzgLDiosMPFExmTggY4sXoYWhpjfjDVjbOlI0Gm69PX1+8AX7WdUyzMucV9U
         2lBw==
X-Forwarded-Encrypted: i=1; AJvYcCXE2fV5h7JObfxOBwaconrYtOaqPGqRqBli9h6rXeD6xogOLpwua2utafIu2BcppRFjjHPHt+kbdkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwbwXEbg1XdljR2oqFYohNmqt9yoIQSLpa0JhOXrCkgP9Ybxr
	OALMzZjxItd7WPYBn99aWF/xC0K+yv3t8ASbWbLejfV/Ou/AvN18xe233sEh2wEwfxhx0rG56IX
	tWsH2KSQAvPg1lE+qvfWwBjiJgwYpe7MZgWCrPc3nRRWKFibCWl8h29hcrEi+Lx8=
X-Gm-Gg: ATEYQzxV7Pex0s50dV2Cb3ZOLpRDetJUvr2wvvRuyGsdGGjCNmZzTO8O2FxHVSNJwYb
	OIyNC7yRWfBFCFl8FzYlEyhgknXki4VEvtv/SQR2/BOWzAdZSAXkwE8rj9yZia+Z1JHLFS+PQ2C
	CsdXnbsfyEzZRUHX5ktoZ7sCmZ4l7lWZ3j/fuT9GDBOLyN4eevnq4e4Gr2wTGcgg2bzJt20MNC0
	NKOqNjtGtVvCAuG90QAlxfJ2WqQhTm4BQn7XEuJwkvyBp+UGy/I1cWTdrZcwhqtPBfYmjqH91AD
	aESzjcTsr3cviypNjk8YgDkm5hLpsXEsRZa/bwOofB8gOWxqlxX4yx3qFsI9ouzgcV484NR62B8
	fMDzEfS9EBnYiL/9rxEUj08VdXmwDcHqRKKCcQMCkEfVlb6bfQb4wV0dm3A==
X-Received: by 2002:a05:6a00:2443:b0:82a:77f9:2a85 with SMTP id d2e1a72fcca58-82a8c2a72demr13105274b3a.26.1774358042818;
        Tue, 24 Mar 2026 06:14:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:2443:b0:82a:77f9:2a85 with SMTP id d2e1a72fcca58-82a8c2a72demr13105244b3a.26.1774358042207;
        Tue, 24 Mar 2026 06:14:02 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be3396sm13517528b3a.27.2026.03.24.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:14:01 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 18:43:21 +0530
Subject: [PATCH v1 4/6] arm64: dts: qcom: qcs615-ride: enable QSPI and NOR
 flash
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-spi-nor-v1-4-3efe59c1c119@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774358020; l=919;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=eF5XHvabBc9LBykA0FGksNSDFueQYcnoVPKzmT91Vnk=;
 b=5h6ClvKVLsu01oh+Y+2wVpqGRXCbb+KQs3smOaUadjZDQKYaq0AkY7rm72qKJbyQsXdtmPi/S
 dIw82+LW6BbDeR5frEur+EZfcJg7DOXcNCrdnIriVjuA5XLXiZ9Gjah
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: yQVDtOqfPNcPG4ZBVH6eeI0lCSMOSQuO
X-Proofpoint-ORIG-GUID: yQVDtOqfPNcPG4ZBVH6eeI0lCSMOSQuO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwNCBTYWx0ZWRfX4dLybvDo69IX
 XnNfkKCopqlLwBb8sGXqc4TmfcHxMSjVlH1wB80Z1VHs1U09mJBaYjrk1KPVOyXcwf3BAsf6jPz
 O6P/Ca1Jz1GfwpdvF2DJjnTaf/U9g9jfb9L3PYs8dSZSkQJp4b2rK0pxh50Y+g7CXHbEH5cP52z
 5/wSbRtckBytT1Ku8BYcoaQjJpthOS7ZcxEHqV9Ug1Cme8LyLNx9lcW1hZkicxeqR+Cza9sqy0d
 pnP0YmchBNv6NhY+IS766lauqzB+ul20Xa10z5AtE7WoDQgVlZiWmBd06RdEarVrJ9EdpRJG859
 V4YT3iznk3Kjb/fyrg4pXG1DIN8pJgEV4pxf8WkpYgtSjLBUhLavzuX0Sae69Whmd4ngiIz40Ty
 NDrjYIwCl49XDrfwHgnBpY5NOiEufz9IwaGVDqriLqFJxNV2ZEQOkEoTm1zsuBevTD4qT+lnhfN
 FEF2UUGnZrDmkpwKvjg==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c28e1b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=4y34Q046fKwHFbVZ31UA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240104

The QCS615 Ride board has a SPI-NOR flash connected to the QSPI controller
on CS0. Enable the QSPI controller and add the corresponding SPI-NOR flash
node to allow the system to access it.

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

