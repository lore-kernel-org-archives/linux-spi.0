Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988545A2A8;
	Thu, 23 Jul 2026 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804620; cv=fail; b=NFzJ/VE06xT6nI68NFjOEneUzC6h78OBKhT14/X0U2gbwGDexwJJCNeQ/ss/TGCzqbw9YkCf/sSSOxm8GoJlT4al1jewe1KmlQGdVPmUIsQcpnHmcgBoM6SkZ86AvT8ziydz9LbRgv5p4cQ6+TRBRRObE1Uuf60BI7iE8Gw7pck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804620; c=relaxed/simple;
	bh=nHERynUITfg5e3Nh2yAHKyBReZZf4m9KBYLOhEczroA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qic2wvVhCqmC1ZFQJzdoy3aMd2mADKwPUohdfNO3XUBCN5gWV+1KQyVETjafdBG00pN71qLL2eKvfxNRLjgwrnbtkqs3giYQjqH/FORVCcQ4tMp+UwU6v/TYCRFTSpqmNltqTnsv2U5KRgLKHkrUWg0b1Hvc5aNxU646PKQxrIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=l0ds0fkA; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EcS2uiD2; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="l0ds0fkA";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EcS2uiD2"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8t4Rg1974626;
	Thu, 23 Jul 2026 06:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1
	nQ=; b=l0ds0fkA687U/2p2+Sy3YcjyWBwlBcB3gVSe5/093oaZaoqGIBOLk7FDn
	pUr2GGyJYKhkSokHKjqF+xB4ygN2kQL3UaaU8qE0C6LwQHmtPdIQ+Zd61Zegbr3W
	Ll/MntVu22shU4c46byo5qSSJYHohrzpl+JaQr/DLwJH7w2DULr03AqP3fJ7Pkui
	3oDne/ec5bFVHikbtqKyViTdoob0K9RwwL/qxMojki2DK33esvhvdhNQkhCLfhR2
	G58e4zFqaw04O1i08GDHaCLurFI6n4EF3ldICpWCEqRTmKOanGpxOf1RCs6SxGkn
	R4DbdpDZOCz6oZqBnDIxHf4X2hZzg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fjwjbxtdy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sqbn4FSgGvebs54fpTdFd2m86xmQX1O0BhDYhTAnC4C9xVHhrg3/gP6IrfQPJnLKcO+G1moP6jW2N3FeesN18Fc11Xb6PvKNaaDAHke7vY6Qjd6wrWfJ2gDY1aKFs2UmoyoxxTzg12STEkDKnLddxuvCV/HHvMYPuGVho3aNK7v6MGWnnfuSMxx/jwWZR6jcV1PmfAQN9cRknJ1fzydJ2pjeYikRI5cwZYTLCrQKIaNxMBqZ+EEHx4/kj3fC3VtupeVOLHy+hhKynJ7NeY/hf7dEnQtf1F8x96D0ga7Ad5L0Y3cbCSOn3Cpd/0LQtixILpu9OHwMb0yMGE0ZhY7rWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=WgPUa/oFWq65EzdQXAmAQcy7sHZac1sLdAMrjGQQBFGolm5aXhgZ5j6wS5zL9OR0ym4ehiZKRAhR8wG0XdzilIawJFyLcbN9nPAz7DZGmP8oEfkqMWbqdMmximPX3vA13ngiz8N3cRae6IgLREpDmCVIjkb58y4KF3gVx1jfeqHFrcrVVblktSKJnDBdVFKgZDIRexWyM4eX1Ks1qP/QC0CY9No114ews2tU7qjH+InPv3v2LoBirp3LTdS87hPhD7CwgjDZKu6xxhY+QB+d+RsHzfniDWySGLIeS/IdvHW94m0Qm7ZP/+DaVA1fV/5IkHweGEETquR+53TLpPvcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=EcS2uiD2v7wz9OfZP1Y+H42lwh9DjBFiXPEoJiSESK/54bXB04pxMVTmuYFEFWdCOBAEPQusQm1luJowR/1ZHiEyGPgU6mLPnAaHTcJWYYFdJzU8AHO5KnwgnoZeNVj1NFwexuJx18JTzHrEZCt0WLWLdygsAdp4Wi6alJ7jIOc=
Received: from SJ0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:a03:39e::26)
 by LVUPR10MB997834.namprd10.prod.outlook.com (2603:10b6:408:3a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 11:03:19 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::ab) by SJ0PR03CA0291.outlook.office365.com
 (2603:10b6:a03:39e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 11:03:17 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:09 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:09 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW31577597;
	Thu, 23 Jul 2026 06:03:04 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 07/17] spi: cadence-quadspi: add DQS support to read data capture
Date: Thu, 23 Jul 2026 16:32:09 +0530
Message-ID: <20260723110219.3180747-8-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|LVUPR10MB997834:EE_
X-MS-Office365-Filtering-Correlation-Id: d0208192-26db-4fdb-c434-08dee8aa002a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|82310400026|23010399003|376014|22082099003|18002099003|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	Cv7ZAQtvOlP2ZtUff0wnQf3YU6Usq3UwG2/t4RiJZIYMUWg0QAbAnleMeKdQSkkgATymLD1SHVQyCx28rPiVQO9CgVTyRtCSOEsk+1iNBFTiUk5qiGrq7Qb9Nsfq5UVOgZG9cyeuZo5Q7uNxyv3KlNI9nKPeYcpf2sCKGjBGmcJtfHPAkSigTRrqjR2J69B+rEfLh2JYI7M7C5kw2NCLRscgt+cjW3u2uKoCgLr/rP4JG0tyxm0tRu67CHc6BmHywKZygwShDuH/N5eYeidMyet7Z597LwvCsMA1kt0ZaeMl6hWbr8DFx3aAnT8bwXxkXj8VxkUrlEQ/1ggFQto2D08sm8eVx7jTEB7e9NwzyjCjSFXVygbkedwh/ZnC9L9jepbN56nldaJostjr7skkNeS0QojCUU1ySl9fmb8eA7fk8MOBK+sNiIYlF9sDZR50oChENxnWAdpzexUbsgP/6ovAkOKmRET1jHI1aExZKb3p6YvaSXEjaLUW+fSV6CQh5RhowBXWZaruWOrmV8QCDiBhzSJFWjr1nuDQVtNXJ3l8rFrt/YozI4UqttEumOVaoEUpF/E8YlOGGXbogqCHp5XdkQfr+7cXegEmyT3Ix4J3jjG2I9olVndjn2fzJnpfHZCIbJevpH/8XGMW9Rxi+giaafk5TUFdzkuA7HMpgLcfJL3AroEljqUjWYmN4IuGX4O08OmQ3kEkC+g65kshpZubhsXVlNoApED7zKVqwl7MsYmWsmIKVEGAqrYOygoa
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KYRUovfIXF6Ppe1MdljVkVMm/U5jbfqizfOCCoTn3gX9SgE84kpX/PimrmtwWAwcWWk/P5G/PfwB6TpeRNZX6BDlVcK+l+qYBrEyf/thAKPdIrZS5hS1AMgxbB2PAF390OMGsLaITX+EPcxozs9OqSUBq7Mcx9gMYhCVuI/J1g2MJtwSci0JfEQglL5MlRMpm4G3T/ZKDowktCnihBRj2mpbPiyDuZCSi3QEnvlvJDS/V1bEa5UWXJ7MHTMztdWY75pzK0dCZDADHUCi3LmiLzgaSUjFqHszix4YxvymjORvsjLt6Bw1RouyWPJw9X1F6VeDTBpPRtsg5l2Nqv5Ku9B3Z4+WBGGq47gxaPO7mKK+f1ef7lb8l0WFcJYpyIsbeUm7RzzjE3JZ7zndgFtZPPT3BqGNRExi2L9TLKd4UD4oj4gJzSzYN+LjUsmkuNI2
X-Exchange-RoutingPolicyChecked:
	QRE2jMYMdxL3yNiZWYqLjxFpCJjakPKcPLJi043bKcbMyRC82bePsHlFd33zpnk44ZdRy4mRu7hH4o3nftyVnhWtWM/E3BhQj9cFAG3mVntZOnVSR7FITrIqyHGWzuRNYEqVKfiActaPdP5NePvhJ1yoI0XIoyWbnJMOBNMVQOv64BnVeJi3JZ6rmo1y3IKkYbOGLKUZdIvaediedZION9XpEkFlNRSxsZBNsDCi7DDo1PCBa6gQQrSrirCHhhIjUArwrc6yfcGE8IQiq0i2OqnlNfZyvfwpdZgFYnBaHbGnJDS3a60YgvufbiC/z1PgGraxHcF/xGUB1UObJ201Rg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:17.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0208192-26db-4fdb-c434-08dee8aa002a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR10MB997834
X-Proofpoint-ORIG-GUID: NVPHXPnJ-m9BXuMLo-DOCjzgdNx0zvS_
X-Authority-Analysis: v=2.4 cv=LPRWhpW9 c=1 sm=1 tr=0 ts=6a61f4fd cx=c_pps
 a=BToDjy1G2hQwEUS1Uhc31g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=by1YfaDFVIW1-MDklf4A:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXwvO1Yj8o1YhJ
 iQTK51q+ClbWlZaQiDigeU6lp9OB6jimMr6V9cvdeexqH7V53CHDUSrsaawygArDeUukA1KVjT8
 IFeBIS97oP5kkLRISRrGV+UW4R8rmLNr2Tuag3+zVZZoLZCc6zxCQCZ2uqeaZncWW5SS2UlzSRZ
 SEa+h0HuK1YSeI5p0rz3RAbxtikuV4UofAxKS6LvSItInmz0guVjBvPBjFPnw9XJeQ4zu3YVxNV
 l68da5uJJEzDV5C6nZyvgBAbq48iL2jHovsXM7nmtPv2Ual74GuNBA3lx6OsDko4XhRnnkV9ykQ
 nj78ABcAxXCwdxFLdhAPSUkq9Tkbjd5QhjA/DCGrEkVleXh26LOMrQNT29mXUO70fh8Y2FoRtyj
 3MwvLeXKuIs7nf5bzh4XfzwJo4Vkmkrbv/RJTaFYxBmicWR3Nknk79dirIWA05gmColx7UWM5Tm
 Gjs2cipRK6JJZSUa90w==
X-Proofpoint-GUID: NVPHXPnJ-m9BXuMLo-DOCjzgdNx0zvS_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX/vuGwT61jkmK
 H4NLzVsLeTet0pQT6WkMSbnBUk//ilWUYsc6EUmmM2MzBtlJXFivrMke+gc23BbWQn9gRVM7hBC
 lQonN5ceZi8QNj7tWfE2SZH8TcgbZlo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Add DQS (Data Strobe) parameter to cqspi_readdata_capture() to control
data capture timing. DQS mode uses a dedicated strobe signal for
improved timing margins in high-speed SPI modes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f8e266372367..046fa5d69b0f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -192,6 +192,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB		0
@@ -458,7 +459,7 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
-				   const unsigned int delay)
+				   const bool dqs, const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int reg;
@@ -476,6 +477,11 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
 	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
 
+	if (dqs)
+		reg |= BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
@@ -1317,7 +1323,7 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
 	}
 
-- 
2.34.1

