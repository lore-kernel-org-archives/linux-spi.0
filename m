Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB93C872D;
	Mon, 13 Apr 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084697; cv=fail; b=kqS/I52F2EfpBFE7VrY8jGtPuFrjQoEbUEJZthHISViAS8Vyd7wa5qu9WydHEnwjgW8Dgzyq6/jLfwolaFJMJaZWMcxu9QQIbGQIpc+xUc3N9Ka6B6F2Fkwz0PUMalB8kYDIsJKUtHVTuYu8lopHrLbxTNjmmfnwIyoFEkhgF/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084697; c=relaxed/simple;
	bh=nkriKc5CTGbGYt1UKKJC3TRItgqBlpf1XLbqJhvPhGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV9HYkOaiiWI1KKqqiFnwqVhmuyaEkGiSuqTmT/gvQoO7/5JNyDgjmQqNuWB/cHIjsqKQxC6MHrR7sCcr5NAHmz9fEBQkKaPtksSGR9FZpqjZyXowbEa9xNFnosQstEVsSfX/aY10DjnI6l1Gs5oKK7TWH5j3Uz/Jt+PAXeESK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dY8LkVYW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=II298d6E; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dY8LkVYW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="II298d6E"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D4x7cr137144;
	Mon, 13 Apr 2026 07:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=A0E00FTPbqJcb1MQddJjp+laKQ5jBvMb4om0u/5Ws7o=; b=
	dY8LkVYW/wkhzn008xJvxKij+VPlQY2PPdNo2LqtqsxZPlAwSJBTQOXdlHv8Elx4
	/Bbe/4mpqUTv6UStfEMzrJqSOkR6iYkkAiuo14xKHTjfIf043sFihiiMXLTmaDTo
	PcayIA6Lo8vtL/kp9ibjOPKUlHzJC2tS0S6GRx1MqY+xoST4PyekFY7dhgNZ6Z2I
	4j4BEszKsQYbMeO/fa3DJCZGn0M3e1m/j6u8q7PM6sFWuwCeytp8VpjSy6jbEauF
	o3F7soc6wAfowbjcCxLjKlfNq7YoPNA8mjACrgzh3LaaYG6v07g66sZeYNvYGkC3
	o1QaHXIFqnmu/GRqZ85XXw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022118.outbound.protection.outlook.com [40.107.209.118])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4dfjqfskuw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 07:51:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcvWcrgntQ3uh9rw3YHUfl7RilUCda9R5YTPhxbV8Ew33RSQ/0Jj3qneVUEcTx4njTyveWK0lVRxi9OTIxehSIhPohpDyoSUm+71JWScdySZf2ZtNhoQO98OKy8m2o9gazXSb9xlg3dviUz9naO8UhuRoF5FZ/V+aX5Lh3plcqOOkzp7i3S7ykasBKsSxlyIdDqnVgo0PtNInfgXEezmtzMpbivR7UtJovRb8YZkAZyX0gJsmI8ZLF4XjV1kuTR3I+ULa8ZmuZRdhWLw21T7tM70k8t0qfQoCj7hRD/FHJJymG6DC4R6G1fudqbL3QKRYfd9Ho+ogrWRn+e4MbHBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0E00FTPbqJcb1MQddJjp+laKQ5jBvMb4om0u/5Ws7o=;
 b=eWUvFrmb3uCKkHDJQnfsoRRqhW+6KZd7DpuCHpr/9CxbtBZtERPaubE8FeD8C32lRsDla2ej5DUFAiBlpVQPuOVQeCFRubCT4NXu4n1z9g/+utL45u5qjvzRgupOzc5OXjedJOCW9sAs/auBv9A+9cdyiCjWUeYm2U/WFBPiFmzqzXOovsYnJ0zmOE2VrJTdKA1XMUgydBTNIOC/Rqp4cQkKdzUGetDie6hsiXOayZCwtOXVAti0GbXGeITObfYY7+J1GSMjRrmTEOV+gN3KUQ3XaKIhHkn/wlq4PUX/gdAodlGMWDu5uPRW/mGL9d+8h0658Ej7BmuQYJ9aCFTwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0E00FTPbqJcb1MQddJjp+laKQ5jBvMb4om0u/5Ws7o=;
 b=II298d6E+6pnzSYUyfdoqO8ZaVw3Rfund3hdzpRViXILQicji0Jseim0nKI9WLhO0etUkDEBWuWnFb4oVUzhbIlw4mOzBEcw1OJ08PVgDvifLbY4A43EbrPjdeqsfmJpKoo5VJU9D+m5QqfPvTpRMgh1/FMSp2EEd9l8zFV3rB4=
Received: from CH2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:610:60::27)
 by DS7PR19MB5781.namprd19.prod.outlook.com (2603:10b6:8:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 12:51:24 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::66) by CH2PR14CA0017.outlook.office365.com
 (2603:10b6:610:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Mon,
 13 Apr 2026 12:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Mon, 13 Apr 2026 12:51:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 899BF406542;
	Mon, 13 Apr 2026 12:51:22 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7D9BF82024A;
	Mon, 13 Apr 2026 12:51:22 +0000 (UTC)
Message-ID: <a451416b-80a6-439f-8340-e53e4b30d87a@opensource.cirrus.com>
Date: Mon, 13 Apr 2026 13:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] platform/x86: serial-multi-instantiate: Fix SPI
 chip select on platforms with incomplete ACPI cs-gpios
To: Hans de Goede <hansg@kernel.org>, Khalil <khalilst@gmail.com>,
        broonie@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Khalil <khalil@rentman.nl>
References: <20260413100530.580649-1-khalil@rentman.nl>
 <20260413100530.580649-3-khalil@rentman.nl>
 <6af0a67a-c028-45c5-b514-52570ecfcc68@kernel.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <6af0a67a-c028-45c5-b514-52570ecfcc68@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS7PR19MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 70161217-66c6-4996-3d45-08de995b5eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|82310400026|30052699003|36860700016|18002099003|16102099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YNjoYJfHeeGgCE35ch9aL4gvhHbgyB/K2kjg4KgKEJDP2HZ+JEbRTcX6mt5sLCMQiC/QuXTtTVGFrh/cglsNYYVc7lqkDRNRbzZaTjOM3nbgJiynkfVCTp+BDRejvK5mgXHE33KlyFs+wrfHq/xPXh7MRJ11DIPXu4TBq6SqCYgXDBHvka5yTB3ksVFKdaRHzjElSbzDfc2zcoJSd3gXXcmAMAhZmT8FbJxfns+VY7iiiL3etoZFxIiy6wxri7w2UE7W+RPvRSW5QRDF0Ddsg24nybLKqIuAewp+V/C3k1blRa8bjFT9cixHc0OLTIydcJmJCwb2Q9VFMPcKA4YiBFG9FJ2D4bO9azOzeXC6+j9NdSlIF+eANM/5BPZ4m9N3NBI2GiYwoPKWyuKwLbBt3W3TqIOc1+y+S9aNakOutA5VI6aGjCFhy9SYBG9fJRj2l/BTFVvpJx8tNege5ewnRLh/nFN8dUbX8tzpK5ZuZsFJFIbzcK1V2NlsqxtW74/pGh+ga+uNIQJMxLQRirVvnYEVmRYEpL0k9dnNcO++0u8HZ7Ih/j+zx6roO8i+p0bvts8Id6tPZZcE5QNaBI072cpAf4Cj+pPEbr/00oQPe7oBxYoSqGOT5XPcWiBzoxgTiO9Ff2ThOvTeOaBXsKoIz7qd96CTGJ2M2/miXqGWs0QkTq1vKMLVK2viiWZLM7tizSUBOk470EC7rk631usB55GT7ONroqwcEyJ6dOBx/JMycP22QUm1yg9aac+n2o+XlCOKeNNedzf+0JLMkrGeiQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(82310400026)(30052699003)(36860700016)(18002099003)(16102099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0/Aqy1V6duXsUMp3zqaBpIalbUv8Tj5yzUOknBi+tMMO7I8f+R4gujqb8clHf+q6hVJa3ag/49KRn76YGEHu6B51ccqRmLzU047inProoIkmWCx4PlfxpX0L5MTsHcJJ4q3I+VIw0qqY3OWaVo2f39UAB3+tmIiXkbnyDVLabC0oBjDiVl49a//Rj1iUka5Y9nR7GuxeZQCqSYtifCD/QdLd0WP/i3GusXKF1QyUDPhKDx8xqyVeyvROrecgPoeCUzZqqimXeqTgOx1VNjwsvJfR6BBpZyQGc8J2XTJ1nJ0pNYhi/UXqYYdHXi+BkEme3yEqMPVliZ1hwxdvuHxsZxBxiLTJDtNHkOYjOREG6I7SmRLnPOwftTTm9Hi7YkRFv7XvVS9SkjJpy3HequjtqjMD83cICGSwnT/x7/4G1lNlMeqSHGbm3iZ5D28ZCKVA
X-Exchange-RoutingPolicyChecked:
	d6ha7XliijdNdRq0CRA+kltRK3nhRrOdcBsaOsD7+aAmDsS4nZ81hb27XXF9gInrv6G7h3NbRMVec/1KQUe/roQtadsxkGcs/t2eJ9+eO/MuVDIeMav9mShp2Ivdv7AqYltv5y5GAVl2rjQzlZZ9paQJkXj/F6msKHqWj4XDHVzs5lKaivTwS6KyAOoXo6tBwtzGrSVQ06VzhFUk6grmyvz0bSUnK7GeED8nPA+t2Ck7h2bK9U/aKxfr7T2ONDZzMKSbAh+4SRqUeQlG0R6YXiwWWkACJbPEdQ/ysQM6GVpD6QEekdvC5CxnmD2jh+OLST84WnDPCZkiSYsMuNkrPg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 12:51:24.1033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70161217-66c6-4996-3d45-08de995b5eb8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEyNyBTYWx0ZWRfXwr4lqdypNqLx
 r5c00WC2CNR3WzyNjvOD3GXELtZt2rhpls94pRWuy71Y4jEd5yJ65gZe+F29/Lvv1eOCMlBklD1
 riQCevbWi75eirnpWFgdfXXihX2TuCFmGvuga38f+vaWpIhySoa310EkeLwzJK83Q7e7evEDHGw
 Jh4GmWMfJkoOCfqP3BqrVrRZhfxykxBNzb+z6fRnpmSBhVHCGEK6Sjm5zsz3aY6N03QzvsbX5zL
 +iY1L5bhHg6hAbuDBzxlKc5Is2wFbJIJU5UO5WoH6GmQtIxOMpNqZ2bbsS7Cm6uIqOEEC2ErFRZ
 Nti7NJJt8vwMEBWML0eZ/mX5HabfS48r+WDHI6s64IjXRo8NVRS4l23ZdgRa4QOZfANL5VXmpGo
 46dNwXg9S8Ngdz2I9Y3UNHeLS/ygDJLv3JHl0aobd/gbgd1JTI6uEj2+ylIrnYa9McYCI+jTV4A
 pEyAGtzMp0+1Tb3P2Cg==
X-Authority-Analysis: v=2.4 cv=TdumcxQh c=1 sm=1 tr=0 ts=69dce6d1 cx=c_pps
 a=X0DbKXi7RYM5x2NUiypu8g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=J7wGSEXvd9CKyP475f0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YWtFivpzJHCZFZgbc0ZMnZ-El32Xozxy
X-Proofpoint-ORIG-GUID: YWtFivpzJHCZFZgbc0ZMnZ-El32Xozxy
X-Proofpoint-Spam-Reason: safe

On 13/04/2026 12:43 pm, Hans de Goede wrote:
> Hi,
> 
> On 13-Apr-26 12:05 PM, Khalil wrote:
>> Some HP laptops with Intel Lunar Lake and dual Cirrus Logic CS35L56
>> amplifiers over SPI have an incomplete cs-gpios property in the SPI
>> controller's _DSD - it only declares the first chip select. The
>> remaining chip select GPIOs are defined as GpioIo resources in the
>> peripheral's ACPI node but are not referenced by the controller.
>>
>> This causes the SPI framework to reject devices whose chip select
>> exceeds num_chipselect with -EINVAL, preventing the second amplifier
>> from probing.
>>
>> Fix this on known affected platforms by:
>>

<SNIP>

>> +
>> +/*
>> + * ACPI GPIO mapping for the chip select GpioIo resource.
>> + * Maps "cs-gpios" to the GpioIo resource at index 0 of the ACPI _CRS.
>> + */
>> +static const struct acpi_gpio_params smi_cs_gpio_params = { 0, 0, false };
>> +
>> +static const struct acpi_gpio_mapping smi_cs_gpio_mapping[] = {
>> +	{ "cs-gpios", &smi_cs_gpio_params, 1 },
>> +	{ }
>>   };
> 
> I'm confused here you say that the chip-select for the second amplifier
> is missing, but I would expect that to be the GpioIo resource at index 1
> not 0?
> 
> I would expect the GpioIo resource at index 0 to be for the first
> amplifier which does have a GPIO already in the _DSD cs-gpios property ?
> 
> Since this is a multi-serial device ACPI node, there is only one
> set of resources for both amplifiers (with their also being 2 SPI
> resources in the _CRS list).
> 
> So I would expect there to also be multiple GPIO entries in the
> _CRS list, with the order of the chip-selects GPIOs resources matching
> the order of the SPI resources.

You can't assume that. There is no ACPI reason why the GpioIo should be
in order of chip selects. In fact, some manufacturers scramble them
(e.g. CS2, CS1, CS3). You have to remember that the ACPI is written so
that it works with Windows (which is the reason we need this serial
multi-instantiate driver.) so it may contain Windowsisms.

