Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B137459AF0;
	Thu, 23 Jul 2026 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804628; cv=fail; b=tXbTtUg1Dcxxb4zDnEwRihRAsuCzOcO8r6ghN3HcBwY5a+agXfPpl5drvh7Ebev+FDLJdRaW6GP8q7+tURDnNchjtsUyHjld7Pvlz41jD0DTdi7TAytc0UaDYlbstNlPOAPKsGDu9vOA68VyngoT0njN4e6vyvdmKc/oTdcvvcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804628; c=relaxed/simple;
	bh=Ws9G5suFGgWgDg6znQfNl9iU/PI5yTaPNUjDgEJ2oLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/Vx3f0WWw7a7RgJeIBSd1iW7v6KCalX45u2HF7NfyhEFb7V0VxEiw784uU84gFbgmk+O+Zf6Y0ayWTbPlbIRxlWeOvAkObkuHIUhLErc5ULhSgJJyDrPp/XKEvmIg3YWFlidu9nbW4Oavmst5eo1tFR+7zDoIolONYBc/C3g6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Uki7A48e; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qd5JRE5f; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Uki7A48e";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qd5JRE5f"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9MG9D4111037;
	Thu, 23 Jul 2026 06:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=jeApygkbCNgx3AJPUNBZRL5kbfuJAq8jwzrWjyGIm
	dI=; b=Uki7A48e297DiXYJr7o1oZFHz+6ThKK1LqNtIXGE2i3DzqFvifJzArJjr
	9TAZ3JnanmJqS1bUxbCW7y7VOyLo7EHrFzOoGCdOEnqJIon8OYAHe7EnuH9gRG5U
	l4PG+XoI1KZdQ/sXX/wmxLUu1YPgfuxFgCqZ2sMhZvHMxdM1f+nqkxYKnHtUaPac
	9ABfbsZDtBJOD+Hk1BlIWW5huTtTyXdIB4s1bnUO2VT6yYT0mV95ZiGK56Y2B4Z7
	zo1GogpPVLXe6NDaZ2xXZw4TP7Vc86PmrM2vHEw7CiMmi7m49wHH02vLJuZ6vWoE
	36HzAArBDRdZNq4cWx9jVkflBsNRQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fkg908cvc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRZ5t8itdkgznaeFbZUegiB/AJ9qeMNtHi5f4q/v4w9xu4METVwejqL4AZfDj1dvZ5F9ehWuBmzZgOhEtTW/TWbRsE2z2U+mWjUd4CV50kw/22KLwf+lIl/7NeZFdJoe93I+/7+Mhb8Th7OO0b75rO3uHf7V+Sz/K7NtwTLPi/av/0R5w+qbIAB9FzDvzBlHxNQjG1hLoIXzBUh7fM20cgToMP2uGWZCQd0eUz2LYlq/dcaZhDtZBn2gXn4VoFMT+Lo9GuIbvhKpJloJ7F6fVeq6z403ObwQUotP4gRLVzGiMfwGu7isEMYaciEzC1rnpiVOgNPY2KfOcbgACp1Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeApygkbCNgx3AJPUNBZRL5kbfuJAq8jwzrWjyGImdI=;
 b=dLtafm3x4BYGeJI0v3XeKieyDTo/hAXEDjhuQ5gEbv8v7el7ttB2/tc5PuNeW1WqhU7CdQvRfvku65VX5pFf5jQKKjXn6ojoiDOapJRyJvtTTZOsuJhsjmjDSRaRJRO2//9kVi9iYB3U5S6Nvng8WGQSy+8EBDQ6OpLXLBPuNoGKSDXWlJtXnPZMFO0chXW7pMa/UkbIU2hl+wRSk92kpgwXvAs69DKvPa4knQMFCmpTHaKbA9pHInJu69/UpPGMRBJq9L/JA97crUSjVBD+bKzRV1C+kPYIV/VEukjDmCtzlYY+oZb5NHVpRakBUf0fXUqmPbQsO/F2tGIylfNQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeApygkbCNgx3AJPUNBZRL5kbfuJAq8jwzrWjyGImdI=;
 b=Qd5JRE5fD58ACT7BUJgTOFs/nw3/X9AN0A7n/YPCXxK8Y3zThKLOC8u0jimM3DkQV8JpKFiz6UG5I5bMt8gSFA2RAUFb/BTI8KTpMe6m1C44O/yC4U7JT4tjHFfalJFCVI8TrcbsmRaBlhreZgTweZ+xPDaBVWCHp6w9W87ZnKY=
Received: from DS1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::7) by
 BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 11:03:17 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:8:44b:cafe::7f) by DS1P222CA0019.outlook.office365.com
 (2603:10b6:8:44b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:15 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:14 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:14 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW41577597;
	Thu, 23 Jul 2026 06:03:09 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 08/17] spi: cadence-quadspi: add PHY tuning support
Date: Thu, 23 Jul 2026 16:32:10 +0530
Message-ID: <20260723110219.3180747-9-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|BN0PR10MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f54cca7-1d90-44e0-b02f-08dee8a9feaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|7416014|921020|22082099003|18002099003|6133799003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6DQ/AIu2SmTirGq4LbHV3mAn36Ks1vTcMMjh81yXh93MWbT+AjAnmPvBuU1m1kCypyl3Gmo3HOguYEhLtoPfKYZTpJzIL2KdE5tyhnLEIX04MmFZOjU6nXwbH54GWMabsH7sFgTletgxdK5oLWUPQ5vv3g7M8EIazwxIIYzYPSBf+y5j7Ry/WroAxTNz7M1MByXB2VBBOQD9ikrTReW+3H4mvmVT5ttvbM7BdjOgxDn80zHN9Ih7ATYA+ut8rGrFwm/aY8QuXp9k0TbGKFdV5XtiUYBPAe6Qxho0rdODXCAq9d5NIqvvf61WNxrXAD47stVTqfpluW5NJ4w54jgFbPXVmdufCdm6YDARZMeiW7RDZ8fb6ESMw+oqVmGtIvJHm5/LvkhscJ7jc10EdxIf+dNE6XhiuW8kNxjXNTXZSorzx0u/fe9NDRUDlhObKgj7GsUUZ2HjI8dJ/5zR8pbGwpJnw+aMSFwXK3Mz5RFuGjuEfzL9URdBofQjeb43tI/1KVomMW1ZvSL7WPiQKcAKXhzbptWA2dTuFPxoK2bWiFYb0siDKUolRLJkJEZzKmp7EVtqoVCdS749U8b2Db6LxEbA5t/NXdiSp1uvcKTS1cHFnnWkKAMXjjGgCq+YT1jooep/VPMxnE7wrfGjiQVTEEHD55gK3De1kPA65V1CJQriLlRw5eaWDzYMrtfBv7H9
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(7416014)(921020)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DKU+dnTu48hqKNNK8lDxuc2w8KmnEFgE6Qg6bt1zPN9e9c9bZ2wcIjwcSQ2xIBzLA0M4cEDuxVkkf7dzOI0GU3FbMl5mC9Qw6+lHnpViwKJ4JOwFWJc+OTE5m+EAfTdXosnxZ8TOSutbfPJnIepvnC36g0BehflkWmc6bOu+iVQ9ONS9p8PALKlerFLkmyYClQoSgxXlEOhq91FN/E0VeAzEPpbT1op9oCROBXZk3i6THizJCNCkfWqkQr1Utre2Vo57EctrWqSwSPVtnsgycWlVwerMK4KaqInRBxghFnnfjCQrfmH6KjTn4C2+gJ0CjC0tj64BD2wLYQ7QrnJildDzmLriUP4Vhd8tjMvjnPKzrcDbOdf4NiyslhZg7LsKY4guUMlno+r7krOuaEbxQegzLQNyzXg2TA3aBa5m/PrkzOfRCO2lRPrBva3YasyM
X-Exchange-RoutingPolicyChecked:
	d06IJweUuESCDIpNaMeO3MH+KVqI9g0lAtTmoEhRaBF+20inFQ5RQQU+p3kplIjaztVAF5a8xgOUP3EzfBwomWex9bolAec4Qc+Zp0jO5N+0lOE3CWl9PWv57qi4yVI0QR6xnw0AGPJ7DDwzUuoYMvHoS/YQSLc0CphxgoshlAEH/+APtKVQ8cKq5JBg6lfyl6B1RT9BcAcvkPOyqM8YUyvOEe7O8zSzbW1Z/fDur/EDztk/YwU0G2vitePyT1Ce2oqm3dU36p7nA+i7a6/bqHn561y36DzNg2Lgldp56r5JRwR0X40uFG9cHrh6ig5y1LNZ0Tofh8z2Evjm+NhOKg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:15.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f54cca7-1d90-44e0-b02f-08dee8a9feaa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX0WRsrzRMpgve
 bN5WYesI4rfiC4bytm54hNoE6ZR6TZUoXyARUNPFK4fMeSp4R0zjrLhCHoxc/j/Y+Dc/h+qBFqV
 FMZz1NQJteBayjE1SWEjAhT66X3K1nfMxh5h02j02W+XNLDadTaK7HGC8jmu40aiHEIMexKmdl4
 GwtKAUb4TW8tlpjEh54beWbJec2NhiMCNam6tujmdxcyTf/GY0jTx8Zfoc4R/MAhok9trYc+ev2
 Csug8b0PXWoMphXpL/JGdzj+MeEUPlO0qwq0ir2tFcQZHaIm1HhaklKi2tT+JnuALUcxIEUWlhe
 D2KZbsY3mMxj3l8CSzuM/GzYDgSaFyCwUA5aZYh4TSCQaewvkDAJecJho3kLcIMhzjdQesa+2bq
 Q3/X7YQ1zd7qXGAua1eBRv98iP8Qw9JvfwoNwsnaQcgAypOLadcR9pOgJi0o8iwmkvP67PIQB/9
 u4cgT/7apZ3UVK7U5WA==
X-Proofpoint-ORIG-GUID: 2jKJKCysO3-rP90XhUJcc2jPsW-Qy31E
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a61f4fd cx=c_pps
 a=xQfGHK7Kh/zEjKjNz0BexA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=Uch-OgagLyHg9olWpLIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX+8f4cRfPNsLx
 SoPI8BgNkr174X03jxSpc971FHyX2pfvvOReyW4Bp7ly2r6Y1Eog/KGWzS0mBzQJo6rBYjoFMCG
 Ak6B/+J/AO3+uwF7/MgAFGiYveWaEWo=
X-Proofpoint-GUID: 2jKJKCysO3-rP90XhUJcc2jPsW-Qy31E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

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
 drivers/spi/spi-cadence-quadspi.c | 1745 ++++++++++++++++++++++++++++-
 1 file changed, 1734 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 046fa5d69b0f..22a5c88bbd8d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -6,6 +6,7 @@
 // Copyright Intel Corporation (C) 2019-2020. All rights reserved.
 // Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -65,15 +66,26 @@ enum {
 
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
+	u8			cs;
+	struct phy_setting	phy_setting;
+	struct spi_mem_op	phy_read_op;
+	struct spi_mem_op	phy_write_op;
+	u32			phy_pattern_partition_offset;
 };
 
 static const struct clk_bulk_data cqspi_clks[CLK_QSPI_NUM] = {
@@ -129,12 +141,15 @@ struct cqspi_driver_platdata {
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
@@ -148,12 +163,14 @@ struct cqspi_driver_platdata {
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
@@ -192,6 +209,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_EDGE_LSB		5
 #define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
@@ -273,6 +291,27 @@ struct cqspi_driver_platdata {
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
@@ -321,6 +360,50 @@ struct cqspi_driver_platdata {
 
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
@@ -913,6 +996,74 @@ static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
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
@@ -1559,10 +1710,1578 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static int cqspi_write_pattern_to_cache(struct cqspi_flash_pdata *f_pdata,
+					struct spi_mem *mem,
+					struct spi_mem_op *write_op)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	write_op->data.nbytes = sizeof(phy_tuning_pattern);
+	write_op->data.buf.out = phy_tuning_pattern;
+
+	ret = spi_mem_exec_op(mem, write_op);
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
+	ret = spi_mem_exec_op(mem, &op);
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
+	dummy--;
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
+	u8 dummy;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  reg);
+	dummy++;
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  dummy);
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
+	f_pdata->phy_setting.rx = phy->rx;
+	f_pdata->phy_setting.tx = phy->tx;
+	f_pdata->phy_setting.read_delay = phy->read_delay;
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
+		rxlow.tx += CQSPI_PHY_DDR_SEARCH_STEP;
+	} while (ret && rxlow.tx <= CQSPI_PHY_TX_LOOKUP_LOW_END);
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
+			backuppoint.tx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (ret &&
+			 backuppoint.tx >= CQSPI_PHY_TX_LOOKUP_HIGH_START);
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
+			searchpoint.tx -= 16;
+			searchpoint.rx -= (16 * (topright.rx - bottomleft.rx)) /
+					  (topright.tx - bottomleft.tx);
+		} else {
+			/* Bottomleft further: Use Region 1, 16 taps inward */
+			searchpoint = bottomleft;
+			searchpoint.tx += 16;
+			searchpoint.rx += (16 * (topright.rx - bottomleft.rx)) /
+					  (topright.tx - bottomleft.tx);
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
+	int ret;
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
+		if (!f_pdata->phy_pattern_partition_offset) {
+			dev_warn(dev, "pattern partition not found, skipping tuning\n");
+			goto out;
+		}
+		read_op->addr.val = f_pdata->phy_pattern_partition_offset;
+	}
+
+	/*
+	 * Verify the calibration pattern exists using the conservative base
+	 * speed.  At high clock rates the DLL is not yet trained, so DTR
+	 * data capture is unreliable and the read would return garbage.
+	 * Setting max_freq to 0 causes spi_mem_adjust_op_freq() to cap the
+	 * read to max_speed_hz (the base rate), well within reliable DTR
+	 * margins.  max_freq is set to post_config_max_speed_hz below after
+	 * the pattern is confirmed, so the tuning-loop reads run at full rate.
+	 */
+	f_pdata->phy_read_op = *read_op;
+	f_pdata->phy_read_op.max_freq = 0;
+
+	ret = cqspi_phy_check_pattern(f_pdata, mem);
+	if (ret) {
+		dev_err(dev, "pattern not found: %d, skipping tuning\n", ret);
+		goto out;
+	}
+
+	/*
+	 * Pattern confirmed.  Set phy_read_op.max_freq to
+	 * post_config_max_speed_hz so that tuning-loop reads bypass the base
+	 * frequency cap in spi_mem_adjust_op_freq() and run at the full
+	 * calibration rate.
+	 */
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
+	/*
+	 * On success, write back the validated maximum speed into the caller's
+	 * op templates so that those specific ops bypass the cap in subsequent
+	 * exec_op calls.
+	 */
+	if (!ret) {
+		read_op->max_freq = mem->spi->post_config_max_speed_hz;
+		if (write_op)
+			write_op->max_freq = mem->spi->post_config_max_speed_hz;
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
+	if (!cqspi->ddata->execute_tuning)
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
@@ -1588,9 +3307,11 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 		return -ENXIO;
 	}
 
-	if (of_property_read_u32(np, "spi-max-frequency", &f_pdata->clk_rate)) {
-		dev_err(&pdev->dev, "couldn't determine spi-max-frequency\n");
-		return -ENXIO;
+	part_np = of_parse_phandle(np, "spi-phy-pattern-partition", 0);
+	if (part_np) {
+		of_property_read_u32_index(part_np, "reg", 0,
+					   &f_pdata->phy_pattern_partition_offset);
+		of_node_put(part_np);
 	}
 
 	return 0;
@@ -1740,6 +3461,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
+	.execute_tuning = cqspi_mem_op_execute_tuning,
 };
 
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
@@ -2108,6 +3830,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
 	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
-- 
2.34.1

