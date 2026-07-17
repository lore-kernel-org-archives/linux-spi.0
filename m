Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74183390C8E;
	Fri, 17 Jul 2026 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314340; cv=fail; b=GOcB/S5JCjhA9OHiGfVYF8tTyAjcG3nijHo74km+t665heMHF7eDiyXvcNzlMSIyOYSsfj55+tE3R0kUJWGergi2Efh89QOAx8usc59rEuM7NPHUBPmj6EktjecEBRjQX+PTn/POXFCDhhg4nY6rYsE0cUcGhGuGnpWQNyslSQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314340; c=relaxed/simple;
	bh=XXod5gsYdwM7TuNfFFwFZK80u1YkPJ13Yfu54EWDiXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcQNfiJ9DWWzN8WI3MqHK/MJedBRMBrnM1b3vLOmyixT+EoXxzIf/jYk80JO/T6BO4GCjBsLv7zk96ddRRZRVOGGzUC8nT4T0YZnWmSX8ts70jkIEeHhdsV4J20dt8kbJVKdkGBQjx+U61azCdnGu2AqDyI9j78Ki3CLX5Ekym8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kLAPSSbF; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U1w1fLUI; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kLAPSSbF";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U1w1fLUI"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlA9d3254281;
	Fri, 17 Jul 2026 13:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=o06IxgyXWxwrCIaljlzC8v05IGlfq0oB+3XuQYWYM
	C8=; b=kLAPSSbFVfZA0hvfnREh91XKCzdaTTjv5orgq54aNvNuMOwatY83yO8Lr
	LsqQWg3WLv2LxCovvxR7PW+rJMLwPAB4n61B/5ywDvENO1g3gAevcWfLQqC2/i/i
	DEF9tbHnKAz4wzj18SYUVInUAJWwn7MTCORLTbBUmjCPX6wpw6RZFU/N0IRmr2hC
	hjxD6M/Lsm4TN1NmnBpsdaxgRb8ORD7mQZvNQdwwRycaxHhkj4I5Squhb3c2+1nC
	Gr38NrxVQ4PqSoaeutyGMnpSYsbzpyCI3EFjLSNXueEdwiG5iLxfqHACrx8Mf/i0
	WL/oYumKHLqc7MC88HPrHoJ7YRVew==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ffks32ke9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEcE3iQOKxw0K0od7O4+t9Sxqf540dekNKSPbffh5CftXIFQfHoZaE85RKR2UeCWFxZZSVonS+eIVuWNzuwHWM6O/VPTA6tKjqY3JwWrNLFW7PtycVbOhyjQGyZ8Y9HFMC5FMNCe2PiwoZCy4LLYk6W/6290qOLghyC/pslZZwmD2TwCXrT1sFw7ahXdAccpvvSVDNLMLVvn1XOmASjoveV2fwx4lIBDY/IIr1SizMhkv0I2uno9wZ9kT1xYDKlpatdhPQ7h42xMCFci8+EPRQCzh0txx3Sv7XNOaVGGMKAq7ol8plqUCl8ZpUM+uN1aeSPprt4KwShVRY44v/9dkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o06IxgyXWxwrCIaljlzC8v05IGlfq0oB+3XuQYWYMC8=;
 b=rYbKi03IUEzwIr2ruAo8FOkM76J5A3evtFKv9o8hHLiKWSp89A2XRaGz9GeACc4WjLAXT4ED4wuAw/UPa6kmk1MyH9ykCh1+e4nwrgvHXbQXe+277hb38Q6e0Tj3dmSNIxfcKAWYmcAA2vbEeGZpbkZXZAxEQolPoLa2hbLsbm+129KCVxTEtsv8wZRr37yPplPXEZ5V+UWqZRKxM+NkVBmBt75MBO1hKwbvBSuJ0eNLZGUTBvSkw+jItdwm7ZimpFWfMU3GWIspiWeOezlI4AnAE68IpV6oZYp920HAGhg80BYgJRxGjBWyL01v3LjX4qAHEtmlqw4v0fJzU7DYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o06IxgyXWxwrCIaljlzC8v05IGlfq0oB+3XuQYWYMC8=;
 b=U1w1fLUIdx0C/m2yU7bh5YQGnu/Oz6XoknH28wlvkvGyw1SlcMLT6vhqTs/l5izA4IXu/eei5HBfHgNOmcFH5qw0QEc0sC338+sWgDfe4lNWvuQDtn2YWQLF5oIU/D4qRc06XJQS/Y4lIk1o17lNhEU6wloXDXAJMmkSgp+UMq4=
Received: from BN9PR03CA0530.namprd03.prod.outlook.com (2603:10b6:408:131::25)
 by CH0PR10MB5049.namprd10.prod.outlook.com (2603:10b6:610:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 18:52:01 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::21) by BN9PR03CA0530.outlook.office365.com
 (2603:10b6:408:131::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:01 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:00 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:00 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4p240969;
	Fri, 17 Jul 2026 13:51:56 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 05/17] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Sat, 18 Jul 2026 00:21:04 +0530
Message-ID: <20260717185116.2065505-6-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH0PR10MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: aa23ac0d-99b4-41d5-3ed6-08dee4347c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|921020|6133799003|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	lGlhlSJb+Dp7wKDE7h89+EszSrYLvp+VOSRzlFm5TQwNRflFGCWRVrl0PXiJ7snwa5gTkFoVA/vnUVZQhmu5zf56VjMN7Q1gAonR81evbIteaIXytPuLX76j5QIVfYReaRmBzL5kzbiRs0+dHfvESWt1V3q3NP/lbbVdp30ToTtbbM7SeLsV2o+SvopxBIbrqn67DRENn8FqvmZEIuT7TmmpVEufvW90l6Ix87t3MogTZL86F0j5vWdvsx8+1rtgzyK+PZT1RWPY9mSMDUQ7QNwlqOzezi3lowZFcGgQcriORgCVrbdM0dd+MGeoeVoaevW7TFeV/8V612Gd8Kc2J8TDzJgjMlft7UuGyt4EVI4rWtng4ZTBi3K20qjLEhG8anydDep7UXE1EyQshAiseufpQhmwhrn1TEgtOnJjZGflDJiP4WcH9o3oRWsXaZ48KeW2eAXlHEYtyLgIfNTR89gRYZ5SrI5gbbDTuCbC7gyV+0BrE7lA2/pUz/triNS+bhiIfBNW0tYYhshLRZuGhN4102eDCr3JtnIPgzeHhP6jIkSp9/xQXVHSpDZPNpVYzJrT5ofpOcXvn9PrxCbu7cd1b0itZBjsVcU65THAttNIQJDu7jYM9qu7bYhLC8/VOKviVAfs9RhxAC20+9nycpIYvfHDmqryVVgIZRVOMbXgj4mNkrmt+4MehSsFHSA0yDcd+K3imCOzY+T1u4ii1+3kkXVRgERyhq5hKeC3NQWYR+hdKrVEyQhIWhzynet2
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(921020)(6133799003)(10067099003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xDjLiowePOkaTB9V2FPUly8lCZWFd2JAN13lij9eptvGOTL6r/+jyIxcp5JSZdwkpKD/14tIF7zsXOHGiHcP+ydzAb2VoEY7avsFhZfPVrCXaEHOvnkQr9L14FTfQ+uiXiDmeyLw7hidhAr98WVVlcpjC3k8D4P/OQGj7UnkypIIRKkqhrRq9LkMVZ9KSRjyW5BNphxRhLP4UCyAo2w2+FHgPhZZtNuFw/eGL+ZFM2MzXFo/NdFpDH9nbGc4J8m/kf/yX4L4acKOfoWQZSRSmBxHoLtvnlAy4L/IZH18IpbwNAtP3A8ab4fk9t/Beyv4ZzRrK3v1Y70flaU7jj/hmqI27XSUz15dLNPW0yRREhnPG0aJxdAPIRDKD/ks9y2Rm2Cq2pze0fkPG5htALDZh1y914eAuFSpIsEbO8hnb9oM8vZ2vw1YEEPY45S8jUri
X-Exchange-RoutingPolicyChecked:
	skC/YVvo5fUtB3UotXK77sISaD7kMNkaWmxK86nqCdx8raKzzncxN82umM8BjxUoCWav+QI51I25PBLmu6cDuKobTJMJ0UxKP/PupoHxbAOw46HL/VJmSscn9nPqKk0K8debFfuOm1YzJ86vC2rKNMLa973pQ0PhGjTm8RoLyfc88q4poBK1g+6N2hYSNoedIBNIacQoZ84jxfls8Q/u4ms/hWkggcihfpmbB1BkS2vmJFcvy+aRRGpTLRQe6xzDbmUo5dXeJ1vHQbJiw2NKkSqGit0i4+SNMnGBsu5JMV0jLnYqy+CRK+a6bwhPs5RQMViEYUsTCXV+cHLAI+mb3g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:01.2333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa23ac0d-99b4-41d5-3ed6-08dee4347c9f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5049
X-Authority-Analysis: v=2.4 cv=e9Y2j6p/ c=1 sm=1 tr=0 ts=6a5a79d8 cx=c_pps
 a=E0//De2tebslxPhFmdrqCw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=XczTfz52Gg2yNcvB9tIA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX4CFy5B56fNLk
 f3Do1pn8CH2hUSP2k/oiHA7YL6FVHZ9ujKaD7/xY143wsMUNGGQcIqru3pfEGXoJdQql4ouuvdr
 BdKymm6BkT54OqdvILza8s99bTjre96fcc3oMeoutDwOzbzbAVeDcDedgvXQmp/Kf94fxoX51+t
 K/UppHqLfpG+twWEZsiON8jLkyb3xS4JMEch9wVCpP3egTxtt3c9kTmbTCB2uY56OGONe52ViAa
 4TjtOfeJoAfc1UpbhnWIw0dj3cc9VbFx3YqQLMYW9u4GYIT5x19vNrnSYKkGWT4LhfkAoZUw95k
 Kwh5kFpB8UETVjmHEt6Q9upK7fssFS/eFx17BV2F1R79nZbzL6ltY/nOpKfiFwAiRyqiCPB0HJ9
 wQAN+cU+HLJtFfpqch20Uyq72MsXGyY5LHoG18zAkNDWEoyACiJlUhityXLih1hPL3NZsleb1cG
 XsvGdX/QPfkxe9I3gWw==
X-Proofpoint-GUID: pHGCpxqNTw7RSQQTR5E1Vj9qF-n0e2ZQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX7JVojjRhTKba
 0tz74ghu9nnNRP6LjK/d6j0MuasnZoCkddR/Xk0RCtli0SnhA0cIg1RumFT28/Mo7SuW4Bda9Io
 ArZlCUL/XrQTJtIQrqdgHXC3qP+oUXk=
X-Proofpoint-ORIG-GUID: pHGCpxqNTw7RSQQTR5E1Vj9qF-n0e2ZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate.

Add the corresponding spi_mem_execute_tuning() wrapper that checks for
callback availability and returns -EOPNOTSUPP when the controller has
not implemented it, allowing callers to handle controllers that do not
support tuning gracefully.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e20eca1b8245..ae9e2d7ac6f3 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -660,6 +660,37 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning for high-speed operation
+ * using the provided op templates. On success the controller callback
+ * sets @read_op->max_freq (and @write_op->max_freq when non-NULL) to
+ * the validated clock rate.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if the controller doesn't support tuning,
+ *         or a negative error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f660bb2e9f85..ef5a6d60bae9 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -346,6 +346,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: run the controller tuning procedure using the provided
+ *		    read and optional write op templates. On success, set
+ *		    @read_op->max_freq (and @write_op->max_freq when non-NULL)
+ *		    to the validated clock rate. Return a negative errno on
+ *		    error. Return -EOPNOTSUPP if the controller has no tuning
+ *		    capability at all. Return 0 with @read_op->max_freq left at
+ *		    zero to signal that this specific op cannot be PHY-tuned
+ *		    (e.g. a hardware erratum blocks it) but another variant may
+ *		    succeed; the caller will iterate remaining op variants.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -376,6 +385,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -465,6 +476,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

