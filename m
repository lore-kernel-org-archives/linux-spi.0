Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42C361DDC;
	Tue, 25 Aug 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678346; cv=fail; b=ZWb5n12L3k5+Hzlvnil9GYPzaaWnzDCJ0ula5a7qa/K4VQtYm1cHMGy6YOXZneUO9lpL8wz/UTyEjIMtqBvAJpC4Zo/homm0z0WE2sQUv67ws38nrlPGcGzQI5KYPl0wUDdhwt3cGuhHfoG4311L7Zx7ujUOzKRGLDUiAEEuu+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678346; c=relaxed/simple;
	bh=wkuVrnarmxIasMn5XiDmmKRWot8VXCo2/nUct9KblTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2TfMbz0pktkBY+dU4wWwCe7HiZPzoBJwTzTTS1UcfchxbSPIWkMCNbCtg5dNE/rfxtIatE2gKD5yCpXtYUzmWUQQW3RaMdcO3/QqXKd4r8g286vcC/WygLPS7qwyrUsR6/HGfgyTkF2zY7/0t1Dy+GEoXTF1T8e7Kl8sR9hQaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=hsE+a3sD; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qfO4u1fT; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="hsE+a3sD";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qfO4u1fT"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVCGY1690296;
	Tue, 25 Aug 2026 12:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=MYdYEIO+db/tf2el7FGAKremTcY0SN0NBVl9kaFm5
	O4=; b=hsE+a3sDQSxtoLKzySBGfM8vXLZvQ3/vCTEmEKI+IRkj9PVP/0JfconUJ
	V/SoXNL7OpyTCfW/S11l1rT10micuVdnz+18OXzfmUtxA80Rs37iF4jtLmif++5Y
	lk3rmMHKMC67eX+QtdPrNot/KtqjxM01N/G2Qr3Qb2lhNR9txcY8TLZt7t3mfieB
	qOQqVD0Nbt+HQRlBCfwsnwMxnzfiFcpI8U4cYKqCumPaCP8GSSXZwpUEUTkrFj+f
	F6ZYBJ2E5zu18F7WYqukMtBw8KyGjLZ2n+kAbPcDBCyivU+rt6Yod/pKaZ4IEcrg
	Ym7Uw8wIqcs5WYId8DaIpcL/JwYvw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g8xf0dbxh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2ORWg711SlkKYkbD6XE42gMd5Fqv12ESLwiBb+ag5s4UyIauUj5oDRE9qALzGLaMvXrgS8Aq3i3GnhwXyvobOR7wthjW74prOrtznDBnhlfSNGdz+KJQXGvjsRH+jJy2K2Ka2JDpq9EzTRhNNpTJKXUU7CrlBlOk4xpH9IrhSsYZsGfrrBXy0pDnaNqiK/Uoo0UKv6h3eYFsDX1A6ReLEwoCuOv+ASXojIt+qie0cmzU6HzFTvEkXJD0VXlxq+loymgi1Ri7Qw1Gk73jdvzE5EmpQWfbmp/9rNPiwmMfmqShc7Rr3QI5FfYS5+kTfIxth9GrTWtbyHMjNBme5Xhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYdYEIO+db/tf2el7FGAKremTcY0SN0NBVl9kaFm5O4=;
 b=wtR80Cnz71wv8BnyvVkIU7ml3Npw5iS66XbY/demgz9iins5GdTkCJ0fG1+eX7gTHioLhjcgNQBW15cy4LIJJmwB+cqFYQ3VLW7C2AgylySYvjTLSI73AsYkhF9mIbVWUUp6isYYOYdcb5NkI82yKnNKYfUW4XEOZ/miwdwkVR4jZdmUArGNggms0bg3KyOLtGauMgTawGn3OO9imFzKzv51Eb+q2mPES3g6vCvFPjW3w9HF1tDGUML8O3GH0kfeXBFzSw9UiujosArO9W3eMO+Qs6MJ4H2Yv1IjKyV3TlPP2O4hQi/p1+4QRfTz/Qu/lx2HhoJ+TUlPP7eB1ZHkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYdYEIO+db/tf2el7FGAKremTcY0SN0NBVl9kaFm5O4=;
 b=qfO4u1fTJlY+V+NFiDJEGNqxVr0690mQtVKmiHVv72KziF0hP4tTOAWLlp/Sb006TMuFaTCzphPk8aq4LvkQnWYPvp9FKBC0AMFVL0RKkFtjT/vcy+iKV4UcLaQfVUNmo2bIDfrEabtc2QHOJgRVKe3OrgRWAJhIKIyHzDmSgO0=
Received: from BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::14)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:18:36 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::8c) by BLAP220CA0009.outlook.office365.com
 (2603:10b6:208:32c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:36 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:32 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:32 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3X1436664;
	Tue, 25 Aug 2026 12:18:27 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 08/18] spi: cadence-quadspi: add PHY tuning support
Date: Tue, 25 Aug 2026 22:47:27 +0530
Message-ID: <20260825171737.776052-9-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|SJ0PR10MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b66a53-8b9c-48f8-dca6-08df02cce5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|921020|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yxXJYj24YRIyBohd8Jjeac8ctppT9H3qTAdoeETrxsolGVF9vumuKgZo6rqM820XzdCadbTm+8ndur9KuYbNtyfx7ddOp0sMkaeRiTNPNV5h5cWr0oL6eVX0kQ1WED7yXnTbCfmxMyABeYAaRBWRFRz0C6JyuJMOgL+vEnTQcc2fIwp+JBssQ4pxz9uYCkcv594GTIhm775jXm8xpDbrrCXTKPR0953Kh29WRBP5xFhg/2oseDtAiIiYWTco765EyZCiq1V4jy99o9yXP1hEGC897zwx4OF+i+AjRSbSK7bc34DvKfbqxnclXg2Q9q0xF30FmBs6EtywG6AIlGp82QKKZHFxtKf2ynQFzQvGndPiHhWS/eQxm1lcMw3K0FxYNjSwFs6/MUpGM0R0n1fz0TmRiqPjQkRyT25iJTlGb3DGqpPe63QbN+uezsfETjhjKFQ39WjYjrxKl5pwlMEV/8nr6hxkcauyeVacd+fzGhdhvCxKXSbF3dRGYSeB4kxMipVOKolqy64Cvu2KgflGABWq9BMjNqtt9BXGBfJxt0KfewNaq5jLzdgm1ZWbWx070jqyQui/rfDtmGwxeeT1c8Yxq53YVUudoc//sg1xmjsxm2H5pI4iKc182lFy26eBhzY4DIYEKOdFS3y6BtFkjHwkFKn4iBY5rAgA6PTEdf2q+haeifkLsBtbr+CnsyWC
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(921020)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EE6rKOOXRqTveuzR1EVJtsHx4KYaleu52vLOKa6TXttajXsF/PLasP8aEot5htSn4fWFL/PyMLtFXmH7C8VZFmM6Nkr77ySiJjOZSP3ugUMVaOgeWWfm3bScdfu0MEZhmPuGIsh8HtvtG6yboEpgg3rO0wju/FxPngl1nwHgm+jOta0eKMxtf1c+7QI6oXnHT6mSnFV/f1aD2iUmzmQnCU9yT596sIgsqKhya5sqX3GSPD1UukyAOQLi3BKtwDC2gdyzr95F7s3zmdWC80un4i1r8P4u2UFwiQGBC2QsdPD9V/WXqxOHit3TmoYyaL0+Wv8/44SDJMWygcL12+3kY7FBcUKO+B8pWQf6g0oZlykr7x8SgrS4jZ7+HTyKXnpNPrNbvm93j86UICjCzK5w+/VesubSlzgm6llYni9n34Sb+1AHxRm80rNfEtjdY5s1
X-Exchange-RoutingPolicyChecked:
	TR7O104gIggLn9vD3FnaPS0f5eNR2ip2jsFECdk/gRX9cqIcSLRswV9d6TC5DSfw7yZDQg+HPKVwCzoyEHD9ZdS+fcWsJc0rDGATcFyJrnuMhRadNcPRAjOlvhTUuFiia4S4geNlH0iw9s5fZhz7HSQ0uvzFEd+zzt06R0B2MEBzm13x2GP7ih869l0vCi7wTu1mq/oW/7+zwxzocp5LamVmB/oJjkSWb7yzuEFi8secx45VABgSzkpELpkAobNDiBKyFikUuACoJDKjVzwi43zkx+pwKqnIUtXX0pPJmZHCrtzNXXwaqvwn7NA6Lqh2xsOc7WXW+W7EVdN19EBesA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:36.0833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b66a53-8b9c-48f8-dca6-08df02cce5ce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-ORIG-GUID: vTE_iWWKeBJ9745OJszvjfbBuQBbzK0G
X-Authority-Analysis: v=2.4 cv=Fow1OWrq c=1 sm=1 tr=0 ts=6a8dce76 cx=c_pps
 a=xBU3AFOX62plvdJ7VrUh9g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=MlhAJnQaR0iBW2fQ34UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX4+XLnV8TDaM2
 p8e4r80+tMyDYU/up2HScshATaMniORg2S1GZYYVGuA2lHkJIKFS1/u1MhpzMAmNyuhkUG/87Aq
 drkYOOYxivSY/Q+IVRZepbvvRM2iUkQ=
X-Proofpoint-GUID: vTE_iWWKeBJ9745OJszvjfbBuQBbzK0G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX4pPPhb/JdfR5
 VqAcueucNTMTPE12owm3w74hIZ3oRYYK7TS5xPEuz7TbcXS+FU7sE0Gff+1VKTgovwVSiI/4cxJ
 bgEJeVp+J956mWts/M42hKBv7tlWEl7mGgiYUfOPfBdkFD907USzyORS+eNc1gRWlgr4AKsJTrH
 axwzDemY6B8uUSIGuz91wMrYCmMTmbJwdyt5qflybUoopamlXMtQDJtmHeoBEIpkfM+MYrZmdhM
 5YUNxvjMsOzWfpeZjsiYuYXLMQMNKh/2aNWDh1mdOCY7uuVRRe2GLvaPsYzUpO+qw2/b/YQDWqH
 tTbw+79JAahIhGzM2MGhNqB/TTGPpuAHYtMkRV4vrNDSFQeDtlVFuXbPRwCbI2Ks6tnYruBJ0CX
 mDRdutP+MeiUZRlR/JSeY84HypRxYt+yQudMKC4mIjXvLDBp1shkZli1ZfSstQf639y+iUSeOsi
 Zes35URJiWcq0fEV+Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

The Cadence QSPI controller supports a delay-line PHY for high-speed
operation. Without calibration the PHY is unused and read capture relies
on a fixed delay, limiting throughput at frequencies above the base
operating speed.

Add an execute_tuning callback that performs delay-line calibration using
a known data pattern written to a dedicated flash region. The pattern is
either read from a NOR partition identified by the DT property
spi-phy-pattern-partition, or written to the NAND page cache before
each calibration read.

For DDR protocols (8D-8D-8D) a 2D sweep of (rx_delay, tx_delay) pairs
is performed to find the widest passing region in the combined RX/TX
space. Binary search locates the gap boundary between passing regions
when two separate windows exist; the final operating point is placed at
the centre of the larger region with a small temperature-dependent
offset.

For SDR protocols a 1D sweep of the RX delay is sufficient. Two windows
at adjacent read_delay values are measured; the wider one's midpoint is
selected.

The tuning infrastructure is platform-specific: only am654-based OSPI
controllers populate the execute_tuning hook. All other platform data
entries return -EOPNOTSUPP and are unaffected.

The calibration target is sourced from spi->post_config_max_speed_hz,
populated by the SPI core from the spi-max-post-config-frequency-hz DT
property. Tuning is skipped when post_config_max_speed_hz is zero.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 1774 ++++++++++++++++++++++++++++-
 1 file changed, 1761 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 046fa5d69b0f..f7cda1bc7139 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -6,6 +6,7 @@
 // Copyright Intel Corporation (C) 2019-2020. All rights reserved.
 // Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -65,15 +66,28 @@ enum {
 
 struct cqspi_st;
 
+struct phy_setting {
+	u8			rx;
+	u8			tx;
+	u8			read_delay;
+};
+
 struct cqspi_flash_pdata {
-	struct cqspi_st	*cqspi;
-	u32		clk_rate;
-	u32		read_delay;
-	u32		tshsl_ns;
-	u32		tsd2d_ns;
-	u32		tchsh_ns;
-	u32		tslch_ns;
-	u8		cs;
+	struct cqspi_st		*cqspi;
+	u32			read_delay;
+	u32			tshsl_ns;
+	u32			tsd2d_ns;
+	u32			tchsh_ns;
+	u32			tslch_ns;
+	bool			use_dqs;
+	bool			use_tuned_phy;
+	bool			dll_locked;
+	u8			cs;
+	struct phy_setting	phy_setting;
+	struct spi_mem_op	phy_read_op;
+	struct spi_mem_op	phy_write_op;
+	u32			phy_pattern_partition_offset;
+	bool			phy_pattern_partition_valid;
 };
 
 static const struct clk_bulk_data cqspi_clks[CLK_QSPI_NUM] = {
@@ -117,6 +131,8 @@ struct cqspi_st {
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			is_rzn1; /* Flag for Renesas RZ/N1 SoC */
 	bool			disable_stig_mode;
+	bool			phy_tuning_active;
+	u8			phy_saved_dummy;
 	refcount_t		refcount;
 	refcount_t		inflight_ops;
 
@@ -129,12 +145,15 @@ struct cqspi_driver_platdata {
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /* Operation timeout value */
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
+#define CQSPI_DLL_TIMEOUT_US			300
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -148,12 +167,14 @@ struct cqspi_driver_platdata {
 /* Register map */
 #define CQSPI_REG_CONFIG			0x00
 #define CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
+#define CQSPI_REG_CONFIG_PHY_EN			BIT(3)
 #define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL	BIT(7)
 #define CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
 #define CQSPI_REG_CONFIG_BAUD_LSB		19
 #define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_PHY_PIPELINE		BIT(25)
 #define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
@@ -192,6 +213,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_EDGE_LSB		5
 #define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
@@ -273,6 +295,28 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_POLLING_STATUS		0xB0
 #define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
 
+#define CQSPI_REG_PHY_CONFIG			0xB4
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_LSB		0
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_LSB		16
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_DLL_RESET		BIT(30)
+#define CQSPI_REG_PHY_CONFIG_RESYNC		BIT(31)
+
+#define CQSPI_REG_PHY_DLL_MASTER		0xB8
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB	0
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_MASK	0x7f
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_VAL	16
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LEN	0x7
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB	20
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_3	0x2
+#define CQSPI_REG_PHY_DLL_MASTER_BYPASS		BIT(23)
+#define CQSPI_REG_PHY_DLL_MASTER_CYCLE		BIT(24)
+
+#define CQSPI_REG_DLL_OBS_LOW			0xBC
+#define CQSPI_REG_DLL_OBS_LOW_DLL_LOCK		BIT(0)
+#define CQSPI_REG_DLL_OBS_LOW_LOOPBACK_LOCK	BIT(15)
+
 #define CQSPI_REG_OP_EXT_LOWER			0xE0
 #define CQSPI_REG_OP_EXT_READ_LSB		24
 #define CQSPI_REG_OP_EXT_WRITE_LSB		16
@@ -321,6 +365,50 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
 
+#define CQSPI_PHY_INIT_RD			1
+#define CQSPI_PHY_MAX_RD			4
+#define CQSPI_PHY_MAX_DELAY			127
+#define CQSPI_PHY_DDR_SEARCH_STEP		4
+#define CQSPI_PHY_TX_LOOKUP_LOW_START		28
+#define CQSPI_PHY_TX_LOOKUP_LOW_END		48
+#define CQSPI_PHY_TX_LOOKUP_HIGH_START		60
+#define CQSPI_PHY_TX_LOOKUP_HIGH_END		96
+#define CQSPI_PHY_RX_LOW_SEARCH_START		0
+#define CQSPI_PHY_RX_LOW_SEARCH_END		40
+#define CQSPI_PHY_RX_HIGH_SEARCH_START		24
+#define CQSPI_PHY_RX_HIGH_SEARCH_END		127
+#define CQSPI_PHY_TX_LOW_SEARCH_START		0
+#define CQSPI_PHY_TX_LOW_SEARCH_END		64
+#define CQSPI_PHY_TX_HIGH_SEARCH_START		78
+#define CQSPI_PHY_TX_HIGH_SEARCH_END		127
+#define CQSPI_PHY_SEARCH_OFFSET			8
+
+#define CQSPI_PHY_DEFAULT_TEMP			45
+#define CQSPI_PHY_MIN_TEMP			-45
+#define CQSPI_PHY_MAX_TEMP			130
+#define CQSPI_PHY_MID_TEMP			(CQSPI_PHY_MIN_TEMP +	\
+						 ((CQSPI_PHY_MAX_TEMP -	\
+						   CQSPI_PHY_MIN_TEMP) / 2))
+
+/*
+ * PHY tuning pattern for calibrating read data capture delay. This 128-byte
+ * pattern provides sufficient bit transitions across all byte lanes to
+ * reliably detect timing windows at high frequencies.
+ */
+static const u8 phy_tuning_pattern[] __aligned(64) = {
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0x00, 0x00, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0xFE, 0x00, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0xFE, 0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFE, 0x00, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x00, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0xFE, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0xFE, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0x00, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0xFE, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0xFE, 0xFE, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0xFE, 0xFE, 0xFE, 0xFE, 0x01,
+};
+
 static int cqspi_wait_for_bit(const struct cqspi_driver_platdata *ddata,
 			      void __iomem *reg, const u32 mask, bool clr,
 			      bool busywait)
@@ -913,6 +1001,76 @@ static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
+static void cqspi_set_dll(void __iomem *reg_base, u8 rx_dll, u8 tx_dll)
+{
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~((CQSPI_REG_PHY_CONFIG_RX_DEL_MASK
+		  << CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) |
+		 (CQSPI_REG_PHY_CONFIG_TX_DEL_MASK
+		  << CQSPI_REG_PHY_CONFIG_TX_DEL_LSB));
+	reg |= ((rx_dll & CQSPI_REG_PHY_CONFIG_RX_DEL_MASK)
+		<< CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) |
+	       ((tx_dll & CQSPI_REG_PHY_CONFIG_TX_DEL_MASK)
+		<< CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) |
+	       CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+}
+
+static int cqspi_resync_dll(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~(CQSPI_REG_PHY_CONFIG_DLL_RESET | CQSPI_REG_PHY_CONFIG_RESYNC);
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_DLL_MASTER);
+	reg &= ~(CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_MASK
+		 << CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB);
+	reg |= (CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_VAL
+		<< CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB);
+	writel(reg, reg_base + CQSPI_REG_PHY_DLL_MASTER);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg |= CQSPI_REG_PHY_CONFIG_DLL_RESET;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	ret = readl_poll_timeout(reg_base + CQSPI_REG_DLL_OBS_LOW, reg,
+				 (reg & CQSPI_REG_DLL_OBS_LOW_DLL_LOCK), 0,
+				 CQSPI_DLL_TIMEOUT_US);
+	if (ret)
+		goto re_enable;
+
+	ret = readl_poll_timeout(reg_base + CQSPI_REG_DLL_OBS_LOW, reg,
+				 (reg & CQSPI_REG_DLL_OBS_LOW_LOOPBACK_LOCK), 0,
+				 CQSPI_DLL_TIMEOUT_US);
+	if (ret)
+		goto re_enable;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg |= CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+re_enable:
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	return ret;
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1323,8 +1481,9 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
-				       f_pdata->read_delay);
+		if (!cqspi->phy_tuning_active)
+			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+					       f_pdata->read_delay);
 	}
 
 	if (switch_cs || switch_ck)
@@ -1559,10 +1718,1594 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static int cqspi_write_pattern_to_cache(struct cqspi_flash_pdata *f_pdata,
+					struct spi_mem *mem,
+					const struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	struct spi_mem_op op = *write_op;
+	int ret;
+
+	op.max_freq = mem->spi->max_speed_hz;
+	op.data.nbytes = sizeof(phy_tuning_pattern);
+	op.data.buf.out = phy_tuning_pattern;
+
+	ret = ctlr->mem_ops->exec_op(mem, &op);
+	if (ret) {
+		dev_err(dev, "Failed to write PHY pattern to cache: %d\n", ret);
+		return ret;
+	}
+	dev_dbg(dev, "PHY pattern (%zu bytes) written to cache\n",
+		sizeof(phy_tuning_pattern));
+
+	return 0;
+}
+
+static int cqspi_phy_check_pattern(struct cqspi_flash_pdata *f_pdata,
+				   struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct spi_mem_op op;
+	u8 *read_data;
+	int ret;
+
+	read_data = kmalloc_array(ARRAY_SIZE(phy_tuning_pattern),
+				  sizeof(phy_tuning_pattern[0]), GFP_KERNEL);
+	if (!read_data)
+		return -ENOMEM;
+
+	op = f_pdata->phy_read_op;
+	op.data.buf.in = read_data;
+	op.data.nbytes = sizeof(phy_tuning_pattern);
+
+	ret = ctlr->mem_ops->exec_op(mem, &op);
+	if (ret)
+		goto out;
+
+	if (memcmp(read_data, phy_tuning_pattern, sizeof(phy_tuning_pattern)))
+		ret = -EAGAIN;
+
+out:
+	kfree(read_data);
+	return ret;
+}
+
+static void cqspi_phy_set_dll_master(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_DLL_MASTER);
+	reg &= ~((CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LEN
+		  << CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB) |
+		 CQSPI_REG_PHY_DLL_MASTER_BYPASS |
+		 CQSPI_REG_PHY_DLL_MASTER_CYCLE);
+	reg |= ((CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_3
+		 << CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB) |
+		CQSPI_REG_PHY_DLL_MASTER_CYCLE);
+
+	writel(reg, reg_base + CQSPI_REG_PHY_DLL_MASTER);
+}
+
+static void cqspi_phy_pre_config(struct cqspi_st *cqspi,
+				 struct cqspi_flash_pdata *f_pdata,
+				 const bool bypass)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	u8 dummy;
+
+	cqspi->phy_tuning_active = true;
+
+	cqspi_readdata_capture(cqspi, bypass, f_pdata->use_dqs,
+			       f_pdata->phy_setting.read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	reg |= CQSPI_REG_CONFIG_PHY_EN;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  reg);
+	cqspi->phy_saved_dummy = dummy;
+	if (dummy)
+		dummy--;
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	cqspi_phy_set_dll_master(cqspi);
+}
+
+static void cqspi_phy_post_config(struct cqspi_st *cqspi,
+				  const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	cqspi->phy_tuning_active = false;
+
+	/*
+	 * Clear the EDGE bit set by cqspi_phy_apply_setting, then restore the
+	 * READCAPTURE register to its non-PHY state (bypass, DQS, and delay).
+	 */
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+	reg &= ~BIT(CQSPI_REG_READCAPTURE_EDGE_LSB);
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+
+	cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false, delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	/* Restore the original dummy cycle count saved by cqspi_phy_pre_config. */
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  cqspi->phy_saved_dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+}
+
+static int cqspi_phy_apply_setting(struct cqspi_flash_pdata *f_pdata,
+				   struct phy_setting *phy)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	unsigned int reg;
+	int ret;
+
+	reg = readl(cqspi->iobase + CQSPI_REG_READCAPTURE);
+	reg |= BIT(CQSPI_REG_READCAPTURE_EDGE_LSB);
+	writel(reg, cqspi->iobase + CQSPI_REG_READCAPTURE);
+
+	cqspi_set_dll(cqspi->iobase, phy->rx, phy->tx);
+
+	ret = cqspi_resync_dll(cqspi);
+	if (ret)
+		return ret;
+
+	f_pdata->dll_locked = true;
+	f_pdata->phy_setting.rx = phy->rx;
+	f_pdata->phy_setting.tx = phy->tx;
+	f_pdata->phy_setting.read_delay = phy->read_delay;
+
+	cqspi_readdata_capture(cqspi, !f_pdata->use_dqs, f_pdata->use_dqs,
+			       phy->read_delay);
+
+	return 0;
+}
+
+static int cqspi_find_rx_low_ddr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = CQSPI_PHY_RX_LOW_SEARCH_START;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->rx += CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->rx <= CQSPI_PHY_RX_LOW_SEARCH_END);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find RX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_low_sdr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	phy->rx = 0;
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, phy);
+		if (!ret) {
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+			if (!ret)
+				return 0;
+		}
+		phy->rx++;
+	} while (phy->rx <= CQSPI_PHY_MAX_DELAY);
+
+	dev_dbg(dev, "Unable to find RX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_high_ddr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = CQSPI_PHY_RX_HIGH_SEARCH_END;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->rx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->rx >= CQSPI_PHY_RX_HIGH_SEARCH_START);
+
+		phy->read_delay--;
+	} while (phy->read_delay >= CQSPI_PHY_INIT_RD);
+
+	dev_dbg(dev, "Unable to find RX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_high_sdr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct phy_setting *phy,
+				  u8 lowerbound)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	phy->rx = CQSPI_PHY_MAX_DELAY;
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, phy);
+		if (!ret) {
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+			if (!ret)
+				return 0;
+		}
+		phy->rx--;
+	} while (phy->rx > lowerbound);
+
+	dev_dbg(dev, "Unable to find RX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_low_ddr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = CQSPI_PHY_TX_LOW_SEARCH_START;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->tx += CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->tx <= CQSPI_PHY_TX_LOW_SEARCH_END);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find TX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_high_ddr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = CQSPI_PHY_TX_HIGH_SEARCH_END;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->tx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->tx >= CQSPI_PHY_TX_HIGH_SEARCH_START);
+
+		phy->read_delay--;
+	} while (phy->read_delay >= CQSPI_PHY_INIT_RD);
+
+	dev_dbg(dev, "Unable to find TX high\n");
+	return -ENOENT;
+}
+
+static void cqspi_phy_find_gaplow_ddr(struct cqspi_flash_pdata *f_pdata,
+				      struct spi_mem *mem,
+				      struct phy_setting *bottomleft,
+				      struct phy_setting *topright,
+				      struct phy_setting *gaplow)
+{
+	struct phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = left.read_delay;
+
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, &mid);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+		if (ret) {
+			/* The pattern was not found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		}
+
+		/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaplow = mid;
+}
+
+static void cqspi_phy_find_gaphigh_ddr(struct cqspi_flash_pdata *f_pdata,
+				       struct spi_mem *mem,
+				       struct phy_setting *bottomleft,
+				       struct phy_setting *topright,
+				       struct phy_setting *gaphigh)
+{
+	struct phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = right.read_delay;
+
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, &mid);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+		if (ret) {
+			/* The pattern was not found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		}
+
+		/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaphigh = mid;
+}
+
+static int cqspi_get_temp(int *temp)
+{
+	/* TODO: read SoC thermal sensor; caller falls back to room temperature */
+	return -EOPNOTSUPP;
+}
+
+static inline void cqspi_phy_reset_setting(struct phy_setting *phy)
+{
+	*phy = (struct phy_setting){ .rx = 0, .tx = 127, .read_delay = 0 };
+}
+
+static int cqspi_phy_tuning_ddr(struct cqspi_flash_pdata *f_pdata,
+				struct spi_mem *mem)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	struct phy_setting rxlow, rxhigh, txlow, txhigh;
+	struct phy_setting srxlow, srxhigh;
+	struct phy_setting bottomleft, topright, searchpoint;
+	struct phy_setting gaplow, gaphigh;
+	struct phy_setting backuppoint, backupcornerpoint;
+	int ret, rx_window, temp;
+	bool primary = true, secondary = true;
+
+	/*
+	 * DDR tuning: 2D search across RX and TX delays for optimal timing.
+	 *
+	 * Algorithm: Find RX boundaries (rxlow/rxhigh) using TX window search,
+	 * find TX boundaries (txlow/txhigh) at fixed RX, define valid region,
+	 * locate gaps via binary search, select final point with temperature
+	 * compensation.
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |                                 topright
+	 *              |                                    *
+	 *              |       xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |       *
+	 *              |  bottomleft
+	 *              -----------------------------------------> tx
+	 *              0                                      127
+	 */
+
+	f_pdata->use_tuned_phy = true;
+
+	/* Golden rxlow search: Find lower RX boundary using TX window sweep */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |       xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       |xxxxx|xxxxx     +++++++++++++
+	 *              |       |xxxxx|xxxxxx     ++++++++++++
+	 *      search  |       |xxxxx|xxxxxxx     +++++++++++
+	 *      rxlow --------->|xxxxx|xxxxxxxx     ++++++++++
+	 *              |       |xxxxx|xxxxxxxxx     +++++++++
+	 *              |       |xxxxx|xxxxxxxxxx     ++++++++
+	 *              |       |xxxxx|xxxxxxxxxxx     +++++++
+	 *              |       |     |
+	 *              --------|-----|----------------------------> tx
+	 *              0       |     |                          127
+	 *                  txlow     txlow
+	 *                  start     end
+	 *
+	 *      |----------------------------------------------------------|
+	 *      | Primary | Secondary | Final                              |
+	 *      | Search  | Search    | Point                              |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Pass      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Pass      | rx = min(primary.rx, secondary.rx) |
+	 *      |         |           | tx = primary.tx                    |
+	 *      |         |           | read_delay =                       |
+	 *      |         |           |         min(primary.read_delay,    |
+	 *      |         |           |             secondary.read_delay)  |
+	 *      |----------------------------------------------------------|
+	 */
+
+	/* Primary rxlow: Sweep TX window to find valid RX lower bound */
+
+	rxlow.tx = CQSPI_PHY_TX_LOOKUP_LOW_START;
+	do {
+		dev_dbg(dev, "Searching for Golden Primary rxlow on TX = %d\n",
+			rxlow.tx);
+		rxlow.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_rx_low_ddr(f_pdata, mem, &rxlow);
+		if (!ret)
+			break;
+		rxlow.tx += CQSPI_PHY_DDR_SEARCH_STEP;
+	} while (rxlow.tx <= CQSPI_PHY_TX_LOOKUP_LOW_END);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden Primary rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+		rxlow.tx, rxlow.read_delay);
+
+	/* Secondary rxlow: Verify at offset TX for robustness */
+
+	if (rxlow.tx <= (CQSPI_PHY_TX_LOOKUP_LOW_END - CQSPI_PHY_SEARCH_OFFSET))
+		srxlow.tx = rxlow.tx + CQSPI_PHY_SEARCH_OFFSET;
+	else
+		srxlow.tx = CQSPI_PHY_TX_LOOKUP_LOW_END;
+	dev_dbg(dev, "Searching for Golden Secondary rxlow on TX = %d\n",
+		srxlow.tx);
+	srxlow.read_delay = CQSPI_PHY_INIT_RD;
+	ret = cqspi_find_rx_low_ddr(f_pdata, mem, &srxlow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden Secondary rxlow: RX: %d TX: %d RD: %d\n",
+		srxlow.rx, srxlow.tx, srxlow.read_delay);
+
+	rxlow.rx = min(rxlow.rx, srxlow.rx);
+	rxlow.read_delay = min(rxlow.read_delay, srxlow.read_delay);
+	dev_dbg(dev, "Golden Final rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+		rxlow.tx, rxlow.read_delay);
+
+	/* Golden rxhigh search: Find upper RX boundary at fixed TX */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |       |xxxx     ++++++++++++++++++++
+	 *              |       |xxxxx     +++++++++++++++++++
+	 *    search    |       |xxxxxx     ++++++++++++++++++
+	 *    rxhigh  --------->|xxxxxxx     +++++++++++++++++
+	 *    on fixed  |       |xxxxxxxx     ++++++++++++++++
+	 *    tx        |       |xxxxxxxxx     +++++++++++++++
+	 *              |       |xxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |
+	 *              -------------------------------------------> tx
+	 *              0                                        127
+	 *
+	 *      |----------------------------------------------------------|
+	 *      | Primary | Secondary | Final                              |
+	 *      | Search  | Search    | Point                              |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Pass      | Choose Secondary                   |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Fail      | Choose Primary                     |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Pass      | if (secondary.rx > primary.rx)     |
+	 *      |         |           |         Choose Secondary           |
+	 *      |         |           | else                               |
+	 *      |         |           |         Choose Primary             |
+	 *      |----------------------------------------------------------|
+	 */
+
+	/* Primary rxhigh: Search at rxlow's TX, decrement from max read_delay */
+
+	rxhigh.tx = rxlow.tx;
+	dev_dbg(dev, "Searching for Golden Primary rxhigh on TX = %d\n",
+		rxhigh.tx);
+	rxhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_rx_high_ddr(f_pdata, mem, &rxhigh);
+	if (ret)
+		primary = false;
+	dev_dbg(dev, "Golden Primary rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+		rxhigh.tx, rxhigh.read_delay);
+
+	/* Secondary rxhigh: Verify at offset TX */
+
+	if (rxhigh.tx <=
+	    (CQSPI_PHY_TX_LOOKUP_LOW_END - CQSPI_PHY_SEARCH_OFFSET))
+		srxhigh.tx = rxhigh.tx + CQSPI_PHY_SEARCH_OFFSET;
+	else
+		srxhigh.tx = CQSPI_PHY_TX_LOOKUP_LOW_END;
+	dev_dbg(dev, "Searching for Golden Secondary rxhigh on TX = %d\n",
+		srxhigh.tx);
+	srxhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_rx_high_ddr(f_pdata, mem, &srxhigh);
+	if (ret)
+		secondary = false;
+	dev_dbg(dev, "Golden Secondary rxhigh: RX: %d TX: %d RD: %d\n",
+		srxhigh.rx, srxhigh.tx, srxhigh.read_delay);
+
+	if (!primary && !secondary)
+		goto out;
+	else if (!primary)
+		rxhigh = srxhigh;
+	else if (secondary && srxhigh.rx > rxhigh.rx)
+		rxhigh = srxhigh;
+	dev_dbg(dev, "Golden Final rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+		rxhigh.tx, rxhigh.read_delay);
+
+	primary = true;
+	secondary = true;
+
+	/* If rxlow/rxhigh at same read_delay, search backup at upper TX range */
+
+	if (rxlow.read_delay == rxhigh.read_delay) {
+		dev_dbg(dev, "rxlow and rxhigh at the same read delay.\n");
+
+		/* Backup rxlow: Search at high TX window */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |       xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *              |       xxxxxxx     ++++++++++++++++++
+		 *              |       xxxxxxxx     +++++++++++++++++
+		 *              |       xxxxxxxxx     ++++++++++++++++
+		 *              |       xxxxxxxxxx     +++++++++++++++
+		 *              |       xxxxxxxxxxx     ++++++++++++++
+		 *              |       xxxxxxxxxxxx     +++++++|++++|
+		 *              |       xxxxxxxxxxxxx     ++++++|++++|
+		 *      search  |       xxxxxxxxxxxxxx     +++++|++++|
+		 *      rxlow --------------------------------->|++++|
+		 *              |       xxxxxxxxxxxxxxxx     +++|++++|
+		 *              |       xxxxxxxxxxxxxxxxx     ++|++++|
+		 *              |       xxxxxxxxxxxxxxxxxx     +|++++|
+		 *              |                               |    |
+		 *              --------------------------------|----|-----> tx
+		 *              0                               |    |   127
+		 *                                         txhigh    txhigh
+		 *                                          start    end
+		 *
+		 *      |-----------------------------------------------------|
+		 *      | Primary | Secondary | Final                         |
+		 *      | Search  | Search    | Point                         |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Pass      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Pass      | rx =                          |
+		 *      |         |           |  min(primary.rx, secondary.rx)|
+		 *      |         |           | tx = primary.tx               |
+		 *      |         |           | read_delay =                  |
+		 *      |         |           |  min(primary.read_delay,      |
+		 *      |         |           |      secondary.read_delay)    |
+		 *      |-----------------------------------------------------|
+		 */
+
+		/* Primary backup: Decrement TX from high window end */
+
+		backuppoint.tx = CQSPI_PHY_TX_LOOKUP_HIGH_END;
+		do {
+			dev_dbg(dev,
+				"Searching for Backup Primary rxlow on TX = %d\n",
+				backuppoint.tx);
+			backuppoint.read_delay = CQSPI_PHY_INIT_RD;
+			ret = cqspi_find_rx_low_ddr(f_pdata, mem, &backuppoint);
+			if (!ret)
+				break;
+			backuppoint.tx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (backuppoint.tx >= CQSPI_PHY_TX_LOOKUP_HIGH_START);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup Primary rxlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		/* Secondary backup: Verify at offset TX */
+
+		if (backuppoint.tx >=
+		    (CQSPI_PHY_TX_LOOKUP_HIGH_START + CQSPI_PHY_SEARCH_OFFSET))
+			srxlow.tx = backuppoint.tx - CQSPI_PHY_SEARCH_OFFSET;
+		else
+			srxlow.tx = CQSPI_PHY_TX_LOOKUP_HIGH_START;
+		dev_dbg(dev,
+			"Searching for Backup Secondary rxlow on TX = %d\n",
+			srxlow.tx);
+		srxlow.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_rx_low_ddr(f_pdata, mem, &srxlow);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup Secondary rxlow: RX: %d TX: %d RD: %d\n",
+			srxlow.rx, srxlow.tx, srxlow.read_delay);
+
+		backuppoint.rx = min(backuppoint.rx, srxlow.rx);
+		backuppoint.read_delay =
+			min(backuppoint.read_delay, srxlow.read_delay);
+		dev_dbg(dev, "Backup Final rxlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.rx < rxlow.rx) {
+			rxlow = backuppoint;
+			dev_dbg(dev, "Updating rxlow to the one at TX = %d\n",
+				backuppoint.tx);
+		}
+		dev_dbg(dev, "Final rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+			rxlow.tx, rxlow.read_delay);
+
+		/* Backup rxhigh: Search at fixed backup TX */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |       xxxxx     +++++++++++++++++++|
+		 *              |       xxxxxx     ++++++++++++++++++|
+		 *    search    |       xxxxxxx     +++++++++++++++++|
+		 *    rxhigh  -------------------------------------->|
+		 *    on fixed  |       xxxxxxxxx     +++++++++++++++|
+		 *    tx        |       xxxxxxxxxx     ++++++++++++++|
+		 *              |       xxxxxxxxxxx     +++++++++++++|
+		 *              |       xxxxxxxxxxxx     +++++++++++++
+		 *              |       xxxxxxxxxxxxx     ++++++++++++
+		 *              |       xxxxxxxxxxxxxx     +++++++++++
+		 *              |       xxxxxxxxxxxxxxx     ++++++++++
+		 *              |       xxxxxxxxxxxxxxxx     +++++++++
+		 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+		 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+		 *              |
+		 *              -------------------------------------------> tx
+		 *               0                                        127
+		 *
+		 *      |-----------------------------------------------------|
+		 *      | Primary | Secondary | Final                         |
+		 *      | Search  | Search    | Point                         |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Pass      | Choose Secondary              |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Fail      | Choose Primary                |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Pass      | if (secondary.rx > primary.rx)|
+		 *      |         |           |         Choose Secondary      |
+		 *      |         |           | else                          |
+		 *      |         |           |         Choose Primary        |
+		 *      |-----------------------------------------------------|
+		 */
+
+		/* Primary backup rxhigh: Use backup TX, decrement from max read_delay */
+
+		dev_dbg(dev, "Searching for Backup Primary rxhigh on TX = %d\n",
+			backuppoint.tx);
+		backuppoint.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_rx_high_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			primary = false;
+		dev_dbg(dev, "Backup Primary rxhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		/* Secondary backup rxhigh: Verify at offset TX */
+
+		if (backuppoint.tx >=
+		    (CQSPI_PHY_TX_LOOKUP_HIGH_START + CQSPI_PHY_SEARCH_OFFSET))
+			srxhigh.tx = backuppoint.tx - CQSPI_PHY_SEARCH_OFFSET;
+		else
+			srxhigh.tx = CQSPI_PHY_TX_LOOKUP_HIGH_START;
+		dev_dbg(dev,
+			"Searching for Backup Secondary rxhigh on TX = %d\n",
+			srxhigh.tx);
+		srxhigh.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_rx_high_ddr(f_pdata, mem, &srxhigh);
+		if (ret)
+			secondary = false;
+		dev_dbg(dev, "Backup Secondary rxhigh: RX: %d TX: %d RD: %d\n",
+			srxhigh.rx, srxhigh.tx, srxhigh.read_delay);
+
+		if (!primary && !secondary)
+			goto out;
+		else if (!primary)
+			backuppoint = srxhigh;
+		else if (secondary && srxhigh.rx > backuppoint.rx)
+			backuppoint = srxhigh;
+		dev_dbg(dev, "Backup Final rxhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.rx > rxhigh.rx) {
+			rxhigh = backuppoint;
+			dev_dbg(dev, "Updating rxhigh to the one at TX = %d\n",
+				backuppoint.tx);
+		}
+		dev_dbg(dev, "Final rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+			rxhigh.tx, rxhigh.read_delay);
+	}
+
+	/* Golden txlow: Fix RX at 1/4 of RX window, search TX lower bound */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |
+	 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *    fix rx    |       xxxxxxxxxxxxx     ++++++++++++
+	 *    1/4 b/w ---------><------->xxxxx     +++++++++++
+	 *    rxlow and |       xxxx|xxxxxxxxxx     ++++++++++
+	 *    rxhigh    |       xxxx|xxxxxxxxxxx     +++++++++
+	 *              |       xxxx|xxxxxxxxxxxx     ++++++++
+	 *      rxlow --------->xxxx|xxxxxxxxxxxxx     +++++++
+	 *              |           |
+	 *              ------------|------------------------------> tx
+	 *              0           |                            127
+	 *                     search
+	 *                      txlow
+	 */
+
+	rx_window = rxhigh.rx - rxlow.rx;
+	txlow.rx = rxlow.rx + (rx_window / 4);
+	dev_dbg(dev, "Searching for Golden txlow on RX = %d\n", txlow.rx);
+	txlow.read_delay = CQSPI_PHY_INIT_RD;
+	ret = cqspi_find_tx_low_ddr(f_pdata, mem, &txlow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden txlow: RX: %d TX: %d RD: %d\n", txlow.rx, txlow.tx,
+		txlow.read_delay);
+
+	/* Golden txhigh: Same RX as txlow, decrement from max read_delay */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |
+	 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *    fix rx    |       xxxxxxxxxxxxx     ++++++++++++
+	 *    1/4 b/w --------------------------------><----->
+	 *    rxlow and |       xxxxxxxxxxxxxxx     ++++++|+++
+	 *    rxhigh    |       xxxxxxxxxxxxxxxx     +++++|+++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++|+++
+	 *      rxlow --------->xxxxxxxxxxxxxxxxxx     +++|+++
+	 *              |                                 |
+	 *              ----------------------------------|--------> tx
+	 *              0                                 |      127
+	 *                                           search
+	 *                                           txhigh
+	 */
+
+	txhigh.rx = txlow.rx;
+	dev_dbg(dev, "Searching for Golden txhigh on RX = %d\n", txhigh.rx);
+	txhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_tx_high_ddr(f_pdata, mem, &txhigh);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden txhigh: RX: %d TX: %d RD: %d\n", txhigh.rx,
+		txhigh.tx, txhigh.read_delay);
+
+	/* If txlow/txhigh at same read_delay, search backup at 3/4 RX window */
+
+	if (txlow.read_delay == txhigh.read_delay) {
+		/* Backup txlow: Fix RX at 3/4 of RX window */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |
+		 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *    fix rx    |       xxxxxxx     ++++++++++++++++++
+		 *    3/4 b/w ---------><----->x     +++++++++++++++++
+		 *    rxlow and |       xxxx|xxxx     ++++++++++++++++
+		 *    rxhigh    |       xxxx|xxxxx     +++++++++++++++
+		 *              |       xxxx|xxxxxx     ++++++++++++++
+		 *              |       xxxx|xxxxxxx     +++++++++++++
+		 *              |       xxxx|xxxxxxxx     ++++++++++++
+		 *              |       xxxx|xxxxxxxxx     +++++++++++
+		 *              |       xxxx|xxxxxxxxxx     ++++++++++
+		 *              |       xxxx|xxxxxxxxxxx     +++++++++
+		 *              |       xxxx|xxxxxxxxxxxx     ++++++++
+		 *      rxlow --------->xxxx|xxxxxxxxxxxxx     +++++++
+		 *              |           |
+		 *              ------------|------------------------------> tx
+		 *              0           |                            127
+		 *                     search
+		 *                      txlow
+		 */
+
+		dev_dbg(dev, "txlow and txhigh at the same read delay.\n");
+		backuppoint.rx = rxlow.rx + ((rx_window * 3) / 4);
+		dev_dbg(dev, "Searching for Backup txlow on RX = %d\n",
+			backuppoint.rx);
+		backuppoint.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_tx_low_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup txlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.tx < txlow.tx) {
+			txlow = backuppoint;
+			dev_dbg(dev, "Updating txlow with the one at RX = %d\n",
+				backuppoint.rx);
+		}
+		dev_dbg(dev, "Final txlow: RX: %d TX: %d RD: %d\n", txlow.rx,
+			txlow.tx, txlow.read_delay);
+
+		/* Backup txhigh: Same RX as backup txlow, decrement from max */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |
+		 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *    fix rx    |       xxxxxxx     ++++++++++++++++++
+		 *    3/4 b/w ------------------------------><------->
+		 *    rxlow and |       xxxxxxxxx     +++++++++++|++++
+		 *    rxhigh    |       xxxxxxxxxx     ++++++++++|++++
+		 *              |       xxxxxxxxxxx     +++++++++|++++
+		 *              |       xxxxxxxxxxxx     ++++++++|++++
+		 *              |       xxxxxxxxxxxxx     +++++++|++++
+		 *              |       xxxxxxxxxxxxxx     ++++++|++++
+		 *              |       xxxxxxxxxxxxxxx     +++++|++++
+		 *              |       xxxxxxxxxxxxxxxx     ++++|++++
+		 *              |       xxxxxxxxxxxxxxxxx     +++|++++
+		 *      rxlow --------->xxxxxxxxxxxxxxxxxx     ++|++++
+		 *              |                                |
+		 *              ---------------------------------|---------> tx
+		 *              0                                |       127
+		 *                                               search
+		 *                                               txhigh
+		 */
+
+		dev_dbg(dev, "Searching for Backup txhigh on RX = %d\n",
+			backuppoint.rx);
+		backuppoint.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_tx_high_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup txhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.tx > txhigh.tx) {
+			txhigh = backuppoint;
+			dev_dbg(dev,
+				"Updating txhigh with the one at RX = %d\n",
+				backuppoint.rx);
+		}
+		dev_dbg(dev, "Final txhigh: RX: %d TX: %d RD: %d\n", txhigh.rx,
+			txhigh.tx, txhigh.read_delay);
+	}
+
+	/* Corner points: Define and verify bottomleft and topright boundaries */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |                                 topright
+	 *              |                                    *
+	 *    rxhigh -----------xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *     rxlow -----------xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |       *                            |
+	 *              | bottom|left                        |
+	 *              --------|----------------------------|---> tx
+	 *              0       |                            | 127
+	 *                      |                            |
+	 *                      txlow                   txhigh
+	 *
+	 * Verification: Test point 4 taps inside each corner, adjust
+	 * read_delay ±1 if needed to ensure valid corners for gap search.
+	 */
+
+	bottomleft.tx = txlow.tx;
+	bottomleft.rx = rxlow.rx;
+	if (txlow.read_delay <= rxlow.read_delay)
+		bottomleft.read_delay = txlow.read_delay;
+	else
+		bottomleft.read_delay = rxlow.read_delay;
+
+	/* Verify bottomleft: Test 4 taps inside, adjust read_delay if needed */
+	backupcornerpoint = bottomleft;
+	backupcornerpoint.tx += 4;
+	backupcornerpoint.rx += 4;
+	ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		backupcornerpoint.read_delay--;
+		ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+	}
+
+	if (ret)
+		goto out;
+
+	bottomleft.read_delay = backupcornerpoint.read_delay;
+
+	topright.tx = txhigh.tx;
+	topright.rx = rxhigh.rx;
+	if (txhigh.read_delay >= rxhigh.read_delay)
+		topright.read_delay = txhigh.read_delay;
+	else
+		topright.read_delay = rxhigh.read_delay;
+
+	/* Verify topright: Test 4 taps inside, adjust read_delay if needed */
+	backupcornerpoint = topright;
+	backupcornerpoint.tx -= 4;
+	backupcornerpoint.rx -= 4;
+	ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		backupcornerpoint.read_delay++;
+		ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+	}
+
+	if (ret)
+		goto out;
+
+	topright.read_delay = backupcornerpoint.read_delay;
+
+	dev_dbg(dev, "topright: RX: %d TX: %d RD: %d\n", topright.rx,
+		topright.tx, topright.read_delay);
+	dev_dbg(dev, "bottomleft: RX: %d TX: %d RD: %d\n", bottomleft.rx,
+		bottomleft.tx, bottomleft.read_delay);
+	cqspi_phy_find_gaplow_ddr(f_pdata, mem, &bottomleft, &topright, &gaplow);
+	dev_dbg(dev, "gaplow: RX: %d TX: %d RD: %d\n", gaplow.rx, gaplow.tx,
+		gaplow.read_delay);
+
+	/* Final point selection: Handle single vs dual passing regions */
+
+	if (bottomleft.read_delay == topright.read_delay) {
+		/*
+		 * Single region: Use midpoint with temperature compensation.
+		 * Gaplow approximates upper boundary of valid region.
+		 *
+		 *              rx
+		 *          127 ^
+		 *              |              gaplow (approx. topright)
+		 *              |              |
+		 *    rxhigh -----------xxxxxxx|          failing
+		 *              |       xxxxxxx|           region
+		 *              |       xxxxxxx|     <--------------->
+		 *              |       xxxxxxx|     +++++++++++++++++
+		 *              |       xxxxxxxxx     ++++++++++++++++
+		 *              |       xxxxxxxxxx     +++++++++++++++
+		 *              |       xxxxxxxxxxx     ++++++++++++++
+		 *              |       xxxxxxxxxxxx     +++++++++++++
+		 *              |       xxxxxxxxxxxxx     ++++++++++++
+		 *              |       xxxxxxxxxxxxxx     +++++++++++
+		 *              |       xxxxxxxxxxxxxxx     ++++++++++
+		 *              |       xxxxxxxxxxxxxxxx     +++++++++
+		 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+		 *     rxlow -----------xxxxxxxxxxxxxxxxxx     +++++++
+		 *              |       *                            |
+		 *              | bottom|left                        |
+		 *              --------|----------------------------|---> tx
+		 *              0       |                            | 127
+		 *                      |                            |
+		 *                      txlow                   txhigh
+		 *                             (same read_delay)
+		 *
+		 * Temperature compensation: Valid region shifts with temp.
+		 * Offset = region_size / (330 / (temp - 42°C))
+		 * Factor 330 is empirically determined for this hardware.
+		 */
+
+		dev_dbg(dev,
+			"bottomleft and topright at the same read delay.\n");
+
+		topright = gaplow;
+		searchpoint.read_delay = bottomleft.read_delay;
+		searchpoint.tx =
+			bottomleft.tx + ((topright.tx - bottomleft.tx) / 2);
+		searchpoint.rx =
+			bottomleft.rx + ((topright.rx - bottomleft.rx) / 2);
+
+		ret = cqspi_get_temp(&temp);
+		if (ret) {
+			/* Assume room temperature if sensor unavailable */
+			dev_dbg(dev,
+				"Unable to get temperature. Assuming room temperature\n");
+			temp = CQSPI_PHY_DEFAULT_TEMP;
+		}
+
+		if (temp < CQSPI_PHY_MIN_TEMP || temp > CQSPI_PHY_MAX_TEMP) {
+			dev_err(dev,
+				"Temperature outside operating range: %dC\n",
+				temp);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (temp == CQSPI_PHY_MID_TEMP)
+			temp++; /* Avoid divide-by-zero */
+		dev_dbg(dev, "Temperature: %dC\n", temp);
+
+		/*
+		 * Apply temperature offset: positive at high temp, negative at low.
+		 * Compute the divisor once and apply to both TX and RX. Use int
+		 * arithmetic throughout to avoid u8 wrapping on negative offsets.
+		 */
+		temp = 330 / (temp - CQSPI_PHY_MID_TEMP);
+		searchpoint.tx = clamp((int)searchpoint.tx +
+				       (topright.tx - bottomleft.tx) / temp,
+				       0, CQSPI_PHY_MAX_DELAY);
+		searchpoint.rx = clamp((int)searchpoint.rx +
+				       (topright.rx - bottomleft.rx) / temp,
+				       0, CQSPI_PHY_MAX_DELAY);
+	} else {
+		/*
+		 * Dual regions: Gap separates two valid regions, choose larger.
+		 *
+		 *              rx
+		 *          127 ^
+		 *              |                                 topright
+		 *              |                                    *
+		 *    rxhigh -----------xxxxx     +++++++++++++++++++|
+		 *              |       xxxxxx    <region 2> ++++++++|
+		 *              |       xxxxxxx     +++++++++++++++++|
+		 *              |       xxxxxxxx     ++++++++++++++++|
+		 *              |       xxxxxxxxx     +++++++++++++++|
+		 *              |       xxxxxxxxxx     ++++++++++++++|
+		 *              |                  failing           |
+		 *              |                  region            |
+		 *              |       xxxxxxxxxxxxx     +++++++++++|
+		 *              |       xxxxxxxxxxxxxx     ++++++++++|
+		 *              |       xxxxxxxxxxxxxxx     +++++++++|
+		 *              |       xxxxxxxxxxxxxxxx     ++++++++|
+		 *              |       xxxxxxxxx <region 1>  +++++++|
+		 *     rxlow -----------xxxxxxxxxxxxxxxxxx     ++++++|
+		 *              |       *                            |
+		 *              | bottom|left                        |
+		 *              --------|----------------------------|---> tx
+		 *              0       |                            | 127
+		 *                      |                            |
+		 *                      txlow                   txhigh
+		 *
+		 * Strategy: Compare Manhattan distances from gap boundaries to
+		 * corners. Choose corner furthest from gap (larger region).
+		 * Apply 16-tap margin inward, scale RX proportionally.
+		 */
+
+		cqspi_phy_find_gaphigh_ddr(f_pdata, mem, &bottomleft,
+					   &topright, &gaphigh);
+		dev_dbg(dev, "gaphigh: RX: %d TX: %d RD: %d\n", gaphigh.rx,
+			gaphigh.tx, gaphigh.read_delay);
+
+		if (topright.tx == bottomleft.tx) {
+			dev_err(dev, "zero TX span in dual-region: cannot compute search point\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Compare Manhattan distances: choose corner furthest from gap */
+		if ((abs(gaplow.tx - bottomleft.tx) +
+		     abs(gaplow.rx - bottomleft.rx)) <
+		    (abs(gaphigh.tx - topright.tx) +
+		     abs(gaphigh.rx - topright.rx))) {
+			/* Topright further: Use Region 2, 16 taps inward */
+			searchpoint = topright;
+			searchpoint.tx = clamp((int)topright.tx - 16,
+					       0, CQSPI_PHY_MAX_DELAY);
+			searchpoint.rx = clamp((int)topright.rx -
+					       (16 * (topright.rx - bottomleft.rx)) /
+					       (topright.tx - bottomleft.tx),
+					       0, CQSPI_PHY_MAX_DELAY);
+		} else {
+			/* Bottomleft further: Use Region 1, 16 taps inward */
+			searchpoint = bottomleft;
+			searchpoint.tx = clamp((int)bottomleft.tx + 16,
+					       0, CQSPI_PHY_MAX_DELAY);
+			searchpoint.rx = clamp((int)bottomleft.rx +
+					       (16 * (topright.rx - bottomleft.rx)) /
+					       (topright.tx - bottomleft.tx),
+					       0, CQSPI_PHY_MAX_DELAY);
+		}
+	}
+
+	/* Apply and verify final tuning point */
+	dev_dbg(dev, "Final tuning point: RX: %d TX: %d RD: %d\n",
+		searchpoint.rx, searchpoint.tx, searchpoint.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &searchpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		dev_err(dev,
+			"Failed to find pattern at final calibration point\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	f_pdata->phy_setting.read_delay = searchpoint.read_delay;
+	f_pdata->phy_setting.rx = searchpoint.rx;
+	f_pdata->phy_setting.tx = searchpoint.tx;
+out:
+	if (ret)
+		f_pdata->use_tuned_phy = false;
+
+	return ret;
+}
+
+static int cqspi_phy_tuning_sdr(struct cqspi_flash_pdata *f_pdata,
+				struct spi_mem *mem)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	struct phy_setting rxlow, rxhigh, first, second, final;
+	u8 window1 = 0;
+	u8 window2 = 0;
+	int ret;
+
+	/*
+	 * SDR tuning: 1D search for optimal RX delay (TX less critical).
+	 * Find two consecutive windows, choose larger, use midpoint.
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |        |-----window at----------|
+	 *              |        |-----read_delay = n+1---|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow(n+1)   midpoint    rxhigh(n+1)
+	 *              |
+	 *              |   |---window at--------|
+	 *              |   |---read_delay = n---|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   rxlow(n)   midpoint  rxhigh(n)
+	 *              |
+	 *              -----------------------------------------> tx
+	 *              0                                      127
+	 *                  read_delay=n                  read_delay=n+1
+	 */
+
+	f_pdata->use_tuned_phy = true;
+	cqspi_phy_reset_setting(&rxlow);
+	cqspi_phy_reset_setting(&rxhigh);
+	cqspi_phy_reset_setting(&first);
+
+	/* First window: Find rxlow by incrementing read_delay from 0 */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  search      |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  rxlow       |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  increasing  |   |xxxxxxxxxxxxxxxxxxxx|
+	 *           --------->|xxxxxxxxxxxxxxxxxxxx|
+	 *  read_delay  |        |xxxxxxxxxxxxxxxxxxx|
+	 *  until found |        |xxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow
+	 *              -----------------------------------------> tx
+	 *              0                            tx fixed at 127
+	 */
+
+	do {
+		ret = cqspi_find_rx_low_sdr(f_pdata, mem, &rxlow);
+
+		if (ret)
+			rxlow.read_delay++;
+	} while (ret && rxlow.read_delay <= CQSPI_PHY_MAX_RD);
+
+	if (ret)
+		goto out;
+
+	/* Find rxhigh: Decrement from RX=127 at same read_delay */
+
+	/*
+	 *              rx
+	 *          127 ^        search rxhigh
+	 *              |        (decrement from
+	 *              |        127 until found)
+	 *              |          |
+	 *              |          |
+	 *              |          v
+	 *              |        |------------------------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow                    rxhigh
+	 *              -----------------------------------------> tx
+	 *              0                            tx fixed at 127
+	 */
+
+	rxhigh.read_delay = rxlow.read_delay;
+	ret = cqspi_find_rx_high_sdr(f_pdata, mem, &rxhigh, rxlow.rx);
+	if (ret)
+		goto out;
+
+	/* Calculate first window midpoint for max margin */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |--------window1---------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxx * xxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow        ^           rxhigh
+	 *              ----------------------|------------------> tx
+	 *              0                     |      tx fixed at 127
+	 *                            window1/2
+	 */
+
+	first.read_delay = rxlow.read_delay;
+	window1 = rxhigh.rx - rxlow.rx;
+	first.rx = rxlow.rx + (window1 / 2);
+
+	dev_dbg(dev, "First tuning point: RX: %d TX: %d RD: %d\n", first.rx,
+		first.tx, first.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &first);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret || first.read_delay > CQSPI_PHY_MAX_RD)
+		goto out;
+
+	/* Second window: Search at read_delay+1, may differ in size */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |-------|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        rxlow   rxhigh
+	 *              -----------------------------------------> tx
+	 *              0
+	 *              read_delay = n (smaller window)
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |        |-----------------|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        rxlow             rxhigh
+	 *              -----------------------------------------> tx
+	 *              0
+	 *              read_delay = n+1 (larger window - better)
+	 */
+
+	cqspi_phy_reset_setting(&rxlow);
+	cqspi_phy_reset_setting(&rxhigh);
+	cqspi_phy_reset_setting(&second);
+
+	rxlow.read_delay = first.read_delay + 1;
+	if (rxlow.read_delay > CQSPI_PHY_MAX_RD)
+		goto compare;
+
+	ret = cqspi_find_rx_low_sdr(f_pdata, mem, &rxlow);
+	if (ret)
+		goto compare;
+
+	rxhigh.read_delay = rxlow.read_delay;
+	ret = cqspi_find_rx_high_sdr(f_pdata, mem, &rxhigh, rxlow.rx);
+	if (ret)
+		goto compare;
+
+	/* Calculate second window midpoint */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |--------window2---------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxx * xxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow        ^           rxhigh
+	 *              ----------------------|------------------> tx
+	 *              0                     |      tx fixed at 127
+	 *                            window2/2
+	 *              read_delay = n+1
+	 */
+
+	window2 = rxhigh.rx - rxlow.rx;
+	second.rx = rxlow.rx + (window2 / 2);
+	second.read_delay = rxlow.read_delay;
+
+	dev_dbg(dev, "Second tuning point: RX: %d TX: %d RD: %d\n", second.rx,
+		second.tx, second.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &second);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret || second.read_delay > CQSPI_PHY_MAX_RD)
+		window2 = 0;
+
+	/* Window comparison: Choose larger window for better margin */
+
+compare:
+	cqspi_phy_reset_setting(&final);
+	if (window2 > window1) {
+		final.rx = second.rx;
+		final.read_delay = second.read_delay;
+	} else {
+		final.rx = first.rx;
+		final.read_delay = first.read_delay;
+	}
+
+	/* Apply and verify final tuning point */
+
+	dev_dbg(dev, "Final tuning point: RX: %d TX: %d RD: %d\n", final.rx,
+		final.tx, final.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &final);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	f_pdata->phy_setting.read_delay = final.read_delay;
+	f_pdata->phy_setting.rx = final.rx;
+	f_pdata->phy_setting.tx = final.tx;
+
+out:
+	if (ret)
+		f_pdata->use_tuned_phy = false;
+
+	return ret;
+}
+
+static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
+					   struct spi_mem_op *read_op,
+					   struct spi_mem_op *write_op)
+{
+	struct cqspi_st *cqspi =
+		spi_controller_get_devdata(mem->spi->controller);
+	struct cqspi_flash_pdata *f_pdata;
+	struct device *dev = &cqspi->pdev->dev;
+	int ret = 0;
+
+	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
+
+	/*
+	 * spi-max-post-config-frequency-hz must be present for PHY tuning.
+	 * If absent, post_config_max_speed_hz is zero and there is no
+	 * calibration target, so skip tuning gracefully.
+	 */
+	if (!mem->spi->post_config_max_speed_hz) {
+		dev_dbg(dev,
+			"No post-config frequency configured, skipping tuning\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (write_op) {
+		/*
+		 * For NAND: write the calibration pattern to the page cache.
+		 * The write op runs at the conservative base speed (spi->max_speed_hz)
+		 * so the write itself is reliable before PHY calibration.
+		 */
+		ret = cqspi_write_pattern_to_cache(f_pdata, mem, write_op);
+		if (ret) {
+			dev_warn(dev,
+				 "failed to write pattern to cache: %d, skipping tuning\n",
+				 ret);
+			goto out;
+		}
+
+		f_pdata->phy_write_op = *write_op;
+	} else {
+		if (!f_pdata->phy_pattern_partition_valid) {
+			dev_warn(dev, "pattern partition not found, skipping tuning\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/*
+	 * Build the read op template for pattern verification.  For NOR, point
+	 * at the pre-programmed pattern partition rather than the caller's
+	 * address without altering the caller's template.
+	 */
+	f_pdata->phy_read_op = *read_op;
+	if (!write_op)
+		f_pdata->phy_read_op.addr.val =
+			f_pdata->phy_pattern_partition_offset;
+
+	f_pdata->phy_read_op.max_freq = mem->spi->max_speed_hz;
+
+	ret = cqspi_phy_check_pattern(f_pdata, mem);
+	if (ret) {
+		dev_err(dev, "pattern not found: %d, skipping tuning\n", ret);
+		goto out;
+	}
+
+	f_pdata->phy_read_op.max_freq = mem->spi->post_config_max_speed_hz;
+
+	if (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
+	    read_op->data.dtr) {
+		f_pdata->use_dqs = true;
+		cqspi_phy_pre_config(cqspi, f_pdata, false);
+		ret = cqspi_phy_tuning_ddr(f_pdata, mem);
+	} else {
+		f_pdata->use_dqs = false;
+		cqspi_phy_pre_config(cqspi, f_pdata, true);
+		ret = cqspi_phy_tuning_sdr(f_pdata, mem);
+	}
+
+	if (ret)
+		dev_warn(dev, "tuning failed: %d\n", ret);
+
+	cqspi_phy_post_config(cqspi, f_pdata->read_delay);
+
+out:
+	if (!ret) {
+		read_op->max_freq = mem->spi->post_config_max_speed_hz;
+		if (write_op) {
+			write_op->max_freq = mem->spi->post_config_max_speed_hz;
+			f_pdata->phy_write_op.max_freq =
+				mem->spi->post_config_max_speed_hz;
+		}
+	}
+
+	return ret;
+}
+
+static int cqspi_mem_op_execute_tuning(struct spi_mem *mem,
+				       struct spi_mem_op *read_op,
+				       struct spi_mem_op *write_op)
+{
+	struct cqspi_st *cqspi =
+		spi_controller_get_devdata(mem->spi->controller);
+
+	if (!cqspi->ddata || !cqspi->ddata->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return cqspi->ddata->execute_tuning(mem, read_op, write_op);
+}
+
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 				    struct cqspi_flash_pdata *f_pdata,
 				    struct device_node *np)
 {
+	struct device_node *part_np;
+
 	if (of_property_read_u32(np, "cdns,read-delay", &f_pdata->read_delay)) {
 		dev_err(&pdev->dev, "couldn't determine read-delay\n");
 		return -ENXIO;
@@ -1588,9 +3331,12 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 		return -ENXIO;
 	}
 
-	if (of_property_read_u32(np, "spi-max-frequency", &f_pdata->clk_rate)) {
-		dev_err(&pdev->dev, "couldn't determine spi-max-frequency\n");
-		return -ENXIO;
+	part_np = of_parse_phandle(np, "spi-phy-pattern-partition", 0);
+	if (part_np) {
+		f_pdata->phy_pattern_partition_valid =
+			!of_property_read_u32_index(part_np, "reg", 0,
+						    &f_pdata->phy_pattern_partition_offset);
+		of_node_put(part_np);
 	}
 
 	return 0;
@@ -1740,6 +3486,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
+	.execute_tuning = cqspi_mem_op_execute_tuning,
 };
 
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
@@ -2108,6 +3855,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
 	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
-- 
2.34.1

