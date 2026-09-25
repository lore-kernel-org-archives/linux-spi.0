Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3444E1C84;
	Fri, 25 Sep 2026 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351989; cv=fail; b=eVNAwgUwa0I6niU3zszHcA1ocnsKmYi/GlVxWlJA+AKvChm5N6un3nW1MGzy1k7pv+zA8tOTIuWE1rkaCLAa5Gm5EmbqAk6SfhoJttzjCPGUGVBcUvTq06wIuPsmL394m2wciJRk0qwq0SmdjbcRFY6srWcnBO1PEYgAvulaAV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351989; c=relaxed/simple;
	bh=BXQ+J19nr02aTOBQeRM9H8pLbNUpWiCcJWf/2D9JEA8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AmBb4a5+pOEpSUU3Z8pq48hM2z0R9CGdCMzc26HVm2YYmjlySsFTBq0JS0QIQZwoZN9Ih47gZO16KPdTVIfT7T2nn9YRezZ+sJKEYi/xe2lTf/YL4zLeOzSVQpowfzZ3z4VlQ0DcqqTDcbJ4AP3nYSixD5qa0xiVbC+wd5luiyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eKbcToHL; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=PyTzlWBf; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eKbcToHL";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PyTzlWBf"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDVjwj2786040;
	Fri, 25 Sep 2026 10:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=C9iv0bVBUjNkHwRCRR6nhEIVqHDUko+6Tr6rNVg0Jz4=; b=
	eKbcToHL/JRCBfVDYJ2IEYi+VKF24o/bkfNwwSEPXt/ku1xO4ek4jpBAbtLVcf6L
	e7TqOsuM9JbcEncREnmEPP8OJzJm2R6iA/0rNRIf9xGr6fS4CnzPdy2ki4/QizA6
	XArfVGGvcDZxGztYYdIcnnDmdd/tG0leQlER0aOwk+SZQUZEPCFsqRQfI7CqNIGi
	oSyF+BRlUyAQnLO8YLiQ59npZYQt004JrGs/JnhrXXI1D6uUv7R11X1M+kOoNu1p
	Vty/MAuw/o+ILext/BHw0JpttNr/7E9/d2VLNBTOf+R9XdeGKkNKQYzl3lhTL4g6
	XWTU5Bq/vc1OwUzfieNtXA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020137.outbound.protection.outlook.com [52.101.201.137])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gw698hhtj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 10:59:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnlU2x9/jyf+dCYPP36o3Ykjwn+OpZIulza5V7HMctwbhod7jUNjZ+H2nxR2d7jGEHPDf5dJ9XIswQPZ4ulExk7587nAv7avX+2Sz5b0D66QDp6txjh6AaREGG99FJydKwCd2iYnM/PQicu+vfRs+stKjCS5DhtMiFJJ4o1WjNp2g+8DbP3kOkiPOf3K/ljBnjFRCRzV+cFm0VzaL+c3i4sjUSXfMvEZ7nx53+7zcBdpqqmDjJZXC0ozzctbnNVotjx6oYiEjFSEfzo8J7I7ZbFkhfkvbT4o4IvDbaGelGkQg42spM6qQ+7xqEC8vWwQNGZYHRxeIJjOuNuViAOc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9iv0bVBUjNkHwRCRR6nhEIVqHDUko+6Tr6rNVg0Jz4=;
 b=gwELa8loi2oZR+iVUHhGFh02epv/H0H0HD6cc6RQrQ4jxTbVGPU7ijd7iZ/Jal8U3W3GtcmYiKl7uvkHuhqMH0lxWlEzLJZ6mwlweuAmp8HtJeK5nABAV9QFRxxp/v5te21MDu8W6tUPhAC416P5v5To32IiaI+1j9wV0DetVsp2QzAub62S/u7n0EAa0U8sWsVS0nlH+yYavkDKo+Yt/rDYDHIXayl+I8eow9MXyhfDH2SSy+faRW2B6ClV+3wLk2R7rIcblAsiAhwbqQHQe7niZC9Ewybaby+3u0GmMrerw+GAM3lbaSGEVtS087wGKO/NkY4g2rDOMgl46kNU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9iv0bVBUjNkHwRCRR6nhEIVqHDUko+6Tr6rNVg0Jz4=;
 b=PyTzlWBf+ZJGyGKZQzqrCCAtwNJDMRAH6/Yne1pWOp1ragyCCo7NBAIkDULBYKi9BbP5DZuT14+ffICf7Yg8KMsL2/AdGatU9OBlrWtRski91P/6nHnnlqYlZ2AL6v8Y9g708eTWuxnizFvOvEmtKxDxn26BrZVj1G+z3PgbrQs=
Received: from SJ0PR05CA0136.namprd05.prod.outlook.com (2603:10b6:a03:33d::21)
 by MN7PR19MB129035.namprd19.prod.outlook.com (2603:10b6:208:632::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:59:40 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::a8) by SJ0PR05CA0136.outlook.office365.com
 (2603:10b6:a03:33d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Fri, 25
 Sep 2026 15:59:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 15:59:39 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5C7EB406540;
	Fri, 25 Sep 2026 15:59:38 +0000 (UTC)
Received: from [198.61.68.157] (EDIN4L06LR3.ad.cirrus.com [198.61.68.157])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D88CA820247;
	Fri, 25 Sep 2026 15:59:37 +0000 (UTC)
Message-ID: <a4eb6a0a-ef51-45ce-81c4-b3098c1695e3@opensource.cirrus.com>
Date: Fri, 25 Sep 2026 16:59:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS
 13 DX13260
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20260919134730.895381-1-rf@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <20260919134730.895381-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|MN7PR19MB129035:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e201eb-8f51-416c-974b-08df1b1e019c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|23010399003|376014|36860700016|10067099003|56012099006|22082099003|11063799006|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yoyi+9cRBW3WcRu0Ra24u/FFu64XkT+iWdvk2TmF+BWpdzGNACUEHaWnACImNvVygqCmBY/AVEjIVtXo469NGdIFdZ8Tn/VnphmoXzrxnhgyZ37E93y4VgIgAEIhMO3i5Cd+amSeLLrCAb3BasfXkd3mxrJuLVCjQmr93YtJk5ruQR+G/8OEklxOv9uQ4kYBR0gR1JT5QFEyqwHGrqjKmcJqX+EJa+6D+Nh7kHLf4u3L4iU8yzzKkiGAASfb4RJHkizmR5qPgVVU5/wABx9jvcPujordlxAcPdfEFfhyI8tEBYIMV89okEMrV5wid6krYQ+Db+JpI2DeTPtETJ2o8JRPBFGBYJlXkm1MlWCuAPPbycrflBcfYsNGTSXOSsiQFlM3x9Wm1LhAWPylGrWrckdPySSFdVDIviSPPHu9F/mlU/simWlZmHzuWZFm9G5n4mYIObm11WyGdWQrE1lpi3LcHmXnZq9pJcDIug+sjRrenpt6OsGrM+l2Tx6bb2hXDDK70OdJSQEslcbn5Ool0O3WUoHzYzieVHIEicSa2Qd96A7tnHJs2U/3CdyBCVgwzc1XvleKLjtokumCGbwSPIaULPyORj79UqfUToFc8Xyv94CJtnR28KFhU82tjiPl9Ak9vci7KHzaN1AgFuYhFWb/O5RU56Nirk5u0DpjwL+3YuAIarPQL4Iv99CcOfS7
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(22082099003)(11063799006)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7E8+1ZZCA/WdtcyW2qya5wR39MRT6Q7Qih5oDzNg+RgZoWE/5bDJ0IPyvv3FBE5iepLwKE192L9x6twMpcMaTa2ND6pM/3jgNmKrHfzn4BHEc0hLZGpO/obgwcg1CbttkVGaCKcsAmTFNl+4aTVcVY5sSRcsSDSjijdtm8hhP4Uaw7RES9+elXbP6Wbt/Qo+6co0w+GRE5bwo9cafUc7l5V+IvYcmmdUOf2i/D30dtIJh7UXi1IEsH+5yINbWDZzHYFeSRn0cDWTfLIFDXW9NwlZeT470QjJUOd3KSCRnjfOnBQtWEUWQgi42qh9K8/ylQennH6xn9J76bBLtxozTHCnATA2SoQiJ22b8R/JGM6nQg2QBUkVNnGMsGFBo/nul8BqhWSgpfiSpXt03rVgaZlQNhf4R6N2yosVEJqu2mRk/rmqT2V2qsocVL2KKG7T
X-Exchange-RoutingPolicyChecked:
	Vbs7Oi3C/0gmtqLW4bDTOKG9oa9ucQSsoUWkfreiLC3LJTe3PnGkJzGFRKEtogKF26l6mxagHiqQ2juvRL0aohfijpmvGSo0zUFC1Wqt0lHK5dKu7TTEMGB1/trv9GTQBmPOfq9YRcWwiBc/90IyGoNupXMAK+iawkNe438KVDrna3KvWI9S2qp/ERi4JOYYz84lGIY6R0hqbXAPMkjaIN+/MmE2m4wIrvUch+6qwillfpofDOlQqratgYThNTO2VjltQFfbzlCkWDDsh5200Rl+TlyCm2YSNIuo781Ra/CQEN/ZKBSdTHb5EYXNtsUXhwoJUh0frvlycZRGAgOl9w==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:59:39.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e201eb-8f51-416c-974b-08df1b1e019c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR19MB129035
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX6MbQOEuaYtSi
 NdP+RCSVuC6rKL/mMYKvSLkLj4Mu4et0p7uHMWs7j0nH4WMsigkdhWllA0A/EWDzsS2AZTf3kOf
 6UMip6NHZ+snTvLY+xZbLWokbL9vdJd7/J3+kdT7tlKffAoaUrZh/1j2exwkSl/mA+cENS5inev
 BYn8LASdjlCu3I9eECNNkSN+MyZvtyrQWQ99MEY8HFg2Z8/JEMN6cjOBtSeWSvPI9Lvsl6bvZhh
 ZEscKWxfI5fknVvdQFrC2aV6CzjD1tcm5VSriPlV2r3w2HUL3myqssu30cwZRUaDBBjZ10M2zo0
 fn305C4nhwViOqfp5kRQhTo3rb4FZjL89dpgIZGmY4k84wiBWYZrsnn2Oq4oslOcxCAryJpGMCz
 4i2EFLk6996/8HcXpZAquTYyX/sxu2ztu0JMmRutB5J9jkexlF9KfgQ4BNvh9oOjorKpOe/nGGD
 UghAfpx90IZmX1rUirQ==
X-Proofpoint-GUID: 0ZXEKNggVER7XiKXpJLpmiXjlPcbAIGG
X-Authority-Analysis: v=2.4 cv=Zu94uN7G c=1 sm=1 tr=0 ts=6ab69a70 cx=c_pps
 a=m7gYBUTXKXNlxA7KPONIMQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=-ypVJOanoBVD_ddxiSEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX/QhLf3LOu/7f
 PQVmsFRS+erMOS1EQbMpkBh95ktQwUvm8JsLrHwfC2gosR0HGT/bHcQ2tKTc9A4M/csbGkphrW2
 iNuBF0p6xm6mXJgNzA/IzBjDhMGRRoc=
X-Proofpoint-ORIG-GUID: 0ZXEKNggVER7XiKXpJLpmiXjlPcbAIGG
X-Proofpoint-Spam-Reason: safe

On 19/9/26 14:47, Richard Fitzgerald wrote:
> Create an acpi_gpio_mapping so that speaker ID GPIOs can be read directly
> from the ACPI GpioIo() instead of relying on the spk-id-gpios property to
> have the correct number of pins. Change the reading loop to read each pin
> one at a time until it reaches a pin index that doesn't exist.
> 
> This fixes problems on Dell XPS 13 DX13260:
Don't merge this.

I've heard there are plans to change the way speaker ID GPIOs are
defined in ACPI for future products. It will make them more compatible
with the "Linux way" and will work with the existing code in the cs42l43
and cs35l56 drivers. But would no longer be the "Windows way" so won't
work with the Windows-style method in this patch.

Which means this Dell model will likely be the only one with speaker ID
defined this particular way so will need to be a model-specific quirk.

