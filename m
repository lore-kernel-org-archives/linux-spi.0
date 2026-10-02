Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE3418A2D;
	Fri,  2 Oct 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931380; cv=none; b=nCXqztj5XSOgE5UDGDfBWqA5rsdP9aLSnW53HiIn7lSEQpNGipJmX9KA0d4Z1XKw0nS6r2vsLllw9+OLjN7n6zj6G9NJ5MzwGQRSysq881can67iozRgL9OIGD89sNHDKX8lr5G1t8CQYRtQyruJ6Dpds2tSu+rlzEMIdiVJvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931380; c=relaxed/simple;
	bh=5fH3iwFmjKTR4dD+k5aX/cl1wka55yWtQa+NwctyYkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=as6it+ZfGcv5nzL1C1LekQIEinYAQIOpWnYjbTP1AWx9CN41clAJG23pJ9+0V4kEKKE77wW4rPm3jJQF2hHABrGG3kF9Wld0zNjLc4Ex2RCYm6pX0RC5iHx5wTXfMpi9J2xGuxYf02pIPYrKQ8l4UULZW4g/4bY3NkQzEZGB5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Fdog09s/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Fdog09s/"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925m4B91818453;
	Fri, 2 Oct 2026 04:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vGEAg+FMsTMOiHSqsHGFpGXF1Fy
	W801R5QJ876ogRPc=; b=Fdog09s/Zb7iwrdw2QXM6p2YsScR8paUpvmA55Ztx0B
	ObuKsfTeWvfCNYhhKu1SsTZYFbYHqs8Ltwhj9smAPmyfcbIU16NmMydGVePcofcX
	zCnb4qdsm1b+BoPu0u4aQ4t7CPTXWNka8QTA0a2e91qyLMQLJv7ySOAck8/TonVr
	SkUwoqhMD2omxYv9Z48wurNYzP4dudHAh1TbCyLwOjNHVoZZmIR69M2g+WgP5RUl
	xBtfzOdA2efas3UxWkEgLunk8u8p6WAr2ER1gljUx1nLF00CVcXQeC1y3tBhwama
	17uzh76R4BUFN99G6EVSW41PT/MqXfOOe+EiT85K9gg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h1hy989xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 04:56:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6928u1S9033085
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Oct 2026 04:56:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 2 Oct
 2026 04:56:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 2 Oct 2026 04:56:00 -0400
Received: from CJONES7-T01.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6928tmvN002158;
	Fri, 2 Oct 2026 04:55:51 -0400
From: Carlos Jones <carlosjr.jones@analog.com>
To: Mark Brown <broonie@kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding
	<thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya
 Komatineni <skomatineni@nvidia.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Carlos Jones
 Jr <carlosjr.jones@analog.com>
Subject: [PATCH] spi: tegra114: assert CS GPIO for every transfer in a message
Date: Fri, 2 Oct 2026 16:55:40 +0800
Message-ID: <20261002085540.1625-1-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNSBTYWx0ZWRfX5JmZ2O4dRVHA
 cgaJYrJOqb3ciJRDhauD0onbyh2jHGT8HIuJwcN0J8lVbasevvzeMwZyDFBoIv8nuZQEjvFFWz+
 0P62jjmjMMxFey2RtM3hIcweKopq81/4Cx5cJmxaIrLrM/mnYz6O
X-Proofpoint-GUID: JWO_s6sWlJz9TgsYBvaJYOgiZAilNxZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNSBTYWx0ZWRfX3yUhWxAVe1fP
 prihB7rQ94r4EdUsLXh7o5RPZ8j4lZ0uAcrkzawWPVBs5pb2e5yhrhhwoSPSRBYuJufwFnl0JRI
 ZSyzMuTGaNZdD3/fU/WbW8SQg5wg9iQgG9rgwDDi8lC+51jbs82bXLmgglgetfzYsYMFhn+eKmc
 4IDc4bDCwV4dGIAV94ZZcD6iJ2/Hie4WIVqqHZlGkGi2KOA1Gz+ME4Vz8nW3Z0QBWX4jTy6IiP/
 w5DdsVBN6B+tmE++Jkza2Jp0AG1fC7JeotvZbTH0jjvMJnZTaMLFSF/y0vbiUkrP2+fdZ7wjRve
 PEXeNZ/45XzfZFKU6yqccWwFtoL2qLLqWQtVSgR3k/wUbeLF/DD0L/Y70ZzroZFB4/Zc/MtaFug
 gvdYBOqPmspRzzTtC/WrP3p9V3D63I5ns3Ni7qj7z/uAySU2cu3ilFOm7jwMUje0UJVH4DE//3x
 bjuuW1YKZfBXVhxvMyQ==
X-Proofpoint-ORIG-GUID: JWO_s6sWlJz9TgsYBvaJYOgiZAilNxZ2
X-Authority-Analysis: v=2.4 cv=Vftir1p9 c=1 sm=1 tr=0 ts=6abf71a2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=H6mhVM5xjDqGWgEDBD4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020035

From: Carlos Jones Jr <carlosjr.jones@analog.com>

The driver provides its own transfer_one_message() and therefore drives
the chip-select GPIO itself rather than through the SPI core. The GPIO is
asserted only in the is_first_of_msg path of
tegra_spi_setup_transfer_one(), but tegra_spi_transfer_end() deasserts it
whenever a transfer has cs_change set. For a multi-transfer message whose
earlier transfers request cs_change -- for example a register read that
sends the address in one transfer and clocks the data back in the next --
the CS GPIO is released after the first transfer and never re-asserted,
so the remaining transfers are clocked with chip-select inactive and the
peripheral never drives the bus.

This was observed with an ADIS16470 IMU (adis16475 driver), whose
register read is a two-transfer, cs_change-framed exchange: a logic
analyzer showed the data frame clocked with CS high, and the driver read
0 while the device drove 0x4056 on the wire.

Re-assert the CS GPIO for every transfer so that multi-transfer messages
keep chip-select active across the whole message. gpiod_set_value() is
idempotent and polarity-aware, so this is a no-op for the first transfer
and for messages that keep CS asserted throughout.

Fixes: 63c1440596ff ("spi: tegra114: add support for gpio based CS")
Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/spi/spi-tegra114.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 1234567..89abcde 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -859,6 +859,13 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		command1 |= SPI_BIT_LENGTH(bits_per_word - 1);
 	}

+	/*
+	 * Re-assert the CS GPIO for every transfer: transfer_end() drops it
+	 * on cs_change, and the assert above only covers is_first_of_msg.
+	 */
+	if (spi_get_csgpiod(spi, 0))
+		gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
+
 	return command1;
 }

--
2.43.0
