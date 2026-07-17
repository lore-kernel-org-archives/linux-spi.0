Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D73A0B38;
	Fri, 17 Jul 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314368; cv=fail; b=qQTkUlTwCYR4U2TnlyQIdolndrkQl7B3gdUoJNeLmRd9iFq9tPTRZG7TUkSYLPVb06QiiFbUd5VHaA9RPNpSRj06ICyGdMAgF0bpbN0AzTPJ3zASJHqlyvJwpgShnltCoL+xxx1DCIrldvs9PVToRbRrk7H13Io+G49gCKciI/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314368; c=relaxed/simple;
	bh=r6mmBI47kM6LbC2TeTm5XGDNze+9ICvcqteBVTKQmZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUJ3WlVYatbXZbtuG/QQs/WbyhQ5TTdlZXScSQE28vV82y14mN3Pe54bBhcw0txnxNdy9H6JOZ4lW+RUADZLpEdl0BMJNRYxgwC6r5vqqYsVO7TEEI89BDZ5S4t/gFom4scB1vTSH5H+pjrGVZH4fFc4CRLunf+a4Olfb9ZCqrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ViR/CaDf; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AQwLOrms; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ViR/CaDf";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AQwLOrms"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlUBo1570175;
	Fri, 17 Jul 2026 13:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Jn4J4+v73YafNI7rjY+a4Pdbl5UXyUH8s/LMgvnmx
	Js=; b=ViR/CaDf6KSHGfMHE8gMNkpxJkIFSWif5SA2JyToDG0BhbzGaFtANGcKd
	DCyCfAqb1aLDZ0ZR+sLsk4hB75pE0YfcZKJDG9Wyb3MJysnZ7ldON53bYYWrAbLs
	6pIM/4ogLXN46xxIRf+V3kUE4qzElcE1+9mNMvJKa8XHWJoSHQwmdz/LcLLJS3aL
	b0DVYK3JsNjdujZoregowEcgfTTn3+ECnWk8/6/gw+s89DDz/7aqHoQkidPFFPNT
	4PWZyLilUz3fDb8Tof0oEw5MDT2PHzQGFnz2E96H/TAvibEH7ZOtQPhQZnkgW+PY
	PrOoKZnQifUio0Ynbiuu16vZN229w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmbgte-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/mfNFdxCg7HqG2Pf2Xo9m6q+ln/QjtOgF7N5VH7vN4kCGDfjvezILEROv9Unq5rVAXWxRUcuU80dOsw999klhoMXojp2fIwzC/pkHxlX65XP1uSu4TCG4xyb70E3QslOKMakb6nFZv5H/jbvB+iR7pqe4whSgOi9GLvIgp/YPVK8dIp6vKG6E/DJXur69bfNjUQY3K4PsQVcSht4uHSoqfVtlMU/btqVoFaHAXpnF46wifs2a60xAgJa0tj1x38XZLsU/QVcy9RarAqB0DFSqhCWs2/5ngi/dlDtgR2DuI9+fr5bsofD8tlF0cYQPfEce0eO9bzXJxU9McNEKrQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn4J4+v73YafNI7rjY+a4Pdbl5UXyUH8s/LMgvnmxJs=;
 b=rd6F6mNE+TUGmVnSJn6IY3IPShA9/OYAwO35aFJFvL0lFq8mnUF/lx4SjIBQP66t1aEJF1kk5akTsp+bLx1pxJjMSGCDAwhUnJjie5tEELMmW1GbZ+E0XARrifPqcmWyPCvcVG5IytAZDnxKj1XwDePrtuSWzOwkyTwzY3CwmkabLp/MkiVDOzTVoAnX9Q4cnwTRzUYYRpcHORXVyseKe5W/4PhugVHHt/6gwDeey5FwYAAbx4Y0BFS/J4x3h8vd1wctuyfSEEQ8P1GXJDbP3Wj8WZ4rDGhp/L6dkgDDVphGfO5Cwl2M5T0G6P/GwtPTgy5H2yiNUW79mUvWY6N1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn4J4+v73YafNI7rjY+a4Pdbl5UXyUH8s/LMgvnmxJs=;
 b=AQwLOrms7Oa2Ef/EkD0ARx9eamXQ52mKz8bOQ9MJR3qhsh/yGnjgn6igGsqYFwF9LXpUawSb7DEs/ZoQg/UwtzLroFFIfpUMnQo6VBu0Foimt0HrFpqhMO+wGqIISMiz5Lj6i9LoFaLCFV+UfODx+rXIfHbyqcyx8iUOQ3Y+CDE=
Received: from MN2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:208:239::14)
 by SJ0PR10MB6375.namprd10.prod.outlook.com (2603:10b6:a03:484::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:52:31 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::4a) by MN2PR08CA0009.outlook.office365.com
 (2603:10b6:208:239::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:28 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:26 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:26 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4u240969;
	Fri, 17 Jul 2026 13:52:21 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 10/17] spi: cadence-quadspi: refactor direct read path for PHY support
Date: Sat, 18 Jul 2026 00:21:09 +0530
Message-ID: <20260717185116.2065505-11-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ0PR10MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c63049-5f06-40bc-ab20-08dee4348d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|22082099003|18002099003|3023799007|10067099003|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	pOW/CraEobjpuHIF/j+xtpGY55qmxHL2W0BrCtf8ETxMvLHBi8avGUfa4MeWTy/sm7Rpa/54foXP4UNPYrLbZ/a8TD2WXYsGhPv008Q7BbCXFQrdDJ/S6XtJikVxbCmcqgh2Caz1UjvWTG3C+fI4Wt0CAh+EJEQWLwIGQwCl06PH0TiGNpzGwr48vRT/gi5O3r+rm3tTh+Ct/lPIjYgs0OOcJEAMTI/+obb4G6FwQSHOIgpHPKLrd3VkVW9S04XEobA302lJJ6Pg8Q0tBw74dtSEsGdzfcO+n6KgYoSo6GEtyrx+eJAO5Zdpfmu9IjXA2RjiBZciYV6mLRHrNTuon7CN6TrzReui9AnsfBXQKn6p/43HooA8G3AQdA5kiMlIRTGYUtwD6UyFyPmGFchS1q4a4sFmxjGfXTYCRJFidYK+qK49Tlwy52yTgWjJCmzXEppmuvKKN2F+vcSxF4w5/QZWeDAL+IFr+lY9TD8H12nZpm0dFF+FFVeGStaFAz8RPctD9lBqKKZo+fFb3UuPPdHb7v7jrAOMtF5JUCv3AeCivmjHnGK4OTEac8I5Da8BdkMuyPdEOEGeQmq5kqMKmkwpD/sz0fIcPy+z3VGDOPXCX0ScD9BJVJlrIPU+lMI4FNUeZWsnWeYljj+YSe8FKayMoYmSizTRfaHU6RTZZLjQ4mKgy6GtGiRGsPqA9MSXfwNOX9cfXvZuPy8DSYU9AMRxOAd8MXUyPdq0MbwUcNQhZyPHOYlirYpmzjTbMmX+
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	st3025d7dt8OII0OROQJ08xXAHpQzAkpKjVgoJb2WlCN0mUTltBgH3Gs6wnBoeeFWnziSsOZnSIUXUQVm7BQUYG3J1pA4YC3X4bqSb2TDh66yBybOSDFRLMt2tlovGtk82nCp9Hun5Kn4NfDGBxjWRKS9L0G8XU5H5Jq0RPvQtZrg2KBjkroIsDP88z1ZjRIlr63yoFquKDXi2YDZuhOzcKrdAnbwi8X/JIlgsQXPtmCSbboi/BZWJq2PpmbgS5PyVZ/62d/tsYEtHdZ3Tz2Al4zBL9hgrlAQmtHC6DRubT0+ngNPPV6YttsDJ8XcSGaH8+Ll5fNsG8nvOKNUxM/9+aN2HXlH2Rd9xiv3xvnbMC5WwnU0TV9VyeGrffm5SGgROsGrAxo7j8WIDF6azlpbsW43XEgXXlSe45VvE0xVjyb8dOw2q4g3yXsFUvpZhlv
X-Exchange-RoutingPolicyChecked:
	QtFv8o0sgd+1VdD+7KaNGZ7znuwYsKITw6zz+0EizSY7Feyu0bEYLhYuRwIaexrUpCra/w2m4TybO+wtiqJH0syQT3fZVycF4fDIKRb2IDmvP2E/XkBFxr0FYstUUOK4sP4xUc751NtOvNL8iZYPProXwdFiLeJUTwxGkGievuQM6exm9M+qO/UmAUcvtgnlrEqy5CTB3WvRj7Bu6gqp7MFRZ4ij7uICZyD3K0J0P0BAOXL0LLiIncZ+R7kTblo7PZ5oPIoKx6aPTr6N/WSqTu/cU6nShCCf0IJ+rr5g/H5poYRwwCNM7eB0Cx6C740VfAj8UYdKOcv/MbaQeLyiMA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:28.9109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c63049-5f06-40bc-ab20-08dee4348d1e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6375
X-Proofpoint-GUID: kZ67-bun3MZlTHJ-gVU_Uuigf4kINWDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXyVl6mRDCGlPL
 UJii4mv6xJqt6x9Lg/tmjqzluspeo6dcxnjOT5mulpaAhkyMLKR1RMkmD2eQ2PiF9CFqSBTJtHt
 ct/+9wstEymfTbaVC3EAfuhuwtr+QtYsGzrBTZ6/WI/os8KVwcP8AmPZJpezJwlpH22QScAiSep
 H+j1dctXRZj+gL1I06ht6eep3CDkAW8kTlmmDyUqNvR+gwA7fUrOl3WhIaIW3yQN6EdAL9ADdWI
 4nAwLRdGxsY9QPEy0NpVeKmo1mrPS8YrTKcRdm/1HRFwol9E/Ev1CEoXr80UkT2a6EOctGbeljj
 abIfZXcUkEMb+eTjPuT8w3hpavow2ddcOm/Btqq4GoZ78ZFBVKCe9MRfQ/InBOOblI9ezR9u39U
 tq5riFH+BdB603pH6f72X6wD7ZPSvvOLViCrRiN4ReTzuMaPEUPrP7oxWlBXkPKb1r1m6ABh27Q
 a1Uh5ekUURHQQgqYGRQ==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5a79f4 cx=c_pps
 a=ixAZ6W2pdOuc7GYTaWtIWQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=kQoCic6YF6TU8Y4tUr0A:9
X-Proofpoint-ORIG-GUID: kZ67-bun3MZlTHJ-gVU_Uuigf4kINWDh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX2gucHtccW1PL
 qQGLpxInEJczriRhl2KXfX9u85Q71sHHzHEf8RAE35xSaPhJ77El1kRDuC0E2pBum66ZgLa3Kv9
 2YaLdRBlw0GVLL+mdeIionsI/dvmUjk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Extract the DMA transfer code from cqspi_direct_read_execute() into a
new cqspi_direct_read_dma() helper. Add cqspi_memcpy_fromio() to handle
non-DMA transfers, with 2-byte-aligned I/O accesses for 8D-8D-8D mode.

Change cqspi_direct_read_execute() to take the full spi_mem_op and
post_config_max_speed_hz instead of separate buf/from/len parameters,
matching the interface needed by the PHY-aware version in the following
patch. Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_read().

Transfers shorter than CQSPI_PHY_MIN_DIRECT_READ_LEN bytes always use
the memcpy path; longer transfers use DMA when available.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 72 ++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5070ffc53d5e..322e95b3bc17 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -151,6 +151,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
 #define CQSPI_DLL_TIMEOUT_US			300
+/* Minimum transfer length to use DMA for direct reads */
+#define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1521,8 +1523,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1534,11 +1536,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
@@ -1580,8 +1577,61 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		unsigned long from_addr = (unsigned long)from;
+
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED(from_addr, 4)) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/* Use 4-byte reads for aligned bulk (no readq for 32-bit) */
+		if (count >= 4) {
+			size_t len = round_down(count, 4);
+
+			memcpy_fromio(to, from, len);
+			from += len;
+			to += len;
+			count -= len;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			*(u16 *)to = __raw_readw(from);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op,
+				     u32 post_config_max_speed_hz)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *buf = op->data.buf.in;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-			  const struct spi_mem_op *op)
+			  const struct spi_mem_op *op,
+			  u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
@@ -1597,7 +1647,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op,
+						 post_config_max_speed_hz);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
@@ -1625,7 +1676,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op);
+		return cqspi_read(f_pdata, op,
+				  mem->spi->post_config_max_speed_hz);
 	}
 
 	if (!op->addr.nbytes || !op->data.buf.out)
-- 
2.34.1

