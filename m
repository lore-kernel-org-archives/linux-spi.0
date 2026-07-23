Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167A45DF74;
	Thu, 23 Jul 2026 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804628; cv=fail; b=oGsZksMtb3F9XruxycKcoVjqJWNwtLLzXXmStcj6xFxMoO4DtihFtI0RCgTpX/ytYbTSKnZgi4h+kXLnvhmfk58aUY+a52orfOUSGfPgWVo4IggLckehu9ME+yjMEEK9UkpHKNFUNe1MxnBqVsAAUMXKvMHxo9Akmra6jnwyiVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804628; c=relaxed/simple;
	bh=r6mmBI47kM6LbC2TeTm5XGDNze+9ICvcqteBVTKQmZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy87AdnBBAu0vbuNel4K9mpOx67JE6DjOPYhrx7zTg/RkN4uJ6ievtoie+tLW+4exgOduHFkMZMAQsDzvD4nCbLkmzoFrICTPEuB3pYB8H+jb3c72COvTOmjXCp6oRomXjHeb6YJTGhfqOa+owvOOBndOmq7dZT9OemhJ8M5SAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Ob32Ofdq; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qdtNu324; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Ob32Ofdq";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qdtNu324"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9I8xa2039510;
	Thu, 23 Jul 2026 06:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Jn4J4+v73YafNI7rjY+a4Pdbl5UXyUH8s/LMgvnmx
	Js=; b=Ob32Ofdqu5D8YdQQkTgSQcOjcOdIkpRjd/u1lsoeqccSmu7oj2b5wBJXI
	wAZTe5I09QGDVGkB/HNyzFGNJepLskslKzaeyyNtlY8H4o43QWt+JKCBW3Nk/46F
	4lmfTte0Wn2egyfMSRKexiseFDBfsNexMHF38lbJH2txZ9Kt+TLfGSFgvOY1SPkm
	dWfnq8KyMXQ0Vkb+vk+4BgGbFVcxEw0XWtIWiAJ3koleMynVMXyGxVhSBzNHz6ME
	WdiLc5jRtdlbSQh1YAX9ekMussg5hYt0hGj9kfXXFOzmkHKU/ajvBuursxMPZQVf
	uEl5DUCF6fkK74wVnSr+DVpsuNfMQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkg730c64-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8Xf5fadDUWGdWug1BKcdlmoY9ji++meSo3+uKL5betB9jx/HBlbwTedQukbJw8J1Vm6ns2XyuUOq+4hiN63cCC50b9M5QWNXezLhu0f6Vb/INrQmB0FNkHkmL7nWnN3FwuUYvEV+nKPUMqdVrxPpSFwoW19JDl9aR9PRJlqpPkCy135cOWUR2icB2lFQY6q/ss7oRBqYHZ+19gBmfeWf4qO5XpqMdXKeYdGxNuLD/xk9miZdqYeLydEjzpx5sNlEojWSclT9AptV8j2hEl6p8k9eYCjhTfr0ttB5nDjU0k/Rtz0ehDfuFMhjOKazjjLwvzrrASE/v0MOBcV8O4x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn4J4+v73YafNI7rjY+a4Pdbl5UXyUH8s/LMgvnmxJs=;
 b=Edw7XoICT7eltRWxNMiyf4GOtpr5WGwCWkyIO3dxvG1PATxHFO8RTLhO3KXW29FZkYmYqyydpHJd3gFQJFCYx8RWlTOtG6Zz/1/4IYL3z4Y/ZJ1qgZFNaGGiSQpA5Po/BWTiWPT0IUuftu8rI02QRKn8HEnXjLqVWxCGN3ZKLQMh1Ofr1+bkyEHFY9JVTZ77RHv5/Ld4xLKNqqxZ4YDYdQz5swBeq+B0vqOGyl2y+tPY+zBJo+UT9ceRzGFJVWVA02ytyfVYZDdqYLIH/ZPud1z8HEbQ/hwhWw+x8dVdirBSS1aDohORtdVi1gZVzLqLB89eep8qq7yUif8hLf+6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn4J4+v73YafNI7rjY+a4Pdbl5UXyUH8s/LMgvnmxJs=;
 b=qdtNu324tj1MY3XtvPSFedP4UaceXIssFJB2pG8t10VvnRk79d08Vo+85UQFuRt9dUH6kMRKWBjocq8B+pxNywvx/GmRSENSdCP6y3aapQ67Qdk3PBm+/Vk1LC8TizpfuP4wv0fNGWVNDwQCAL++DEguB8K3XNl9N25awU117N4=
Received: from BL1PR13CA0171.namprd13.prod.outlook.com (2603:10b6:208:2bd::26)
 by SN4PR10MB997898.namprd10.prod.outlook.com (2603:10b6:806:4ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 11:03:30 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8e) by BL1PR13CA0171.outlook.office365.com
 (2603:10b6:208:2bd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 11:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:29 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:25 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:25 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW61577597;
	Thu, 23 Jul 2026 06:03:20 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 10/17] spi: cadence-quadspi: refactor direct read path for PHY support
Date: Thu, 23 Jul 2026 16:32:12 +0530
Message-ID: <20260723110219.3180747-11-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SN4PR10MB997898:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c146c5-ff42-4692-476d-08dee8aa071a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|56012099006|6133799003|10067099003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	tFumcifVa3gzbBGPdI+3uCxHc7A1qQ8uBSVmuhTTNMQpU/CkHS/RAmx9OrfaArfiPlT+Z42GhVbmMRjqWF0tLru2QwGwob31ySqi/bqLmq46ZxFXTlDR6lCdZX5k5EU40rZuPLnGsIJB35bAxE7EZ4aky0OuWNJhqS4S4fPdTUshtlFeqP5F+Mobgp+I6BQjkRDWecviXKgzB6MiQC6lJ5lp4OXa/4ui0+LTJXBrnSgsfJkq9zUMj/RlR4iXWZ7xfILoVC2Qs2MWO/S/A4C1WjbZK3frM0vJe5SmKMylLwfrLnVGYZMANGLpXraJ1BcX1bXdk7kvicHr241xOWRyot1/EEydOsTBEiBVzDHfCaYikWxbnjY7UByMGaiU8fmHYyoqqKET3P5RwvMzmshArMEGSWK2HqQFgfReePW3E9UlNOKK2n4yOFiVEWL6+CfeDTZY+6UcdzhVT4Q1ggaOpDZNKd7zXZ7R1O6SSxYOnR7SReGiR6EfL0QI4xFIrTtbL52ezUAwAE+n3Dd3moHTi8euyt7n43b6eZ7zuZwufOCbfFpMe+OHhGSz7X9EW95X4DzAXK6LqY/GYQdaW8pRmjz2hf/IolKPakx7hBS9qatrpNLTbr1l4UmyCLVx8mDiRuAAn9qycEdo2rOWob5cLt17e5pMqtiw4QqYdvN7vUZ6rB6oI2bJRPMPUz/gCHvP4DA7KEqqj6uugco12IGxuU2Mwr+yUaoz0E5Qlp6Oh4HMly0OHBL5p/4trKhLE05X
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(56012099006)(6133799003)(10067099003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9UKX5ke8iJpssNyxsUJyxGTxA4gaJYCbxyGXaybtLSs228uspE76/HieFomCVYMvaC4jk3Gzvj/P4hDQ11EXdztX1+h2LzzSXpih+KVnVgG/CCvnnz22cnDPGHamTNAa3VHpYwSdvuMTpgIpXZo24ncnK3F0HhVEALtB4bQl3CITQXdT26bBpDlwSs+EMlTMFahtHrcNxZMIJ9wkGJXWgIDC4ZY2VGR5seObuRX0qtEX8y+k2U/pQQ6146FtfNLHPyMNRqDjJpCfFnKPjUFlzCGeQ76/f7Yb+Fc7FBh9fQ2PzQpfTEYICo3D2Q1hoFJcoaYii846qE2Tc4NI9fLyJbRJ06dc4lp2g8JZi8JRzJAJtjWAFXI8A4kweo9sBetqeVY3LXK/Nw2SURPALuLzc3WI/A7wcLtvhuSvTU4sXJQQPLApNz5Iso+2A1zPElVX
X-Exchange-RoutingPolicyChecked:
	rTlUipoBXeBjvQZTAdRFrwn4oOBVtwoqoPmAZNZ0nbMoAsxKBCQcyu2iCVTzGyGGcQACpMOxz19ghERFJ4z6B1rcD67naRcpsJzP6/nzE6hDlPJ6OSX0QKQs+PuU4uMBWaGfK5hDUEfP8bUUNwTXTV0065ltsDtFRTtv9zvsK/MbBPOSxhAwwairdkZtuznvLJVtjNTWo5CWYSUO7RrRXy76vl68JnRwXa4oW0uT/6/0wiTMcZbJZxZKpEbST6cnOzTzd1zB+K0aYmiOYFkIxJUi3/tttR2IfG15+KR4F2CSqRdNT66Aee4RQmfDj4jd6FjOH8LoZjfOye2WdT5+fw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:29.3299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c146c5-ff42-4692-476d-08dee8aa071a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB997898
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX03bNA50+wJuI
 KLnaeOVXqGFREOCHJ4b3YVVs4q8wDt2PjCTa8vJqfqT2unLF/tftL/x85NoBmiBaxhnqk3sWNJp
 YnOYjVyhqo8ynZu4BZGXL6ai15W6bYA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX+LVL0mwJibcs
 yLI2zO5mdeRU8E9hER4YO+x9BrhKdi+CGQZ9BD4lLxwz0tDPow2ayvGbqZmmX1n9CndrypAObET
 cGgQUvHExYQ3USODRWaPQmj93z1kk6WptIxord/t7E14aCla5JN7zEyrKgo/V3Ebp2lZlOX/7RN
 v9eMiSpjqOTmQg476qi21K+nb5piH544MIIVrMk3LDgLbfPQbHEFLhIKjJQie4uXThPrBj9M03k
 WMQXQyVa/bq5Vzn4+q+v0nz3eCZ9t6ePrlhc6PEy/al4AaWGs/cAi7F6I4wGbTUA2/IwpiLJF4A
 YCHNBvWY5fu9ZdznOTMShye0UvPzJM4cNrL9KYHfdnmI00dTQvN0FuyKa4qEQJ3WMtmLRe7Ladp
 G6JK+07TAQJuxL247OuZlbozb4fAwj/V7vkI/46nnyRPCF+zquwg+DMe8uVXR0aiLbbYZH7EP9Q
 T+p/U0med/UDj+KUIbQ==
X-Proofpoint-GUID: svFy4xc0-p1e0e8Kl1q7TNEdKrUnh7vG
X-Proofpoint-ORIG-GUID: svFy4xc0-p1e0e8Kl1q7TNEdKrUnh7vG
X-Authority-Analysis: v=2.4 cv=Z/Dc2nRA c=1 sm=1 tr=0 ts=6a61f505 cx=c_pps
 a=VvAZzv+PhNtEUaR8E1V7rA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=kQoCic6YF6TU8Y4tUr0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Extract the DMA transfer code from cqspi_direct_read_execute() into a
new cqspi_direct_read_dma() helper. Add cqspi_memcpy_fromio() to handle
non-DMA transfers, with 2-byte-aligned I/O accesses for 8D-8D-8D mode.

Change cqspi_direct_read_execute() to take the full spi_mem_op and
post_config_max_speed_hz instead of separate buf/from/len parameters,
matching the interface needed by the PHY-aware version in the following
patch. Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_read().

Transfers shorter than CQSPI_PHY_MIN_DIRECT_READ_LEN bytes always use
the memcpy path; longer transfers use DMA when available.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 72 ++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5070ffc53d5e..322e95b3bc17 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -151,6 +151,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
 #define CQSPI_DLL_TIMEOUT_US			300
+/* Minimum transfer length to use DMA for direct reads */
+#define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1521,8 +1523,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1534,11 +1536,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
@@ -1580,8 +1577,61 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		unsigned long from_addr = (unsigned long)from;
+
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED(from_addr, 4)) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/* Use 4-byte reads for aligned bulk (no readq for 32-bit) */
+		if (count >= 4) {
+			size_t len = round_down(count, 4);
+
+			memcpy_fromio(to, from, len);
+			from += len;
+			to += len;
+			count -= len;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			*(u16 *)to = __raw_readw(from);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op,
+				     u32 post_config_max_speed_hz)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *buf = op->data.buf.in;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-			  const struct spi_mem_op *op)
+			  const struct spi_mem_op *op,
+			  u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
@@ -1597,7 +1647,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op,
+						 post_config_max_speed_hz);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
@@ -1625,7 +1676,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op);
+		return cqspi_read(f_pdata, op,
+				  mem->spi->post_config_max_speed_hz);
 	}
 
 	if (!op->addr.nbytes || !op->data.buf.out)
-- 
2.34.1

