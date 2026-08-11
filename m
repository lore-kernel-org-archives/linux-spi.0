Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D343390C8E;
	Tue, 11 Aug 2026 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473327; cv=fail; b=c+xB9jtCQfbn9ni4a3gF2tbRVDdlmNcNnE88ZfyHhQdxgUzT+3IL31l6dTxxqAB1BtE+lYW7ooHc3hPOoAluUX8lfbnyho/8+S7+tBUULAWnjfujqouwe9YkB4xoqLTPqHTMAAL7KWTsL6hX7weJKNj3efsrEtBZTmzSckEMb3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473327; c=relaxed/simple;
	bh=WKVXHJB0AdeEulQEB73WpP8Du4kcQpGopGcbjSG6Kf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLQ3vFoBE9E3nz1+Uq9rOKWfngL1pLzVgzHCR7CH9/BKIj3+I5zGqT+E2EHX+F116mwcKNk8ZP6Y2OVR2S/f6jZh5oaiTndzwIHGjteVKrDD23FkJSY+MkZ7RFABnOUmJJAOavZ1wfwV6kwoGhhs76CexrtQm+DnHZP3FXU4vUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=OwOPwgBP; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QaSaWqvg; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="OwOPwgBP";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QaSaWqvg"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67BGMKDj2014181;
	Tue, 11 Aug 2026 13:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=+X4OnFKe7SEw4gZmEqh997XautkroE44X9Vjvdyek
	nY=; b=OwOPwgBPguLIhSFb5vVzU9xnhrQYa8NflNjXQ7VtrmvZmXuaieAfKk5iC
	+osZgneelPGS2OnZTO+e4/MTxAB77lN1M3N99QArw/iJQZajr79AIkF3XDlrRuEf
	phr8hHm4XAPBP9UEN+gOUe5FbUBn2QChUdRQHM5p4U7Xc85uZfWgvOpsl6WRbTW7
	UaR3KPaUvlpKSbzTrHOHQo/IuvGm5KdmAbVk+406yjmJHuy/Svs5widb8X13SiPU
	bC0IiGoLuzS6++YU+K505KQTiGeOKA3jSSoANEHuk+iWmrdY4oRc4VuduCY5UJf4
	AuNcuRYKhYOEG3Jr21F19YZxUlIww==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g02pbb367-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:35:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDz9fEpdZyBaja33OmC7ZhbauSOlXPDJDxkQk/5jf79DydPPQ1ULH6H2B7ygl/SpxGM2gaES+FCpfJPSFz81KWB4W49UHHsZGo7cMdFOf9Lg8QFFwFVA+HX/KcnzSthKxeOvnDjrlz0n5JnfpDegZCEWpAjQV/2FZU8MvgDNbVyTmiFTvPp7ful4ss7jxQPcq2MbGs5wY3gIovFbYI8PoJt1lh6sKc8gmqcuSUoYh42ajbqv/S9YVWDeB8lNhSjk6YgbqAtLNsETqwatD7lxsJyEgqxcY0QDA6tQYncIkRJX9EQ3VjW4oUitM6l6ZQD05UolsX88ab9P5G4i1OQuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4OnFKe7SEw4gZmEqh997XautkroE44X9VjvdyeknY=;
 b=SjSII1Rtjm8d2Ww10I8zt5sNj1THtbc2FhRXLsSAY6c0OBYGM8n+md2egwtoOFu+caRpOoD+BUFTdYHMb8j1KQJ1DQB76lkI7EmgEPOPltFlB/EWz9twkVcRYOS7JAmBR/+73KkT2OPwcb0n0o1UNqK+M3ttTmw30f6mo4y1yCjvC/DLvelDGx4aD/u+gQwZ7GPKzNwMy/MJ0hBEqpwFJ9Hgt8JV8XRStSkT2Ib6jdnypg9bfhzRlNUvuLT3ouZvOktCtLoL10YXjY/POK5ABFrW06lLLppHEapWSoS3psMXKdGsbK2cViTMuRmDiPrI6zH1YR2g1h9ij4lnE/lK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4OnFKe7SEw4gZmEqh997XautkroE44X9VjvdyeknY=;
 b=QaSaWqvgiKkvSag6xG/fITduWf32NjVrdbTByduDR95N0STWhysqdUszH26zbcSH9vmZ4higapL3IhIlGhM6JqETa5UAROcTecaRYS46GoyqwiL9Zr/oUhzEarbUSETVqixe1Ytav0rtkS/DHiBlYx4Q5aB+hghp8Tb915+lNFU=
Received: from BN9PR03CA0452.namprd03.prod.outlook.com (2603:10b6:408:139::7)
 by SA1PR10MB335620.namprd10.prod.outlook.com (2603:10b6:806:51b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 18:35:12 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::6a) by BN9PR03CA0452.outlook.office365.com
 (2603:10b6:408:139::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:35:10 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:34:28 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:28 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe5659766;
	Tue, 11 Aug 2026 13:34:23 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 13/18] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
Date: Wed, 12 Aug 2026 00:03:08 +0530
Message-ID: <20260811183313.1550425-14-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SA1PR10MB335620:EE_
X-MS-Office365-Filtering-Correlation-Id: ba404fed-ffa3-43f1-b3c0-08def7d746a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|921020|6133799003|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	voJqVUKySXUzmZLNKfZXxJcZCmYGo4H9DSAjTzc0p1uikeeW6FFm534AG1UA+IPfJZjPMIDvHRxaBQ0MMexjjVKwn9r0tDBZeBLEQCO8rlFu2RlmS0A7Q3nBcCVmC222xF2MJoLxjKiADmlwCYd0LgQx80UiwN1wZP10U1yNFaGXzWR92z2WqdhSXcuVze5OO3g9MtS7DUdNTCexCyLwWBuU1Wucm8Nt7oHd+mncBykDRFfx3Nxxe8Ci8EwO16unwSP3DuSWIgu0u6sy772rWjb3IVoSsVz/aQbsF0sraTwekanrsmex4pLD13eGPl2qMyMfRWR/o8nFtPcnlgKzSaeoui8WqdaZwLOJf5xFXKLplWlTXRL1X01fZEbmnEolOzd1fET3Hnz4upn+wU6czTs+mD4TLMZcJzOpFk4Ruw1buysSqeIanwy+aIgK6SG4FxvrO/levy0MU4HakByT6kXmOnynFjByPipS9gLTnjhvlneeyBStUYzx7YW7FdV8JTDlVWUEu189IKX9/FtTaX3VPGDma4SWO6ZaGOL5ztaHiWenl6H5VrzNx9t4GFlEjvU6Wy+2j56cWu5CRPr8w8MydA5pl7pihUrGJsuPJDCHU/13ckz9ttLHmtdBXxbtSCPZNbspMM6LNQ3Z/OXR8pNpLBUoqPjJopOJwo6K+Yeue8wqGvOfG/0ArE3CH30e3hO5P/ukDkCcJ5at2CQjxzCr5py97Aevs2X/inCUJ0LAjOpDvYnMy8G+sC/KFxUt
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(6133799003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jektnbXRyCZvWpVNWRvoBBLjfoKDUfuw5Dm/j0NfkZ06QKJUD/lIQO8emxOveeIkLhJLsvRHbMXhIhPy8dLeoULw/+E4nis19x29xXxsuY3Bw+ELMv99kPRDTYv3rOqtd3hUoLqi3TUQyYjEtdsqxuGCvOT1hkpzTHT46tGQsnz6kf8IJi1SzUf6GHCM6K371uAMXrfQ7naXQSHLnyatQlUdPx8fz2gVwfK10dm40lcTIzFvzaRBDvtk8ivwJppVevjVLrC2FtxJNuMUaeC+otZ3yGB1YDmR0FHVjqeV1Luq9LAb4zpCYqpAaRvSBCIZhuwCAVPYMgmH7Ven0s1n4+gykUMVHIxUm5X5qRnGEIEBnwqSMrIQMKHRUybYjHL3Uodzs4r7eWe1N89/e7zAwr1yIZ1i0bdKgC+cUUOFIVQUKHRSnMxHeDBaf8hgyybi
X-Exchange-RoutingPolicyChecked:
	Nv2VO+nAItBQxyK2Vvnswk1tEXikb74MxFFeuTh1zmibdLj78zOdXTNeBmabqZzZ7AtNhPWptasSti/1iE5eqoDJQ7ZMyS/FR7rvHvQ8Hrfuizp7LuMEL17cy8izVojZH60l1gniCsY2ifuFjT9GcKGw56bZRWIEWfTQUtlY2UH1u1RwQwuACoevwaF5T9C6pO2gUAMPiHFPXab9sDhz0QP5aQeDUiqwV5X2w/ZnvbyQ6NK6JkosbzEUJ53GmhqtA2+m6ejNJb/d1unChhAr7JUQYXMnyM18G0ADyIkzx/znBnNwL/QFHWMRX4eGoXtuJHfUYw/N/U8Ez3anMagPSw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:35:10.7527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba404fed-ffa3-43f1-b3c0-08def7d746a8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB335620
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX7nibO+D/wdl6
 U4Ewh6h0XTbLbO3BGxFzJzHv6LfJtR8UqSEJBWBNL912glq+dXFj0mThXjnas5pd9IYBaR+0uZN
 49W8tjN9cH8BEFdHtYPGqGFJFtLOM2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX9zU5Wc1rUoHW
 VFxCOgRkzNylcUciziJ9LnNVKx3aexaCrzDhXoRrgJSxVJ4WkHSV/dl5NYf995SYpWkFvVKlxzF
 4PYsB6P2Ss2YMpT8esxnHoNdBL77s/577yuI9IdEA8dIkJxjVqme8yrAatIbUwwufeQ0JnCDtpa
 E6XDxqF/T5iBwqmoGUdMO1DoukJrDgoSJgc8ye/42spp8S4d9z1AeQ0p/uBZVlICXD7MZh63k7N
 +HOKcNS01LkF+YRou/G9ykXbOSovYvovvdaKNpyHJAH3t2Oct5a28OwK1M5+II0NR7MODHoJ6QI
 tMevp4L6pM7Tb5WG0sD3ejeY7u3t5cMaMyUIrrRjHol+ERCw0iuM7ssE/16BfLsF46RDOmgdYSa
 1YO2x9CuouYoOXmpVLx1QNP9ZU5xNcqqMFBaVvlnx5ak+jpNLUb4tPfryhmjKduSexrPJv6wl/+
 z6fvU7i3fL8zxhj9wFA==
X-Proofpoint-ORIG-GUID: K5qSrjc4sWTDJhzm-4trZV0fCurNM-OO
X-Proofpoint-GUID: K5qSrjc4sWTDJhzm-4trZV0fCurNM-OO
X-Authority-Analysis: v=2.4 cv=Ic+3n2qa c=1 sm=1 tr=0 ts=6a7b6b63 cx=c_pps
 a=P7Y/ubs9jOqwJofkHNyo7w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=okWzP3EbMLmikBYkquQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

cqspi_configure() only reprogrammed per-device CS timing (CQSPI_REG_DELAY)
and the non-PHY read-capture register when the clock frequency changed, not
when the chip-select changed. In a multi-device setup where both devices
operate at the same frequency, a CS switch leaves the previous device's
timing parameters in hardware.

Split the update condition: baud rate divisor is updated on clock change
only (it is frequency-derived), but the per-device delay and read-capture
registers are now updated on any CS or clock switch.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 940cfb72b946..d4181b501d8d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1602,10 +1602,19 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_chipselect(f_pdata);
 	}
 
-	/* Setup baudrate divisor and delays */
+	/* Update baudrate only on clock change. */
 	if (switch_ck) {
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
+	}
+
+	/*
+	 * Reprogram per-device CS timing and non-PHY read capture on any
+	 * chip-select or clock switch. Without this, two devices at the same
+	 * frequency would each see the other's timing parameters after a CS
+	 * switch, since the lazy clock-only check would never trigger.
+	 */
+	if (switch_cs || switch_ck) {
 		cqspi_delay(f_pdata);
 		if (!cqspi->phy_tuning_active)
 			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
-- 
2.34.1

