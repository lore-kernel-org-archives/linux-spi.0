Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390283905F4;
	Thu,  3 Sep 2026 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427295; cv=fail; b=mScrP50heWt3QWxmduLH9ldfcGpuVl20tU/gVEytpzYosmPoGCNunNIEFsSEhAsNKDSEVa5iO5wWYhtgrNLW28wHjjEPYc52yXfJXh/VJUynqjasalkRRlFKeOZA/lAj+qQsqCgp1a0ajowJaok1gHwXbh6nxiUU5XV02tATCDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427295; c=relaxed/simple;
	bh=X/vpxndSyaHLo9G7/qhxKJ12mp58sCAiV25jl9ZVw6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MI32E5pDE+B1eWGF+1zQfvwqkmFvDWvwJGBwHLUjIBwOD5m97FgALkCic98qvcn+DwE9K8TsM4oHW/waSecAi9jqoVzh4BP4Af2r/XPithjYGc+hmhzeI3xj8A8ivE0AWXVXyioiPae9wakb6JLwDSc1xhyN0dizKReZJAgD/qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=V1Wny3Or; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=NmyPojlc; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="V1Wny3Or";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="NmyPojlc"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6834bfrw147244;
	Thu, 3 Sep 2026 04:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=X/vpxndSyaHLo9G7/qhxKJ12mp58sCAiV25jl9ZVw6c=; b=
	V1Wny3Or18469nGW7E/EF4nElC5t5LzBaIQaZE4QS9Sp7Wh89PzNAjWrv0/Hvmi9
	z4flaOkkO4GpxAkth/fKcB/L7vj7si9cTQ2qHqHIAWUFqLGuhAq9MXe7U/4oI60M
	5B214f8u6XUjfd3xog+vFFMpXCoxB61CuvkhVE6JQQYpyTWGOLr23BGkN5Bn6UYa
	5yhSWXkYE25dyMvAdcHV/y/EwYB1Dw4HigDnPEQlGfh8JSuVkJLuFv9YPIZNsGyq
	Ut2Wv+8Ch0zeOO4rV2S9PRPkfA1MoecifKPUHnZm+GCBCfawJEPab5dPQHwChDvo
	KWtbSKY+cwy0j2LGiWQPkg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazhn15012042.outbound.protection.outlook.com [52.102.128.42])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4geyrqgbqg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 04:21:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmAGG02hFOcnoI9YnCQc+Kz5rtGselfFA6Qj/lmfMfY3nkxasPgWBB2tyeCs4P+Hw4JNQvI8aC5W6mo3IOVirnwq9HYjmeP3xcdX4i+OIV4MAk8RYnWGXqDmjVQ1KVyH/XtKYc1huM6IiQvjX8RC2JMRuCCdU0mIUX4WcBoTt5t7tniamgyQfNuRvKn+0Asq0QFTri3EwtALhqI8KnsrqsVTWKjPBSs/Tx6xLliT/Nw8ODvPREvMeqs9ygBmOA7xVtVN+Kw6ueCGp2EwmIWT1/hYpOcM42ept6FdH3BardYS/6zcgOLurcBPQ0WcNgWgeB6gErQlCIl2cjuJW0alGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/vpxndSyaHLo9G7/qhxKJ12mp58sCAiV25jl9ZVw6c=;
 b=SCEgrylL8Rdw4Ap9HVbiJ19nOjGumJlhZa4r6i+hJhpqEk34VtpbHOVdqUk+KTtxDydqdvnX+O/ov5EGchvukH7aL6Qw/uiYhNgjqvVxvPchgVL4l6TSMHm/sXeGeHlYeohsSPTbXNNzBLHdE49NYjujuSflESwErWsTfHwpdzJayXrR3tb2qphNtGBDyC8bsF83Tv4zBTBAJ8mjIMj9zY2GRMAafHYt5W4Fx0V6r8JcBfkHkz/aWXBOfI/PvTs31a3EVNDMvpXz2NjXePSrXjW8KZFJVWP67xN2m+ZmmfEwyD29Q/mQsZEq7N2UlJPOtJRHTgqM250/niVlPBEzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/vpxndSyaHLo9G7/qhxKJ12mp58sCAiV25jl9ZVw6c=;
 b=NmyPojlcFCrG1qc08ptLvY5telh5AuSLLPVabal94XRHojx3d0ZsybY9ZTtRCeToMln1fYVNAr3OCcXmdfXp1HBDMHJFVDWMEs9j8qdE+77na2Nh4/anLAJYaibCwUBPPIZvY6jijUsWSNHrzK3RABpwYM3XSzSoQ1X9HUfHFwg=
Received: from CH0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:610:b2::30)
 by DM4PR19MB5716.namprd19.prod.outlook.com (2603:10b6:8:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:21:05 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::56) by CH0PR13CA0055.outlook.office365.com
 (2603:10b6:610:b2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 09:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 09:21:05 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8DB93406543;
	Thu,  3 Sep 2026 09:21:03 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 70E7A820247;
	Thu,  3 Sep 2026 09:21:03 +0000 (UTC)
Message-ID: <dad5e839-4932-4ae3-86d8-a3c2f4ce07d7@opensource.cirrus.com>
Date: Thu, 3 Sep 2026 10:21:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with
 broken ACPI cs-gpios
To: Khalil <khalilst@gmail.com>, Mark Brown <broonie@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: patches@opensource.cirrus.com, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Khalil <khalil@rentman.nl>
References: <20260901192625.1497791-1-khalil@rentman.nl>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260901192625.1497791-1-khalil@rentman.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM4PR19MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaffee1-ec7f-4127-e9f2-08df099cae3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|61400799027|23010399003|34020700016|7416014|376014|10067099003|56012099006|11063799006|22082099003|16102099003|18002099003|41080700001|12100799066;
X-Microsoft-Antispam-Message-Info:
	aNa5EQ5Ee9Hsc1jzL+dg86rocT4+Bb5RYxDqDPCmyrKHMmWHRBHtsarqefEer2xgOMVNhdgGa2w7nxXat2170qrGJrdJPup4YOkfHliFynG3P8bu6aIMqkrzmsTlup0YnUCXH2E0DQtotgovUOgdcF83nnhHduK5CVUOhIsWwOwnQNfbDOdspCaflOeJT3Hvga+TcAsdneigBwiQOn38vE3MWtXKTLizlY2wD9SINukl6DvzrBqiLzF2MoIZ8vRINvprBukWD5KW3abPX8zIYfTYS2JJVCyoY8+0XEDByCX6YMrcoyfN1vTyhXclmIprfWGBbxdDbMHHICE2wNtF3uJtKmhjg6pcMMUltFvybAUjGUm3kaqz0n8BxL1a28SG+LuG6LavEC0leT+zbXWssjFQP+CDhYS6n3QevqXwSw0qp2TsBtaDpNQlghG2Hx0JT0LImoCxED6GROwMu6l4p20aq0EXTGhHuK2E5gaIcxx1C3kvO3dA0k71gqN5A2hohhXMuuJMUSyDGl+ibVUDzG/MRpwvZbaODwjRn9NK3ONVtAXHRVfoZmvz/8LiYIuaYv3S9r8lQe0MQkSsGSgc/02eWRXwB0k02v12M4CSRk5H8SCJNY8hzICjQOElOKAhhIIyQaFqdaKXYCANX6WLrpDtFOhQ3b1PDMGLKCDObaGjQ9xJnxxDGyY0cibedmnyWfrf5NDRYm09LuKoBbNMEiAwQ0pRZNkkMGVaI6FneSvrCKU19HRdWui4c5GzEx01
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(61400799027)(23010399003)(34020700016)(7416014)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(16102099003)(18002099003)(41080700001)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	39bffSS0a5FD2WmULNSX7DH2GSrG7o7bEmvdoJH0K3EMf9vmERMJJ6x/kTp+iPagX88Sz6GM6EY89Xb71OeBHyCx5JKF2Q+yFAUfholpWOd3ng1OhO9Nba6FIukMx1PTGeDiJ4BGYVeba0QUidebLripnA0ms+5LiLqdcWYA73B5092pHmus4oNKmlvzLysdaOokJUZp78MPR+20tOw2D7AeRlCHp/eLjNf0n+ayWKp05/UTAxZ2rYbWti8b+kMXz2f6yVtKxWee6iqMJU+mghCHTwWh+PGgU+HDMILb35h72+MEJgrsGY4wJP71uDmdAQTI/ONm+UPmgWl6bBzoz2i6nKAlg8OEfc9tF7tq+TStURyp5ATVs4+o7kSrFSQiwPPI9PLFCUf+iFT/MZXwHCASKZ6c/1GgsQX6QKuTLPw3oCXYB679vzYiHMy2UBVd
X-Exchange-RoutingPolicyChecked:
	NC/IK//hvMLgNpP9qU5jVGHolDzmCz/W1dAUTFQ6VJWPQKr7ZinYimVXnI0wPxWIBIbojKj4/HuS+4S/XgpRz0yuonw3GAe7OEG7YzxWzRb+h2YpKNhJjMoXWKKbmal2MAjoZGxrA1SDOKPp39G00MICV0dRZbedNVcE94buZwVdUGjsRqT5ZBHvzm1oPovGqhYEuHXBYQe7kJjWS7vjaSZrXS4BBWOS1PTHGtfsXKylVTHLG/uMY/ina4b/mUPK8R0F+j2PVNJu+rSB4nsA80t3z3Memt/YrBcr5fREiAnJSTMg9wI995e3nTBB9k8tGXeaa/4uHeRzqx4+1O5RFg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:21:05.0097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaffee1-ec7f-4127-e9f2-08df099cae3f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5716
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4MCBTYWx0ZWRfX1O6tZwF1W3++
 v22yQjw07X/qbWjh5AWJGfJ/kpCCDbY+SIhx82y0f8ts31QG5715N3d9hBBoKAOFexdSontCVJv
 KafqxASqKBB5XhZs0WbUgnPH3B17FrRHmcm3loyMExTL3SUxD9zbwZ+iYBMYuyAwi55c6ts+Hqj
 MDohYjdGcaG8Q69G+bk17WSqS1iD2EG4FDVh7S8G8FiWVs48M+2n1gZtYxV8EUGM7dnQ8n+YAyc
 x07UcWeoqtd1KgkdyaiFCIFENIBCByfM8Ssc+LzWF8yxVf/6uMgoG3w9lvqdqocYMbPWLs/jwKu
 LY1CDzQrtQRyGe2BG8XSGM/zVjhprVyVuq5f5Ok6xauG9FqudJXL7r0Au27v+WPxvdqGYBuIrrj
 JJMGHLqO8cQh8MO/ciuXqKBN630eYZm73xsYW/W1mGxPvAiSlb53qYiM7x/8ldF5Wkm1xDot18m
 F2ZYAksEtbT8rxpXn1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4MCBTYWx0ZWRfX9IpHoB0CKguo
 cyP6dLUu2BYYmB7LmjHazVXqP8UO7bz+Wrk9JOuIUBn3iWeoFXW3EIh4cv9Q2oWnKsccKo5jL/I
 SaRcpmuzf7vvKCNEkZ4uho2BPyp3YHU=
X-Proofpoint-GUID: Lya1HsIZtGxTjkbHt2wuuUfydr1KnrKr
X-Authority-Analysis: v=2.4 cv=A8Nc+aWG c=1 sm=1 tr=0 ts=6a993c05 cx=c_pps
 a=s54M8FUBmQbC3TpDjMr/pw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=4y4u4hxousau9Sf5jXwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=jZz-an6Pvt0H8_Yc_ROU:22 a=VlVynqX4KLlZR1Cn4-IV:22
X-Proofpoint-ORIG-GUID: Lya1HsIZtGxTjkbHt2wuuUfydr1KnrKr
X-Proofpoint-Spam-Reason: safe

On 01/09/2026 8:26 pm, Khalil wrote:
> v3 of the patch series fixing dual CS35L56 amplifiers on HP laptops
> with Intel Lunar Lake and broken ACPI cs-gpios.

HP told us they have a BIOS with the cs-gpios fixed, and they can make
that available early if you post a support request for it.

Can you test that new BIOS? It would avoid the messy SPI workarounds.
