Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AC3C5546
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165722; cv=none; b=uSBzA5FgwxNGtdUPa26W8hMVfMv6tZ6y1bkllyzafrjm88uogcpEYtsTJJTbwcEdcAl0V5AJMVtIaY4cKZhIakVlNkdtP+CPN70eTEUJSCnRk5VwxYAx/obpI+/j4E2jwvQUwCGLy2qVh+XaUhGxRDNzdW7sidyHE2fst5b3ZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165722; c=relaxed/simple;
	bh=17Yiv9qE2TbdWW2B+sfjsCoYrdlNtkiAjWBT3SqBDO4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SNuzQ6FKckBEEgOGR/AbsoTvN4OWdUpi+PoasqymP4spBhOqhSCEeRAHDFEsatiD/3PdS8Md9nkt4irTRj4gZfp5g8kXzOCEWbfGJMVt8u+a0oIVEfn0BF6wzX+YseTdDZM6vfxkz5hk7GRi1vnVTUHAQCzKejvUGJYtysxrhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtDwerSG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H6sjLKxF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtDwerSG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6sjLKxF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEON86250072
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZWBrjk8gfGrILzQzobZsj5
	BbGVxX9kwkrJPUxOT7Bu4=; b=BtDwerSGs8d1p+u/8Vjtj9QFR/VWWpehyuqzr7
	Z7+caaNqK5gARi6BZlimT83uuQ6y6lsGJkzfnyLEIEZt/TdjX4vUXYyf38UoLJOM
	DyX7jWJmmU+je3GYspk3GEWOu0PBHLzi6CVzzYdpO5b/P8QDJ1PqNPpTYsJVvGvB
	3ZKsKrVP/LaEeOEjWO8n8ZnGO/PhgcJqFfsT0qejhE17ZWJZqqUDpsRMij+abm3s
	F6PWdJygiK6YZy2ezU4UoJALCgikkmo8OPO5QpqduFsLVmvxTqBoVsYtkpvjvPxV
	ttFcn0Nk1SYTgGCd1PQ9mQlwOkZVOz5nBWkwkW9r+7BGmZJA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux519n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 18:28:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so2922315ad.0
        for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165719; x=1780770519; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWBrjk8gfGrILzQzobZsj5BbGVxX9kwkrJPUxOT7Bu4=;
        b=H6sjLKxF80z8B9RDWEiiSj2wYM6z76UAv7Py6kL0pSpDIkcyze1+oDD6tJB12ISUW2
         k5l9ZFL1oiok6IHlA0ybmmrkk5WgKxBWMEkuWE/zbitsuH7tPm5Arj4ywxt6lX/r1+ce
         iQ2ZLpZC5nKggdvv6m//MgzipoEJYpsUG2HeOztP23jaaOH05RT02w1O+c+AVoqQ/BuE
         T98BGUV9nisFnvQTFEVQPtIRWC/+c9cVaq2uT2Ug8keBo9YVj6VzSWCt9zuszF18G2qR
         sjibSpOsCsIK/XLMvQN1XECZShZQzxtgDnhf5VOz1xG1PumYVO57HIUvfg3+qGK9YIzl
         iMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165719; x=1780770519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWBrjk8gfGrILzQzobZsj5BbGVxX9kwkrJPUxOT7Bu4=;
        b=i8Zn7h+FjNLtBKstzgmRZ1HR1Clmp9O/Nh8gcgHoa8FwUZ0sQ7AITT2ttq2U/FAjhy
         o7IzsVv65PnrE0IRcQuNqu5Sj0X8sGvKzKQgpik/NGQRBjAL18dWheX20450PSOuZSft
         EuR4Wsb0MblcTv5lphKDkdRgO84CV+4KmOhMQ0x4dVvED04KQCf5WFrVG+XIbkSMRbHk
         IkVhJMEZgrTp1DlNkAPuyIWA0JDvx9KIufJLokBHpXcLFO7bN0/VZK759j4KCgHeQr0r
         rozUkZdh0DxGIPhz1rfRclbw7qo+y7aaKwGMGt0C86LlqsujTrNmf/1HoLc4Suefart1
         Enng==
X-Forwarded-Encrypted: i=1; AFNElJ9KcQz/XNp05n3Niz6BGDgE0En8FfAtD1Ix00RYd0lJcfMdM9A57bG6iX0ZI10iFwh1FvUMboY1xi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Gq8+eBoSbSQBl2CJ5x75yljZASUmv0hlOpz5qdpaC05ubpYd
	49ZsGnvX4FSNoJlVQPtQntL7b/vrlcW4ZX5luoe0KtzSQPMEcyxvPY1uqHNKPZv4ZzGNgHjNYEc
	jgQTvIeR6p1ZBkT/gnZZoFM9ymuayLlRjyD3TpAIE0RYAmSLJg18dzwsyQa9dw/w=
X-Gm-Gg: Acq92OF9Nwlb/e1bMYrIkRwwhP0sJOFjWrillPPu8UGmuaHQJWkB8OwTvZpvF9UAH5j
	Ck6bYEhLj76xGIKSMDY/2i8v5dQVACdGqaG3Tl4t5oaDDAJLCiBoJ2aIA8sfHMLEsqD1H51IGLi
	MVHlNLYABJVZEG6o+8IfmFlP1GFriq69GUwbX2CQUz1kOLlmN3lAV4UMAII/74kw/XIAqHgf6YW
	dKGujwtBM8INVOWyDO4RdYKEu3VXuEF+tfgo3huhcXbS7yAYNT4AjmV9Ezqdw31tML6kCJcNK6P
	j+3zdclCBiWaopALIt/4ySXx46Zsf4yQGIT23ru6v54FXZR/+LTJYOAYWlo9qJK/hHYwfKEr7yj
	Jfsnr4TVXxhz0w1gYPcKsdgPUOExW7toWAsf4wP8EIGVtYhUP2EsbA5m0LRPTNTwh2Q==
X-Received: by 2002:a17:903:228b:b0:2c0:af09:f3d4 with SMTP id d9443c01a7336-2c0af09f567mr21537845ad.27.1780165719173;
        Sat, 30 May 2026 11:28:39 -0700 (PDT)
X-Received: by 2002:a17:903:228b:b0:2c0:af09:f3d4 with SMTP id d9443c01a7336-2c0af09f567mr21537565ad.27.1780165718591;
        Sat, 30 May 2026 11:28:38 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a27ee3sm56879635ad.36.2026.05.30.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:38 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Enable SPI on SA8255p Qualcomm platforms
Date: Sat, 30 May 2026 23:58:22 +0530
Message-Id: <20260530-enable-spi-on-sa8255p-v2-0-17574601bd63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEcsG2oC/0WMQQ6CMBBFr2K6dggdaQOuvIdxMdRBaqCtLRATw
 t0tunDzk5f891aROFpO4nxYReTFJutdBjwehOnJPRjsPbPAEnWpsAF21A4MKVjwDhLVqFSAWmr
 NRIjatCK7IXJn39/u9fbjNLdPNtMe2x9d9CNMfWT696VE2ZTyVBVSodaVBgkh0sLsiokGivbiU
 ypeMw3Gj2ORR2zbBzdenGvEAAAA
X-Change-ID: 20260529-enable-spi-on-sa8255p-8166eaa226cb
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikunj Kela <quic_nkela@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165714; l=2558;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=17Yiv9qE2TbdWW2B+sfjsCoYrdlNtkiAjWBT3SqBDO4=;
 b=XXkD/QKdjaNZgz8iLvCtJTsxJBYT9ET5BKXWr9oUONBTDMdnrZOS24FOCTb0bfArZqET2uJUW
 Zzqz3CAS4WSB3fe9o6QA9MqDQcQYV4SEEoN7JLLNKSv9W54V941+xIG
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: XGmRFYwI4422-zXZoGAwQtHx1eNeQTWb
X-Proofpoint-ORIG-GUID: XGmRFYwI4422-zXZoGAwQtHx1eNeQTWb
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1b2c57 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NeO65QaY_C3oiTlxhukA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX20U/AsqwCthw
 aCi6nnfs1m6cUvAaD8VxLrZxAubw/r43Wb0M027GjmcF1YK7AZEOyvrJxZ0Iyhb0jMgCwYDL6bS
 1Fc9qWj7wQ1rLnZvuMXJTUH5opMZ3xhoSi5HbUEXkAeTm9VI3EXSuGhK8WiNdc98LRENaKMoAih
 JPpEgW7sB7R3LiuV2IXaHKw9QU4q7ZXhVbaGN1NWdmxwS7ax68ZiQtYCdbXxGtwrftNdDS/Jo9u
 66+EJTAnHAq8SphxvJAWa95E9OR1JlGinfCD/6GFc2H7UvmSOFC06/zqP9USgYccj4btJVXunrr
 ByVnajDfsclxIGcW37tIl9d9XeKz0uzz104d1ZXoRTXHMJhw+anxZ+B1Au/b7I7aqeYjAgB9lWl
 wmmLzBEr9/pQBg4jNO+gxZ/tgnBpDtdqAl9xC8VKO1x7oZSJBcIc35dDVjwr1ktCaSkiqTC+89p
 R8fa8K3rSaDn5EUu4lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages SPI frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate.

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Praveen Talari (4):
  spi: dt-bindings: describe SA8255p
  spi: qcom-geni: Use geni_se_resources_init() for resource
    initialization
  spi: qcom-geni: Use resources helper APIs in runtime PM functions
  spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms

.../bindings/spi/qcom,sa8255p-geni-spi.yaml   | 63 ++++++++++++++
 drivers/spi/spi-geni-qcom.c                   | 83 ++++++++-----------
 2 files changed, 97 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml

---
Changes in v2:
- Rebased patches on latest linux-next.
- Link to v1: https://lore.kernel.org/all/20260112190134.1526646-1-praveen.talari@oss.qualcomm.com/

To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Praveen Talari (4):
      spi: dt-bindings: describe SA8255p
      spi: qcom-geni: Use geni_se_resources_init() for resource initialization
      spi: qcom-geni: Use resources helper APIs in runtime PM functions
      spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms

 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        | 63 ++++++++++++++++
 drivers/spi/spi-geni-qcom.c                        | 83 +++++++++-------------
 2 files changed, 97 insertions(+), 49 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260529-enable-spi-on-sa8255p-8166eaa226cb

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

