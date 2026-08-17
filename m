Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E73D5C38
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983428; cv=none; b=Gc5mF1duzMns31JZOkeLq8XjkATA48km4MFwujfMrkdWtwVf0e0jPvpqkk/7S48rKmwj9Kouu5onxW4OmbCyysleFzKNTqGxz1Klv7NA5j3oG6YehHkKdZ9DOnDkI3UbFfDcTG48PR/eA1RiUsj+CxYSk6dMSHOGejEKegp09hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983428; c=relaxed/simple;
	bh=tH0LszceWi9hMzNHxL3XC5ESSX2iXWTn3F1Uz2is49M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lCCAyHQ2ZmLMLGllImFGqUco/6KBm29vvArSv1QfMcb/o/fNEa8msdi0K5fRfZyR00U3hsfp8ySA8x9ROcgcAKtNon0GwJj91zhdNLamLENfAc8UY/tTsdzwgLtQD1cZXj1K6QuGKGrpm/9J4tAfJAr6sfqkrL/+MzeAFmtfVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ngg4kLEy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZV2gOly; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ngg4kLEy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZV2gOly"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYisg2328151
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vrvtpwd0+fS25kuaO6nZC3
	9jYjBhMlx87DyTXC6yY7o=; b=Ngg4kLEyL8Kefc594PbwmUSpAiOD49FFbxTheN
	jD6VIPy/8nM+mXNZMEUsw39DzHUjw8eqdRyGDYnCORwrVxwnlqgORyTDLJvLEKid
	V4PqG+sG8XqmuKAz2L7j6DcLdL45lPZDpYMJNsm8rMJADM20dOBj1Q1DqL+1kV/7
	M8MlwygIojWKIqW0N9kMRTQNGU82bX3RW+83IrvyHTD8T9fnVQdDaQhs43rdgWas
	c2yu8o1wfUdeM3P+v24YiKFOHE/nHnYhUfvICvglM1rtPSJpy+0RJ2338QhvaC2a
	1Z6Pm4UDFGyp0eQcKeF4gFdwvQFbZ6Y9HpssuEqS7EFvHnLA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1j037-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:17:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso3562199b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786983424; x=1787588224; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vrvtpwd0+fS25kuaO6nZC39jYjBhMlx87DyTXC6yY7o=;
        b=RZV2gOlyUC89fBjVCxYwbZpCSx+OovitqdltMSlA9YZn7UBhOBu9DLwkO4JLON+/UB
         q9TraCxTT/jBQNLNhczqnEeYo6TIzdelaO+eYs4CuQcrGEfymz0mJBPYEOZxIxXYrazK
         HPbVIN8SGmQnMrz6dIwZ7bhbKy4dOJE5a3IjriitxsCbQvkisurW1xGHxmFxHjnkU8Td
         8v4a2F6NcyxHq/mFRuRrU/gCbs829m4Ivxxq0SZKKP7XUlbfEFNsW03kYQwEwX8SBITA
         PYsPVdDscnzaX8b3Ne2Yut861NiBnd1lBqzw6mU6oeTlCmxwLyy1wyV02iuYwKGSo1CW
         NvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983424; x=1787588224;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vrvtpwd0+fS25kuaO6nZC39jYjBhMlx87DyTXC6yY7o=;
        b=IOl8wwcokQ5Do9tGMVFYEPlI5pSiaYjosKlijNbEqLE3DScg9Ah0wDhCPDmXTT2oGd
         AAB7EI3LbhVwSINDZMhoy7uOOHe3BZLkZbS7HtnC4skbR38gcYim23nAyOS/uspewUE8
         8OEt8gz+97HoW5nGEMiNdD58nVCYzt/QbSolldMX0FyvNCmIWrUtII1UI+fB17uS7dcy
         oQiLrVLmAuo+gI8xm3bAxiVAE2VOrpNqq8MCnODUHAJFHe2WkknUVEsXbYfkKeaRHGh2
         F3tyXHkToGuN3X1ys7fmErs+rwx/x/QjGOPMH6W4Ot4e3t78hZyKEH4wheaTIDWFpKmt
         B5qw==
X-Forwarded-Encrypted: i=1; AHgh+RqEHDZ+t+akB/9yfBIponWtslSJ0STk5EwkU5j3fjpL7dIasyg1fU2u/xpzc2ZbpR7CTK2vPDZoZhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3NXt85KYd9kamm6E3u2EZ1o7O1dEmHELBbK4F5rtdepSNwuI
	K4eGKJmfxS0LE/Fr3pWix3iUColIiMQh0xQQP0/HLSNFZnw4qjcweRNaY7x9SU4ePbRYzOdy+TZ
	i+LUd9gANaUjqxd7GAL91TTKKiZpRycoXZlm/Xf0qRJ+DzvLqs0moN78czmfN634=
X-Gm-Gg: AR+sD12STIVe7qMCVUwAnMMRv2HWBAwhjA144I1ZrLIFeTjRZBPGDgvB3ujGaU1/+nJ
	EKkU64pH0eiNrdDE0D9l+XfV/S+TdTpmFa1612Z4x2mbysJEo1u8vS9c8XuZR3OYPNhRcReWgtD
	M0kJcLtkJKtIARc2DHe4yLHveJoEb4ZACXkBc/1cQoJ2/8NHw3fDMh4bSv9fsp1zkGOguptRTJN
	QNAMx9ZBvjP47MyXJYNMhKiJpAB/sGzFRYz75JxtYL8OpHWKT8L/s3VxizZsRty8wD+yQzmCyu7
	LCRmeu7TBAFBbEKNkFqL0EYldHdEttj86qOJPj6ZXhKOmpUjihwLk1k94TjO46hneX7X8BN9Ekr
	NCRCmFmm8lbilmRBypMLpWa44XJkqSDRNYw==
X-Received: by 2002:a05:6a00:1489:b0:847:9aa8:d3ce with SMTP id d2e1a72fcca58-84fde14ff2emr24848033b3a.2.1786983423748;
        Mon, 17 Aug 2026 09:17:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:1489:b0:847:9aa8:d3ce with SMTP id d2e1a72fcca58-84fde14ff2emr24847989b3a.2.1786983423020;
        Mon, 17 Aug 2026 09:17:03 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc0fd9sm563035b3a.45.2026.08.17.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:17:02 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Date: Mon, 17 Aug 2026 21:46:51 +0530
Message-Id: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMzg2oC/5WOUQ6CMBBEr2L6bQ0UKeKX9zCmqXWLa4RidyESw
 90tcgJ/JnnJZN58BEFEIHHcfESEEQlDl0BtN8LdbdeAxFtioTKls0rVciAwTY/BcDBdYPSTaS0
 xRBO8oR4N29gAG+sYR+RJll4rW0O+P1SlSLN9BI/vn/J8WZmG6wMcL56lcUfiEKffpzFfeqv+k
 On/9WMuM+kKXdj6Wt68rk+BaPca7NOFtt2lEJd5nr++nqcvCQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786983418; l=1858;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=tH0LszceWi9hMzNHxL3XC5ESSX2iXWTn3F1Uz2is49M=;
 b=2a/jh4YIJff3PSn9kMbxH0upCUnnEQDj5BXGk+J191JBIQye1hvg7N6RFblkQi/usSmcymul6
 JJanRzmZ76SCFchS1L4CcqTFKN0vDR8ZaTbNKz40tIs7hEW2ja6D4im
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a833400 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=DF-2czj9NRJiL_b3NI8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: pFCek4gs7MeiX_0gZoMppDJZ05B02ZgF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfXwaUrM2YRoVIo
 Rlc0RzxtGPWCpUHFP1LNwRXzxqEg6RLC5l940NT4Mx46SI34VDOr/A4AGYFPp5jnfn3/d51fgTP
 744FDK4uxDJERLsnt+/CUL3Ocj0MwZ43AV9UcgisJiIlbblVRGdUjqJfwlE5mpuVPWzTfDtYW9j
 nwVzaIHeI1VVJkp/x95Cqo5LVOqSfdrdJ4M770roOkxLEZD2vHLVjv4PC+8rarn/4gT/EMVuJll
 joCCeoj7XgMh3PRIV+9v/QJknY/gEel+rvIo3MKUXaCnpiIcNYCLiTolQ6TF03gkDs/3QNb3gyj
 747s99Rpem4kFsOO7XXFNwoQYb7ot3ydpZc2RtdkSjZnGePwvMga6Uw9ZROzv7t2okK465Jsrak
 eXcz3N8H/8hkRXjtuhZugbupu6pahiU4inir3BtOXsFVUNEHIPdFjq1T6cD7YAkYO0tNoWFzSK+
 B+mxmsPWYDEovOO4Esg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyNSBTYWx0ZWRfX4GEn9p16zT4W
 azqNyQU41wb+UCQIppZYg6LxnDWaAHOmRkPAy/2HBVXm30eOaakBtQcfYBFzoE+bnGCz6KJPBIU
 gTx5dhMEBTjpezqbS1TnsxDhwLXaKeo=
X-Proofpoint-ORIG-GUID: pFCek4gs7MeiX_0gZoMppDJZ05B02ZgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170125

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
devm_gpiod_get_index_optional().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Used ready-gpio instead of target-gpio.
- Updated commit text.
- Link to v1: https://patch.msgid.link/20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com

---
Praveen Talari (2):
      dt-bindings: spi: qcom-geni: Document ready-gpios property
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

