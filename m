Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082756;
	b=PGF0Sms8jdlqfhC4HiXJzN/nLckZJhlIxvB93pwemXA5FVYQA3wk4Gs8EjwP+N1D3MS0
	 FUe24R022FCwmMnkqRc98Gzr8U5CECc0bn3tiPKYHwFelYBAXQbUjXYWAaojlKx+LcONx
	 ptp31WYsgyHir8KEVdwghuUj6QNIKWDnbq4+ubQxNIJ1dHVYh36LBBA/tFAdzXrvzKEuM
	 QJeU6sjhAAADcQgbGju37MTExhLj8fY5/tR624dklzgyeibMfruM33zJOVO7KlsmAy2KM
	 5S0ZIVM7m0NOMGZOGl784CZ2POr+OCgEVAtr7a3v/YBy8KAtOqp4C+Eta/zGYUDFLDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082756;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=c6lFbXf2MfVY+hT/4+LG90sdJvphivap16m8VBlsCRI=;
	b=rrtkkeyHy8u25rJ3Ejpg+I25HsBCZzXWbk4qwaTRF7yyoK6ti+Y0HKMaaatkcQHEKCRA
	 QpVHUg5JmWeh50f6F1iA7MmxbgxLVKzwx1pEBSIusOQ2pvFMguWun/OcPW+ruFW7eK9mL
	 fi66XCvEBg3Oce6YHo92EqPSUcw+JO9IrzAyKyEBBfBrEb50lTr9s4l4sPDfA5f4ATm27
	 b3n9qQ9gDoFihfcmkigpQKb9oyajMBzOi1NNrRg9WCXN4/RZt91UG5qLao3WzJicgYO77
	 4ucMe/X/ySyVuuJzfoHtvnuCwOH059b+x9tUMzre3j8wE+8GBO5b/wh/rJvj3ditsrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=l1UavVs3;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=aINzzwfs;
	arc=none smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04267606A325;
	Thu, 19 Nov 2026 10:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04267606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=l1UavVs3;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=aINzzwfs
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9Qqj22057710;
	Thu, 19 Nov 2026 02:05:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pfptdkimsnps; bh=c6lFbXf2MfVY+hT/4+LG90sdJvphivap
	16m8VBlsCRI=; b=l1UavVs3hPguD16VBWm8goDrmLsx/xSeu9S7amrQQbQqT2vZ
	/e0GXsRmDLEvfLV4K6KB22tot3O8yo1PRHEodZMg5ejSv9iF+lDZOXEvwPAMfONa
	is7QRfdWkCWs2WimfPufOAGRb3VH4fhqD4F0CSZ4NMXqvuru4j0AcLnllF9QF0Qb
	wtxYpY1LigrU2VARBQmwtXGEizguPh2nea98EHwjDeVCnNfbKMzjM2beDOpsSbds
	TeDZpoXHwR9MJB9yxFMe9OFXnSbAGJINL6os9PvBJjdhPybEEbBdTRw+u+2PJVQ/
	c8U8BYpQES6lKHgX0VaQ+LEg7HV6Bby74x5SaQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4j1ny430cr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1795082736; bh=xn6JVBvQCjXCiIzNT/47Tf7lmwUkJq6WyBFbcC5SF1U=;
	h=From:To:Cc:Subject:Date:From;
	b=aINzzwfsuiumgsAhkfpC/YXx+e48L85KS9Gu+EGBO5Ze2KL4O+YLuwSkXmc7ByeAy
	 JvuxQw/cRl5Ewjr0mpAHccjcT4SMBz56XeLqJ+HO8yx+A99YdavMpgSm2Jk2NygkHI
	 +ReJ1iA2YGeVXvBezh/LvLMvzajBeektVHrYEW8qdtULtFYk0/yJ/zRrN2zeaGXm2o
	 C4s+1WtnHb93E60BaFK4rkr5HjHjnHCyIBxhAQFd8sPb3F+l1RTEpFku//Ewj5kEwU
	 9Rh+qBklHvaqTJdTOeL9JtoyrsiLzP1Im6jOQjcMc6c6t48vMQOqgVCPfzEK6ttsYQ
	 np46ZQbaUGRiw==
Received: from mailhost.synopsys.com (eudc-mailhost1.synopsys.com [10.213.161.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D147340183;
	Thu, 19 Nov 2026 10:05:35 +0000 (UTC)
Received: from prakriti-VM.internal.synopsys.com (unknown [10.150.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id 9607AC17D3;
	Thu, 19 Nov 2026 10:05:31 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: [PATCH 0/6] spi: dw-g2: add Synopsys DWC SSI v2.02a controller support
Date: Thu, 19 Nov 2026 15:35:07 +0530
Message-Id: <20261119100513.433044-1-prakriti@synopsys.com>
X-Mailer: git-send-email 2.34.1
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
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6afec9f1 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22 a=jIQo8A4GAAAA:8
 a=MR3oNLM8PPuS6zyyqOIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX2XXyA4UxVCV/
 4TMEdIh1L+a32K8yQsab7VbyT+/gxuJhjXVaank7nchQ2yndf6kJE+HbnIlIKYV81kzGp6Yl3CS
 DxqSVzRkAKGPdxtJQXFD++cgAvDvgziEngiYStiDXgZ7TFUMd5xVog7ORgdWIOMzDKtNatGuyT4
 jROWSLTWbpUXmpGEfI7Ue+lT0R2e9IGb+e+qVJHllMk4bMfGkcCcm0Rr2AXO2/RG+2S7GIsYyWN
 Ebv5v6nLoMOV2LsnOx+KszdOrBu7EfZJjsX7QXVPh1hA8ImDPurUwpuU17nz61wsrAKHeq5WsEM
 /sVOtIS1X9PyOyj1sNsIVbhxhJo4KwkRB2aILVVBJogt36CPZKPG9OoVV6ZzA0VC7FHiVFhXrHA
 28PB6PoWdtisLD2fGW7sMqwMLvGx6b776DDODhYLQr6IXA048oFQVm3mFpuGK4XG/Sy3QNtS0iQ
 V00vShxNxPhnR7camow==
X-Proofpoint-ORIG-GUID: PNsa0h2MmJdiJudWzZ2vAsy-0bJll3lA
X-Proofpoint-GUID: PNsa0h2MmJdiJudWzZ2vAsy-0bJll3lA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfXwXl/jF0Aevs/
 ZVhWfwWJuMlihQhNVvGSFC+HyTxHFYRhQFZqPFKQAgPmPfglwJNkRGDvCFZH1+yxRlw79BODUfI
 ddGIm5Qsbem5JPqqhyNZtV1M2NB5S0s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611190040

Add a driver and DT binding for the Synopsys DesignWare SSI Gen2
(DWC_ssi v2.02a) controller.

The controller uses a per-chip-select register map. This first posting
covers the MMIO glue, polled spi-mem transfers (short register ops and
FIFO indirect reads/writes), SPI-NAND handling, and memory-mapped XIP 
through spi-mem direct mapping.

The series was exercised on a TI K3 platform with SPI-NOR and a
Winbond W25N01JW SPI-NAND.

Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>
---
Prakriti Sharma (5):
  spi: dw-g2: Add Synopsys DWC SSI v2.02a driver
  spi: dw-g2: Add indirect read and write
  spi: dw-g2: Add SPI-NAND support
  dt-bindings: spi: Document DWC SSI XIP properties
  spi: dw-g2: Add XIP support

Siddhant Kumar (1):
  dt-bindings: spi: Add Synopsys DWC SSI v2.02a binding

 .../bindings/spi/snps,dwc-ssi-2.02a.yaml      |  199 ++
 MAINTAINERS                                   |    8 +
 drivers/spi/Kconfig                           |   21 +
 drivers/spi/Makefile                          |    3 +
 drivers/spi/spi-dw-g2-core.c                  | 2308 +++++++++++++++++
 drivers/spi/spi-dw-g2-mmio.c                  |  457 ++++
 drivers/spi/spi-dw-g2.h                       |  552 ++++
 7 files changed, 3548 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
 create mode 100644 drivers/spi/spi-dw-g2-core.c
 create mode 100644 drivers/spi/spi-dw-g2-mmio.c
 create mode 100644 drivers/spi/spi-dw-g2.h

-- 
2.34.1

