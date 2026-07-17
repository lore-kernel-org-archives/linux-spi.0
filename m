Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4037CD45;
	Fri, 17 Jul 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314331; cv=fail; b=lo2JJdLeRjXsEOqhf0dm5g/AJliwsTlQ+Q7H4u9baoKaxcg78plnZ/2pd18IwXkZaeFh4zIYx7udYUrhvLDnZNUt3SAvtFutvnTKoQT6rvyuEAyakxHIDg2dPgS90T+3ArUjyJFtMAYqO9kxWFSK5G2kP+E33dctoQ7B7AWETO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314331; c=relaxed/simple;
	bh=YuXgDPIx1AjekSo7gLvG6fzbTgn/QAeY0NkVE7RtZoU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XF88j5HXxDAPK9AorKUDF3GmD/KBCQXP6YPzsdwPCJnYsKTum7Z0pyB+Vt1W03bs0LxnvlhEtMnD0vTtwuibLc1m2bELIZIkAg3P7AjgP3c7kXjEHGHw9Mb3xxRcBaXqFksGy8ptmgCnqEj682+cX+niiaJAVIhCmWMolLNHB0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=aFYVc8Aw; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RaUZ3JoJ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="aFYVc8Aw";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RaUZ3JoJ"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlBSF3254299;
	Fri, 17 Jul 2026 13:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=O1XTR9YrbAUxt
	62al5//RjlhkzKE1FWEvLmzMMVdFA0=; b=aFYVc8AwWwrdtKCb0YbCe9zOSWmKM
	Uzn8uEw3UEpkwv+nJpnvglV3HZ48NH/64d/fFfAXDGuWSuMaaA7wIKzqFXNPQ3y/
	sz2C3WPx++E26SwI1VHrtEhADKU65sfXGFPR5t2AiqRfolzSH8Qn7x9jPPkjVe/u
	R6+gBmD+fxP6WcmkAp9Ukp/MawsJOO1Q2SiANS5gI9kOVU26g6CPPNJM7ksOpkFl
	8DM5HiSXTzeH8TpcskaG/RHuHUaTkxz/I8ZmX5hn1FjfrAcoVXxKrkQi/JHdQqKv
	mtUIZ1MbMPmX4Me6LDFhaJoNs+Xi2nKsK9cGVRk86elLSgFGJxhxKI6rQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ffks32kcg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:51:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIAHkVmGdEfVPW1xGEpkvGfBT7RBMYetWrS7M5QbfJi7oQtx1GNJ3/ixJHq32hilJYP8E4XTWic4VCly6HO9gbhfz0f4fYTMbKS4gx2mCgABmYuK6YspU2mUAIrF3K3tKt6gM/WJK0xGpcYG6Hgpfm4UpFfOTlvwdN3AzUF7fRygm6Yov5+fqCESxyw04V3cjUbPFN8sJU1NekCzqs9uCJ9ktXyyMyDwbi72C6YgFNEo3C2eN8W+sxYj9Z9BJblHPBCKAoY0jt8FBXuEEKoFuW5rFBlIxtiaIioN2KHSVBJAasrdq67rb+wuFgu+tj5eYjGnSfurgjwzaTIGXYNkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1XTR9YrbAUxt62al5//RjlhkzKE1FWEvLmzMMVdFA0=;
 b=PYg0bcVtlPSFdWpNgczZ2al6+jCM8o7xLP+MqHtFrFqp2Tg4L65NUV9nd/9JCih5cDgVh6K2sQJiyvS7Sg+BT+5/iicXLnT+1RnoI3Cy1dlz903nCafoKp/jLah92l+3g8SMblI15rv6FaI+xBprEA1+K1rpEwT1zH46CiUiqpd1Ff9oCFTrXTqddz6B8+ZEQjeWqe1yy2Ge8UCPFY2c/ET6aIbkSdHCSscAZAIwwTgWzapK2RXGEwOswXOoZP9vSlD54gZr/MJZynD/xRqRSGAr6BMdHAnyQxizsDIE7pykcG4r/vtCanr99umWoVt9z6QjOCT+xhjxSyhpzLlOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1XTR9YrbAUxt62al5//RjlhkzKE1FWEvLmzMMVdFA0=;
 b=RaUZ3JoJ1k2tIDMti4OJSvNYXjs4K7Toonut0d83bUpGCx9/Fj+/QfMoZGctlci92EsO8Qb3tdJLXmaJ2wrjpg0zjhC9rLOkAJK8hfMPbl7q32w5XuTfxIrJfoRydUb8EpCfDtwZGPNjBO+WqpglYCFu0UCG62hh9rhmsJjo3+8=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by PH8PR10MB6357.namprd10.prod.outlook.com (2603:10b6:510:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:51:40 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::8a) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Fri,
 17 Jul 2026 18:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:51:38 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:51:35 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:51:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:51:35 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4k240969;
	Fri, 17 Jul 2026 13:51:30 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 00/17] spi: cadence-quadspi: add PHY tuning support
Date: Sat, 18 Jul 2026 00:20:59 +0530
Message-ID: <20260717185116.2065505-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH8PR10MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b7ef58-2559-4b38-a803-08dee4346f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|921020|6133799003|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ibkHPp+/MIsmYGmhrjkoTEa84qfVI7qEtHxSIxqyKaumLneBTolhZD3vZHvHPGfeieNioiavmy31u4wVN0Q570F3iFYtzsxWOz5I+E08nYDt+IOT1eM+Jl2cfSZhEQkH6zw+pCyD1nv7KdUBdyiX96Ev1dqgZc6Ge46UkZhtMyMAjJOxRM5yFDT9okC1w51NYDGI6V66698KEYgMs/rDE8U7qqz7/ODy9Xzyh6K0HdvblEIz5kWzdfbaq12SsJD6sEp/nrY9wK/ecjcA0Rliz+KaAAvvlqHlF6zk1WUkslFfoWtVmJUly7j/RTKqLmVJ8cIdodjOztiaapK7JQFCMGxen4zVqGZ2sjiOuPUHBvk709fDjvlO70mnQnWLuFWpHp+PzStDJfOpBbxUR6WlqPYar7PauZ4nLytRCq+dmWTXlSSMjpddTBnLxHX6FJox1ZjKqvTJGczU6gAYCIawAH4rtgtelXCPQfwHTnXVRqUvlioyw9NWq0uryTaVb19pUbh34BYaJcFqvLcxxs2409t99+2RYOSrJWkX357nX8pWRXRW9ZlEP9hQ0jDN8iGuslMZ09OxALq1mrBYNCpoBid/jS4Q7lhx9Wtwn1sHwpkFGNaGBcd9jO+CehFno5QikHUb2bk33FxML+QXRgso8/ToTseVxhw7SPc4F+IbTwwx0WI3GpTIPWri4VPAe4QX54czVysuQUdKJU+j9u3KCLS/l4NGkhD5p0fF29TsgBGqjDaUn/m9iJlhRKeX3AD2
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xtrBk3/w1d6GXwT6SSAd7F2dBO3WT7rf8rE3jvSRzK1lQd4MXY5YCMjSvpq+B+be9ADs7j+IgyefL3Pk9iHgk2UWyTboX6um4r1xsW+M2IXT4lLXjsIHkSh6menHeORV7nHccxP/9jcoMHPGerYWjR8ccws+WHZRuycXbBlfc/nB64jyesk4aYhhbTBGOjWQwgwbP0nlnunpeN3HSGy4Rvxxi8SsqfT1iFlbaxEomtkzfC0HTv1AnWEedvLr2AwsLLZnv6uhLLFu6PFchs1FJSsbAQuxF9APqmtgOwTU6XkQP9rx7mt1c+h2zh5KG9u6Cny0qb+FwtoP0x+uQ+s0EZQD+3WIn5sJo70CsgfxKFw5My2S+h9JZnWXrbljjXOrfW0xMFvr0lvgfhL8fpfzFQQJpvnTFyJ077V6X+iWgPO1GEmYyEYqVuHJ+Aw1ah5E
X-Exchange-RoutingPolicyChecked:
	iFqyAo0HPww4qGissIxXbmCcfsl8HCstHGmil9M0b9YCnpwaP/RRyAtnguDgAq6rhlQSv1cexiDtK3Mk5gWpOytQ02DNI4dtQ+KiDCQQSUQM2kGy1wsSHJKrdME2b2JrvMBF+GxMW8w001ny72fnGhMuf3E5k1HO/lwEhNzEBIIRch8Hu/0EACLciDWLd5V3qHnyGftp1yjkD/mWgHlWlHQPiijksIrVf4gbAsHjtJ7RBA8t9XG3dV8NjkxNXwbn2k+OA6AmD/NpODZLAwlJassUvM8GeBUTx14KNCjxjEo5ny9jD9Igc3RAkn3zbthEbrXorXF5h8606FXdHAYImg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:51:38.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b7ef58-2559-4b38-a803-08dee4346f38
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6357
X-Authority-Analysis: v=2.4 cv=e9Y2j6p/ c=1 sm=1 tr=0 ts=6a5a79bf cx=c_pps
 a=XNh4DmHdy4Cg7KTw7bneTw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=1qu6GB6xxCx-qJtXegsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX4atMDeqUiW2k
 OsqENlvB0KrinRC8zl7KsH3z8IpqpxWQ9AszJLY6c0rS6hEVKxdWthqCFV7/tuGGLDVhe/VeoN+
 yvnP/AHlqZ6uaQ/6dIv7zce+jl7n65aCHdomQKoNgGDQ1skRLxSvWDTna1PjAqU/kQ5Sllaf29h
 Cfa8+8YREvhge+xrt/0pn2zivv/JH8IVPQXmBFybhTR2INJyDUeVQbG/ffSsryIAUXKsTQRUE4/
 Kn79EfmvuYu36euFKNv97L+bOWNrvH5FXyam+VG2Yz7Xjd4WqyyI9W62MEAC62OFmIO1EeIzkBm
 U8Wm2pdITU1y8UhX9D3W3iYo5sx96IjbtEAY5LwB0tTHUZZ19tsxAB29dnDJX4mwfnMTvpbofKD
 bpOrIWKh9ukIMlzPl8PY5NrMuMpleasFCbkFA4kp7kKJ/9UNgSDUs6i2OoyLXwYHDI3sSnYLPJ+
 o3NqlwnWJiR//25jjrA==
X-Proofpoint-GUID: XB3znTaTW6gtxt9M9l0sxQgPnPZRrNe1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX0t3BLCChGirF
 yoXVN8wk+wPUQl1Ml95jmOEfASbtmWu5Xx/5n8biP2YvcANqPx1BELpO+bVvpFgZ/+YGPNU52Xb
 5mjx4BzfNLHA5oEQCZTjMoHJBL1D+E8=
X-Proofpoint-ORIG-GUID: XB3znTaTW6gtxt9M9l0sxQgPnPZRrNe1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

This series implements PHY tuning support for the Cadence QSPI controller
to enable reliable high-speed operations. Without PHY tuning, controllers
use conservative timing that limits performance. PHY tuning calibrates
RX/TX delay lines to find optimal data capture timing windows, enabling
operation up to the controller's maximum frequency.

Background:
High-speed SPI memory controllers require precise timing calibration for
reliable operation. At higher frequencies, board-to-board variations make
fixed timing parameters inadequate. The Cadence QSPI controller includes
a PHY interface with programmable delay lines (0-127 taps) for RX and TX
paths, but these require runtime calibration to find the valid timing
window.

Approach:
Add SDR/DDR PHY tuning algorithms for the Cadence controller:

SDR Mode Tuning (1D search):
 - Searches for two consecutive valid RX delay windows
 - Selects the larger window and uses its midpoint for maximum margin
 - TX delay fixed at maximum (127) as it's less critical in SDR

DDR Mode Tuning (2D search):
 - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
 - Finds TX boundaries (txlow/txhigh) at fixed RX positions
 - Defines valid region corners and detects gaps via binary search
 - Applies temperature compensation for optimal point selection
 - Handles single or dual passing regions with different strategies

Patch description:
Infrastructure (1-5):
 - Patch 1:   Add spi-max-post-config-frequency-hz to describe maximum
              frequency achievable post controller configuration
 - Patch 2:   Add spi-phy-pattern-partition phandle for
              NOR flash PHY tuning pattern location
 - Patch 3:   Parse spi-max-post-config-frequency-hz in spi.c; adds
              spi_device.post_config_max_speed_hz (0 when not set
              keeping all existing DT fully compatible)
 - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
              op->max_freq equals post_config_max_speed_hz, return
              immediately leaving op->max_freq unchanged. All other
              ops are capped to max_speed_hz
 - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
              spi_mem_execute_tuning() wrapper in SPI-MEM core

Cadence QSPI Implementation (6-13):
 - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
 - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
 - Patch 8:   Add complete PHY tuning support: DLL management, pattern
              verification (NOR via spi-phy-pattern-partition phandle,
              NAND via write-to-cache), SDR 1D and DDR 2D search
              algorithms with temperature compensation, AM654-specific
              execute_tuning entry point
 - Patch 9:   Reject 2-byte-address DDR operations via a new
              CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk flag to work
              around AM654 OSPI erratum i2383
 - Patch 10:  Refactor direct read path for PHY support (preparatory)
 - Patch 11:  Enable PHY for direct reads; split the transfer into an
              unaligned head, a 16-byte-aligned middle section with PHY
              active, and an unaligned tail; also reprograms DLL on
              chip-select switch when two devices have different
              calibrated settings
 - Patch 12:  Enable PHY for indirect writes of at least
              CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
 - Patch 13:  Reprogram per-device CS timing on any chip-select switch

MTD core (14-17):
 - Patch 14:  Extract spinand_select_op_variant() into a shared helper
              spinand_op_find_best_variant() with a skip_mask
 - Patch 15:  Negotiate optimal controller operating point before dirmap
              creation; iterate all read variants in performance order
              across ODTR and SSDR interfaces
 - Patch 16:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
 - Patch 17:  Execute controller optimization in spi_nor_probe() before
              creating dirmaps

Testing:
This series was tested on TI's
AM62Ax SK with OSPI NAND flash and
AM62Px SK with OSPI NOR flash:

Read throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NOR (8D)  | 37.5 MB/s | 218 MB/s  |
|----------------------------------------|
| OSPI NAND (8S) | 9.2 MB/s  | 35.6 MB/s |
|----------------------------------------|

Write throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
|----------------------------------------|

Test log: https://gist.github.com/santhosh21/0b9b5f94411c655f3edaff91f1c319d8
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v5

Changes in v5:
 - Rename spi-max-post-config-frequency to spi-max-post-config-frequency-hz
   per DT schema unit suffix convention
 - Rename CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk to
   CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR for clarity
 - Rename SPI NAND identifiers to remove PHY-specific terminology:
     spinand_configure_phy()     -> spinand_optimize_controller()
     spinand_try_phy_ranked()    -> spinand_try_ranked_variant()
     spinand_reset_max_ops()     -> spinand_reset_max_freq_ops()
     spinand_op_find_best()      -> spinand_op_find_best_variant()
     phy_read_variants (field)   -> all_read_variants
 - Replace bool odtr parameter with enum spinand_bus_interface iface in
   spinand_op_find_best_variant() to preserve the existing enumeration
 - Replace cqspi_get_phy_pattern_offset() with per-flash probe-time
   phandle lookup in cqspi_of_get_flash_pdata(); fixes incorrect pattern
   offset selection when multiple flash devices share a controller
 - In cqspi_tune_phy(), reprogramme and resync the DLL when the active
   device's calibrated settings differ from hardware
 - Edit cqspi_phy_apply_setting() to update phy_setting.rx and
   phy_setting.tx alongside phy_setting.read_delay
 - Reprogram per-device CS timing (CQSPI_REG_DELAY and read-capture register)
   on any chip-select switch, not only on clock changes
 - Move post_config_max_speed_hz early-return to the top of
   spinand_optimize_controller(), before any state is modified
 - Remove dead NULL guards on SSDR op templates in Pass 2
 - Downgrade tuning-failure log messages from dev_warn to dev_dbg
 - Rebase on v7.2-rc3
 - Collect tags
 - Link to v4: https://lore.kernel.org/linux-spi/20260618073725.84733-1-s-k6@ti.com/

Changes in v4:
 - Add spi-max-post-config-frequency instead of extending spi-max-frequency
   to accept an optional second value
 - Replace spi_mem_apply_base_freq_cap() with spi_mem_adjust_op_freq() extension
 - For SPI NOR/NAND, execute PHY tuning before the dirmap creation
 - For SPI NAND, execute PHY tuning across all operation variants available,
   perform duration comparison, and select the best resulting variant
   by taking controller-specific restrictions into account
 - Move i2383 check from cqspi_supports_mem_op() to cqspi_am654_ospi_execute_tuning()
 - Rename cdns,phy-pattern-partition to spi-phy-pattern-partition,
   cqspi_phy_enable to cqspi_tune_phy and f_pdata->use_phy to use_tuned_phy
 - Remove redundant spi-max-frequency parsing in driver cqspi_of_get_flash_pdata()
 - Extract DMA refactoring into a preparatory patch
 - Rebase on v7.1
 - Collect tags from Miquel
 - Link to v3: https://lore.kernel.org/linux-spi/20260527175527.2247679-1-s-k6@ti.com/

Changes in v3:
 - Drop spi-has-dqs DT property; DQS is now enabled automatically when
   the selected read operation uses DDR signalling (dtr flags in the op)
 - Extend spi-max-frequency to accept an optional second value forming a
   [base-freq, max-freq] pair; the presence of two values signals PHY
   tuning intent and encodes both the conservative base speed and the
   calibration target in one property
 - Add base_speed_hz to struct spi_device (spi.c/spi.h) and parse the
   two-element array there; single-value DT is fully backward-compatible
 - Move frequency enforcement from the cadence driver to core: new
   spi_mem_apply_base_freq_cap() called from spi_mem_exec_op() replaces
   the per-driver cqspi_op_matches_tuned() and non_phy_clk_rate field
 - Propagate the tuned max_freq to dirmap op templates after
   execute_tuning() succeeds; store persistent op templates in
   spi_nor.max_read_op and spinand.{max_read,max_write}_op so the
   frequency writeback survives across the probe call
 - Replace NOR pattern partition lookup by name with a
   cdns,phy-pattern-partition DT phandle pointing directly to the
   partition node
 - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address DDR
   ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
 - Remove RFC tag
 - Rebase on v7.1-rc5
 - Collect tags from Miquel
 - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1-s-k6@ti.com/

Changes in v2:
 - Restructure the .execute_tuning() call from spi-mem clients instead
   of mtdcore with best read_op and write_op (optional) passed
 - Add compatible-specific .execute_tuning() call which can be called by
   spi_mem_execute_tuning() if exists
 - Handle tuning requirement check by controller instead of spi-mem
   clients
 - Add support to write the phy_pattern to cache if relevant write_op
   is passed or get the partition offset which contains the phy_pattern
 - Add tuning algorithm for DDR mode
 - Add support for DQS
 - Restrict PHY frequency to tuned operations
 - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-s-k6@ti.com/

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Pratyush Yadav (1):
  mtd: spi-nor: extract read op template construction into helper

Santhosh Kumar K (16):
  spi: dt-bindings: add spi-max-post-config-frequency-hz property
  spi: dt-bindings: add spi-phy-pattern-partition property
  spi: parse spi-max-post-config-frequency-hz into
    post_config_max_speed_hz
  spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
  spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
  spi: cadence-quadspi: move cqspi_readdata_capture earlier
  spi: cadence-quadspi: add DQS support to read data capture
  spi: cadence-quadspi: add PHY tuning support
  spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops
    (i2383)
  spi: cadence-quadspi: refactor direct read path for PHY support
  spi: cadence-quadspi: enable PHY for direct reads
  spi: cadence-quadspi: enable PHY for indirect writes
  spi: cadence-quadspi: reprogram CS timing on every chip-select switch
  mtd: spinand: extract variant ranking logic into
    spinand_op_find_best_variant()
  mtd: spinand: negotiate optimal controller operating point before
    dirmap creation
  mtd: spi-nor: run controller optimization before dirmap creation

 .../bindings/spi/cdns,qspi-nor.yaml           |   17 +
 .../bindings/spi/spi-peripheral-props.yaml    |   12 +
 drivers/mtd/nand/spi/core.c                   |  238 +-
 drivers/mtd/spi-nor/core.c                    |   80 +-
 drivers/spi/spi-cadence-quadspi.c             | 2232 +++++++++++++++--
 drivers/spi/spi-mem.c                         |   40 +
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    3 +
 include/linux/mtd/spinand.h                   |   11 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 11 files changed, 2467 insertions(+), 185 deletions(-)

-- 
2.34.1
