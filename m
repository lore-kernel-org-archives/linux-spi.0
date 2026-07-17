Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AB39D6D4;
	Fri, 17 Jul 2026 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314369; cv=fail; b=Sifabvwb8ZkzYOh2nY0bWVlswuzkYXeOey8xDCYgP2xW1NVnb/I8yH7QQy25ieQkLZYuVc6PuWutVyn9jLIK80O6PHhsdbaZuaUWfU4jo0QRXZ8324niPGIPyJ4T0LKZLMM4clIBBn6uncV2zVVbBwZw3m/YWtFUy1VXGyMJJiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314369; c=relaxed/simple;
	bh=NlBClPnibM0KySwnwhBAcwY1mjSRn1kZGPB81D3dGzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1e+pzDZuoUkx8rm0NQXB+K72Yb8E8tp/UelLFD0S0yZjtQrKtLGf2hhSmDmrbCeuRai5TBeEbgBy6jjxyv3hoj6QTOqyD19rxhaUcxhRTFVBC3wQ7uWRaUjzvMD9j0DME50fKV3hsedvMDaIkYFuLFhfxGF6mAJCvE27MNSILY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ejYE4V46; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oNadOK85; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ejYE4V46";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oNadOK85"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlA5T3254275;
	Fri, 17 Jul 2026 13:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Z+0x/gTksPXU7FZ2D9S8r1K8rcyMlV9iapZy8UL0O
	Z0=; b=ejYE4V46y39I5gYZ5X/0leEUqIbpa+l5KE1Wks6+RgV6Q3aDnddR8vWNM
	12QWVdVR2Q6pvfB/ECetYZTwycxVTMOgeZEP68/5D2bwIlO0m2mrynPa+aai51nj
	MsAPg1Rxi2zAXJ7JEnajaoyI22umQJ6Cem00b0XPN9YJaRXa8VbaPPnpB2+mcK9O
	Cy5zsPDcmRZratHhIgBuyll4Vu5xQzCRvf72dtY86hR12Jj1KvtaTV2wlWqrcaYK
	wwn5ydjurhOPZLEGGy8gWZUAIG2OjqB7oLC+h6Bup32au9GbrZUPPKQBBYV0Cc2Y
	7/hlrUN0uAdbJ63oqeVRbsSfssTfA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ffks32kh0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eez2nCvd0fj5EQdScjYkqk4KGo4y76phq2ZZC12+XtmQ6lBcAL7nunPJiM2X6cpTmbFjtYgDGvThmm/9doGIBXS1L5jmy+2h3DFDpc7t1J/VU+s/E9/HgWB0aS0sbKLIP+s33l1DG4zMmjwQdoz5ufhN1R7DRDvufYfD06Q3n0TttUpUUTUOqgGRHh6B8iT1DR9dGyAVjPgD0zaIRgERf2WmjiVVdOCC2jPvDo9vlukZClmR1RjwCJzZVttcdyXMhqnKdHiOLGMk3wletd9TFXSXy89zzrCnuy3xLGs31Ygvhtduk68FSWYR3460EmVCh1LBD7JFnrgYghZFimT2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+0x/gTksPXU7FZ2D9S8r1K8rcyMlV9iapZy8UL0OZ0=;
 b=uXKK9qKGPhow0iTYxDZqhqRSU53kyEOGYj4afeEbvVuyq/H2gRwytQfnFVMrvc4PKOTTl9oH35lI3UxtTMCd8QvbL7bVB1a7v9cG/3beTaUouh9c8b34/pV0/UCNbjgykg2M5jssX19llQhnnomipbcFSUx/HuhByTQ41/avb2cUR09KtivIfFwxXpea4loJxNk4J2UkKh58HYVvyPsrxoQRX/txkTNEzIaD3PGWmNVZgB8b4P3FG0FEh3F/vMHkD1mZWEpDstlmpYtRV79iutjCN+sjAYa1sIokaZuMp+2TRHdTW8Igaec+2X3+LxSkEf7RHMpNiWn+OLzT8m1mnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+0x/gTksPXU7FZ2D9S8r1K8rcyMlV9iapZy8UL0OZ0=;
 b=oNadOK85vk1Wz68Qd/V+XPTw5tFrwhfh9rvR1n1Gu/KRDnVzMDCJn3D+cLvC3NKN3JD0RPXGgggS7GnD/HYRPdeO7Q3axbPdDbQP82YjdKGgZafUZHCH0WyvHZv4amx4PeNMjfnAj43NXnS2GMSDdX6hxcooaSpDNNuqcfsfaQA=
Received: from SJ0PR05CA0137.namprd05.prod.outlook.com (2603:10b6:a03:33d::22)
 by SA2PR10MB4746.namprd10.prod.outlook.com (2603:10b6:806:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:52:32 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::17) by SJ0PR05CA0137.outlook.office365.com
 (2603:10b6:a03:33d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.6 via Frontend Transport; Fri, 17
 Jul 2026 18:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:31 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:31 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:30 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4v240969;
	Fri, 17 Jul 2026 13:52:26 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 11/17] spi: cadence-quadspi: enable PHY for direct reads
Date: Sat, 18 Jul 2026 00:21:10 +0530
Message-ID: <20260717185116.2065505-12-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717185116.2065505-1-s-k6@ti.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SA2PR10MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0881c66a-a4fa-42bb-abc1-08dee4348ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dGftsrfzKL/Z0E4+l8HHO3c/28sLoPmb7Q0K6oN+ugA0cJtxeuYOH8IGTf3L1mokmH9ZnSrMNFutpnJRp9KvNq4THIGt9GmeqAWYnz6khik4jiljUY78CeCZ3HrL4ROpx5KtDeZNO3/ySs/fd3gZW7Maq6DvrWinWH/os1IKI+fR04UmcsTOXeI0ULAj0NG+N06Yjv2YlCVnN4C/r8wkCBWPFrDlYDCOLq6oz9HiuZgzZ9835+DwqkYUyIxLpG1HAMhcQlwOX1rFpDNbe27FYEw2s9DIJ+OL4JbUUfaVcsp7eFVWlzbKPA3fFlzyaabWgJvhdGGa8fOToIhDc7xpLmNXXd7vDrxgHIDGZ90BpAUUxlodHCoaiFPv7DVIXL3odqCIdrP1U63ZnLQYJp+eR/3caKgCXZlfO8pNn4XtJKJoFZWK87CuMFj/CWXoZj+/GTQIkz08GV9j+MfE7vvaLYi+5Gq7PGt0sYgG/tZoPv1UKNWQAvdwPo2VNgSwrkq1Fc4wnuMdAlGVYzYUnjUI/RgqUU7K2upS8qCBbvSnO+CL0YUas3d40p04C4lLhTuBApj4+cMQzG+iMZx8yhXS4+My1oSsBCUVX6V9jGl5Mc2j5upZ6NicGq8G7o+eTz52BBJbEZPEnUc1FK5nAyDySh5UXHsk7ZUeZgcZNC1pr9MdOiRB6kSCwjV4YWzEbnhF+b7qSkL32CqLwKnSsaIA5vfI4UM07DtUsFC1O9ln1hdPywnmLpsOFVd3Eiujr29n
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ixcBjv/7ZjsaVP5kjeuF2/GRFJ0yTdFxeCgANI4leE8WT3dTAuq0D8RbwwHEk7JHJoZEz7xD01r4OiPyRKq7tFN7JlCFIMTKZd4v31dr5ClTHcsumapzkYdv2wf8dH5ZwbEmywWeV768Sk+Mt7XfYd63k4phONSiy2qIobLZkwq54X91nP7IXO0q0UXtCaU7BGHkDrY7OHcpFrLhWMNFsBVKscQNqO20dtxMbVo9Cn87aS0jnSV7yo0ayWSWocoiLfDpAUTVJJ1y8z4pFPuQGgVzuqLfYXCRhv4qQtkcv3X4oXPAumMZxAxek7IyXz+8D2ppTvRr89zd+BqybrbelaifEgkJLl5mVpkPvyxdgIrIUTQP1TN3lknUt8gdAzVzxMd5KBY2VswGOrFTt0q++zv012A5+Cb9VLShHU9UCaL7UYA9tkIxnQhLKSpEpOLI
X-Exchange-RoutingPolicyChecked:
	a6vw+7MPJwxNRxl6EnfHfoiLPG013JdpZNnJZq1xqF+JXqz2uin1wcig4MQKlj91ReeSRL9FYjji37UWdshfBetwZTD9r2tKjWlYw0ys1PFb2tywhJS4n0Fj+WXhO1h24MyfFLs08FV4iKo5/62UNnVFvGEKgSsK1J3wiBBXi9sMQnDWk9o8ctJ1AL0fQdpd6AzE0+ldNeWPM27kWqD6Zuzl1Auqw2ggvmZmDrxYsjdlAeLcbv1ECB5YYwFCq13gkF65JCnw5HyTnMdNAMBW1LGIQ8DVVogsGwWGfSM5cWWeq1gZO9JeC7+7gfoybyimI1gMnZNdxk0nyeG0CSmSvg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:31.6357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0881c66a-a4fa-42bb-abc1-08dee4348ec2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4746
X-Authority-Analysis: v=2.4 cv=e9Y2j6p/ c=1 sm=1 tr=0 ts=6a5a79f5 cx=c_pps
 a=8g4i1X1tkAMDiabECo8pFg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=EeSCy0yzjnJx7k32krcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXxdgjq8TY0ibS
 NntsikqtdjfTWFMGye5+c77NrbGgwft9Jxv57ceYYUIRc3SrlGbzDN7lrQGiK7O+MoTvP/YeVi9
 PEhjt/6AmjbSiQmzi4HF2ePHAD9hk/HEW9I2p8ArStpg2+kJPJUZSGiPpicntZlaxCc8NiKmgrM
 qNgGK/MDRvhiCKuNxHzZ8fvpqguibv5QgFAbeoawUj0ud7aVZJwGikIqR1prozdhUD/19Rclx3F
 47JFJ1b4j6mzZCVZf5OvHb9HTufpxnnuN6XETiL5AA2shhzw4GbjpVciieyYlHdEJ4jz8jRSeSV
 nuxUK9JkcRfkKEkJrakTf9ey27u+GfnUo6hPw7XQTqdT/kyAZk1tYjFJeJbzX2tjUKpwWt5nFZk
 US3aokUubcGgWdRybk5zizubm+lliXduTVLcObHHlQeqKvr70wsfgMsNxdSBk+mpOSSl3eBPSz3
 8y+FNB3yCLysPGOYzCw==
X-Proofpoint-GUID: xFPJYKJzYzQRzuLGZ26Rx4Co_5QY2qL5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX208Upasw4rDT
 EdPUVOFk8v85OGGMb/lNZAnjAk5ZS6g9T3SuJPzpgWrMQ2gyDftgwFisCtwg41XUqMvfBKZo+9x
 Z9ywuow3u3nda5BXKj/zExOg1Tc+Sv8=
X-Proofpoint-ORIG-GUID: xFPJYKJzYzQRzuLGZ26Rx4Co_5QY2qL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Add cqspi_tune_phy() to toggle PHY mode. Enabling sets the calibrated
read-capture delay, asserts PHY_EN and PHY_PIPELINE, and decrements the
dummy cycle count by one since the PHY pipeline absorbs that latency.
When multiple chip selects have different calibration results, the DLL
is reprogrammed on each enable to match the active device's settings.
Disabling reverses all three.

For direct reads, split the transfer into an unaligned head, a
16-byte-aligned middle section with PHY active, and an unaligned tail.
PHY is used when tuning completed successfully and the transfer is at
the calibrated frequency.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 124 +++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 322e95b3bc17..35a400073944 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1067,6 +1067,82 @@ static int cqspi_resync_dll(struct cqspi_st *cqspi)
 	return ret;
 }
 
+static int cqspi_tune_phy(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+	int ret;
+
+	if (enable) {
+		/*
+		 * CQSPI_REG_PHY_CONFIG holds the RX/TX delay line tap counts
+		 * and is a single global register with no per-CS equivalent.
+		 * Reprogramme and resync the DLL when the active device's
+		 * calibrated values differ from what is currently in hardware,
+		 * which happens when alternating PHY reads between two chip
+		 * selects with different calibration results.
+		 */
+		reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+		if (((reg >> CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_RX_DEL_MASK) != f_pdata->phy_setting.rx ||
+		    ((reg >> CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_TX_DEL_MASK) != f_pdata->phy_setting.tx) {
+			cqspi_set_dll(reg_base, f_pdata->phy_setting.rx,
+				      f_pdata->phy_setting.tx);
+			ret = cqspi_resync_dll(cqspi);
+			if (ret)
+				return ret;
+		}
+
+		cqspi_readdata_capture(cqspi, true, f_pdata->use_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * The PHY data-capture pipeline absorbs one dummy cycle's
+		 * worth of latency; reduce the count to avoid over-compensation.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	} else {
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+				       f_pdata->read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+			 CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy++;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	}
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1516,6 +1592,14 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
 }
 
+static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
+				const struct spi_mem_op *op,
+				u32 post_config_max_speed_hz)
+{
+	return f_pdata->use_tuned_phy &&
+	       op->max_freq == post_config_max_speed_hz;
+}
+
 static void cqspi_rx_dma_callback(void *param)
 {
 	struct cqspi_st *cqspi = param;
@@ -1617,8 +1701,11 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t from = op->addr.val;
+	loff_t from_aligned, to_aligned;
 	size_t len = op->data.nbytes;
+	size_t len_aligned;
 	u_char *buf = op->data.buf.in;
+	int ret;
 
 	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
 	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
@@ -1626,7 +1713,42 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		return 0;
 	}
 
-	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+	if (!cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	/* Split into unaligned head, aligned middle, unaligned tail */
+	from_aligned = ALIGN(from, 16);
+	to_aligned = ALIGN_DOWN(from + len, 16);
+	len_aligned = to_aligned - from_aligned;
+
+	if (from != from_aligned) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, from,
+					    from_aligned - from);
+		if (ret)
+			return ret;
+		buf += from_aligned - from;
+	}
+
+	if (len_aligned) {
+		ret = cqspi_tune_phy(f_pdata, true);
+		if (ret)
+			return ret;
+		ret = cqspi_direct_read_dma(f_pdata, buf, from_aligned,
+					    len_aligned);
+		cqspi_tune_phy(f_pdata, false);
+		if (ret)
+			return ret;
+		buf += len_aligned;
+	}
+
+	if (to_aligned != (from + len)) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, to_aligned,
+					    (from + len) - to_aligned);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-- 
2.34.1

