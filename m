Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1039182F;
	Fri, 17 Jul 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314335; cv=fail; b=BIhbMZ61xeElanyZ0WG21ZkWNsnslnkSTPf7qxd/Mk3D469NBcdvSKkgIaRslavBFSHyTL2yOpZ71rq95L4lkb12BFwuKuTwI1MxtJKjPiJjVw1NrUpxrwnSw72+0/M3sziK/e2zVY5oRSHXq8x3MxID4dPpYVb0fRcAVE0PSu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314335; c=relaxed/simple;
	bh=ff4xKPF92zG+UqX9X1DnD+Zr7KTxJ/jAWu6wJ/4Oq0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuq4srlqz030ep6XBxyTOnpneLEVpAM7bRf59Xs813azQ2+W2WbzBa23uzyUqcnGr3U03n6wjJorpZb3YIHeP+9i78SEHCx9vTibfLnxgCFc59GAlDh4yI6xTBfdRMZ6UdlAfRy+ZFhZvB0ndobdRr4AAhOng5ttm9hXK/62wag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=hETqBNAy; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BMTQ04g6; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="hETqBNAy";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BMTQ04g6"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlKJi3222741;
	Fri, 17 Jul 2026 13:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=s3F6sYAM/ogfoAVPG0gjK+a53a3vaB1nPkLfBLzOb
	rk=; b=hETqBNAyocRKRfO6ITFHXYg4dp+ysnJHC83jFmzTY4Vv8HQPYJ2uJv0H3
	I74N+EJ6TvB3BLZOeGOL9QVsn8xhkeOzi3teb7eaBD1vneofaNvJzDU6AkKRtoik
	XaG5Dz1RcjjICT/w7K7sn7i7dDe3827zZ7pRppC0ovU7cSF68ExyuZznfdTsUB30
	oWoISiuvJlzR1B63nT+3FfvePo1pY2mYma3UYvxj/8vEa7Bo302ZnrkVb3xzKQhg
	naBA8wcXngnqW7loNAnoPFwPg8wXePpMs4sMx2g4N3KXkJPcw0TVkVAq8UXHx7pS
	DSPkaNJ83V2tR38snEmJW2upA6Z8g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3jtvs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:51:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhwmuLhBA7YEzRouDhgLeN7d9bUB433K6bKXIl2dBTXOu0f9FTekS0tBr7xC5jilhJh4Ukx0DwP3gxuORpt/CpJ6K0DRmlXn4ehS7GV5s0eGcmMCe0KHvEb6vRICW6M9MSqcmDzGsBH77egP2X2wEOQmicoBX+WVgIJW+QY8kpyh8PLVEs6nNpJFet7ly67/vaPJFMOBw9rzf+oe+rUZrXl3NlPY+heMfRL5RcntYQd9JnhwAiVtqDc51oxYtYpeqJO7DehCZyPbWIDaFP2oeEdIqR+vwnQ61rBuijch+ZbBKmkkui7vOi+HOSd8kb3/PDMMfmAa5mc2/Gv1AJblKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3F6sYAM/ogfoAVPG0gjK+a53a3vaB1nPkLfBLzObrk=;
 b=xvLJB1VwBvyhjg6fJlNQwU8O9VHcam8fKxpt/0C+PAIVUITVtqy+m6pjOjcEIo7FSzf9RhA0y2y8vEW5ud0ZdabIhQ5SvvbnIHu0PUSEK87L+xYKytLyv3z81xS8tttX9/priCpJY2uwSEcKAqTSFKaDjov+jnhnA+fZfS5T+0IpbBYD/tPn4Hh3LwGGzczbcq4QS2dtcC6AGtUUAa63uDES7sZCdvQYVatnKbM1AAaP0SwggeH1Y91iXBtpDWjPOoPwYmHHgKYYoa4bhdMPpOUqDi4B1UO11v27DwczZSH3KnT0XkVqnJlJk+QRLwno5w4etOxd/rKYw+ZIoEw7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3F6sYAM/ogfoAVPG0gjK+a53a3vaB1nPkLfBLzObrk=;
 b=BMTQ04g6dUPi2Bd+7zV6jrsf0Lqm18Gq04zGvLKhjEFpKYHmR9rGEO3m8HVNQiOl7YFF5rcBW5vgBpeBUwJsBniyEDFJZl6osbvN/59KtdjCqFiDf3xC2+W6X78CymiUEntV/0RWqQhbDE34By3KKtVMHjVK1q7Alax88qFY0oE=
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by CH9PR10MB997880.namprd10.prod.outlook.com (2603:10b6:610:342::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 18:51:47 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::d) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:51:46 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:51:45 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:51:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:51:45 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4m240969;
	Fri, 17 Jul 2026 13:51:40 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 02/17] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Sat, 18 Jul 2026 00:21:01 +0530
Message-ID: <20260717185116.2065505-3-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH9PR10MB997880:EE_
X-MS-Office365-Filtering-Correlation-Id: 06355972-1537-4aef-548e-08dee43473ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|82310400026|1800799024|3023799007|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KFjVt1XxUYncDgDzJc646VhYmdIr8cVsGPIIWyahpWoctUyW2mRBflxqIgUudIpPPyZ9V8NPIJjbDyk6qwT/n49kKO5jC1lc4RgRAera6Tn32AXc7riqNXDlIqb+N5DkFiRPcpqL1d5KbjcisKyrnhgfOrO44Zrr92EEnSfcEanR/ZI7zdLya8UCkQGWZSesN4HFzs63UcSKlss43hBse1H54G+c30HvdvpGyug8F/ikaXX3kisQTabuPZ3p5ZWHLCsFBLrY90tkcB/CWDJpuQeTuqsomKNHof0vSoAyPYEd4/jLumGTg1iOA5DHc/bpf1Rt3eNopsOxW5rF3NVSejkPHbhw3LqkjH+SPSNp8tWrVgsOS7ZvmsZKL0uKfEfHYimlH/3hyeLSCvFJ1ohSHs55/5lX6MAjN0W0BPvDEiDhLW82g2FSUNE92AEgCJFVOK954ViA/HaiPoW0+B/0SZmbgg/5EJsIcIF1wkycqbiKVJOxDnHlFb+IEOuaJYgjI/ZQFD5F9xqUsskeXgVNIX+YSP8P5Dhdpy5W+hXwPFPUfHron/WTL4G0TE9HesTBa5/EdrLQIY8a3a6CsBKmKpD1s+CkZRS/VdshHdmpGNQ33AWuKpErcifOkLfkSQBh6jrLFbyTfqYaJNg2fNgFbV4LOgz8ltP9H/bjKvAwe3sfc7qfkTxPjGt07jta+d3g/4Umn0Ar6Mx9swrE2CMwyDl1nvdptMKTDTaxmxUHVQHVAcq5KYdIv6XCRmTuZJCa
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(82310400026)(1800799024)(3023799007)(921020)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1axJP5eUvMsUih4IlrrHHfN8ZSx4//L5pf3nk/5pYkrOgnESfryJRDBvQFrsXktgf2A4if88trsAOgRRGzsO2dfFlJnEQeoUTKStWTi1UHunVR3GsB6x9FBlEsz4Y5T4ZoCd/l1tRZt9sdnRzRyo9jwZEdrAaT3cUtHgy/EQZExh8ekIxLyPBWFsqoUnuukQCXq2IVHAMwBdJ5MUrnPQKpGY7xwI1ZMWZipc+FF0zF3uq57lXUIWJBfJFe8vfJ32EqCFjEkzlyg9Wijfd0LiE1VP09s4TBRQgBsD0hQL3fDAEtMLrfCdqxm1mP/e1s4H1P6S5Z1hn/7Q8HkziFfJvWFN1vHx1JVT++esEi9SQEwqoN1CI+qMR6MIUN7uc5Fa0nwiGfo0zRu5AnSxu2cImRFy4Py034OjxYAX/lm7JWOBvm7+OK6xFI3xUIyyT/P2
X-Exchange-RoutingPolicyChecked:
	Sa8wbmRK/SjgKYGWRg3kZUU8RrBK7RtE7LeFvrFd/h3xMRSe7NH/7PhAo9O0RAjotFqWQo27AqYXlVhcHFHxyb9UiRzyXdqPhJYkeI6/HofsFNX9lEI7iMW94FEIsrnnoApAsnJVNvRioFg1AjxNMIjnDmfjU/oStlQPHK6LSFVNRssV6bBbh/K7iee8k+PKAeCx0Fvd/Ka+mMwHbpcHEXdP88FTPDR8ZWazsdUUHPkeXGe7wo7NHLFl76Qe92O5oagc45cCxtFyvWnGBYepZjd8fyp9uq88Kht9ZBROk3qR45taTfudwMZp2kGqssM+/Fdk5F1bXgA+RyFNvRcXGg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:51:46.7806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06355972-1537-4aef-548e-08dee43473ff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR10MB997880
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXwaJ94JcOlZK6
 IYRXa4bQmMBLT+H4xr7gdvIHzp2CPGVmp0TkOOnXCt/G1ynRgRcuuSz2nXu2BBx2PlGufvKPNWp
 cHCG92VMUXmAULbhPlPlduMPM87dzqE=
X-Proofpoint-GUID: qbkTxXABIGmkpn5PEyfCcvZzI1SkW2br
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5a79c7 cx=c_pps
 a=6wX/tLcgNF/HagpTIcwFsg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=aBuQwODoJmrdCVe4joYA:9
X-Proofpoint-ORIG-GUID: qbkTxXABIGmkpn5PEyfCcvZzI1SkW2br
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX4R5r1g8GFTck
 nieOaCz46/7ogk9SJWBmqxQ4fXC9uRUxvJQOktJdG+Ruu2O+dAbpFp9S8q5t1v49ENU8zyGgO82
 sGfVVIn3TwTdzvbSV2RtJGI8UREl78kUlYI54WduJ3mk38A7o+cxFb8Zki5oe9J0d8Z0ZNlp+1a
 ZRd4bwjfo1QbGL/KsgRfgVnMZW2MDcPsfiK+sFpz7oFo9TgYbA2GcqOfgkjbMwGFnRwy1Q+WYeW
 wjMLtC3pTfbO/WbWSs4ce9qh+hH51KUnrFsBE62eBPLKqJel+jAVVZvMVqBGa5+ZFtIR3pTwOeT
 hJeLYawh05BJ+USfd/N+yyXu+G/GxfyOKCvtHSMNcBFmEajZb9TidoUtnaYEETq8Af10s+67Sc8
 ZjwDZpy4mWKzpnhoDBfJ+wzWORVdXp+PuE5n10bAiqf6se/ZcogLam1UZf58ST2uKoPyfcwSl0g
 9pMN4kIeaZhHjK2mDJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Add spi-phy-pattern-partition, a per-device phandle property on the
flash sub-node that allows the DT author to directly reference the
partition holding the SPI PHY tuning pattern. Used to locate the
pattern data during PHY tuning when the device cannot load the
pattern dynamically.

PHY tuning works by reading a known data pattern from the device
repeatedly while sweeping controller delay parameters until the
capture window is stable. For SPI NAND, the driver loads the pattern
into the page cache once using write-to-cache opcodes, then reads it
during the sweep. SPI NOR devices have no equivalent opcode, so the
pattern must be pre-programmed in a dedicated flash partition. One
partition per device is required to keep the procedure unambiguous
when multiple devices share a bus.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml  | 17 +++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml      |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 891f578b5ac4..277dedcd4246 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -209,5 +209,22 @@ examples:
             cdns,tsd2d-ns = <60>;
             cdns,tchsh-ns = <60>;
             cdns,tslch-ns = <60>;
+            spi-phy-pattern-partition = <&phy_pattern>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "data";
+                    reg = <0x0 0x3fc0000>;
+                };
+
+                phy_pattern: partition@3fc0000 {
+                    label = "phy-pattern";
+                    reg = <0x3fc0000 0x40000>;
+                };
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 12211f8c9f7d..d506807c128a 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -122,6 +122,13 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-phy-pattern-partition:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the flash partition holding the pre-programmed SPI PHY tuning
+      pattern. Used when the device cannot load the pattern dynamically during
+      PHY tuning.
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip
-- 
2.34.1

