Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24028BAB9;
	Thu, 17 Sep 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652591; cv=fail; b=jJddTu4WsLgyi57KzTYTa3LJ62crhIF6NB/W9ePqo/2PTJOTBYqy7+R5D728VTtz8vhxZT3n18JyT8hBCAHXPPCQv2w9IlkLwoH/vpT1z0A0FDNbts4nUfSYaE1Uf6OlNC7JdwwQyVKuKkDJE1lg04hAUPWZ2EucxDmbiomABUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652591; c=relaxed/simple;
	bh=fBER2UhSmdF/ljtzho6uGp4b27q4b0lNrnr0yWD3sdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJvQO5n3exCnYY5ic2vjWVxBmqF6qFMQAGqeBd5QjQz8nQWhM2tcxY9ukyGR1DDIMsjTSlGlxHoIq93Z1JqXwF9fHIP1R0O1YhQE6sXA4LN4qs8YItsu6S0Nc1+PwIIC9s/taloILU6hxAwLoEaNSL5Fn3I7xsMUk+Co8QjVUMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ux1Uc9aA; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ND3zVI4g; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ux1Uc9aA";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ND3zVI4g"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDPAPg392485;
	Thu, 17 Sep 2026 08:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=wFpviMBVDoJ6WUcmX/wSCU2F85B6C3b1sau8oV4UtAY=; b=
	Ux1Uc9aA7VGSyPLU2kvfidBGMYLvlNq4F/x/7to0ips3yk85RFh6fYLpJ+8P1Kbt
	8DS0uqWMY0mT1C3L6oszCzbIJRBwPEw5d6yAAjIr6Et/J8Jy+H55FtBN5q9HvAMM
	C+qmcisKjBGAQxupiyMX+RlnU5LbyHk9vkrvcT1sDJopXTssm+RkPTAGUHba+h5U
	nJb4EfzUN/Cjaui6HtM8+sbJ1Hfzm6DIDO+Zd5w2V36S0zhIQ0XE/vAhG1tpHmrl
	dllZgeB5QX+rNnMj94Yalcb9FccE1dv/VfXCWrgnR3GWu0Hhv3qS/Z0sTZJYanE3
	RGmlJua9jBe+dBL85AXkiQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021072.outbound.protection.outlook.com [40.107.208.72])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gregu06yx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:42:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/a8Qd5md/gtO8YczUWx5O7I8Oo1tzz17IBag/McXdtG2nJkpUFIXt+fhvJ4KJ6lC8AQiyttO7SffPgdt+HygWaUSdAzf3ZHqJyd+QtB+TMmjfQaIxPK9OMyur70kDZjneGJNA4UQAZrJ/IGN4KxcVAFTrLhw9Pf7VeSxsA0vAtzZERemkx9DOYhBiMm/B9IbVbKwGLZplFhaUn8218K5YAvbvSeaaTWGGXBuv6IVOlnEQBeXJsgAk0sAK+NpoUanEcb/HZIOxYieHsIozLwUds7W5//jbs0NOPWCIFe86ePHLtFpjQDE+PACCSyNIICVr5HR5LHqDwug5xWPgcYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFpviMBVDoJ6WUcmX/wSCU2F85B6C3b1sau8oV4UtAY=;
 b=fKkIH5bZEjR2DYi/ST8keRXvxKDefO+BL9WzO0eZ6vsPJG7f3W8/7bBlnq4eqaYDW8zUyX6gcVv8BrmRIYuqYnpT4IWw+OGS4EZW/Wy7+oFbYIJPFsCzcRiORG8nxmw8rfcNYgYk5VfFSHyxDBcCm15FSm/paVAc4eqM+vljxXvFVYyb9g4ZEsYYGx2yAx9Tec7xFCSjMrJyCVO7wjTVvfOCv/zTJD2JgndMXJe20SDDrIHGUkQDVwgKGKa6gt3g/nrO2nshlS5v9zJbE0MYj3KYQDsliVXdoiIX/VS2OFaGRhypNweg8np0pkIttTUfcE6eB8QzDz8BYyNzWgLwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFpviMBVDoJ6WUcmX/wSCU2F85B6C3b1sau8oV4UtAY=;
 b=ND3zVI4gQ8bAMd01epfUG60TTPdSEsT70Ki6ETrkm8KoGLEjyy72k6QJ+iABtg8uHjV6wyHcWvNJKF1yDeLNnsQLJEQoY3z967FiQgDtJ23Xmo3zhuiA5f4/lwtweqT0BeOCQRVQS437PdX4IO2NhUnSPhaie0IZ8RWM9KLilE4=
Received: from SJ0PR13CA0198.namprd13.prod.outlook.com (2603:10b6:a03:2c3::23)
 by SA0PR19MB4620.namprd19.prod.outlook.com (2603:10b6:806:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:42:25 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::99) by SJ0PR13CA0198.outlook.office365.com
 (2603:10b6:a03:2c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8 via Frontend Transport; Thu, 17
 Sep 2026 13:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 13:42:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EFC91406541;
	Thu, 17 Sep 2026 13:42:20 +0000 (UTC)
Received: from [198.61.68.148] (EDIN4L06LR3.ad.cirrus.com [198.61.68.148])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 834DB820244;
	Thu, 17 Sep 2026 13:42:19 +0000 (UTC)
Message-ID: <a15eae4d-d533-4280-986c-5de90d5fd2e4@opensource.cirrus.com>
Date: Thu, 17 Sep 2026 14:42:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with
 broken ACPI cs-gpios
To: Juan Jimenez Carrero <juan@jimenezcarrero.com>, khalilst@gmail.com
Cc: khalil@rentman.nl, broonie@kernel.org, hansg@kernel.org,
        ilpo.jarvinen@linux.intel.com, patches@opensource.cirrus.com,
        linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
References: <20260901192625.1497791-1-khalil@rentman.nl>
 <20260916212355.7216-1-juan@jimenezcarrero.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260916212355.7216-1-juan@jimenezcarrero.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|SA0PR19MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: b512beb0-87ca-4da1-abbb-08df14c1807f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|61400799027|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006|16102099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	XEE9EOkcfCeMe12RkQNPR+lyuKYJmVQEelJ7uBWC+vCMqyC1UlQMipn2J36sSARABvmporWB7GekHwBdenbPBCAFHHEf8dY7YhJeHBQr388cUv45xtljzdJ44CsEibBuSlEHADwPV7aluW1w/uzhE/s4EjNpkSVe/UEzFxwfn3Z6uD4Q+hmo0sxJFlxzQWP+3jpbC9zXQOvGaAf/BlkjyJBsNYRH3yw3aJP1hDgyIBASPuYJC2hrisn9w/oNdPOXJnKTXuqj9ZyeZqIc3Jy9p/HufBuE6o/tagN7YfdqVVdowUMa6clu9ZPVk7ug3y5O1dplXxtxru0gb7X1O9j1OYFu5lK5f3NvYIWRmT8046/p6Y4Ur5O3HiCUOBaL4nrQueOSGAuwDKG9PvkwbbPgvRodFutCjWQrNFc6+lgmqd9xufJxCrFkdziVZKWUC5wjVXEtzmWm/ibdo3ksC83sHHnPcUL0L+xpNX/GGRBmPY+Cou5kEt6orzwAtMhW5qmUMuV4DlCxHgEHGKyNqKeCiSZpS3x4Dk1oopc1VIs97ntzpJ/mcMpVa9sSHPDouAy1chyXZ04GArf6WMwkwATi/jHmAwjefH5F4Log984a2F9lrq7wbiyadMu/Rq7awIv40v/rguB6HlRlF46wZCqBTvBGEn2kyEkcFlUwKJmapccTOZdPNxcDDk/jiT7FKIoGlUsNh7UC/IhYYdBYqgXifZCKQCcBnf9aAhyLNKcwkbhzfWL2T91OYM4xsrCqvoUCQn695TfVwExfHOnuHqZcLg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(61400799027)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(16102099003)(41080700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	28EXsR5U/f0rv3rbv2397yUYyyGZxcibiF0CiU7nP8Zt9WT0aYUlxOLvk9UyvJZPfEAEePhfG2jNM5pu4XRtZzCvuoAcdtEfqpsST/fyl9lIth2waFDwEmvWNyqr1B8e1vm1qkvSDAfMqCg1Ue9lJCKCgPtrFe77oCLyRtgsvTgyhUpZvxARbNFzsw07BSf/SDC7vAML6MWrHLWHeX/G7yqJFxZ/GfQEAXZ+yGf/3ZmusXefxyLATqkyZvq2o2RB7KK5RnkL86h2uTTAg8Ftv18pt0MXrSlN6U0QTlnTnK8kZrYi19uoc1xmVmksFbEOPB3P1r5lKuFp+ga6gWpk35VNX8TL6tFuJLh06gigKIdjDMyEujqz/WWKS5fVTsBY/ew5YjfsxRcRbgIIjFHU1Pc0DznYecJI26tEgz4zuc7AAXkoFOvi3r2jb6bEGQ9L
X-Exchange-RoutingPolicyChecked:
	EZeZcjEwo0bTxlrJ8mErwMR4F5chkVEWcCyQWRgLDBVff7L8wffrNX1zKFQvskQstcF7JHoCU9qq9VlYQuGN21c4SrEjUFH6T398UFap2JPtQLDfqw9TGML89MehRlbHYpDnGkW0iWq6tV69OnU1LdDZ3/0cPKTokYtDnH9DXdxuUeb212PT8pFbbuSOyK8RPePTVTFN0aeBu3bIBcaDnX2ghj8lfdsrkXooq7OIkZgKAFaPdIGKef2dsl6rEm+u1ZPEF+dNrKdJMvrH3qRJSB5oD9MvfQyRqLtMbOEX22VzSKhB4Wbyg7nyRcvjFawca1mPVDYqwE/9b3m12f1IMw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:42:22.3767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b512beb0-87ca-4da1-abbb-08df14c1807f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4620
X-Authority-Analysis: v=2.4 cv=f8Ddl+yM c=1 sm=1 tr=0 ts=6aabee4f cx=c_pps
 a=iw7oLBvYkO7Cn1VXvgkbEg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=yyXclAyY4St_ZHg35aEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE5MiBTYWx0ZWRfXyqDG20TDc2Cg
 5mWkvsPyjCq/cz67XsZwtqGMT/c4b77cgwGSaQPFRuUJS/EDb1dRrxveRhHmyO4NeC/SYRJoX89
 IMkUg6vKFYsF3QplolPLeexDRpvc8fo=
X-Proofpoint-GUID: LtYjpDjviBWSkFmBnRxdwZphGI7lK30L
X-Proofpoint-ORIG-GUID: LtYjpDjviBWSkFmBnRxdwZphGI7lK30L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE5MiBTYWx0ZWRfXxOD9l+yDU+mY
 Or7hPo1Im6zMPXWdN/Rfou/LdTjGzvQ+gxCEyWb16SI+H5t6F1pv7amnieog9qkFyte2RS1tcKZ
 bZ7nI/kWZxpDL3VtlV89ncPkSQl/0MoXbJ2GqqOYehxJaXEMMjJyeVlMcR1g4ExU/Dz2e0F8N1i
 VT5HEcrOZGSueXykFOCTvGu1HP7/IEjQC6XrujW1WvAgT4QW7GJALKUSHDdiT4mZBzGRAj1cOmd
 RVxB07ptISTe1CB/Q8GiGrIV71tjNr/JVX7f1n6Y5i3g+zCCKp4G+rYyQO9OUBYWfPnCYeGdPlz
 Hmt/5gfkXmCsY1PyyXSC1NiICwNcXJRrbzyKJ6TMtzNTcHZ2Biim3q46SO/W5g4wZuHzajgOtSE
 Pzv6pfetlIY2lKAiOQMB2EqOQXsthgEvns4g5tYWfx9/2iOT2pa0R5Q1yb1hddJTXW1XQ2w+YVd
 oxuTGfjSJQ93nxpDAMw==
X-Proofpoint-Spam-Reason: safe

On 16/9/26 22:23, Juan Jimenez Carrero wrote:
> On Tue, 1 Sep 2026 21:26:22 +0200, Khalil wrote:
>> v3 of the patch series fixing dual CS35L56 amplifiers on HP laptops
> 
> Following up on my earlier reply, where I had only run the earlier
> gist version: I have now tested v3 on the same machine.
> 
>    HP EliteBook 8 G1i 14 inch, DMI board 8D8A, SKU D75TQET#ABE
>    BIOS X91 Ver. 01.05.02
>    2x Cirrus Logic CS35L54 Rev B0 OTP4 fw:3.4.4, ACPI HID CSC3554
>    Kernel: linux-omarchy 7.2.5 (v7.2.5 plus the patch set of Omarchy,
>    an Arch-based distribution)

The latest BIOS (01.06.02) is reported to fix the problem:
https://bugzilla.kernel.org/show_bug.cgi?id=221064#c23



