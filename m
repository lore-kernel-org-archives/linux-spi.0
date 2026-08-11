Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360E3806D0;
	Tue, 11 Aug 2026 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473256; cv=fail; b=LlCNFvEkWBbYSnqnDyrfoAKmMMq+nF+0CHDp+RQKi80E6fioH/Iegbwwo7aifw/OHNnLupzbMI69uxIjcuq1FNMHrHZXTBBX6djUGvvz/rBvhlBDrc5RCEAhrDIJPRE8FX5tUDcnDygcldK3YlJweuDTIr1H1Dbk4bzjgTcZEZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473256; c=relaxed/simple;
	bh=aF/DbrmPXM4j0mLlW+L8B/c0eqWu65juxQfllEXfCQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSRczZZQ7bTvpMtndRQNMplVobWC/qw3Qm4iHpNjuPgEeXfn0s5XEgNwa/be4gkn3qHom1ygXzpWajC0l2bRvl2whkB5N2JMqWR6v3NHKCaBbglVjLJxx63G7Y4BlIOmlIWjMQFe+X4TYhEwreplXvvkc8kMVgG/CiEHmMQvZDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EP68VnfH; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D98jcbWh; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EP68VnfH";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D98jcbWh"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMc2R2174911;
	Tue, 11 Aug 2026 13:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQ
	lA=; b=EP68VnfHQ4SoWS+W7DQaNHmBTGYcWtcY3vaEx7CGQe2C4y2EyShxVZonU
	gmZ0hcBLysrhULtm1C+cbOIx7CEIm2n0fvmEURuvO5h7icA6RXOuwn/otWv2tuWB
	LtfOAZwepLrYFcXpN8plSbkfzPVD9/XGfUyAsYrjy3U3Jc/3aO2yYwE8mrHLVah0
	6Vc8BiyBUPRm8kvJeN8LZICUW2U/02s62D5/yCjwXXMoRrSBRF6dnnKmDVDGVHN6
	YdhUsYrrDJpVjGVJr8+y20yMYw+dTDj3Skey4A2FoPyVwTTS7Ab7gi3tldc8Ygn+
	JwGR5GnnNCraZpkNyMOY1xuLtnhrA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uhxd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:33:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBll0I9/FbBNYtlDbVvOSiO7A24KYSl7uSiGUYk2qBmaZqxlSR+4xDU2DZlLUGskCw6EGhx7F5YFJj//6DnkxjZCA1SogAEWT/i6UuvBUHbXWdQII3L099L81dEp398E6bjO4a69qhNXDlVFoCoilv/D0cOP2PpuxHHWj9IpXaM5WZxXMo0PlFYfidQ1Eh8761NvYkow71hzual+dbvgRGop+jSoM4gDTLzxsuJ3FJbHMSAqtd+JTPNR1TaP8bDT0JPnNE//x8OwvYrcu8G7xB6Ck7o+0FL6VxZg4LkzD2w0kM/dUaC04LTMoo3fbKnaYZiodUhpU4uOOiiLSJrKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=NLzlpyxxQJwI2S39cMmADm6r6kxVPRnPaRpezcbfp+WwCdLQD6C/6Phzg1xhwfmqVP1yC8iZ6BacVaqX4okEt8D8Ez29CgE6VN6AXaehe2VbzRCk1XF9+dzkt66SktHEp/Wml6lVT6lJ3l8jYYOrIDSjV/xjYKQOodDTXpAIj3EYcI+LS2zVNm0ylhXYJkhz8QAnBjTjJb9CIC8ZpYEEks3v5YwixhW+aTitRiTZz/MCZ26nIMQLnDgTFriLxl9QmsxO96AToxy8f6ZsLUDXblO+74oOSpWTEoSv4ihwHPIQACpc5tVj+jDQr0MRHdiL7bWn/+DACc0ZZcO8AoED4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=D98jcbWhCM9nTbdvKzc/x3qLsSm2fZgQQ+I5uU7QzWXynUfOkdpOZuAosHrmp+8I1dbAfadTV15/08o8rzr5vLrlFe02W1+kcftagOiCBLA9YMLTdOc3eNWc+y1H8OPDNI4MNDzcZ3u6vPys9SxEfIe6oj5dDsRa43Xz4UkAIt0=
Received: from CH2PR07CA0058.namprd07.prod.outlook.com (2603:10b6:610:5b::32)
 by SA6PR10MB8013.namprd10.prod.outlook.com (2603:10b6:806:447::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 18:33:51 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::83) by CH2PR07CA0058.outlook.office365.com
 (2603:10b6:610:5b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:33:51 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:34 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:33:34 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIds659766;
	Tue, 11 Aug 2026 13:33:29 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 02/18] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Wed, 12 Aug 2026 00:02:57 +0530
Message-ID: <20260811183313.1550425-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA6PR10MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: b5998488-94e1-4fd7-f3c8-08def7d71786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	l3qKb2dz8KVn4etoZvkvLNSHXgSz+a/EfN+2CBTo9fraifTYhWF5pqWKZRGYs2C9Wapi/fziCiR3xETFZWvg4uSHd98ilYWlckXFe0BHNxDDFib7TQbGK3kEM9X68bX7D0cVelerOMOi53PW4xdzbYQ5zaLClCd4MRWULtVgn6CCEUxyi2UevgYdKcAO8tW3jWK4KNS/I+Xl/dXnLehd4IqaMioBUjX9rc46QD/MHu0lmrMi75Ryp0iZ/SywqEdCdX9v++z/TrRPIQUYz8ab57S2n2wz9xkCNOeLqbx1Ue48bWY2TGnTuubKHdspsZjPEVhTRcFP24fddsa2TszTOyePxEVC/cW8evTBdvxraTyD4D+76u3JYoqwdX88QmFCn0gFqJu8WR3A5yi3w3+Wifxno+5YffyRvydOhmZOSYhRNSCqJWOVM61qlR4aHOOMS4iX0bjivzikekmLycuazbFic5ghgol2FQhlBBKTVG0E/jF3XxghuYGSOk3e09ZiXg9dOMcQr4XtZz4NFr7QtGPYPOrMplMr1uxKnEMcbPqadxnvgiIxyGA+x0q7w2FG3hcciM4qz/C0l0G+shlEmL2RQmz2BZeuFVadcY9ydNjsPKoL0mTrKZ50hrUhuJ/m/m5nttt65NVFcphnpDGF45SnbwFXCwylPNLl1NqTtB9MDUFRnIMxUi2p2K4EqNAo2Rgf0gfT3eldlx/wyEdn2wcEti2xSvkvYENTWL0/6QXjX+35eRqrFlQ5U/nHI6dd
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Y7uWBYhM8hcBEQquaeKI/ZHK04umoeWpsI7sPq7jv/mKB4lWVh6LIXYxWgd69RxUmfK+ovhyOSG0KIedsFMhruuUiXq7QMnFo1DwsgKToISXcDdMl+kxb0kRbETdRKJI2TBLt1ILVhYlJ+t/MG1+buadEYz4jtCPX9u+qEGXhaeqGUAO+8JVJjed710HG3d1/rFHrZWOeN+LGRMrkxABt6cwgr6REKd4J7YlTxq/ENQSRY05bkstd5Z+r+Ga93WlwLTObJHFjtLOuVwiLBHwmLzgyBufbtAYzU135uD5OHcGIFDhs8GeiMC4tDaIeSNlPR54AiQpo0zxTiolthomc0uZHeppDj3tjskdyHEQg1VxOoQhD5SuEnlpLjk4+j6vixuy08aFHc7kV6ds8WoTM1nVOv7GRC5sOKKkFpmvuCx2ClrOklmwFApOm6AH/Rn
X-Exchange-RoutingPolicyChecked:
	GEMmJ92VwZWmF2aab+NaptGpKfuGVf+mSyTG1SKQhCJZTNtID0OUEhYFOYk5Vbd6UA7D283MMdIF0xmUdBFZ0YlNHJXcBnBL+3rjse7jmIwnIZCNfy7AqdocowaJXMGDKJLjRVvyOY81/jumPBvwycyXjqAQWkMdlAyGGH7UV9bNZgyYWrLTywmgdTAG9ac3S1CDhEMTyojLUDpTEgrhk3vLpipBU+Z1ajAsfCGpsTecdfWtKdpvauSbJnpJzWwH8UU0g1Qf600QKnsOuDUT4Km0bLu8Kqw3g1a3NvFAETIXWHDmCvR/Hsm3u4IxB3tvYnkMZZYIm/Ge6eh8KxJWJA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:33:51.6979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5998488-94e1-4fd7-f3c8-08def7d71786
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8013
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX5kVXG5VyZhx0
 OPa0J7iV2WIkCcKe1nMH464gGhQaH8Owh6fZEG6rDAQPrZPM65A4wr8bLWWQ7IlKUzjKHvYgor+
 hKpTcnG5b8lctK3sr9A31oDGj7DhS+Ul2na8p+O7DfjnubrlDpP3brJqO/YWEopuluL9rzG7cLa
 0dvbJGKIpaoYWgGNEiEQBIaupys1dhKZBgJDxDL6CF0BJ6VP2c8WanUO2TsFpUe2Vas8NTwIagO
 xHMvIwKwflvtqzUHje6LBqHGWQCJ88S9nGZsKXOsO5rPDb5wT+retrA8atnAq90/kUEwI7iw4wH
 2mwbiivMKIpuos6IxZ9KxcZXuEk07Yp1/w1ZvkNhmbjvEp6AKnYsiXXoaRVZHtE7wFJGgFihGRc
 gjGEOwpDOeHnguxgehBcTu4/ibqPifTFw3P57pcafMyD/74syEAfwZ4PDLdFaJvoQFU4NGCNPjg
 sVfx9Ju9xy5H3q3t9Jg==
X-Proofpoint-ORIG-GUID: mKUW0hkLJd3rjeYkhWALZoo8CDKwneOl
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b15 cx=c_pps
 a=J6o3koRVWeMoKD0aP1wsjw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8
 a=aBuQwODoJmrdCVe4joYA:9
X-Proofpoint-GUID: mKUW0hkLJd3rjeYkhWALZoo8CDKwneOl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX3pxIQ4pjeIrX
 8tIMmstBwIJeb2lVpo6MTv+777WVd0ivgxZCVQzBuO7DufXiFqSyrmjffB3yCXvKPaQSoSYk8/r
 0yOdjUiG1UUaOsIVQwbVHQ4JDS0XZBg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
index 84976fd3ee1b..cc01b643fe9b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -123,6 +123,13 @@ properties:
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

