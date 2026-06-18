Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF661A9FBC;
	Thu, 18 Jun 2026 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768355; cv=fail; b=mxBYAD18M8LBSOm88WCf4wTY59Qz9uDjpjrDB6QDwy9KpFdERp0GSbjGXYhzzvkiH6WTc9bBdGWL8fk1qI5yGUcNDKxN5hu12+xBftfHNyKW0823PNjcbDocdHLrXPT3ChePEcRkwPQ/vNXuVOu6HZpmg83Bau0Gs7ngQCCoNDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768355; c=relaxed/simple;
	bh=Vm2wjXIAgVaRLYNYzwtw/HBQOr2FZG728QoRz8FgKD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R17XKI4j5u59rB3QxNidvg7c0hno3UApyqbi7engm1gMSV0wPAVBx2WWrRKV8xzbQ+NLQ/iMLnFmpWNcp2gStTze0EihdseWrjUHH6N61v6P2zl6I7471fg2/SUOFeghVzkQiyG2MFkLM+pehg/arSOln+yCDUlQ42l85MJ5pG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Nej5yY1H; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aC8el7ml; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Nej5yY1H";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aC8el7ml"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I7WrjE2383810;
	Thu, 18 Jun 2026 02:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Aq000ovTC8ur5gA6COEaYAn3sx7vf1Rg8oSz1eJZu
	KQ=; b=Nej5yY1HrJYIAhkLld+PqaBqub9SyHHIve4jPfsxZZOLmqo3EQlY+SB5Q
	gwPG5MWdTX/FvZYBvKaFaOTHOfbtxBluKdTztZP0IpnjzFzTI5Pt5D7K+SoelKAA
	D5RE2F/n+TsX+odb8MKGNnHmdjN3FSYa7UHgrSmFAewfgD5el90ngApkUvwyx1Me
	eELWtSklXtmW+ezgiTTgGI2kKoT1N4w9loAH5ijKuZMFRE9OqwbzGumlfOYI6+gQ
	SuZ65WecBcNVB60gleb8pOh7c54JNX+NAlNxEJW5vVTeDT43cpBq4+01n2zefMUM
	pBLb4rcNZODrK7hSWiiPgcyDDIbxA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	by m0380145.ppops.net (PPS) with ESMTPS id 4euthp6s65-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:39:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMEKZS174/1SQXMYwqJKsIO3JIfqJ9asFEz37pOm34wUthaEYyYOv5yPjYIOu3Y9/pCohhEwrZD0oWfinl7miMFsT0NhDKUFGfJgScfgCVueSL/hLVbcJE9S0eNwEGs86C57GM3DXIhsMw5ym9kRzlk2JhUTAahLODCU6HnJuLncAB8zSEvhesUFqc97X9YPax0GZRwmRhniZmpRsFPZu5u/vHjgupWH1KsoCcQqi5hPjyu1H0ixwpRbkpawKLHKS8kAPyXMSI9yA0mrvd7s+MKCByQODgDjlBFMjg9eQstBEx/fK83tfpqJy6jPVRLRotswtcE+oL5c+puA5pibWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq000ovTC8ur5gA6COEaYAn3sx7vf1Rg8oSz1eJZuKQ=;
 b=U3sw6stST4ytjXEZarenPhx8tI2/qbluMjpKyy4NhtxdfheQfcBxXvpDU4Wrkby8D0pTHKjoWLqyuh1fyt0xgXpEzO4QSyUGu0zw82DkUjkf7eT19FPVbqs+neogNJf2pJD7mev4yGPm/9IWg/6boOweQdIKhte6uNzPPE685s2RJgMMa/p47tOmI4c08LFrUiaqHCnw+lHXO/kuVv7ZpgJirjQ8a0QgMfpCQOQO2JAg5/Fdd0OoOxznS8pCx/KbhBH4Nl7E9YeoVYwW2V0SRTx+Vl5vrPP2iLLu1OWlV6T7VwQ/RVrqHsmcR2ZuP2T/xfKa4/XePo+KuNfaSND7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq000ovTC8ur5gA6COEaYAn3sx7vf1Rg8oSz1eJZuKQ=;
 b=aC8el7mlz5yNv3PSBIKuVXurylRTRvDQeHd6sEz7VSebSO3ri+/xNbJycondMRV0saRwPhTITVNjxdSEgEirUP8IzcTM3waa+/daK8kfvuMpRTcK0fyK6RDFEnNbuf0oYshftYDWo7vJMe7EcOi91wga8M8talF1BsEZ8JE81Aw=
Received: from SA9PR13CA0078.namprd13.prod.outlook.com (2603:10b6:806:23::23)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 07:39:02 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::36) by SA9PR13CA0078.outlook.office365.com
 (2603:10b6:806:23::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 07:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:39:00 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:47 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:46 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvo3521710;
	Thu, 18 Jun 2026 02:38:42 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 13/16] mtd: spinand: extract variant ranking logic into spinand_op_find_best()
Date: Thu, 18 Jun 2026 13:07:22 +0530
Message-ID: <20260618073725.84733-14-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|BLAPR10MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: da088629-a8a6-411b-cd60-08decd0ca9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|7416014|376014|18002099003|22082099003|3023799007|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	Td952za99nyksNtOCa2C+YRhG7xy7giXKYLI3WfU5CAcvFLIg4Q2281s19T+XLsRMgNeRboXriRDKNmQRoaDTpy0Gty2FQYtBM5VvOze00dzIGhc8AaqUIXuNrnPaIpL/tABXiFIjUbtiED+wPSUk8R8FCVpT/ehw/IWxxSziwsCNb/cZzBQHDL2W1iN7i5A6C9wxOrdCKbkaj+0g8N53kMRhVmop1BdN8rbBzBLQVLstUXi36Qacnir2y0hqNDJoLnxBmc4MoNKHG8/LfNLn2c94arh5+MWCzBbRxYLvQ+0NDftjolNYCDZadLyrJpAr848oY5Rh3lvtYhk2Qt3bJGO+munC068FDhM0UIgMDsupQcElzyqIO4vgOR9WbIgf5EYwtpwwIwiQYAKjHgl0kTO1cVV5wY8uqOqpDOvRL3pP6erEwVKCBKpXqJ4VNWop2BUaY8Apt+8yJzN9xnCXBbbRHPnmqbIwAkQ6ZeDn5iENYqDO7Un0CKmo7u/1X8emBysdGvMn0P8S4nF2Be/cENgrAADAIDZc+LtqAeJySaJF//Aumn9i947NCw09YNqzvReiCDTlM0D3I0FHbyikWzBkT8yciPjjIp7xJpHIqxvrUZYIO/jpl5T0GBtecHtvASweNE7r+XGzo2YCVC3YbWloeV7eQTMXA82d66nfhFhC3x2q1yMYDFSWMurLHQBJraEu2pevVHYL63NSiPBG1Gyeavb0TLpsM1DjS5iAsl6M+BSkxETHMG5X2TmEMAiwN7zwgQ2XMfmLI4yEsIaUA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I0FilY4JuSoCNTDO6ADRsWoOU1mNHmUNfihR4gqicnWV/O+khoZpZnLhTRgad4mDgi5S2YY82yQLfMa7RerLJ3sG3YEc6TS9aZnFTAj4zc3IfZqTyTkajpiDORzVveDYuZHN6o+X6Nba2wY7hEtkOuun/ZefLtS+HM6uGpl6oSKtnc//Gb8Ce0/U4CzMBvUoj1oFjatYhGbZnjL8hRC9TS+xTuluatNutd4kyoCF/a7YArwn08Q/JmSUHNX5+rVInKDUn/irPmPezNTrFoOQs4klv7azn0uuSBcaTe+WetbNnFJXc5k3qsa7le44TyQz+oD1Z4WHu4mcsGGGHy4mCzW9HjSj55guOfCpN24F+XfyFO3TnXCchrAwYPcFW4yuKWU/NtR+fub2PaZPdcHxszNDpuYg6f5oeRHtknpiSuUWzDAklMn/JyJa8M3SgUMO
X-Exchange-RoutingPolicyChecked:
	FdhtWwLuo4VTbo+N8mdjXjZeJCVSF+3AQgZqOg59+kMHihyiXubiz77FRxSoORY4P5djtVDu5jaWPG0Goh9d7Z9YXMXSpM80gaMnEpdt+LherIxqYHw0hQduyLPbC7jlNyvbIyblXjgSl4Bq/kL5uDNaraI3LyAqsGnMKHHKsmTfrEBVuJ4TqHPraAX4WPpvzYofJjnq7n81YznakfSrziVJmQJbVSb2b0FXjsTOYfDcYcW65Oc7Ds84ejZvu0+Zm8sJGhjXTh3XoxEGIsVpxxYhpAwgKJ4NSkUqf5W82VWYaCa3at0cELvAcToWMWZipiAy8Un4NvKi72+awJDoYQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:39:00.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da088629-a8a6-411b-cd60-08decd0ca9c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfXwleS3dHZqrqC
 9/MF0C1V+HnPz1j8wlYpL9cj2T5hFz92fG7P0g3i+VyzAV60MkcICDJirxtlT3d0iVSnx95SKEr
 GNJEwrHoe/ru2hLdATRDAIaOi6QKoHE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfXzkw9NfwTEfNp
 ilaEKWLCbQdzUJ3xgNqH9vjkn2OANgxGAdkeHcVqqpYbrrwXttje2AJahXKP+xjoonA5hcr/dfD
 2n7IpmBFXoqFlW6GlL8QJajDTVWLjL+tRynnmgoKhj3G5WAdUaRsqestGqWCeYdcnG3CGEmgn2b
 hrhHGR0HhM7X4Dn9wOOp+k/FbqPEupBe67D4VgqqKBksER2zTzAeklfY4ei7m32jT/wsHlVqfkW
 Q5RkVn6iVUVjNuDuGB33DwQ5Vl88W50FiUeQQkKyIrHnV0GFWsIrlhurBeQ9unX1FKcLQqAjZWp
 avpOutVsWz02m3C6oYVm717+7P/OnIlWH2uwQ60MjvaAZtmAu86bJlq20NYSA45jgdUfcw4SqX2
 DNI/owuGOFkmEXu8L3zhDbAq4V3D3wAefwVMyrQFCi0zSScTzLsc9EMnCtF+oRCEf+apaeoRTNc
 DZL+Yl8l8wTDahO9TNA==
X-Authority-Analysis: v=2.4 cv=N/wZ0W9B c=1 sm=1 tr=0 ts=6a33a098 cx=c_pps
 a=qV0RoXYxPRq0QxHYvE7eUA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=b2CdaXXOtDrlFHZ3GWMA:9
X-Proofpoint-ORIG-GUID: 8K9WeKwORF_qj5ypYrkz3vFOBsLUl_9P
X-Proofpoint-GUID: 8K9WeKwORF_qj5ypYrkz3vFOBsLUl_9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180069

spinand_select_op_variant() open-codes a loop that finds the fastest
eligible op variant by transfer duration. Extract this into a shared
helper spinand_op_find_best() that accepts a skip_mask bitmask of
already-tried variant indices, enabling callers to iterate variants in
ranked order while skipping previously attempted ones.

spinand_select_op_variant() becomes a one-liner. No functional change.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f86786344d52..b678d0534297 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1541,9 +1541,22 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/*
+ * spinand_op_find_best() - Find the fastest eligible op variant.
+ * @spinand:    SPI NAND device
+ * @variants:   full variant list to search
+ * @odtr:       true to consider ODTR ops, false for SSDR ops
+ * @skip_mask:  bitmask of variant indices to skip (already tried)
+ *
+ * Iterates @variants, evaluates transfer duration for each eligible op, and
+ * returns a pointer to the fastest one not in @skip_mask.  Returns NULL when
+ * no eligible variant remains.  Used by both variant selection at init time
+ * (skip_mask == 0) and ranked PHY tuning iteration.
+ */
 static const struct spi_mem_op *
-spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_interface iface,
-			  const struct spinand_op_variants *variants)
+spinand_op_find_best(struct spinand_device *spinand,
+		     const struct spinand_op_variants *variants, bool odtr,
+		     u32 skip_mask)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	const struct spi_mem_op *best_variant = NULL;
@@ -1551,15 +1564,16 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
-		struct spi_mem_op op = variants->ops[i];
+		struct spi_mem_op op;
 		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
-		if ((iface == SSDR && spinand_op_is_odtr(&op)) ||
-		    (iface == ODTR && !spinand_op_is_odtr(&op)))
+		if ((skip_mask & BIT(i)) ||
+		    spinand_op_is_odtr(&variants->ops[i]) != odtr)
 			continue;
 
+		op = variants->ops[i];
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
 
@@ -1588,6 +1602,14 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
 	return best_variant;
 }
 
+static const struct spi_mem_op *
+spinand_select_op_variant(struct spinand_device *spinand,
+			  enum spinand_bus_interface iface,
+			  const struct spinand_op_variants *variants)
+{
+	return spinand_op_find_best(spinand, variants, iface == ODTR, 0);
+}
+
 /**
  * spinand_match_and_init() - Try to find a match between a device ID and an
  *			      entry in a spinand_info table
-- 
2.34.1

