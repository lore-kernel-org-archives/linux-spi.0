Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311648D860;
	Fri, 21 Aug 2026 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313028; cv=fail; b=N3mmB4SHMUr02Gw1+7SV1OQMcs+2GyjBGKaIMM3kLTFEFvZMC7Kk0aakXC4M7yXX4OKO+lNRv4DFWm2LzIpD0fgsd67WGTyJQZbdTS/7IrFaeNSEZvX21XxQkoMfI6orA2R2HiTdOTyOTImHAdDbOReEqfGQFrC4Isuzpi54Vro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313028; c=relaxed/simple;
	bh=MDx2qjP/XXiD3vIr9oQt9kMeHBFs0R28iU0agoq2Hnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnkmoCXwDy5X9ppyHccsC1nk6bLk29s3hKKM7uyIMcRTCT1VVhRUEfnGGNPL2V1L/El7mOHoYiJg1ajtvne6+Bju6OVF7NcGYFPfT2DTFs3zH+WT1rkBAsrK0rf9CklQsGsrTmOTmFh1yZdR+GK9e0EtWYwQvon5TRn08hIrMxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=fpylUKhP; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GSPj4kgP; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="fpylUKhP";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GSPj4kgP"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9KJBN3421338;
	Fri, 21 Aug 2026 06:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=8ugXXaYOACCqQhtO+XS/9SAqsz/zeF6YSVcc8SKLY
	/0=; b=fpylUKhP1CWD7weTpVuOtIJAhnPVhtGNAI6lr/wky79IHJCO5mz44lMOQ
	fzA9YfKlGAJfRVyPdG3Y1KhDrLJRkYPWLoQwggZ6MD8tXeQylXZYwtSEuYX/KCDF
	dxCKXoXZ2JXMAVDQFWKkENAr2Hjsxa50HSM4ScltbvMz80A6f6tJPlCvFck1s6p7
	cs/ualY/smzwt0NeYsT5L2pWw01wANstIF8DEv9l59ihdV+93Vz9dRpReQTmaMp7
	AQo+Uk0H1WESiyccvmWVItfGzz1FmnBrCWevBD+UciZquPJkwncOi2xCP2frzSDD
	JGFkD5dUMlasKeoRPN5f4qNkOqq9Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6knmrn2j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:50:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+vlhxZdsp2vnNLfpgYscZoqo6dTlfWL41hrVelqrPRiQITBXN69GkESUPd/eKg8UXZM+mHjSpkA8o5ac39CIkRxfIQNaBhTLhC716oGp7e0cUklGrx3hDbGW6t3kYl+XiU8i2+quo62FJn56Xzsvr0R9Nof6LD/GN6H/8ZIFUlozAtezXEi4c5MOuv/9lG+khc5pErYVCIqG7XtrzHusMYOCJ/jY9GeLVfHrNaDJIO9KD/koMQ90vt/khCX6/AkHbJ2P0fhBA/gLaL4EeTFsk8Gb06W6nYFz28DN1tHEeHuIadkcQa5N4SxLoEoHM4vkdVKy+vamSUo/Ch2n/ku6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ugXXaYOACCqQhtO+XS/9SAqsz/zeF6YSVcc8SKLY/0=;
 b=PggHi7IwT3SE7sdudErv91830QBLY6TBCmqCrBmnLAu1KUzbQCQWxYWHkNP2EhwSg30fEGOwplkOMlMmEqkORHW6PRwGKo0xXR0BLbh4SsSczyi+czbj5LYddfOuG67jIQco9PaorZdIw6Wyoa6oT9xhOxA1WRkB2qzEUwaIvavaqZ9Xm9IApKCVUFQ9FB0CIqNohm6Apdg3UP59zliCQJxM8oh4GfG7KPi/n8xGAk9nsyBoAo6xYNMWhEAl65RkKCMD2+iJLMZJlLaTnAFCLVLU814JQG6pG+ruilYy3TxvWjRqZVnMK7f2du52DHtdFQK98gEB37zL/iOMuO1kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ugXXaYOACCqQhtO+XS/9SAqsz/zeF6YSVcc8SKLY/0=;
 b=GSPj4kgPtkF8rqSKYmd8Nfn4reZ+UdgpLBvkWLHQnyFM46q5Z/dM9XQYHFmAUsLbkL2NyK6TMdB8kFwn5Efeogg4/IOAyYn+q9z6nLlP4maSN4ISkkFfIhKgP0t0/Xko1AZS9PEmN8fyO7EPWFu7HUrH7eDKbqGBpthm2d73hL4=
Received: from CH5P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::12)
 by SA1PR10MB6392.namprd10.prod.outlook.com (2603:10b6:806:258::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 21 Aug
 2026 11:49:57 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d) by CH5P221CA0016.outlook.office365.com
 (2603:10b6:610:1f2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:56 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:32 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:32 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVll2022942;
	Fri, 21 Aug 2026 06:49:26 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 10/18] spi: cadence-quadspi: refactor direct read path for PHY support
Date: Fri, 21 Aug 2026 17:18:14 +0530
Message-ID: <20260821114822.4040338-11-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SA1PR10MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: e96ea42f-7ab5-4679-caa2-08deff7a526c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|23010399003|82310400026|376014|6133799003|56012099006|10067099003|22082099003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	NGkxCzp261gkJpg8ejydcCSxF6N7t1gm0WwVkFF9KM1mnEwoUDAY5JDUSuJKYPNUUE9n30TIhRvfxqr1iFj2d4EBMbTYESw+57oMj09QQb/rqTlocPpBEhOOYWloZ2m2Jw88YzDT7Dcm00Q3Cjv/9nXhXKse+z/NhfkNEw9NiqomhinaZTj/A9TNqUPPXZVVvZI/0yASCGxJr2FYmLt6Vmm/0EUgxT1Gn6jSkkOJhc5i20AWYTwrVES/RNOVzqhs6gNwFdsubCqgesBXnw7BDYYJ2ZaerlAME14tA7fhqDWBO94OjjeEjMw4AUWNU0hJ+wJBKbRQ4sshc/E9nN6PVSr3Td0+E7Rfgg6+BF+tkpLdGxk/G5HleQ0Mhx1dZDTRvxpB7l+zO5zAURihiMt/ld0iQkh1ESRAvLHlQoWeG5IwLC14V5x8ob9zx4SFUYBPE7k8Pt1b0MlM2ksDn3l8pz8qL/FWTALikbT4IpifPDdE38vL+y/txzU3PskfELUYXpQvu7wW7wBaQLh8uNuks1TCaku+R9dDtPRWipWla4yjm+T5uij/w0TdKE+jzB21q0EpJ1rnrCvTl/zx9SGgTiwgVhKson+/2OXHbVMBMyNKvXob28Yz+P/31CA+68d9NmUyRh7vdffSkRHEqQYJZuZJXICHNJcHJEcCum1LV8pWjXdLmBeIah47HC7amxBho311TNDbIfb7bh7SiemHHsetP61MV9zDNTUhJiWbbi8JzkvKqpniBjvNuKOAg9CW
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AHn4Mdk0s+tJS260j9xPOBM0XxktPkY/kDfd7Pba/irmpj27BzV6A0Pq67q+pjhFhLMFan97adwPwwTSyIOfXQGnECMXqrWuMXkh2YG9chRymotG27QSCb4SR5a+F50D0rIBsvDmgluq9AzwkiKg31Ka9hGEkYJusIs6iT8N3IilPzaeZEDyMzQgQJ3kg/oV5LvqXvhbPtZYpXSyxO5t7EnEH+PIslj2pttc+pnk6NHWIPru9F6YNnAbLBT/WqOzVr5VZjS7ht7+UG/dA0xXpWNS2m9ZC/e0hXlvIFdhNe++lf3u5pnbCJxwIY8zhMrAmJT/t/gPSpBCc7azHf9cWUkbsL/ZuglRrNk1ccYHj1NabEzhDc5m5w6IdvrPgr7AwAVXh3/zCNy4X54Xq09xjRs4z9UDcicQ57T1uudwjuxEaL6Tx0+1m7trvCcVJdRs
X-Exchange-RoutingPolicyChecked:
	MHBCZU0WKc+Kpw7wxRPcVA/fsRHX7Pufa4+GF6GsZikIBD4VrmFsKrYKjGAIOGaUgZunjTRHYsbwfK5WtLIJuZvIh/oAQgE9zMrW3BOiA8J0T//ljMMkZJgHP5db7hGO46TeqeoQQwbUiuaIQ2pal3PgoOG82OFjfcl5Yzz1Rn2Nzyom3NAH3GdrGy30UslnU49+TRBUm4gETNaXwp6Or29r5dCA4z8gjjH14HohAeqcFpQdb+wxYndVaE4xXp8JN89e65Tm0Sqyd2PjuK9vDgJtyxmgzRgSV8mEv4oj+cTW8dMoZsTJC/0MyEyJ1ZJ8SCRFjVpY76fYxjw96y888A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:56.6071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96ea42f-7ab5-4679-caa2-08deff7a526c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6392
X-Proofpoint-GUID: u8d_w_729nD1Xfxr9GELZ3PdN-YTbbkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXxk6L1M7OoRS1
 JxhoUqULiMzNzOElR68cKMxwhLNDT0Jx0YVBpFXPbXhUnWbvpw92whnOdRd/DysJZ4Rsu7NFkJZ
 g/niEkzcJfoxDaYZURZIoFTNAwrIwGOzhtsw5MmR557scrC5DfmYx6i/Zsqsc7z5LMvThV82Xcp
 rl4vIrBAC0BARq+jhb6LC1+PXvN1Tc+Qkn/v06p41sDnCxS6xsBFRPxwMtmviGoyDKxRlIkOHww
 TiZGUaVHny4VqA+WNaFA/jvS9QHOBSZE5ym6l+/Aq9aSEGe9ggsEBRK6R9OiAh1E1EbsxTkNjjm
 ITLgeKcfPsAWZdqtMnTwT+Npokg8m5YWTpv9hcthjHjmmPId0oL6b+IMMH3GSs9Dlw27VXGWN87
 qy3cQQDPQHEFpqrBv7nzLJPkBOV08rhtQi1HtZfhVnRogDwWwboosrQvhmMRuwr53t69iZp/w0C
 A7HvAkCj+MD6p8Bn0Pg==
X-Proofpoint-ORIG-GUID: u8d_w_729nD1Xfxr9GELZ3PdN-YTbbkU
X-Authority-Analysis: v=2.4 cv=fuzsol4f c=1 sm=1 tr=0 ts=6a883b77 cx=c_pps
 a=U2ki1QFzN2iGT7kcnsve6g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=aauMkRGVHSVL3AvwFNMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX6x3SpGVygUWR
 eF3dDGLZ8wd71KaIXbS/v4CnXa/Ea3+2rNOVCvGsNbvUViitlps4adrfENHx42qbUY0K+F5/xvv
 rknDI6Z4UbSh1HhvTdSLf5odazfLM14=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Extract the DMA transfer code from cqspi_direct_read_execute() into a
new cqspi_direct_read_dma() helper. Add cqspi_memcpy_fromio() to handle
non-DMA transfers, using 2-byte-aligned I/O reads for 8D-8D-8D mode to
satisfy the minimum 16-bit AHB transaction width required by the Cadence
OSPI controller in that mode.

Change cqspi_direct_read_execute() to take the full spi_mem_op and
post_config_max_speed_hz instead of separate buf/from/len parameters,
matching the interface needed by the PHY-aware version in the following
patch. Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_read().

Transfers shorter than CQSPI_PHY_MIN_DIRECT_READ_LEN bytes always use
the memcpy path; longer transfers use DMA when available.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 75 ++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a1aaba7c1a7e..99a0ec0e769c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/timer.h>
+#include <linux/unaligned.h>
 
 #define CQSPI_NAME			"cadence-qspi"
 #define CQSPI_MAX_CHIPSELECT		4
@@ -154,6 +155,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
 #define CQSPI_DLL_TIMEOUT_US			300
+/* Minimum transfer length to use DMA for direct reads */
+#define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1528,8 +1531,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1541,11 +1544,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
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
@@ -1587,8 +1585,63 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
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
+			put_unaligned_le16(__raw_readw(from), to);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/*
+		 * Use an explicit 32-bit read loop for the bulk; this
+		 * guarantees the minimum 16-bit AHB transaction width required
+		 * in 8D-8D-8D mode on all architectures.
+		 */
+		while (count >= 4) {
+			put_unaligned_le32(__raw_readl(from), to);
+			from += 4;
+			to += 4;
+			count -= 4;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			put_unaligned_le16(__raw_readw(from), to);
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
@@ -1604,7 +1657,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op,
+						 post_config_max_speed_hz);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
@@ -1632,7 +1686,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op);
+		return cqspi_read(f_pdata, op,
+				  mem->spi->post_config_max_speed_hz);
 	}
 
 	if (!op->addr.nbytes || !op->data.buf.out)
-- 
2.34.1

