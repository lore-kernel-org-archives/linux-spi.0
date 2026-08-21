Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECE3C37A5;
	Fri, 21 Aug 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312975; cv=fail; b=jyVPchYy2/umsVwQOmoEIwLqub6hcI2bMVm5CUntEqsYQdoL8eeEQbEQUhd2Kmh2jJQ5/h9dRoaS3uF0Uf1GLwKhKkgvx1gUvLwcblASmSXJokLi40gczGHivSrYJ6Hz+C0baHpa8LsxHvaJODQ6sBvAF5fFMIqu/IG82IPqhrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312975; c=relaxed/simple;
	bh=Giwx2rrKgzNyerkKhGTq3O+MTCPxEYB1i6Ue4uASltM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E07xtsFDbUP+FE5ckw2L/OoXSsVi5pzuZ2ItZB4+s5FY59dPANpLqJPdBGZzrROAEh1MC7Rrl+b93fouxe4imGyP5VpkSZ2a4ZEDljuZEOeoLLA0ULF1lb8Yu8PxMY6yUFZFQFK187K0OV2QD/NWZVL6QzRiK7ErWxdX9TldrVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=PfclvTQo; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lrsTzWqT; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="PfclvTQo";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lrsTzWqT"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KNHq3254941;
	Fri, 21 Aug 2026 06:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=7PUSFr1CMLSKJQSYJa7YNC3gotH2wPORpfsTeMcMs
	DA=; b=PfclvTQoIly/+0rGzDm3dg0pLNl/q3kdXpdXxOilKPaKrzxMdKizHb0uA
	QrT0H/lO4eHt5/gDAqbL1O0XzvZRIhZz9DcWsFLtUH3y171gOFFLeGA+byIfqchO
	EIWgE+IKelGY46BgB+3Z0v65hyqWGTTu4ZqkLr2wAmHusTd1Rgk2CayQRkJDEWNz
	vrOxV+dgSDvDMWildJhvjKAUr+azjmTwmMV7XfvRecAS38W5A3CUvl04jVKDpjtJ
	AAoEfk4Azf3yISesQz6Fb3o+6bQz0PIU0zW3WadguAgon8p9k+1lVj1bwUGz7Mil
	/lnGjxE5/ezbG64joLPqzamDi8UlQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1ddr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAKAF+xZ6YgpEF9t0Kv3oeVLhwfVAsng789gkRld8G7x010v/Xju4YZ7glk6qhmAlJuBdgJKBIJNdiUXu/RO3ohNtoCZycivIt0LWtBcUz0eX3HEJcgjWU43ZadiQqJJbZEAxL04EJkvIG0xUucwg5yuMdrpSRPIoUk/HxVLUjlN8pYDLhlRbbXUXe1dGQvilXATGqsRncnkLWH3MzmK85oxHPNwl2eUkZB+WhN0Y1fga3HP6z8Km43AO7TMhxiujMVI/GgZXgAYsHuatwe3pdsECMSAODF54hyoka0S+9KxC7hx5xBBK7sdOLgPPlC9WksnSsD88PSdmAW9iSnEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PUSFr1CMLSKJQSYJa7YNC3gotH2wPORpfsTeMcMsDA=;
 b=ykOZiaW/rqxq/mmnLT8QVtEi2i15nD4G8FqArBtytvKPIk8PhxhMIWaotwvUBVz6UKmiSsUOI3lBpNPRGVomeCt0I7XS24s1ckdXjKUTKHzuw9gO+C9SgQNL3DvClIAMyCV1d/tkZ7RW6qKHdWYyfzegtYo08v3UtJpH8JEXnl9dHAMhU/fg+gdTReEr+8xyIryrEhEF5XCJwMu0pebxcRdH2Q+x+SugV4VbsgY9YhCpMeNdw+tmFtPT8rucq3YdPa0We2/GrXH3ZaBdw3gqhP2PT45T/QcJtk1DEJtPoL/7nUTv8X3B64RteZP9xTVLJGrUfoLfPoXtMEvv8WV9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PUSFr1CMLSKJQSYJa7YNC3gotH2wPORpfsTeMcMsDA=;
 b=lrsTzWqTDrKRmrVFsvc70jO083FPkYRCIQbAgG9LmAcIPQmGOB27FC66+BYb3Pfyfyu0y2vySicRNNA8txIZ82fxFr4KLN4PB86qTy+YEciWYB8Uq0LitgEVSDOw9baEIyn6/TF+3sixRYnkxt15jb7U+eABP+VMkdq+Dma0qxU=
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by PH7PR10MB6082.namprd10.prod.outlook.com (2603:10b6:510:1fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 11:49:13 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::8f) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:11 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:53 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:48:53 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVle2022942;
	Fri, 21 Aug 2026 06:48:48 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 03/18] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
Date: Fri, 21 Aug 2026 17:18:07 +0530
Message-ID: <20260821114822.4040338-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|PH7PR10MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6202d965-fc95-4bb2-3a9c-08deff7a373c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|921020|3023799007|56012099006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k9xloCUqI4ebJORK2gA1qDubc4dNz1eWJCneaiekxnI1EXdYHvUdJeH5LLz9123ixsNQSFPG+vwbvhuEZ7Jln85wlpvPaI67PabdqvM+QCSMQHO/0WAoCoL9/2K3XzmnpGS15creLIlt9+nnsRcEYIr8BtWDP3z6mVMtke9feehT79JJk3RWdFbO0uc8HUy7Nv5i2960uO+OGaGPam4czqNK7mTFaMawtpS5QchM3FOLyNUXGRcr3j23AiOAGPwaQAYKUdd6salOBHy4DOk6lQz5dIpY6Qllc19+16ZNhWv+tPRvVG4lI7NYwLPLw6uPIehKg+TlkvHWkVYgspASNjnpBssmlk5DukNUgi+ktNnzBdevZMLcsO3Ln2NCu3ZPZwqHRwmQYbK7QJDnlVAjpHUH/XeS8/bC1Z0j5CO3gyxk+OiTtbJAG4b+6AI/EqvMXTunhV99wKLU/EljhV8r2RTP/jVBut+UNxf/9Us4rseIO72mKKakKLYoTo2dTIgkX1DKKDAIYMFykkVsRV7amCIH7lm49ZUvDCYpLrOsvdzh3IeeUKNkbAqhGqpwPVTT5Xp14JwJQDJKVKnLzYC8/KKqogtbH9QSdKif0A9V1sZ4A5eoiG021z6K0fhiP412ykYNB8TqVs6syWg7U73+OVndlL/zf4hwKbkFHkB2EVFnFZXSJhVESReJxCNeJBPN+O51PepsEDi0qzSEdmFZy58Ik1dbhSYMkv7CFmdr77vmQfEu5MH+1oAq9wZo3jRl
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(921020)(3023799007)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XrP/B81iuWNu20j/3892Vm1VPwqjvv5412XAHHZYysWjF75u1Uuut/pXn0p0kSM5ZjoPn6kWAORq3uHHx9vivQyYtDn0WlFTjS4kAcPcKyb8Oql3mPBGBrG71edsn4x3j57JS155ThhuUrSFwTRr5y5ZYZJ6gP/OLffCX5uWkzi4kphVODxrk/vS4KMaDGGOcxff4INecsLQPmYWmy1SupnG1sdZP3jSjxVpDSR7mOjO2TziSfcoQLtfKyfcev+4qDEQZuhv5mKAGRFGHFLB0JmPIKgbFp/B+v44eGYOKWMW444jSQSNGaRpL9Dm8gPfOb17Y36TjdcmFXoTbnxLfgyjpLSBscCS9tA3uoDEX8ERX4qdIhQlZso4HHfGRHZ9b5AF/I3neTZbM8u/P5KytxDhfVl5cfy7pOSjEmKyvtsWBONld0NY3/v4YPlYkHCL
X-Exchange-RoutingPolicyChecked:
	qEDt26lWrRh1EO8aDsdBWua7cPcacQjp7ai4dnTWHf+bqiF/LNTtH6uBfwCSeIh0NVOslYBcblXA8c11/WVSduNM76Ikk7sTmUAhM3gCPh/4dCY0OyF8knKQwautF5QKXn5FMpqHLFWg3qY3ezvSJS188KPDIWS6Fc30R84hD248klXeHAQpWezAtPq1bMxz4HwNkfIbGBOlPfb+AdEI51wkX3GDw/iRS5ZOkD0pWpWtFrAl5CJer1wfug0ihUJQMFjfqzVDc9zaa6prA+d7uHwava9G4e8afY8bRmZJ4R43liSUac5urNAXw7QFrxV4PIS5aMozC64M0mZs+cM1SQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:11.0005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6202d965-fc95-4bb2-3a9c-08deff7a373c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6082
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b3e cx=c_pps
 a=/8oI+ICX6VsmSI+SRIYafw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=2Gi1gDZmOG9PIfG5304A:9 a=O8hF6Hzn-FEA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: QUn0jWqH5lDaAxBvBE5ayEf9z2mvM3oQ
X-Proofpoint-GUID: QUn0jWqH5lDaAxBvBE5ayEf9z2mvM3oQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX0avDnTlKNgqV
 p7/tml37+e4aIahhdBUStAERldiLz2O7xhTC5Pg2uIa1ZjXLh4Hi8a+oVEPNB9CvyJ28CFnKZeq
 yy1TSdQj4U4pCzCKDDemC8lq+seooW4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXwU1ou5uTmZ+7
 iyBVUKNOOa9Pyjx5ZiIQWDnlWVFWiCRw6T1jA1obgM/qIwPHFEkWzVazftlssbR9grnoV3Qqogl
 BuT6pJCKRW5DuyD9Njl673f03SbpcNLcdEPyIq7nNcB8JpagaIxKcsuY0S/I4CWsv0aVg20gB+/
 6uvKib+2eueyBxpp7V3g0jZ30EitJVeBhUg9cPNs9A4nXKHHSd78M8UNvB9nUOh2KnOvi1zDHhn
 3vfmCMrMZ3RfQSNZTrkgAEMXHatTHM/MD7LZVgdPpjOB0WkJ8xVO/7icPq5EcoXXnuk0oNfnqYP
 9Xq5jR5nTvx0j2DbtaPDa1cseFsSlnEiGwC2guA8Z1OGwNiOA1Cm6Hjwi2X/ChggshO9HFUAkfV
 ZyS5aNXzgTStf+WMUagkwN+IqR/gWCU8EfaMv7WJTucyV35ipAx75dVQVCUSV8/ONUPst9fBqdW
 iDEvrlli0jqt6VbZcCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency-hz DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5b5b3bc5f0d8..6b01ddb7cc32 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2800,6 +2800,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency-hz", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 88d17fce02dc..02fd602f29e8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -141,6 +141,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -195,6 +197,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

