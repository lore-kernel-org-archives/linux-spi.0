Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0B43B493
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011241; cv=none; b=Wm6Fmque5ByB/oo/AWWT2A4hyRFeYDEaoaWajXpM5KT1kZmRQjVhZndP+NhZsMAIi2QqhTG6GyLMHgafOtcn/FlUkoFIH1PKtTCv8zUt/g6LIDRCND7J9CpCDiCWHdROa9fW25cugbVc1S1ipWUZoS13jrHQYNtXpNP84BT1nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011241; c=relaxed/simple;
	bh=JNWrtYLxwk7gmvfMBwtTQOHeTRpiGtmAjO+J3SwZF+0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sTr9GExpd3jhKMgrabIdhELmeDoYbl/vjJ2Hs8KXrxci+LpTi3P6BFyqnnu2l/rk4VxEowEOdNpU/sWeZ3M4+iYpJJBLYt5YQGd7SkIkQjHF8u6o0zFDJ56X1WGShGw52D1348OJAhBywuy+NKVGUhp87+xPS4hw4TtKm6mO5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGVi6njr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jAl7DNjg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGVi6njr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAl7DNjg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nnx61626093
	for <linux-spi@vger.kernel.org>; Thu, 6 Aug 2026 10:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hLUZ79TEnuLfbfIWErCoO+
	lM16SWLforq3VCstkOojk=; b=TGVi6njr+os3CRM98+SN6YUD5/NnVEwKcQ6DCv
	fmAQUU0NDoqI3NXSSVRE0z72YOIDvZ96q01kCq0MMUUatJL5ln+OGMomcimwLn8j
	Eoss7cHKzliDqi22v9UTi/960w8AH8kQLjH+29roHJWXt5La1F13rTPNEghzlzzS
	cc9tbCfFERRB7mCENmCyUa1vw2XwoMlXGomj8vG/q+Nt5aUK3BKOsDqegT0ENtcz
	iXY/c5oncvOFhsyMe/8MrV1j8rpafrXqkngHCsT37pyxxQhM041cn7YucvGVy/9d
	z6bfLnIIXp1CYVtJwtm0u4SKAgHZL5pI73BNdNkqIBOr6CUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvntngq17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 10:13:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb48f41343aso642947a12.1
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786011238; x=1786616038; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hLUZ79TEnuLfbfIWErCoO+lM16SWLforq3VCstkOojk=;
        b=jAl7DNjgZxoqjBY+zITbt6uBFuG4RMkzfS8nPuxRvUaQTFeQUaau4MUBUqcE+TpH5D
         /28416GNmCjF299yVOPzqnQSaX1zZq5EjzKL3lAkq3Bokfr//YJva0BQbCr2UCnFb7QH
         yrDBO1k/MW1b/zMEYaKCNTH4OE/BfNivubj9FmKmTL1pz3j1X3o+BEuAJxkF4LoeRDjO
         qPcmRuEep0wB+0Sqh3hrY4Y0X26Md0bK4N59utSR+/VeKFHhnBG/imqdGKPQi7E9fE7D
         S+YLV/KZIU03CVTY+PQxwddo0nbvGaJYaoTQzgyTX5x92SL2GilxGXrUPd6PhGRG82aU
         9kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011238; x=1786616038;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hLUZ79TEnuLfbfIWErCoO+lM16SWLforq3VCstkOojk=;
        b=jOmb6slLWGbPicRD3l7rGTA6iYR/Nk0zx0mAlj9j0RoviS0oLdBDU8+2KkMNU6lVHj
         FOoBHhWt0e3dOKtgyk4f89aUfMyXLMu0s0uhJcwAtssLVq30q6ffGnZ4y9h9dpJJ2pCv
         26+b4AE50Q3Cwab3qRAQz9pouz1omO27piuEd35Vo3CuidadIwy/fCE23xzxA5fsGRjQ
         wNHCvMUrrFQJ4lN1RZxXsZVRuhqcGs0S+ULrJUuz4wWnYXyfhw9RPdtzyn0DvOeLMiKW
         pNL5DLyCsRFUtST9GOpV7chdjNrXNn6mvneZrJt9imrXPOnc7E6g+AJY1Bu4z7KZYnLI
         4Rbw==
X-Forwarded-Encrypted: i=1; AHgh+RpUyXif8AF0S6SSwrP3+nlQKx85WBeWSEGeDUeSmjovo/VLh8rKfBrd8IhMH9oiyBQFafq0gUyhXcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7IhWUn5ED9lsg/KUrCOsUu5Kxge/kpImIlZBSH81fg6Jw5fJ
	31jZ/TazzR+DgJtABfZRGH31ZumzeCLltDn3cDlPzeYYZT238o+1MKKeRQxjIsk0tAvakC1AAYO
	7BccjHJn4ErnNRddTC6XvRv6T/B1NcPcLn6vRc2BQ+Y3UCfbu70Na0rW+eZaFTPDV4bL249Y=
X-Gm-Gg: AR+sD11YocgbCGLlg8Elgqj7sYPrdewV51wYm9axUWMpxdHYcGZKJFwLaWlecq1tFml
	lkPSIzf3j4G5UGNhgXZMwopzOXRAxmE1YP2KrMGYxfmbw8shsKcHkKbsmo04+qngJq8a+Z2k5tE
	kyxmr0EnS7fW0/oCGrD31YF2OVb1wut1cfNIKlULKOSWD+8V+3D5TGuQ8+GGr4wgVM9ZyQIenKI
	cZMduCYVhxb0sKf5OHg5f8gb0V2PcrnYvAP5uYeF2MFH+qoY/sMiF6JBQowaoMLtxUfpYfPXzDG
	jA89rrTnCmKkcwgq2fks32qCdcyI9STEIokJ6yuzBPurVnuX2myfdcMkaU97pDpwEAOLjB8rFnJ
	cyszqMb3dgt8Agznhh7+ElnxsyvdFjc89KQ==
X-Received: by 2002:a05:6a20:3d05:b0:3c3:d298:81b2 with SMTP id adf61e73a8af0-3cba29c0b7amr3312166637.1.1786011238601;
        Thu, 06 Aug 2026 03:13:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d05:b0:3c3:d298:81b2 with SMTP id adf61e73a8af0-3cba29c0b7amr3312110637.1.1786011238067;
        Thu, 06 Aug 2026 03:13:58 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707c9970sm2668814a12.6.2026.08.06.03.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:13:57 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Date: Thu, 06 Aug 2026 15:43:43 +0530
Message-Id: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFdedGoC/yXNQQ6CMBBA0auQWUsCjYB4FWMmtU7rmNiSzkAkh
 Ltbdfk2/28glJkEztUGmRYWTrGgPVTgHjYGqvleDKYxfTOYsZ6FMEycUBPGpOxXfFlRypg8ysS
 oNgdStE55YV3rzvfGjtQeT0MHJTtl8vz+LS/Xv2W+Pcnp9wP7/gFZp5sAlAAAAA==
X-Change-ID: 20260729-use_gpio_to_notify_master_of_spi_target_activity-5f62a9e14875
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786011233; l=1426;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=JNWrtYLxwk7gmvfMBwtTQOHeTRpiGtmAjO+J3SwZF+0=;
 b=5/Icw4+hByze2/Zn1aU4GKkLQt+fcqbnGKaJSgLRAXl+4M+8NXPQ1HPjEOv4c9KWHH8SBNLTF
 Rl0sMvRhgkKA2U3HCpnLRrGpIXOV2RCJmJ2qK65NK3JQ/RqZ9DJqQpH
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX4oBeMiAeheBB
 /6rPUiqiYPI1rl+Zzj01Q2hSEw4qT2f3DGNaU6M0Fi8D6Z07MEjhCzDp/d8YwNorwo5woWaibIW
 W/Q6g8irGfmts9D2LTQIK7RMEIZPg8Ui40ej5q8i6Vwv7+fBPWG77O4HgzXdoSusJqDM3dxQwyS
 U1DJhQPSLhNbeMM1unpKyaP0fbaRUfVUTKYjT/Lrg8fnomrlTozNskhG+z1uZ4MfkxJDE8vQJAQ
 A4LHiN7eDbUAIqB7G1Inw0TXsa2mfc/ZHZ7ew8HTFnyYqPqusVVDfrNzizUrPRGS3SNivx9MSQt
 Y+q5V7i/EFIJc1TPZ8NEqsMYpPxkeo44CrUEWkj62PtpfZEgDaXW5heI140Aewsrp1sXj7S6t3n
 1eByrPWhEJcCPmOtvFNINrg8Y30201y4wfdnEPIiHDePVJdghjwoRt0omai0ksbAjtwnwGqE7EH
 CVmaUtp+qErWk3fp8nQ==
X-Proofpoint-ORIG-GUID: IkyABmXUkXX4WZwELDqje8jv51TeOQ0_
X-Proofpoint-GUID: IkyABmXUkXX4WZwELDqje8jv51TeOQ0_
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a745e67 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=DF-2czj9NRJiL_b3NI8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfXwsR8OjmS/VU/
 xiBztz+vIbA42cZG6lgtSA6UNiu3ORCw7huRcGXKFFdaY7gL2ZkFNW5G8kd+52B3Pvd5Y5XD48B
 3XtodfT5zlTVBjuOWMxwus1nJr6zWSE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060080

When operating in SPI target mode, the GENI controller relies on an
external GPIO to notify the SPI master about the target's active state.

Add support for an optional device GPIO that is asserted when a target
transfer begins and deasserted when the transfer completes, is aborted,
or hits a timeout. This allows the target to explicitly signal its
availability to the master and ensures the GPIO is released in all error
and completion paths, preventing the master from observing a stale or
incorrect target-ready indication.

The GPIO is optional and requested only when target mode is enabled,
using devm_gpiod_get_index_optional() so targets without this signal
continue to work unchanged.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      dt-bindings: spi: qcom-geni: Document device-gpios property
      spi: qcom-geni: Use GPIO to notify master of SPI target activity

 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        |  9 ++++++++
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |  9 ++++++++
 drivers/spi/spi-geni-qcom.c                        | 25 ++++++++++++++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)
---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260729-use_gpio_to_notify_master_of_spi_target_activity-5f62a9e14875

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

