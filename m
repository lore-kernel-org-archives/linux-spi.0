Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A83806CE;
	Tue, 11 Aug 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473263; cv=fail; b=ZPGkp8jmqTQPWIz4vpdo//xBNKJmgjrkhEdQEQ2OYuAsND7Vm+ki8q9JPDOZzjrxC+ev5s9IskZX91zi8+lV51P7glQpFWAR4dlanfifHzYISaRab7/EUGd0dsEQ0WSpG9Ow2bhx1HndwcZe642Xg5UJ6sMuzADhwQf83IB8d+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473263; c=relaxed/simple;
	bh=v6ww6XIH8TcUT23LUPoMxzFGFmhFMyzO6/EXwGCMXPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4JBzrTEmTky3yZXHYqkf6J8NftJT/SdeQLIvW6Xm6DmRMLkIpZy2UdgKNuqcqeWHk5I9r+XAAj0P6ce9J5gVTRSV7vdtPPNptRGk1r/4YmCOj+ZP1WOS8Lx4vcZGU+63WL/2kBOset7wAI8jkszA293cCFKucH5ym3SkqRFGBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BGiIpHAZ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v1XtAxaR; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BGiIpHAZ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v1XtAxaR"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMa4s2174814;
	Tue, 11 Aug 2026 13:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8C
	Qk=; b=BGiIpHAZOgcZTBGtkqpGlzC8yrOfc1pbdqHv+vcaoPbaI5L3Seezlfeh1
	sXWJQFIbkfwgFermbi7RWPUI3FVf0gorKw3BtccVUybpc+cKYREK2abP45djL1FH
	8cVFuVtXjW9odz5HqD6u19b47qHL2ATMT0VcRuat7/1ZyV1Rr6B/8bAS45FL1V4o
	oi24Rg0gE2vjQfrDHczaZ9wHe2ndtUv7Rg2Z3V28ChIyRRtFRBpC0fg2yHDgT0hu
	fBXf3arG17ZCdtp6OKlHTbi2is33KiqiHKt5823+WRQ8XippCN9pckTzbnl2Vyjx
	yWOI+S5oMH8+DfrF0SnDaDnwnsNsQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uhyn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRzHUuyb3O6aqNOlSxsD6JK9+b8Xy08a51DERurhZFPdZwUztPJrAVH6321VRpFp3ik0EjXAURnBqGRsO2ZfFBtSoDPXwdMkjZMshLCS583Uh2e3uePRVWKZXJsL8WJVIlcbHoUWIuxMtn7FVHptpc6HoGXZnsbL01tfQsUJEdKUArEYC7NTkVa+BZFwxSx/I8QrAMatHo3RFYNdTvk637sD/NYRuKyTTtftE+pFvT/wC/BMIlQ1N5bE5fI702HsOC57WUmCeew+UmtDJdtXBhxsLlUevyoGjf8ZAM7B1gYoMPGJi3k8sL6XVH8WRrJi7yI8lGF/OJwA2/LEfu6ZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=S1f9zC+izlSH7MmobDdE7xbdF0jEYJ+mzLYFASuTGqawJjqOLz8cXO/2rClXw5Hov7IesyKwsODpHSbhBAnkbi8xEnMTqTLIjXV6s9DwO54ZwJSb5uxMwb9akc4WL7Jt3bRiTBT8jj7A/IKqgcrCW+yvzlT7lo/DXpMQ/o7siUE5YTBgriGvkDbKejxkUzHUzJVvlUqh6dfWXXie+naiuDgExb8FCqjjS+NKNXGcae0Q3UXcY6Nxcb/YMzzpZD7IFkQggfUqm+LaPc40eMF8vLvlGN4M7Halsmg3pRBayv6OcB5EuGpcuLc3qgc/iTMy/8rVgmbOEqUrTZhdpyi8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=v1XtAxaRduBnJf2ClQHQimH9me0mnXGN257RXPeBwzUYsnP5WefeWkm1LhDYt1RAfCvxy0IK5461SecivJphYvbAVy/XSsHWrWIYezRa75wDL+Dz1QVFHodaogZxAb5fqBU3QsFVj9a6GEpJtN4aEEg+OzBKtw1sR0s+dmRy5Os=
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 18:34:06 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::35) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:06 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:53 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:33:53 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIdw659766;
	Tue, 11 Aug 2026 13:33:49 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 06/18] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Wed, 12 Aug 2026 00:03:01 +0530
Message-ID: <20260811183313.1550425-7-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cb8886-067b-4592-a0d6-08def7d72040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	W7PbwU0R/dBFsS0MT7jct+Ll08crxcHZT3MsmjW5Oettj7xuoM7cEFEPCEdSTs+cuWmGD4oOpNQMyQbNCGBUfsYTlYoXQVfFKiMBnDMmi2C8UUJPmvPxGyVBY1q4hYFlbmxFjpBMwzZZlUagEuIsY82IGHbgcbt2FsCggEu6EyyPk8mCkb05jN7ubkHR8lOH2044dH9uo+rRBA6TdVxFXzn8Z6I5fygjXx+9pUHb2csb+oeXtwlnSa3LAEmvqh6Nc0CcjM/iOcgvnO1N/TewK7UsMn1AMxWcLVNWKP7TJRsqk52z3FuAdNDyCGbg5uzr8Q+Hea1fEgFtPLxrPK1oNHAGAgtAW/QUov6IIAlSdiyHwAxa4HjXkABkK/QlAFpAGX1NLIfOJd1hp4/vXK8LWjYpUVyZz9MbSH+3GJaLDUUR8xv+AaKK11YrrS+eTVZDHLDNB5mEloVg/O6e1alqQMhwjEQA8pL/+blax38qPqDzWRb3BFNj5232mC2+GHrt5Ywc9wcyW2pjQyFU0W6f5Gzze8jq89EHz595IfvHL6JN+jo4faVhZDEpOyhZpQbcafyfEA4qtEa7nEZpKYlvDR6WshungbCjQRM39I+c4GpXdj+NqnJD5M2jjCXCvNYocUHN9btvctNPG0XRWaJOBx/LXUSvq2xaGADzgDt7KF3lkZ7r9meJRCfyEMZYI30JpQRmcHcArfvv2i4yotCFV8w5iYBYui7E5ujQQQJDfKABsHVK+NdkVWYuEj3Lr3bs
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(56012099006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4wbRChAaJGY/mTGCqnrIL4Pml0MNpfCp4368Nhs0XoC6Iz3HDzr2oo7H/S1oZFTjIEj0eeK5vF3CFgikHUqTxSkjHdWCXU79ZFR0G3VOoCMrslLit/mSzaGytPrROWGp1nSMZ0lUWAojnhDy+aFks9vgz8AxfLDOaShMmPBYHXAQPHDnf9JnfkkDwb/lK1lldxpuaiLGZ/jUCdcMPAY5ut+litDZ8UVutXvHygFynHML1jebP00nWqsI+ld+CfRxoDr1M5cmJXeMIy4aEwJhf27Zmo1xQrHU15emdncAkeyfC0fBS71y7bUJtk+xU95P3A6wRsOxHwC+SNaIEZcV9zFahz2jm1Fiy+ACHYxJjnv38B6H5muE1i04TNJLOMJHhIDLGw+t91Y868NPesT21/ESBF9yHx/qlPghdAcq+al23egsmnhS6L1voqx0U5wy
X-Exchange-RoutingPolicyChecked:
	U6A5zZxQtaK/meU1xSDTL8OH9WROl3ZVa5QNQreM1emfA/mjc7fiexQTW3BeHJ4EQ29qn8ZeoD7rT9SM5Q4anmIpoA24AlGti9rygst/0BUFYLygy8WjMzGJTZzNJchBYjrwNAGgqhAvJo6fRJ69UuOZGGp9SWf/ll6/QbVKQYLfR7kDpszAD6BeEtxOu9L/EbjNf2n+ofF5AGv3gsuwdzP5Mcm0HLod82SwwOAiHenVP3zjeG4vzUnLL5sM96w+JC3uJrtAK3TiuaFReguMsaiNtVXepc14N55nShZLdLwn3rMi+J9W/ii06zYhasPgRjPs7qVSXYdtPbDO6T7+/Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:06.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cb8886-067b-4592-a0d6-08def7d72040
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXy07CRiD7buLR
 QHrH7g8ttk1tDSPYwUgWJlIDZATX0KR3M8uDUr3GUuBo7G7jMEKG2Nl9cZRME5Bj0kTMDA/WtJX
 /lW8dAeLjDNknCaegfjNYIwDlneFNbfMZumnWhUHwb80QSgx0WLrpbsI3FenzBtXGKh+d4V4y2M
 qLL1Ip0rJCPMo3H10B3jF8CpGLIoScEcceF2qMGXkOVs5FT58guxBlxg0zzc9d4MR4Xyyjz8N8V
 a3KCHHNRmN6AoZFa5LdUqoCDp0EHXvCywbjPP3FzbnH8OnnoQdpp/HFrqWQbKLievPUVzTx7iRs
 tNhs0YGtlIPFgMaKF5V7UEBNiGdoQ8NuNj8Fwo0yHOTqNgrLVbj6qzFGB04GHDvGI4k/VireGb+
 pw6036nak6RG4Tgp4TDG+jY/EEhvd5cc6bGuSDMLJxFPRqdSCO6eUTBCw0OFMDm1GAsLoL+aY4w
 QFAbNagI1NJ/zRSsF/Q==
X-Proofpoint-ORIG-GUID: dr-DfMxLo8sise-gwiXcAYUbj0QgaDc1
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b24 cx=c_pps
 a=ZweBVesMg4eTnUcQsPPJdg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=2vpyfyhlguDYHLkT4YcA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: dr-DfMxLo8sise-gwiXcAYUbj0QgaDc1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX9MXm+A4i7jnJ
 5x7qnzQo0oXUNja3hraKHQ7u/l8Y1OPwf2mOqUtNcnWb+DXAoJ/ioJD3qssynis7RPfmqwTt1R5
 ixJp6qYrWqLicx5zEpt4EaDhZwzLOi4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support that needs to
call it without a forward declaration.

No functional changes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ecb0be394696..f8e266372367 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -457,6 +457,28 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 	}
 }
 
+static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
+				   const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+
+	if (bypass)
+		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1274,29 +1296,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const bool bypass,
-				   const unsigned int delay)
-{
-	void __iomem *reg_base = cqspi->iobase;
-	unsigned int reg;
-
-	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
-
-	if (bypass)
-		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-	else
-		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-
-	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
-		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-
-	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
-		<< CQSPI_REG_READCAPTURE_DELAY_LSB;
-
-	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
-}
-
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
-- 
2.34.1

