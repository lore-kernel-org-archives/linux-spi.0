Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459433A6B6F;
	Thu,  1 Oct 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849862; cv=fail; b=fK9E8+G0xc3UL1iMaTQfOSwuc7jaJSgQlDyuWHaGX5uR1ztDTwBQBVs8dcZznn2d0UlEY1NU9eVlRDy63I+APvbp1QatpTTgHuwiXEKlwm1BprLiV3uLvuZAMTezwISj8CkxxPmtQFUpHLnGwc/D0eOq52nbW0z9cJ6jkrnIFXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849862; c=relaxed/simple;
	bh=l5Sb0Ybs1Ja50CIfJ8ZuYhU+BpHxH2j2kx/Jqzq1JoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg50TRMRGCWM3kdEjNx1uvkZD8Hum2voThvwIh8QYAIIsYMFXGABcR+rqLW1jmWcVsiG03x4ADwwvhWZMJTGhEl1a3KHp0UJJ7vzgxAGuukHXC1T9Az1U1dLzyfMQHRx9JnnPpIMMqBNTIWKwZOZHYUyDU1eQ3pfcT7R2dcOgyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JsV6BT17; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=KUN2Vbkg; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JsV6BT17";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="KUN2Vbkg"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6914rXqi3045106;
	Thu, 1 Oct 2026 05:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=srCfalqRND6tSHXcdD
	fTnY/dgWwe1ujEUoqD51Px6wI=; b=JsV6BT17a+WXYWFBPJxfBJAmduJ9aGNbkz
	G5TuSo0yTYsWDGm/6ioU/0Gl35+yRGc1jLJ5n0+jDmZ7n5LV++KfBmugOUWtBThw
	ESL5zpSg595NC1oKhQiH2DI8Q4hnE4NwcUy6MtQnudvHGM8o7VH4sS6OrMeubExQ
	RY7KdIEc9d6RqFar/HruFY6op4m5aeUeJ5jzcu1aMU/7lQbvlmWP4svwt8i2GJIu
	GiyTVR30682xq2/vacm9bfEO2UOEb2t629J/c7EoiX+heSjrXXYa0bD40r6exWyx
	b3kg1pfQhYPD17895nwz0w5clWW3RpDERcqHvRmKuoObjxXAUiRw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022074.outbound.protection.outlook.com [52.101.48.74])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4h1gv7g9fw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 05:17:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaaxrsDxx8YDwIS3UuERiMe/6bClvHsGMXcTZgfpKAVXL53a1v0g8nBezrj+IXs05xXi1oiDhD3YRsvQBNmY66xoQvrUPozvhQJ6CN9xS3O1xnCQd4AEXcq8j8+/mFjEasaMR2gDo8c/Uf2SUO60hVGdmANc34lPEbvtULVeLnJKKcExeeA0FnHcZHN39qyZ0wbbhEyfav0rp3FldTMpbInPDbf19it8Oa2GJghZO/6jeedho8MP93Efc3ovu6zTO6n9pOpIvqhaOLbkZRxuNmzX3qWWGyX5GvSum+76MvydEi5XqZQ4p15YQuF64R01SVa4LgM9UJNcI7ofPoeesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srCfalqRND6tSHXcdDfTnY/dgWwe1ujEUoqD51Px6wI=;
 b=rxfFWaXC2fDeSjBRnZ5Sqyd8kzUB8m/rVDJsIWOH9/vcchlvW8eTSErM2giPQl0imMhYDEBpwRpAvasGb+2T49Qc6vxiOrInAb53iUfcdbeKmfsSM/G9OwV3/tL074+Vs21Ot0Jgz/FPl5Q8xzrL2lJhKTLd1E8at56VxDbls6KFs3wkk4iwCarxb8ZxH1BcVsRVHD+5R8nQ8KjMAs2ocnCmvX8MlrwKepZA4a9y51NXttjdHkpsyIEBmjD7ojGv6CWyhff6ife66c5Nl4Kr26zsnghUUtnSOs3TGf1Alp8NHiP/6W0YaPtPRhi8BxMSDb0805E2BBjFwZnNydBglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srCfalqRND6tSHXcdDfTnY/dgWwe1ujEUoqD51Px6wI=;
 b=KUN2VbkgNZkyGkQoX+oVuOxVYr0dyCmyUamrVxJXEMkv0k13zMvJY2w5oK6egN4Ygz8ktyM/l7G5ja+1u7DTJZI1Z8+k3xamqqd0mQw7Hyn2wMfvu5ZB/g9TDM56bIfcjfqja8ebhMa/bXM1nlU7vQWypfg763a7cegN0ukVtVQ=
Received: from PH7P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::8)
 by CH2PR19MB4730.namprd19.prod.outlook.com (2603:10b6:610:67::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 10:17:32 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::8d) by PH7P221CA0014.outlook.office365.com
 (2603:10b6:510:32a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 10:17:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Thu, 1 Oct 2026 10:17:31 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F4099406544;
	Thu,  1 Oct 2026 10:17:29 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DAAE182254B;
	Thu,  1 Oct 2026 10:17:29 +0000 (UTC)
Date: Thu, 1 Oct 2026 11:17:28 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2] spi: cs42l43: Workaround for wrong speaker ID on Dell
 XPS 13 DX13260
Message-ID: <ar4zOK/IDogYqa31@opensource.cirrus.com>
References: <20261001085830.4014291-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001085830.4014291-1-rf@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CH2PR19MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dc5e12-5674-4fcc-9779-08df1fa53439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700016|376014|23010399003|10067099003|56012099006|6133799003|11063799006|22082099003|13003099007|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QwHyKMKQNRFzLPSxqX4MnvPEXndL+vOjyIVD/+8QiyIUHnNSGpVY0u0Z8iFyegkD2RlNGtva9ax9EPwcJcFhfIreboFIY6ZanFTlg0zMbm8jQgLa10hFVV6hc8NddxAH+LNBlypsPC0C6owxd4e0e7pn5tBEOGuc63OuHz1R49durffPoafVdhk4b2hNT3lbPVmSbV22SJBQ7bKdTBhEwzBjxhLFPby5+yaPpFzMw1IdV7wDtb2qHiUx5T9a+VPv4zL+Ghwncl/MGoDNuN6jQY6GKyxWPuyhmFi3QmUtsCRdW6cEkM3uGb9IschXv0IU3h+qLt0ADf9/tMt4/JMwOLsZvi66BugTi02qcz975ndDm+wnQohyKtZ7tlMWDfut/+EH1D3svplDlisweHVOBQWt46Is8B8O4l/Fk2Jdz2A/5AvU8yeQ6Xq6rOI9ybXVGilRL0c/UBvhbt0PI0E53N0I473gAYXIK1L64GkqWI+jdiUId8DyFospoBv1G+yL8D1rYUoxCZAv0BFYukG1HJ6rpjmz/AyGJ+3De+GDxyM+ixcBoG/ehqLCPD9am46FswZfGIg4B//tENXSfmFB2NUGyAEcGvvzji7KZ/OzZdAyybtI8WbdB77VBYOELt09v/iK9CIFdXch3ciDsmYJLw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(13003099007)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jnuXK3J0OfOm7gng9e7+/0v57txiQ+i4IvxMAqP8mNYsCnVp6JL4WN5aR1OUR2KvG5eGxRHnQANn1ZpI/lclioIEzNJC20bBfmxbqC1MKaN3uF4MfavKfGpqqEQ4kGfdaiIO7ZBSkdbVbyIAlYmutMRRsrsgh0GRPLRvsg2vqqM9S+aXm0jO84m3xruliLLIMCtmCVPb3OGzHGnT6SYtcu6F5W+aKpjPpO9m0sb0spnYwE1s/KEtnggT5wl9srPKxv62CGlRxLNzTghLehLwiEj+I2CwQCCiQowRfc6v7ooC7lvwYGYi5oTROFrAgvFlTZZ8m6YOohn8VpsozGRNWjAZzpWGE0ELUGrI7qWN/pCk9iEoQ7LLXenVju345v5rwD7NSwAKrhkRNkVxiz7EG1SVzxwEd8W/zW68cN985fMgqN9ymHyhn1kV5AgPlvgU
X-Exchange-RoutingPolicyChecked:
	XZILgOfpCuhqdMPTQ/RVF4OJNPt6hliSnlNvWFpY0rzhzowGFUYgWg3YKk96ch7UTlyqmKSyGqPRxrxLR6WXVvJLGrvf0mAnNnOvfODPymyyWvEUSC9MkQG0XQrR5UxjnjlA0yyZhxRhVnnwJmsmkxHoCY/egTM44dm2gH1vN6Pmfg+I9PcgK3abyXTDJIT3rwD3/AQTrsjbJwQ30c/lSxbcf3yFI2PeRzipwe/g1lmA2gx5tQMdIxOqukRX7ouu3EdAuagCeC7DO+SDPiNnRPlPQWB+wv8GIqYhrgCcGlRXNppARffRXU6HXNTI63qUWLRZlRTOt0t2iDflJvyqwg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 10:17:31.3009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dc5e12-5674-4fcc-9779-08df1fa53439
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4730
X-Authority-Analysis: v=2.4 cv=JtBkP84C c=1 sm=1 tr=0 ts=6abe3342 cx=c_pps
 a=HCvUzjoPJca0/5O0yIdMFA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=iRohn1IGXNOh5bVst7kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX1gjk67mmeNCH
 W6KfWIwgIGa0lrZDQGD1D09xk7nKZOz58Y/QYRZ+5idCxaCyHKLsfQ7IkXcYT9nQsWmpCCL49xT
 A4r+TJbZHARlb+YQX5Q6CblRof4J0GwQXpNjWQGHILwYo3IBHaql2+2690w1hxdN0ktmJ3IRb75
 ROEnt9ruEZZvDcfCSKJmCHAFu5YMQ953a8W6Aw1GAZJnC3WQIcsZO2BmfuBsU3IkH2xZ5OfnATD
 RVjtZAn5Pu5FNaXdVPZMiPk8Mq4BW2lEt+bgY/HjkGAaEui3T7wnoc1wHLdCtq4CEl2UQMdqY/E
 RnuRmWh8r+tWvdsdiusUBKKteqLbMA363X1QfidLidM1Lvr5lKA9Vf2tmeYdzcir5C1qmBkRr/+
 To+qkRjp2kAIbtB+rsAmYs6Yywk4MpL1vIYYJq5+54st4wOYZQaVg/TGkfJ47BMCvhenoqtGYmr
 zjlAGdeVpSP/v0U09jQ==
X-Proofpoint-ORIG-GUID: LC16h1Wsni7uNDhhtBLUbHNGAT1egGzo
X-Proofpoint-GUID: LC16h1Wsni7uNDhhtBLUbHNGAT1egGzo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX8NKBGF1a59Bs
 N1XedYJhWnB6vHj+IikJcnwgRuyBTADNBgvi4ACOQqSdqcPZiBdCtyd1vh34aDHkzSrAl8C0uU5
 mQqpSxU3WiLuLXIPyeIV4/BbCVIbUDc=
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 01, 2026 at 09:58:30AM +0100, Richard Fitzgerald wrote:
> On Dell XPS 13 DX13260 create an acpi_gpio_mapping with exactly two
> GPIO entries to point at the two pins in the GpioIo(). Use this to
> read the speaker ID GPIOs.
> 
> This fixes problems on Dell XPS 13 DX13260:
> 
> - No speaker audio
> - The wrong firmware was loaded so the speaker protection did not match
>   the speaker characteristics.
> 
> The Dell XPS 13 DX13260 has two speaker ID GPIOs, to form a 2-bit ID. The
> ACPI GpioIo() has both pins but the Linux-specific spk-id-gpios property
> only has a mapping to the first pin. This meant that the speaker ID was
> wrong in most cases, and that would lead to the codec driver loading the
> wrong amp firmware, or not finding a firmware (as 0 is not a valid ID on
> this laptop).
> 
> Assisted-by: Codex:gpt-6-sol
> Reported-by: Wiza Jalakasi <wjalakasi@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221956
> Tested-by: Wiza Jalakasi <wjalakasi@gmail.com>
> Fixes: f3c605147741e ("spi: cs42l43: Add GPIO speaker id support to the bridge configuration")
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
