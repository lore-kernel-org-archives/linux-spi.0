Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999A1624DF
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452609; cv=none; b=ORBW9d4PGre0rBSy8rV2icF/DgkMKcu4BlTCu5ziyaKqeVXUfGqKMY+nYDBXrdq5otJSJQ21s7teZ7BWZgw36aJh4OcaildZbo2ehCt5MA2LuwvKfgFLKRbBN4lEHPuEG60yUinnBqTakx6nS8VOrJTSOGSZ28bucWV1AlpaHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452609; c=relaxed/simple;
	bh=Q2KE9723VRXYW/gWpR0+9Xwce0qPw4gv29g7kTdtqG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mTBkUG0ucr/RZwTVwDvSALV6xETQ9IcFvjBUkXbsAKPlhiOggNGz7TntRJFUD2jZ0SS1oydaflUrLY9PRdE5oRZN/s31DE34vU0Sis8tIvqAWXdrf+Lz5re+aUgzh4TX70fXEpK4pzDPKYX6pKg/ym3FX9fusB8rPNw+AYhgOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GKhx8jgG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f/BS+tUL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKhx8jgG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f/BS+tUL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QGxQct1449970
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gbJ9ic5VZpmMOFf0cztQ9o
	0cHqKZQH+aaKl7RK2Nlhw=; b=GKhx8jgGUM+X9Mm2FGrW9L7GEn7XuXGVQhKEBe
	kWKmJnEy4y0C/nHeupTHp4h6/+7ICUM4jrXCzAtbIhPyYeHuELOFWdDV+C5HCHNk
	SvY5dApwYRGzvTkL6E22us8Vw/iBLM3oCZ3Le72Je4VLelUgst4KSgacbwLZF7GM
	5or5uep8V5sM3cMTRdujvUcfB13kKom3eyHSyGn6VispCHFMmBpehaE3qLdYTv60
	TMv6s+1CxdC3R5TZdZmyeUi+nihvdhVMIs0wiLHxx/HmeWrueA5hxAdwfCK6jhz8
	kZK4TcFJSu1dv9f82zEH26RkI7++pyX+sXKb/TPOQhnGfdSg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfsyam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 19:56:47 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so7680918c88.0
        for <linux-spi@vger.kernel.org>; Sat, 26 Sep 2026 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790452607; x=1791057407; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gbJ9ic5VZpmMOFf0cztQ9o0cHqKZQH+aaKl7RK2Nlhw=;
        b=f/BS+tULeyWZi1BPaS01EbFOjYWWU3TmJq6mEgYmQATo4vk5J4yiSyQdthI28O2F5k
         wp5t4aLtbnhENd2X7cZF4ut67VkDwFVX/iPkFNUC3j51xV0d1+bmuUKlqHNzIELoqisj
         rHyO8xdrj03PvarPU0taZxMBM4I2N+FUyCKFgGq3XRUBN0WhVqEx3n6cPwMRgITrWWH9
         a1F+b0NdIMhoobOCkcxQNsAD4Mo/2PWMbmjMMyChj/TRLTIuurEBjLGcatDkrXt1r2Ij
         G6QhzurNWKa4vIBnXcJk4X7RB8pLrSReN6HP85JvYoKkaK/t1zP5oDjVBaNp7Pfl4vdO
         qMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452607; x=1791057407;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gbJ9ic5VZpmMOFf0cztQ9o0cHqKZQH+aaKl7RK2Nlhw=;
        b=qtdYwA6WI9qc5UfcD4l8WdVZ5rpHTo7ptT7x1lw00IH3Drr6INnNUPGmwqSqIKPZz9
         cnOn9pa52q6r595IGeJUicy6Lw4Ppun7zXh0R6cemkgFE3rpzxDGa9EYYFHFH3SEObIV
         G55AykWRiePkRSjjJrd9yX0zBwYp3jpyEuliljoSfdAEsQW1akBCS1idc2E3M0ZDqV3Q
         z6IgxDhSd5K2Du3Vzn9SvBbJzzHBAuGVmxswwy5AL5HAPj9A3OVDoJEDE/eARWuLPJTF
         3Vgw6dPBYdi6M9uQamJ8JMWFXOLPjKehQmdS0E0moSK7Fzg+rUqRdvtjNodxmPQkE01g
         qDdQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8vis0wWAGyfaaik5rwMcAwBYUfY957tL23R03tQJFNBH1FRqoOPNDorJcamSOfOh/uKifyUwSivI=@vger.kernel.org
X-Gm-Message-State: AFuF++k8tVyVhj+Mmg70Dc2vudkhdTMX49Ot7BsEXsylKTU64yERNGGA
	m9urwCmpS3+Oad0VZKqUBFhf++pGX5/ssp8dQVCfrYKjzqvUp3m7Z0qx04UwCV292yTMwob/Ljd
	LtQypcBBGVIeXWbYzlLwO+3w7oxjqb+mHCNePM1+qFs3FFNytdHdMkkaKsMQQQ4k=
X-Gm-Gg: AYBFou0fjMUQmVP5vC14pDXen9yncUOEpiS6lte/I5SSeAtgLW+ATBl4XzB6n+KwijM
	Wr01XRIpQioHe1prjo8t7CHJVdfmNASIDIAafiQRYMcfDsa8lTWzAJv1fj7BDJmILTqMX7R31ix
	RkBm8g5DPSAiFJIU461G/st7bMaCn5/Z1Gxt/HVtCXlsou4vk9vx5ncMhm4/A9b7Lb+HRJiLtiN
	vF6f4xKgdbqknFzManptOxZilG8VJAdUkvCTs/5QcIhau2ZUC5axbsx/hLGxCMyPa2yZe4tlzQu
	dfHdfRERky28xPPErSHfmWSeJLCB7ks4WoLMoy8spvYePF3HMmoYEgISMtPNSIVr0y91MHnF+gy
	liJe3Js6EAs6riEPD+tQcDWspux1Cw6Ri
X-Received: by 2002:a05:701b:4516:10b0:144:fb42:50 with SMTP id a92af1059eb24-146d00b735emr3876501c88.31.1790452606692;
        Sat, 26 Sep 2026 12:56:46 -0700 (PDT)
X-Received: by 2002:a05:701b:4516:10b0:144:fb42:50 with SMTP id a92af1059eb24-146d00b735emr3876462c88.31.1790452606030;
        Sat, 26 Sep 2026 12:56:46 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407ea69sm17179025eec.7.2026.09.26.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:56:45 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v5 0/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Date: Sun, 27 Sep 2026 01:26:32 +0530
Message-Id: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAjuGoC/53Oy26DMBAF0F+JvC6RX0DcVf+jqiw/xsRVwdQ2q
 Cji32uSDYtmUTYjXelqzr2hBNFDQq+nG4ow++TDUEL9ckLmqoYOKm9LRhTTBrdUVFMC2Y0+yBz
 kELJ3i+xVyhBlcDKNXmYVO8hSmexnn5eqdg1VAgi/tDUqb8cIzv/cyfePR06T/gSTN2drXH3KI
 S73TTPZeg/+gpv/8zOpcGVYw5TQtXWNeAspnb8n9WVC35/LQduKme4c0h5waHEEtwScY6St3RO
 H7Z3LAYcVB4gRgK3S2qonDt85lB9weHGcBQraYc6s/sNZ1/UXMJzuMEECAAA=
X-Change-ID: 20260729-use_gpio_to_notify_master_of_spi_target_activity-5f62a9e14875
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790452601; l=2813;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=Q2KE9723VRXYW/gWpR0+9Xwce0qPw4gv29g7kTdtqG0=;
 b=zZ2NzyfpWtC+cfYih+/6O+WLVBqEiGQDR4MJUsr/px9Bxdjre19U0ASzbPpexVUEbohLt/Y0L
 DL0EI6oFPX8DUsj0ZH1ev+8cvmKlknZHCSmcj7PH2rISOqGjdlPHGIH
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3OSBTYWx0ZWRfX8o5kuhUu9FFI
 Dz1jNDUPJaoT0WPu5r9Ct/F/cD3tov2K7JHL8q0kr4o/4ChozBUJhQaP0QpoW14oaiMfX4PCfcy
 NRv79mdbchnaPZb0zQBPs0avNEspmbY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3OSBTYWx0ZWRfX/DkyFpjkyUG8
 KaccyJwI5vouu1Xt17cmv6xXUuPE7oN6XEufLTfUF89KLnNogGi929yjwuXf0AAn8hmubcVT5Vc
 EzC/Hjoicvl9wTd0Fi+S/kk9MfDLyre+m5mpB5t1wYZY8TZ9ieAbYpX39yV0AIfFgsqI8EIXPpm
 kyqPnnN3/0eeQVSPgBDzSquXbDTNDzK+XwRZbxRRECjYdFzMMJMaBW64rmvlOQ0NUbLQdSZ4pbw
 4Gq/f9Cf17CtimhEQCq18OHqelyy1XobSi8YO7CtIexGsLjaE4zhJaJahFBGcZ24on2gKtrFT9e
 Q/Od54bsFQVn/Z5YXW0FSvO4wqxLGo7d6bi2XGyU4PxagO7owSbXIw+h/28mDGa9XnFIy6F6FLi
 Heausrr+G7tjwgQS7Ltuj4jTVumIe8adeEZYFYleLJNu6HH+jJCAfq9PI+zhyty7wKofFNL7uF9
 i6NlUfd81B7plxHRMJg==
X-Proofpoint-GUID: TejAaU6p6X5ZYboVQAtuHi8Z84VfH63P
X-Proofpoint-ORIG-GUID: TejAaU6p6X5ZYboVQAtuHi8Z84VfH63P
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab8237f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=tiKpGdTzN9YaXDHrg9wA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260079

When operating in SPI target mode, the GENI controller relies on an
external GPIO to notify the SPI master about the target's active state.

Add support for an optional device GPIO that is asserted when a target
transfer begins and deasserted when the transfer completes, is aborted,
or hits a timeout. This allows the target to explicitly signal its
availability to the master and ensures the GPIO is released in all error
and completion paths, preventing the master from observing a stale or
incorrect target ready indication.

The ready GPIO is intentionally made optional and is requested only
when target mode is enabled. This preserves existing behaviour for
systems that do not require the signal and avoids regressions on
deployed platforms where the GPIO is already controlled from userspace.
Targets without a ready GPIO continue to operate unchanged by using
devm_gpiod_get_optional().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v5:
- Use dev_err_probe() when the optional ready GPIO request fails,
  instead of silently clearing it to NULL, so probe deferral and
  genuine GPIO errors are handled correctly.
- Link to v4: https://patch.msgid.link/20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-0-fde2ebf043db@oss.qualcomm.com

Changes in v4:
- Used devm_gpiod_get_optional() instead of
  devm_gpiod_get_index_optional(), since a single GPIO is requested.
- Dropped the redundant mas->ready_gpio NULL checks before
  gpiod_set_value(), since it already handles a NULL descriptor.
- Renamed target_gpio to ready_gpio to match the property name.
- Link to v3: https://patch.msgid.link/20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com

Changes in v3:
- Rebased on linux-next tip.
- Link to v2: https://patch.msgid.link/20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com

Changes in v2:
- Used ready-gpio instead of target-gpio.
- Updated commit text.
- Link to v1: https://patch.msgid.link/20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com

---
Praveen Talari (2):
      spi: dt-bindings: Document ready-gpios property
      spi: qcom-geni: Use GPIO to notify master of SPI target activity

 .../bindings/spi/qcom,sa8255p-geni-spi.yaml         |  9 +++++++++
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml |  9 +++++++++
 drivers/spi/spi-geni-qcom.c                         | 21 +++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)
---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260729-use_gpio_to_notify_master_of_spi_target_activity-5f62a9e14875

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

