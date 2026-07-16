Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C9305682
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179680; cv=none; b=sdpSpW0rByLIoLoEU3laXSMwBIFOc6ikgVKalc/KTtKy2yUwLGnndnNsVuIz92+GFXmxkr3hlnwB7fdZUv/2KP9zJM//leJXRqurgyJtlQFj0D08mxQHJtZa3epfDFAROcjvxXKZHf3dNCrp4y6bHQWVWIpbpFNJrbyurijP0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179680; c=relaxed/simple;
	bh=0lvpFGWnm2io3s1iSPC6UmDBnisD5p6SnumNDWN44PA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Baf8ls/26j35VhH561byGK9OoKVnibingRk9aI/KDRYyWkgTGoi62JT2QKzy+EtfBv7H8x95om7tDLn0diq1BBrWgqu2TOn8i3oJC+PUFi+m1gsJx1XAF+oPTF28xLYzBPW9g1KRv9rZ5V9zTHEm46TuL6ZgmmInpJXp1LDZPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DTHqFIxF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LfTSv6Vh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTHqFIxF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LfTSv6Vh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G4074Z1677669
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y6RBLQPDF9zl8nYoyJsquM
	b5cipagqyhdFtPnoxF6YY=; b=DTHqFIxFVjSGoQcKwnr9/0nJdfHk4dhN64bkld
	+3+3hqLK0/lxc2H5GI3cwoK4r+HRRE7W+xvVtd/HICoc5M43PWIl7Rs8+WSH72Ly
	DU4nSSe7xjMEPcKL8921WMqxEtvJrjgT5msItlO9G4h95B9zGK3QjInYpnYpEwJZ
	LQjbuU/AN5HBAXCCMvjLdwcy5JJyadQsVWdk3cYYYsZizjkAf6wLuR7BUCKCpG9U
	hHrRTqHavhzxUbs/IUfdrgweVEOrBXYj34V5YeYVkWlFnWevqXdA0mWn961QkDy5
	WmksCFFoEiKKH+Vw9S8a14cBMbh8biTDo7H8AEKDHGc7da7g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1j63n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:27:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38de842a1a9so5344346a91.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784179676; x=1784784476; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y6RBLQPDF9zl8nYoyJsquMb5cipagqyhdFtPnoxF6YY=;
        b=LfTSv6Vh7NESonn8616oM2iXPuy/OoNLs0HLxPZtRFiUF8LgRrSofhKlg1j70UzX2r
         6OnSAPBBX+FFwB5heAI7k/yr0LpKLQxtjl0fEs4dADOeElDYNpLjRH/F60O8bOmKE4wS
         EgVryZQ1YN+xn3whEtxLnE5rcDsHuRoYADkWilN1T+pWP0RNSU18WtHsv1g2zsfiLhbj
         Ib+h42bTw10zoEiyX8V8OkDWNIKaDICzldpJOJ1sMQrW4jQ98i7GRBMmdr/X8ayfhMCQ
         W9TsyAsoCHIV7J++36/kY7PFJPBsECHb/9WSJ1wmJkrlSBV6uNBsIreegqEKb4m1h1Dn
         k39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784179676; x=1784784476;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y6RBLQPDF9zl8nYoyJsquMb5cipagqyhdFtPnoxF6YY=;
        b=HBATb0R0vGRnR4vM4RfAr3WJWZNoCxQzHH+elgOQvYCZPBnYQOp3zA7i20Iwia/0dF
         wy45wrM+0hc0MIpg0Jplc/R/Z9G4KFq6T4ElNPRjWlQNjSg5pD3emrtpaMn4+CR3HYsT
         TElCFHro5lQZlsws+1brwhwmAor9vKb2Aqpal3yKCAeu4l8uVyDIukdoGp8jJR5YGyv4
         6dn035pJrX/f0mbJmk8H5x+zeK/ZgNivE0MF6YH7Meqn0ovc1DhuC4iZkNv1kQ4R5U+/
         tZEuh5+a50fMOxm2B7NUFHlyqH6REbOTCe1Yq7oAffHJqIlzHRncULT2Uc1Xh1Nvvqev
         1Xbg==
X-Gm-Message-State: AOJu0Ywkb154GS/myx2D5osYR+x3r1clvHVZryx2xwjH57HhU3ZDyJQT
	gCSL6sCViyNKHaJJ66Mo1c8iAO8bvAPMWVLznFWW3tTdrXiNvQz5N7DK876uPHlUJHRN+9VEpp6
	A+k8uA4+d3moemD1PU9uFLzqd8H13WxrkkKadr5M5Mbc03ZewWfEXDCcCMP13ljM=
X-Gm-Gg: AfdE7ckyXQhC7cg4dTxVWkm5x2+DV4PJQFwaTGr4l0+Ekw3ADEfV0ldAn5GjcMaum+c
	7gbjlKcGCDd8koZUbaio22tNrqF5KBxw4SkB+MG7a/kFlbGRoVhCcpWrccKiev+fv63Jmw9SGw0
	WmW97u8V4uccTheL4NuGxECh/zNtofL0jhXJmGOZIhwjUPDVSrqoUz4N97/bZ+/jywJYSPkLPXa
	d6YbVb/gcYBExiFf6yUym6aqtvvtDyr9Ygkw5M5WylyEa+CQyK/oRm1wic2QzYPhAkdU90toM/q
	/+1eQ8BXKIkhND6OaeAo6jJQdYn9ykN0CO4xN89BKZTWXwiX3dVYhMuQM3XxDb6KFyFXK63OGTg
	iHqDH55yD5w1ymsaKmYV4vZRqF3wP+c5qiqBe3pronEYZs6v/0WcWiNAjdNVO153gIz7JQOBgsD
	zyyo9Hriqi0CI=
X-Received: by 2002:a17:90b:2b90:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-38e29fad722mr4822168a91.9.1784179676326;
        Wed, 15 Jul 2026 22:27:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2b90:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-38e29fad722mr4822152a91.9.1784179675892;
        Wed, 15 Jul 2026 22:27:55 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e53349dsm7795812eec.7.2026.07.15.22.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:27:55 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Subject: [PATCH 0/3] Add quad mode support for QPIC SNAND
Date: Thu, 16 Jul 2026 10:57:44 +0530
Message-Id: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANBrWGoC/y3MwQqDMBCE4VcJe+6CSWsCvkrxkMZpuwdjTaII4
 rs31B7/Yfh2ykiCTJ3aKWGVLFOsoS+KwtvHF1iG2mQaYxunLc+LHxjBONtetTP6RvX6SXjK9mP
 u/dkJ81K1co708BkcpnGU0qmIrfBfbKk/ji9rmZwBhwAAAA==
X-Change-ID: 20260716-quad-ec2765317214
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfX6C/7R0CIMSuo
 gF+MkFuPqZVzUw8pBzfWWLnhRZkOUZi0sVtbdxvo8kIqZQJjNWcg5i2k8ByB4+J+b3cDc7/tUaT
 k0DWuaqUSbCIq5Ry/1BywPRGskaXs6EBLv2WjvxUr41iyUsEafJ6LynnXxKBks/KgmGPhW6zGw4
 3u/topStGnooqVojkW0E8Q9rjg7QmOr5ANS98adxb81HCBMMqRCXQ8Hef3eqTQCLY18oSKCswha
 YDks4rYmuMRq1hX9h0JknmlMofXclAZZSeHABMo97wvgsCJEHPTLX2FtCXmSU9gSnTYfUzAB8kk
 dOTz2aS1FXOcdnb4uK6gV00U7Q+19aQy8RnPH5zR3Yj/R8cqQJ9dPnlvYTgN3fqVIWfqVLAPi+3
 vf3gzI4pW//VMI2m2CSagNvHsAHUvUN0s7yG2h9UbVtNUuLMgQCzO64Z4g+s1YjycnHkP2ZAN8Z
 owuHLvonIMShU6pSuDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfX1ToQDOmWB+l2
 YiKQVvE9pZVKiRCSbyF7E4cE+5P6chBBBhZ0KzNwnIZbyIFoTDyEnHgIrUBa3RJzHTUVMBAuzSO
 6qbWxpAzHIMjQnl/OkPCWNRo8L32ELA=
X-Proofpoint-GUID: j-v09N70rzIdya2q3K-CAlEJg7PkzKUM
X-Proofpoint-ORIG-GUID: j-v09N70rzIdya2q3K-CAlEJg7PkzKUM
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a586bdd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_qZMQ80_SVObjUDSs0AA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160053

The Qualcomm QPIC SPI-NAND controller supports both single (x1) and
quad (x4) transfer modes, however the current driver operates only in
single-bit mode. This series adds support for quad data transfers and
includes a vendor-specific fix required for Macronix SPI-NAND devices.

Signed-off-by: Md Sadre Alam <mdalam@qti.qualcomm.com>
---
Md Sadre Alam (3):
      spi: spi-qpic-snand: move command mapping helper
      spi: spi-qpic-snand: add quad mode support
      spi: spi-qpic-snand: Handle Macronix quad read opcode 0x6b

 drivers/spi/spi-qpic-snand.c | 155 ++++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 52 deletions(-)
---
base-commit: 19827e7930a5511c68e12aac6e4522f3661a1709
change-id: 20260716-quad-ec2765317214

Best regards,
-- 
Md Sadre Alam <mdalam@qti.qualcomm.com>

