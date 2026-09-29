Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA9442138;
	Tue, 29 Sep 2026 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663834; cv=fail; b=kEzIs0UKeeGGQaP8rroSPgYB5PEfSda+lhvrDs4U1xdrRHCaS36hnM9rdS0Dw9GuPjVnFoyKXv/AdnZpQD0lb6clj4umprY/AhHzeZqpShOEGCw+vczUu1ge3vogY9ISU7Zke9oOEE53Gt0vfSamFYVyE4Y32vffzx+PtDImGZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663834; c=relaxed/simple;
	bh=qaysllzncB3YBFqUDideg9F9kDdSq2hkx73flZiIXGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZbqAvwSHJMPSFFUEzoOHXsQjcNgyWKJE0fHg0jwuxUNy/uQN+HD5iP4ZvLZtRtCqyVSZoJPrs6iKbI6fyZ05TgNbPjzw5sp7yLMQh6uCMPzJTmPkAffFgHg5fpvnQvIpxyEfSB77jYMNXaXTRh2ZVW3YV4yIvgEwbqaY00O17I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Y9skIxZ1; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=TBLVeXpl; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Y9skIxZ1";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="TBLVeXpl"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46Ofd3787012;
	Tue, 29 Sep 2026 01:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=97kZyPytORIKpmcLpRXTSZxByuKhfMduy3xmdTisH
	RM=; b=Y9skIxZ1nTu3yJ/RPB287SmV1kyh7KCy/RXhRJjuR3zDMKJnkUc+7DePq
	PtxRzyrlGljnzcaXSOdGi5cidw8MX1nyO1wXoq9K/qS1waFkhrXAELA3/jgbW7Yw
	HI55K3CBi4WJHd0frBqrQ1c4YsFFMF7xZPSEqWjcOJidwGb6FfZxHvdlZR0meaal
	bXasWSuCpklCUUQAr06nZaDOSKOOQEnT26bEJhqHYPAxEoVZftu0/6pWXfE1EvNr
	eTOEKxltbo2JUt2x4bLrm0lo13WTlRPAtkDG8rz5/vR2wskf9QBkazabbK4jTizX
	JVhiPGAu/sfRM6yMh2XdQri0OJWFA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h02grj052-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7zvidSXIDKTr7KuxNtq3Y9Dx/G89Qjb6EmgSFZqDyY6vbN/CbjSC32DFNfxL76NGvfM0GEMG+a1jMASE6A8k/FlFSPTto+LeVlAt0zMiNDN7eR/R+PR2JRKRMSeVY4/0jlcVehmrmCbsMt+sgQXFhll/UPGo7BlHYJDB+zNXAADcq+uHhKfx0LyuBq+mjkZRu0MeQ9vadE9Zdv+Zzamnc+hR9ZAweV4KRwDsP+g90iA+0OJgv/D2fx5CCIRapsEyTdmJpGKxTOEX7g7umfHV5SXJmEDKF+CUyWcvAgw03Z6rUyiCPwqLRZuXdmNuPUoBdBWPCA+xAvRJAJWzCYdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97kZyPytORIKpmcLpRXTSZxByuKhfMduy3xmdTisHRM=;
 b=fyePhA6ybKpzWpHqjVOH4j4QdP/3cKPRHzA+0cEGXfysdz4wv1fvHjHaEAqup+9XgDqrVxQMGbBih25tyi2SQIDdJtmwAsQnzsCEm9qtTnAI7nNNMTLkct83/Zp7Hdx4rta4qSpwCnmI6WPUjYTrV417k6B+rXdG6SJu7Ul9eBr0EBIWBi1afBqILZcNwbsCRbyiiPVgKw/uH2ebSI15hh5x855IQbK8SzFGiEmndc0Q5HukK/Je73R94sfIQUsDhWpVf/B3zW3daKz4Tb9Pk/whkgOQMKd9oz8lD/pBmDxwPJZ+YiRR0Nw4zqc4lDd0U+1CLsf5c1G19i2l+u+LBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97kZyPytORIKpmcLpRXTSZxByuKhfMduy3xmdTisHRM=;
 b=TBLVeXplNTqotdw4kkpWwv/Qr/JY0HmO4w8abhJm2f7PYs2uXNbk+xHg2fuKRLXkCjRHxSnCyGlRLAP3vN+Fh8VSza1fujKsKt7e3MIFC23OkTRJOnGkyMv/T6PTPa/XgOFLNbv5wYoqn9eVvgSlOcK/MZe9bk9My/jP30Y2F7g=
Received: from BN9PR03CA0609.namprd03.prod.outlook.com (2603:10b6:408:106::14)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 06:36:47 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::85) by BN9PR03CA0609.outlook.office365.com
 (2603:10b6:408:106::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 06:36:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:36:47 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:32 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:31 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn91395904;
	Tue, 29 Sep 2026 01:36:26 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 09/19] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
Date: Tue, 29 Sep 2026 12:05:19 +0530
Message-ID: <20260929063529.1235417-10-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: d956e7b7-2802-4143-8203-08df1df40938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|7416014|1800799024|36860700016|13003099007|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nwmv4kVQam+1AL809uRW4eVgx/jCfCP4Wbi3oBymuAjoZ33rL4Ato5REyb0Hgr9ICXUJc/737qzo5UnyKopQLNn/kjnx9uW2n6nE5VCIKqkkSdmgqRBnA+6ciW3dUM/N1rHV/9g6F3X20bkalILxv9GXkGOOG3oH/aRmVwkV5xHToJ8MKlZKYwL1gyzTXI6TuEWP9qHeKH2Hb4SOyyM8soXpcDzUalry4iu8AewcSa1buOdjRgY0Sy3NhUx3pyG0A8O5mgO1VqX9usPck7waJEvmwngcoAJrpBimoOBRCV0IdjKidChokCbz5KsKwO55apzaNNoBJkckfvI3DAnYcAbTOX/XZRNSx80Fzf3EiB3Ic1zKVsu3a2GCpVak/KFAgekGFVmfIrRJN2C0bdgcT1HqFKoglBEqAVHwEU7HJWnYCAlMCKx4t2SjVYLe2BZGb5D2fjrCcSpDKmmBoWffDoF29WMZftIoJpMzpejzqUZpnJ84iyn7P9nn8gn+f7nv878+T7KQdJ0gKL/W8kqm/A4uMZ01BVhZSp5BfQhZ38CUi+t4JmLTIlg3J4gPmCmQRzU55czpuWQK+rH8wF+OlfYnzIQkr+83rg7+8DYnEJegstDPOgTJwyxboOOa4M5Wps7+nYdIemt4zRKJfNzFoPwpZJ8fuPkDqX2UXHHpIVvhIyVsavlKJipy3Z+dcQnLNru7CsbaZQKLS3rYZXSpp0E1+ufyfWG8SJbTAc9otb6fJzFOjZj4UwAdHherabVY
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(7416014)(1800799024)(36860700016)(13003099007)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DXS0/PhTa8MQnYA2C937HpqjHwsMy5pdbSCCkg9EnD7zAYMJaA1kMsSB8UgZKkuQlElLfG/ksuXvResiGxRkcRQlJSnDLY0tmF5pHCDMDsstD6rnaE9UVNtuFY3ge8293xaQFDblr0w9ejvaQ7OsNnAC9s1C2NLpcnayFpOzXuQu7MsnNo7i6BrvS31X3SopdwcqrCrZuuRcLe1zpcSeHA8/wvSXy/NQkn6Uo03UL4cIndq6wE222yb8HlL672FgP2pYHnAaSfbwFezZuIdSxHXXgrcOs2dszu8F/NwpBBOWNlHYxCfX6VyIYI7SqAj2s8IdDggnkoMN35iFNLh4YalbdQp66ipHG2aY9F5JJpyrZ7rclALLbCmWStLaC9jhafBjQGqHaW50udLpLiVFoS60aScfjucNtFHwConP44ht3k+Gkjc85kDK2onUhYW5
X-Exchange-RoutingPolicyChecked:
	d05N1xN4mzShx5k7VexxJeE1P71xRn8spGmJ4kctfvPsmZ6rujOAsuCar+JukISIgevSwvs0WQJ/gqe5ld7iG4gXIF3fZ3o5a6Dd3IsBJCsjRoBt4s1Pv6xSlD+rQSfQ4GFRlLH/dBRxKRaGgx42vcthou8z/mv2VHMobSbVk1MIHtoU3YP2lxCs/KeMYzP8Of+iCvBCVbg1bUsjmF/+YyN2Sqhf0Xbcpo9FeUEJjwgqGpW6JPwd/ym1lujBZmQD1aTsojNeF8dE/Wa3VCaniRZeI1+FfvvHYtbim7ggxABu++R0T116sDSc4LaiSRKWr4BaE7amvfVfryZNT28XYw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:36:47.2582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d956e7b7-2802-4143-8203-08df1df40938
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Authority-Analysis: v=2.4 cv=SsEFe/O0 c=1 sm=1 tr=0 ts=6abb5c84 cx=c_pps
 a=wUQTFLLo3/oASVCpA6ZfNQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=T-kh0MV4vbdY-aS4Zb4A:9
X-Proofpoint-ORIG-GUID: 2i3I0lE9dIF22q-JMVb6ZTd0vim9guLq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX9XWY1oFDPlJ6
 TlAWLapMo5kWOLS9apXqlcaVJZOKZDcHXHuts8RTj6U9qEhzIzEqwY0QrapwnXntHgR0o5iQEcb
 X8hFPgv3sTQEC3StgebSv2tgc4a4cPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX+nriFxXB5QCB
 FmGdd5NauvwtL5LTdcTAgHQ/zNaldg/OArVHy+nmT4+urriSSJPv5XbZ7jN3LvhhC9eYIjMz4Xq
 RHtL+Oyg5d16vufMbrZ7vDTujdwyRYhcidPt3xpcrX0UNmS0h4YAfNFo5hRINu5pB2Kyxspbjoh
 nk6qkEKhg5gSavgwQW3c19ZRfBzLeo6eTkHI3L4Q9eRxYCaVvKNmbKKxuqLU2SOVyi9Li9ZiHRg
 LuDvDNPyB6e/klffJNW0nbuoeUzeeh1Qt5TU/u/38QxwtnTBXQvdx28b1ZD76nChdrkPCI5BTRr
 AABJUyuK4aNKuOo2Rd6Apou+J1MJPtPcUQGaeL8PE3o32uUmd+QUDVfZxXMVH9eiJ84++EOBkp2
 mjmSu06hPkUYAasoMoc+WRPNPn6DG8zYTEIOs/WGv28nOlMAyghgtU9QvD5TBUUDk+DuqQY8eDj
 r80EzzNhRQF2p75/i5Q==
X-Proofpoint-GUID: 2i3I0lE9dIF22q-JMVb6ZTd0vim9guLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
2-byte column address is used. DDR PHY tuning must not be attempted for
such operations; non-PHY DDR usage is unaffected. [0]

Add CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk and check it in
cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
with read_op->max_freq cleared -- the op-skip signal that tells the
caller to try another op variant.

[0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 46 ++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e21164419b00..6ac3607df0bb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -37,19 +37,20 @@
 static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 
 /* Quirks */
-#define CQSPI_NEEDS_WR_DELAY		BIT(0)
-#define CQSPI_DISABLE_DAC_MODE		BIT(1)
-#define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
-#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
-#define CQSPI_SLOW_SRAM			BIT(4)
-#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
-#define CQSPI_RD_NO_IRQ			BIT(6)
-#define CQSPI_DMA_SET_MASK		BIT(7)
-#define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
-#define CQSPI_DISABLE_STIG_MODE		BIT(9)
-#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
-#define CQSPI_NO_INDIRECT_MODE		BIT(11)
-#define CQSPI_HAS_WR_PROTECT		BIT(12)
+#define CQSPI_NEEDS_WR_DELAY			BIT(0)
+#define CQSPI_DISABLE_DAC_MODE			BIT(1)
+#define CQSPI_SUPPORT_EXTERNAL_DMA		BIT(2)
+#define CQSPI_NO_SUPPORT_WR_COMPLETION		BIT(3)
+#define CQSPI_SLOW_SRAM				BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR		BIT(5)
+#define CQSPI_RD_NO_IRQ				BIT(6)
+#define CQSPI_DMA_SET_MASK			BIT(7)
+#define CQSPI_SUPPORT_DEVICE_RESET		BIT(8)
+#define CQSPI_DISABLE_STIG_MODE			BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM		BIT(10)
+#define CQSPI_NO_INDIRECT_MODE			BIT(11)
+#define CQSPI_HAS_WR_PROTECT			BIT(12)
+#define CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR	BIT(13)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -3179,6 +3180,8 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		spi_controller_get_devdata(mem->spi->controller);
 	struct cqspi_flash_pdata *f_pdata;
 	struct device *dev = &cqspi->pdev->dev;
+	bool op_is_dtr = read_op->cmd.dtr || read_op->addr.dtr ||
+			 read_op->dummy.dtr || read_op->data.dtr;
 	int ret = 0;
 
 	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
@@ -3194,6 +3197,18 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Erratum i2383: in PHY DDR mode, a 2-byte column address locks up
+	 * the address phase. Skip DDR PHY tuning for such operations.
+	 */
+	if ((cqspi->ddata->quirks & CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR) &&
+	    read_op->addr.nbytes == 2 && op_is_dtr) {
+		dev_dbg(dev,
+			"i2383: skipping DDR PHY tuning (2-byte address)\n");
+		read_op->max_freq = 0;
+		return 0;
+	}
+
 	if (write_op) {
 		/*
 		 * For NAND: write the calibration pattern to the page cache.
@@ -3236,8 +3251,7 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 
 	f_pdata->phy_read_op.max_freq = mem->spi->post_config_max_speed_hz;
 
-	if (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
-	    read_op->data.dtr) {
+	if (op_is_dtr) {
 		f_pdata->use_dqs = true;
 		cqspi_phy_pre_config(cqspi, f_pdata, false);
 		ret = cqspi_phy_tuning_ddr(f_pdata, mem);
@@ -3835,7 +3849,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR,
 	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
-- 
2.34.1

