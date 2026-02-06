Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33D30ACFF;
	Fri,  6 Feb 2026 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406034; cv=fail; b=EFBgdf4LrqIOT8wsuInfI52ndItpmO5p2JulvKOW6MDEHuXfaHSWWTvR+Wxfmo7M1ZEiVbDk3B6NommeVV3aHUdcbsn3wyZUtATFL9gbk2+N08vbZZvlD6DALCZYqEsVZ93ypJ6ttjIqvJ1NOOqhjQFVw+vqp2YMKc+2EiOiNn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406034; c=relaxed/simple;
	bh=QltQj5KZtdD15BatWsMioBFY06MNn6jGGO4GaAnyG2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BRcneyrMKdmP5xFQp9XjiXKMiBf9GjjMX5HQmuQUMZRTMc+6cSikqVRJumFYZqbwu26axNbPMB9keokKw6dOJPCy0WUuCqQ+S1r9F9im8DgW0qdl0s6i55UifEhbitohwHgzHOS1F+fjbNPbwhZ4oTCtbIXoWkB3gzzR5aBxEZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T2bEjeeZ; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T2bEjeeZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR5koymnde4KbutPBfFZOMT7DqsRNlrH+8qGwxhPttF7y6Zn1r2sNfK4eqElapZauYqwZDps0Qky58kfTm4sewUSxg57YKz8SoCyRLSHDfZzuwtkx6kLXaqdVXhGyr7dr6ILe1Qhp8DockJ1fYNcvKY/jtLBIDGRA3OCnDCizq8K7Dr87dZk7D2mhwB/RKXwSuDxl+FfhXYnX4HFHo1dlcRUejUOXG9+rDer4/zLNl454ezvdDRMypYPFsvzoGUIl+Ec6+sIJt8ST7PXsItUv+jEHChrRZjeZTESed6LT/k43Bidj/itWekUCJ/nTjhZl2Fv7QXAcLEF1dRzUvtF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aazFyhGg8sE+zW+66y8Z6qELdgRrEcVjd8YWHhWFo38=;
 b=gZgPpiPhKqh3aZonh/H+JraEFuFWMVs5cmHgoJXg3Oult75Q3EHcleyfiNygbRz5v9kJa4UQa0vAa+sGWi8h/eszeVAZREkLQ9CPYQmjb8Ov3n95lrxr898yqIkYB19Ddyey1I5gSlvudoZko2HHBvViZvsPbvy7+ssSdoPCRASwWldwYaZALaRr8YqUbqw8sFSdvTE4O1aTrT5MCNvotkilHoEGBoJkMvZulqKIjiUVgNzEOFD4CKHqytSi+GhFGkV9vpDlQW2BivfdBlRjj2lTm0qmk4JuBfsojCweW7WNTF83YWAdEj9xEG1IReghXMAREdAgwwzdoVP6ky2lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aazFyhGg8sE+zW+66y8Z6qELdgRrEcVjd8YWHhWFo38=;
 b=T2bEjeeZQUAwvGeWCscqf1QTuHBsu3b0ECW11r17KOtIFRDEl5PxkwDXjqS90XlwvLa/29nrOo2ddyiGRO0ZeYbq7XdWSTD2XldynR/PT30pMIxKm6nnXXqAzvZqcaqgILsFsL1DtW2Td0ClpTVtzcEa+5uSawccw//ZSuSwCWw=
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by DS4PR10MB997551.namprd10.prod.outlook.com (2603:10b6:8:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 19:27:12 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::e6) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 19:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 19:27:10 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:27:10 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:27:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 13:27:09 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616JR46B1839723;
	Fri, 6 Feb 2026 13:27:05 -0600
Message-ID: <fdcb19ff-c949-4538-8819-88720e514f04@ti.com>
Date: Sat, 7 Feb 2026 00:57:04 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/12] spi: cadence-quadspi: restrict PHY frequency
 to tuned operations
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-12-s-k6@ti.com> <87zf5nf5g1.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87zf5nf5g1.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS4PR10MB997551:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8a4327-59a4-47b6-2c6e-08de65b5b95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NktRMUloV1JZSXhZQXAzOWlWQU1IM2lsamVxSEFuNUxpV2Fmc2FxQ2E0Nk1G?=
 =?utf-8?B?QTlac0U4S2VIZis5RGxEekVESUYyMngzM0xoN1lESkZ5UEdOc0t6Zk5ndmIy?=
 =?utf-8?B?aWhKV3F1UjFCUG55YVJWWnVhOTVZc1NtSVYvQ2pMbmIrVVE1R0svK1p2bHJw?=
 =?utf-8?B?Mm5LU2xvNy9KbnkvNTYyWjNXL3J2d0llOUdoR3dqM1JXOVE3dlBvMnovTktM?=
 =?utf-8?B?VEhTRlZneFhpUXRVdEpBVFRBK2hURFRKd0psM25hbktnR1I3RGkwR2VNSy82?=
 =?utf-8?B?TEdIN0d3SFk4WE1HYk1lKzQ5d25aWjF5dTlZSjQ1QWhnQmQ5UnN6dkx2elBh?=
 =?utf-8?B?WWFEdFN1czVyaTJRVldTMlh0T014U010L3pWYy8vandmQ2pFYnF4RFhHdzE2?=
 =?utf-8?B?bFB5SHNkSnhWdnhKR1ZBTjl0bVZKTG1vQkVMaW14cEE2YjNQWXNzNWRFTk9Q?=
 =?utf-8?B?WjZMU0ppekhCOEFqKzFPeEowVlZLcjh2QmpVai9zdm9hQ3Q3aElQSm81cXJl?=
 =?utf-8?B?TXU1eEQ3R2VLNzBWNVR0dWZaQ2kxMGhvNHlGb1Uzd3l1ckkva1Z1STM1bkpt?=
 =?utf-8?B?bUhLZkUya0t6ZnlWaUJWVnVwMUxOL1M5cHA5OWg1aEVkb2dta3NmNWFiSUhy?=
 =?utf-8?B?NzI3aW9LWWo0ei9PNGwvWVIveVpOdTNOU0NsNHdidnJrelc0TG5zNW1BWWNO?=
 =?utf-8?B?eTJwSUdEb3dzaEs5U2VlWitIcnkvUWxGNFd2NXUrWjdod1grd2hySFJQaENS?=
 =?utf-8?B?dXJTaWc3MnU5d3AzUk9RWU5XbXk2Vy9WMG5SSVcyUnBTNy9oTUR3V0t1aHRU?=
 =?utf-8?B?eVBBTUtsU1FWYkFDOEhyZzR2NDBYa2ZtbEYzNlRhR3FSTEozZGd2bHVuZVBp?=
 =?utf-8?B?cDFSbWFKQU0xMlFSZjJzNjdYK3cyZkQvcVpWbGJ3Q2VHWXlOVFhWNG9rUS9P?=
 =?utf-8?B?aXNDbWw4TXhoVDVtcXVncEpjakdka0M4Y1pzMUhVcUdJNVNJK2xsZnlqbC8y?=
 =?utf-8?B?WnN5LzR1TlVzTFhpZnBDNUZuUmNLSUpDZUNsNHJPeGdtY1R4WUovNFEvWlNO?=
 =?utf-8?B?YXE3M0dUNmRHeW54VytOUXZZc3Y2V2ZrTE04aVdlMHRTeDRXVVArb0RYL2VK?=
 =?utf-8?B?c1QzelB2dnBiSG9GZlErR296OFR3V1MvTCtnMmYrdmFLMFYrNFpQUGh0dE1j?=
 =?utf-8?B?elJxUW5XbmJiRzNBL3pxWEdrRzhRd0FmUXRBNEszNE53U0U3aGpDb0o4Zyt5?=
 =?utf-8?B?NnVJRXl1TWJYOGFkZHNWNTh0VW12R0ZSWVpuc3ROZ2NLQ1docXUxWmdsZTlu?=
 =?utf-8?B?K3JZSTBFZkRWQUI2WjB1V3g0aDVOZlp5Ymh1Y1ljem5OaXR2bk50ZHFDUFJl?=
 =?utf-8?B?emNveUQvaHpNT1NqTFBuYWhMeWExSGV4ZnhVdGxOeDh6ckJjMGZEV0xVZ0hn?=
 =?utf-8?B?M3pyYThXL0FCV2xmZmhMWFAxL2NyR1Rna21xYmJtR21HYnRIWVRLSk9ObWVU?=
 =?utf-8?B?S2RCVVR4OGNxb3plcEdVSXg3UXRkeDlkZ2JkRnNJcFRHeUNWaHJzSjRBQmNu?=
 =?utf-8?B?WWljVWU3K2NDdG5pSnpZK0F6Rk9BTFFTcWtpNzIrOVBlTkN2YUpEZWd3ZWhv?=
 =?utf-8?B?dVpneTFlMWg3dW9QR0F5ZkthMmxTa2FtTW52Uk1SV21OemltcHNhYVlBcmx0?=
 =?utf-8?B?R0tQNTJ4ZWovNkV6Y1VkS3A1SFdXWXpiSjk1bGMyOWZnOHNaUjRXbXZvTXU3?=
 =?utf-8?B?ZTBUVTFvbjZXdUtZazNZbHBQWHdPU3FmMWFjTjBqRlZiZk15QVFpWXpqVjE1?=
 =?utf-8?B?Vnkxa1pYOUlxbEtGUldNSkdhZ3kyTnpQYTRlQkJoa1BxaUhXUjFPNUtQN1BT?=
 =?utf-8?B?Zmdrby9DWG43bTJGMXJMZVFJZGQxZldsRmJiMFRab3RHMTB6NHpQYm84TU5n?=
 =?utf-8?B?NUFUYllFSUxKQ0tNR016WEJ0dkpwcHlTQnRieDJrRnl5MkJxY0tvb1NIZVJx?=
 =?utf-8?B?NW5Sa3VueUpYQ0Q1b2xMVjdBcUhBTytXWnI0dDdwTmhIQ2lsSDZHS0hYYUo0?=
 =?utf-8?B?QjlwMFluU2dBU2Z1VWNWNXRYTUhSVE56Vm56b1R3VnNEMk0rekxHcWEwQUdo?=
 =?utf-8?B?Nks4SEpveDdsdXpLeGdmSUNQRlZHZjV0N3Y5NlladEhYZ2FWcWxPWDJLd2xM?=
 =?utf-8?B?bmgwTG54cEpMM0xtQUFPdEVTZHVQVHdsNzhlRFVOQ29PYjZ1enVTS3dBMHRa?=
 =?utf-8?B?a21kVHlrU0tQcC9zVlhiVEFTRHpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yn8lP4mj/pagmqauAK6M9t0XJ7hsaPUTfApualTWOD3XqejCRwCzqsk8noUHwVQ06wmQfDHKy4P/IS1FFl+b+nz21Hd8yzIH5VLAYe4f3An1sVBa3J/ds9O7HNL0ClO1URv24S1LOazbdAlhiNr+poL1TZH6Avmc/rNKhZID5PMp6ahr1ZgQU6FPK2CFQ+Nv+sn59ih5wo7E//Q6RZt02bTNCPjZEYWOXnGC4r37ed/sFgtPNIhMKOCNIe0aGpPgql4TjER0psJSz1kBfuTLQBhVkfD6Y0f8vLtgPBdL38BcAdRyowmee6gqFz0KP/9M89siSWuCc6+6mhUDZWXLNGGn5lj2ZSV+vJdyjG9UU3q2eOBnBnOjce2h9LQrbINDJcnuxfgm0ulpKGZ/2hEVli4Af+8l1krEee20bg8a/woL0D7wouwJk5dMY6hMPyTY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:27:10.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8a4327-59a4-47b6-2c6e-08de65b5b95a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997551



On 05/02/26 23:17, Miquel Raynal wrote:
> Hi Santhosh,
> 
>> +	/*
>> +	 * PHY tuning allows high-frequency operation only for calibrated
>> +	 * commands. Uncalibrated operations use safe non-PHY frequency to
>> +	 * avoid timing violations.
>> +	 */
>> +	if (cqspi->ddata->execute_tuning && f_pdata->use_phy &&
>> +	    (cqspi_op_matches_tuned(op, &f_pdata->phy_read_op) ||
>> +	     cqspi_op_matches_tuned(op, &f_pdata->phy_write_op))) {
>> +		cqspi_configure(f_pdata, op->max_freq);
>> +	} else if (cqspi->ddata->execute_tuning) {
>> +		/* Use safe frequency for untuned operations */
>> +		cqspi_configure(f_pdata, f_pdata->non_phy_clk_rate);
>> +	} else {
>> +		/* No tuning support, always use requested frequency */
>> +		cqspi_configure(f_pdata, op->max_freq);
>> +	}
> 
> Shouldn't we handle this at the core level? We know what kind of
> operation pattern we provided, so it is easy to set the correct
> frequency in the operation structure.
> 
> Can you please make this happen? Perhaps you can return the operation
> frequency once the calibration is successful (in the read and write op
> templates maybe?) so this can be picked up by the core and used for the
> following operations. This way the controller driver no longer needs to
> check if the operation has been tuned or not, it can just look at the
> frequency. When using the highest frequency, PHY tuning must be
> used/enabled, otherwise not.

No, Miquel, this may not be correct. There can be cases where an
operation does not require tuning but still can run at maximum
frequency (166 MHz, for instance). In such scenarios, simply setting
op->max_freq to the maximum frequency value and deciding whether to
enable tuning based on an op->max_freq comparison would not be
sufficient.

Regards,
Santhosh.

> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

