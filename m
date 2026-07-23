Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDC45A2AF;
	Thu, 23 Jul 2026 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804648; cv=fail; b=qrfbtRsFpQlDH4GucpO8Xx5l+yXo17SNEtXEzf/tFMIgRCeD6JVpR/Kztdh7dCRXjaLNdps9Z46NDmNq6iy1EDFqkXUEjzLeONyd5TXb15m0X/1XOYEqU5qg1hwUbhRYYeMvBuyqFoCrql2/tJLoAl3LtLfpTl32BaW2jPuTICA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804648; c=relaxed/simple;
	bh=pIn6FQMQVRmpAi1OIWqN2WjNohkALTG2Vfo107304pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRNclnlnLzmqDgR70xU65VpSSF5/Rid3yJkTAFb4XrG0m2W35Fy53WY1maZzI9AScKKv02kciyhMv9QNtNFCRXUKYrdgpoOgSrzFw5Xxms6rhWLEnK3OjzOGwsv3Mwx7AL6slghlvoOrXztwtK0M62cJgBse5/MTm5XVRJyGiJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=RiLErUiX; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KazrTWR4; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="RiLErUiX";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KazrTWR4"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9I75I2039437;
	Thu, 23 Jul 2026 06:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3KQVMFD538yJ3bW7oX3qUKzdhPkCw69tpRcHsh0Ql
	kk=; b=RiLErUiXOjVTE1mrtU/4/mxY0RFAEbeVIKGfDVL6GnGv7Qx4Te0aVQQYc
	sh9NdovyhrRD9KaLv56TrQcgVs1cgpd8J4fRqVUGCeML0Pwh7WgyDPPZvOJbWWy3
	kh8G3frVsaV0BPryTBKsTWdDUQOA5Y8HGQd11gtEzGUWkJQLbwDwJFU5M6dYCBRq
	CrY1mBikJ5neN9HiHjtvYkRwjdLcQBh0pM/O6xw5y/YdPJAthUiIWpRUhwvw2kLc
	wTQd4fL7Ou+A2N9r6ru+koXCb4H/TBj+Qz4oCB/+T9fKhr8Ocdr45zKzTiJKEbBD
	WBIoBmlo440ZtHDvQiMAaHEEomeSw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkg730c7d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfDK02choWBPMONf9nV1d3tdg1hQikWHYNlMVljJianx/qwNgb498m5j/OjeqCNAbdCGOIgp1XlKLZo7lz2QI8Dy8eF/IBJkOIslsyc1u+B2eh0G4ZK78+1p7dpuMEk+N3sNuS0v8Ie1O0hj/Mg/ut3Fbhc2AX9Uaw1jD76KAJtcoBlsaztGZoZdoHBYwjb7EM8XPhaKMAEeHvlHZJHKE7ukLiXg6HTEmw9O6aG2s3SqHUDumaAzpZgCaAnVFhasg4G9n7I8uuMuVR6p2U1UAxmt29OEC9IjzMpXYns3KoVWN2RbdafrSdiwosqjw5OhiXpQqUHAX0iTh3xL29Db1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KQVMFD538yJ3bW7oX3qUKzdhPkCw69tpRcHsh0Qlkk=;
 b=itF7KtdYB42eqC8QyqkucMIgLkcqCHCmtfqqBH29Rb+dsPYAN+4JJCzdyx8csv8cu8GxYL07kxK0SzD0wrb6dTW+svfHvRlenUF/x0oKIbK8xeFCyBvS7hjcZXEj3a6QEFC2VlRZ68y+N/Ln/D/NcxBIste54zghaniN+/0JAdmcs7Hb0jatqRihUPh4px3i6fhcpeQY8WKC6zwuxBWku3GBE24+k+ec4UwyvZLpL3V5vINqXCcrw+Ac9swA90dr1MdGXNdu9/Ng6nznm5MYHkwsUnvul3Unq/KqZq5VOOpgEzlbjAv5CDOqkyWbLtRZu4RDEgJN3XmRCak6TVpu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KQVMFD538yJ3bW7oX3qUKzdhPkCw69tpRcHsh0Qlkk=;
 b=KazrTWR45QP14sA1/M2fcWHI/q2UnDnT/2GiciZHPN3bfw+Fxim+QrhpS12fzdrO5EKvzmdAam+tRp+oKp6pSsauKqHXv0kIjdIHUy1Z5R0gh8/TBL5aNKWglzhsp1/9J9KsbyK4jdXjGTIEiy6gfA365OvGZXayDt1VBxJrKn4=
Received: from DS7P220CA0081.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::6) by
 IA3PR10MB8759.namprd10.prod.outlook.com (2603:10b6:208:574::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 11:03:43 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::3f) by DS7P220CA0081.outlook.office365.com
 (2603:10b6:8:259::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:42 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:41 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:41 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW91577597;
	Thu, 23 Jul 2026 06:03:36 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 13/17] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
Date: Thu, 23 Jul 2026 16:32:15 +0530
Message-ID: <20260723110219.3180747-14-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA3PR10MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 2908fc95-6c0e-4362-d5f8-08dee8aa0ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|921020|22082099003|18002099003|3023799007|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Q1m6kMuvHskOajIKfPooGQDv2zhnaTQzuVRUqqREHzE+4uND7Hc7ad8zP72EqoKYuS37WjNXLotDXfS3uzwU+7K2HXi4L7GSBV0J1BZALmG+OPRqPvkE3UU38zcrUln6TrebICvdvqmU4SxWACYamjEFiSNX5D/wn/lz7gj5wkpzgnLl+JIr0X7MVExtkVPxxMklV7fXwQlIlL7/7pyajk/orGzqKSrQOSdDL9Q976L2GdLWNF+Vm3rVk5GA55KdvYAl9u4UbNdmEzXOORiOk6GbpC6/5A4M6P6Rl4ixhT8sl/L8dBuN9GjSAUuDG1PUsPOwvjQBi8Si43H8xgunb3GpKUn4nn6lBeoUZSCHBp52T7kXX6+Ju0qQosj3Xw0Kbg/ZSsxmqf5UP1k/hjDUxLf0BhG+V9NOS04ijXpvYGI+iq9ac8TKGa6R73o0jBwI3i5CP8iyD9aIOJJJDF8yvTckO5uwBfTHygwyxxJM5NQIKhUG6JTe8oRKFPMuD7O35ep5TfM25fF4coQUGz28F2UxjybqU+5DypaH3Ov2gfBXAAjIyDR+Xfm5BcnGI+uT81iLJWhFu9pbzDL1VTUZfdUORTwkFAYtBCyZUcRSA6OHXC85OLS6r2l6yrzkN2SAu8FRPb8XLxZjqF/NhVPO5yT7NNwD3LMhfCBEHay3TQGW2uen4KABt3iRkim1V69iy3rJ6ESTmBNOCxpZ3fUup7NbaUEF+ZxjVntFL0h6npWf8fysF3yLX4XrIaopN9X6
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(921020)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	14aJnfrrf7HXFNwIS8042HfPbaHT5VyEnKolpMotz8ebM4X6TeAMnWwRE1db8Tzo3CbMkRo6otE+F4pKVRF52VYu3xqonIdDcOqu8f6lORP2q2aIZKQ1f9+Wt7Ndr5NC98vCqWSZ2/m2j9hdOcALURaQki/jq4hSVp7D36GEM/527GPJK8Jn5vef1duCiVD/n0RlJy9pVjdysWIK0C7l0GNcS4Hgmc5Sp7E95KhdVe97oelhYtKFpNz4fOc9FOKI0X3oEtimYdX6OJPrSxpM1EtnLqfF2aAL5XixGHAEQZO/xxPMayoW7Ajrhxg715U23ZgDG4oLGU4T6HVECVORG/VFKvb338g1ltv+hIeNW3tlyldQH2uP0kHFzemC+1roqsMGAfo5SOcirD4m3uN3nn9haziBN5Sf8f5L3z+JFVrb5XdNzM9YAHlZIrGyAUfw
X-Exchange-RoutingPolicyChecked:
	QEwjnXUYgpbzmGbOsWG0hbApF6+z/I9BgMsSbhEa+aU2WKqZBoyUxOSX/NlVgw0od/yTmcTea2ng0/q+x5Cpz9/LojP4L8BLrEA5CDX2aolNb9Y2121Lt/aeqDXR3WOv4LaKJMB50sLhWDiNJK9nEw47pt98kx0duhs+GF1PLoNjQJoiCYWlUB6AlpFyj5DJMdIwGiIfW7/oyVZ/9AerZFf5+8emdE3nKdtugCJSX//U7lMoLpq3/gtNuQvuOSnFN5+l+Qeh/imaEb2cDiNzRLGLc6GtHs81QXQkSkZU3BCTSUAbUIRlib29XqyfbxbIQeL9qs8uczQ3vI1rgJvkNQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:42.2381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2908fc95-6c0e-4362-d5f8-08dee8aa0ec5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8759
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXzbOFiEMUeriz
 89y5RSeeMFco36LeYP5QVhRS0uCQo/CHqe2pzD47Yiwe9/f91JNEbvp47cVICw1VI/NMn+0Q73j
 pWAllgB+sDOaMP1DI9sMpPtxdCmROeA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX8HydHqMb/nIU
 CUVvHBzYsx9hJ49tkSBHAyFsplwq85mNnc946L/w51lGXerHI2CMeFqMtfRbBb1psF4da2YvNvh
 0IVuOTrkmgzHz8itsW2oeiMvVrYKEUfWKb6nY3e3yRSTffBQC61CDl7j7QK6vaA0AYdQWlkgSaN
 H1LwpVT8Df1HwV7M7PLnfz/z2tNTB+KdaK6sImM4nhKHTbRabfANwOuKJPX0AAaJKaH0sj64NLG
 llD71KYNunl8KG0XARf4hkfqhU2058ttTRBXuXEKSh4VYTXu4HJjz0YEWQW1fPgb1611Djx33O+
 HsZ2Hn20ruionoXLNaHpKDpeISgTD8rpOylLXcEOpE1fEpdeh3/S0WhXBl9L8sxWhIpBvTLe5Xe
 RDidrD44J/0oQWbMI2iytlq+YnnCflvWFJQb/HzC01nNJ8pJuNR/yRn8S9CJqARZX7u1Y/mqPyK
 SeaJaISy3yWkOGyfn2g==
X-Proofpoint-GUID: QYDsWxK5zhwYrW5BxLoM8_WIhpatGbkg
X-Proofpoint-ORIG-GUID: QYDsWxK5zhwYrW5BxLoM8_WIhpatGbkg
X-Authority-Analysis: v=2.4 cv=Z/Dc2nRA c=1 sm=1 tr=0 ts=6a61f513 cx=c_pps
 a=y599upwrfiZ3HV94zaFOUg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=okWzP3EbMLmikBYkquQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

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
index 542ad331ff16..8bf3a5a8bf43 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1570,10 +1570,19 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
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
 		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
-- 
2.34.1

