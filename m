Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BE386440;
	Mon, 13 Apr 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070109; cv=fail; b=XM77mqFp+l7JPiBYgb10xLCJZGGDsmH0O1ywT326bHw1O0RDzpv0kfgRI2c8jGzmOEeCv1hxqICY20CkmEdIeghPFFZYU47Ib4Nil3Gdr56taSdFLLhEXJbSXeTbmfr+EnFWmJahRYrEVVWpPeLA3jSgJnGYxrAEpF0GbTZr0uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070109; c=relaxed/simple;
	bh=ydnLRXeYnfkA2QcNMF+AxyZP0amzvw4ROstQAKurmRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzFB+BdLsoIxNKPn6KyrWcdRNd2rIL7/OAPB2BSXtM782nIUSOqFt8Jt8h+bmkHpLwYrXoUNY5JHVrt1+XUnixqd5lTwnbNBkjMiIlmNxbFyuL6TIRqZKP8DseLmbNbu+rglivhi2zSp51A7w9Ko/ozcbydCN5xOvTIEKGkqBDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=A31k4STX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DDYuHeuj; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="A31k4STX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DDYuHeuj"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D6K2Yr270311;
	Mon, 13 Apr 2026 03:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=NqFojSXhv5IOHPEHKfOv7PaPUpHDKBxQ5VfoObsXmUs=; b=
	A31k4STXawUqhIFcMKI8z2If+E4ip9JFEteLrFSo0Etklwztlw0w9jO3n4H0z+yk
	1e5jKWHiHsuAhAHS0z+Xy0ha0X6NT36sISJjfwPTnYJaejypM8hQRtJOnpJOMb1m
	p7C6ckbCIlWhLpUorfZfcGnCZ5R+nuk29Up7z4UXHV+b6F7nQ9YBU9pNtPThFet1
	BQbx84yqhLNQRhXMqcB1KExSvzxcxIWfSXnTblV2L1xdVVL0tomMaBXN/SEJViTE
	BWbwftaL1HHRALXQOO6ALiunH2Vx6Xz8g1UnfDxqXG/mZjRwo1l3QA/r1909tI72
	2EjRCBANXFkTZLrxZIjWWw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021119.outbound.protection.outlook.com [52.101.57.119])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4dfjqfsdc2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 03:48:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYa9DrEW3+F83K4vXl5iQNIF9rABe3TRSoTytJ2l7+FVpfqRZNybFQjAAzxRLe0SAlelZnMDQUcrXPQh9eElEPNJBTcjZYLBQOwzKFea2hNbwJ0NljMI+MEz27AE39426RzjDMIgQnH3KzHOPrtXqOck6l4dbzIr8xeAeW4z+V7bKEdNxmzpFeRzxU4Jq4NpHeI3ocvlc6VHfqq8EUog/y0snc7Y4GnG2BsW1jXYGvTrxmgsicN4TuLsQWtqyEYeiCstoSwSMGSMyixAkkkT3bEMHMpixludc/AZBzcR+HXpGm4Pz+UIxhz1sya1JmQRx4eOEEC/vYC1MhAGE8iI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqFojSXhv5IOHPEHKfOv7PaPUpHDKBxQ5VfoObsXmUs=;
 b=k+SCLGHuFbCejxDU8EXteP7Zr1iJ6iJSVZ+MJa8WE1gqeZMYzljyyBH6l82TlJFXM+44hHtN0oTOhRg27vWz8G9hReeBHb6Q6F8TtlydtXGyH1b4X43Kom8ckyt2fUE88pPpOB4G5VPAUtz8ACzCKOZELJyEPb1Ez0sjxVpvq3pkLNuN+fF1/T+MBT8Qm9ilA49d3PIhX3OmOqlKLOwGBd3u45PMXUI8z+oAdwbceeauPheNwSnduXKCMncyeBxtFDNzz8rzTNKJX4pt3kDDBYb/l94QIiYX+LxhB7swSCG1Uh4rJkEQ0giIn3wiFagrr06st1BkctBO0mwVIqXSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqFojSXhv5IOHPEHKfOv7PaPUpHDKBxQ5VfoObsXmUs=;
 b=DDYuHeujuQ5uNp7LyUCV2B/aZ6yQQVNoMLF2YsczGWEYF5XEGwNPrSW7gWrbJrSb0pod3QEVKw5KZINJU2IBJNDjPthrZgGvzSQR/Vq759eC4jOzoK7hJJqzzru3UsLdogl0HZM59G1CXKr2WMd1UM/3LDYWc4ocyWYrEyo9KwY=
Received: from CH0PR03CA0399.namprd03.prod.outlook.com (2603:10b6:610:11b::18)
 by DS2PR19MB9698.namprd19.prod.outlook.com (2603:10b6:8:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:48:07 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::dd) by CH0PR03CA0399.outlook.office365.com
 (2603:10b6:610:11b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 08:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Mon, 13 Apr 2026 08:48:06 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B5FB8406542;
	Mon, 13 Apr 2026 08:48:05 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AB3CE82024A;
	Mon, 13 Apr 2026 08:48:05 +0000 (UTC)
Message-ID: <328a7f49-3c88-4417-af3d-9530b78dadf7@opensource.cirrus.com>
Date: Mon, 13 Apr 2026 09:48:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with
 broken ACPI cs-gpios
To: Khalil <khalilst@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: hdegoede@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260215135524.1171065-2-khalil@rentman.nl>
 <20260411180414.481427-1-khalil@rentman.nl> <adrD2BrO11tQq49R@sirena.co.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <adrD2BrO11tQq49R@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS2PR19MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1e7fa1-4079-4c09-94ed-08de993961f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|61400799027|376014|56012099003|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	AG2+OLR/rqStgmNvuFyK+oT1A6qdyZ6mnjSraxeyNorYUzNTcOgOYJM9nShF3ncK6CRefFGpvV+TkAQ6AmpgLn8/enLcVP4kfDItRHWY9+jRgRRGRruqqPy8thOsgze9u9pHxfqoygh1vyBVLqHhrAda1qZ+wNs3GwTDpWblFXqPey3LNSUrrng1ME4FmLVE7xoRiQ2xkHOSjbsuvEhNs+CqTUmEv+wxIE9XRIKhUY5nrQ7liiXJWv4stl25yvUy8VkJdvUIxxSVYubHu0LL4aQf33HqXgGiBJJaArqLRz9fxyahUKJNlXY++no2XA8Wo/HEbOodgnyJAlLLwQxsEtJfoZ6+zLKZBfjKbEfSMhfWsE5+zs2/+5TOd2duE+XqQ1XlSXCjb6ZwBU/VZik2tAg0JimP4kVYRzdIWJqlOIqF1NFQNlVY5yTVao4rBnhVIe4Qnk5oAt07jM53PLvUbHwXR8fAJbApzdtvFZimGciLEw5R0s/yNo+g3XGdnJYiJApAKvr/ZjzDxb3Lz11Gcd3P4UERo9t3DKA18DkJdie/CiKgKVh6Jp3hwzoE+ZFXr2BlLhuKGIlJfvnoEGgi5B97OyqqLW1TNHxrVzO2HIaO5fbXM8eQOjumz4YkwybGT1i4p0w+TBHOUcgh7jTfMH+AGWU5A6uzDBr6+M0SfR3TZrhYj72G+6SUnJ+JXSanna3+Bb1n+VCM1YDw/5HWdaOvhswUcc96zXy/3u/HAtELmPHpZ2yrzSIQQxYjP+JfOV7hNwDnuakzQyNv8TwJgQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(61400799027)(376014)(56012099003)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DSZTfV/qLJCgqm80iR7x/LsnOw3T6BLcs93p4q2LW2tTUkmEgQzfstEUzZX+jhKzJDQHpG9ZGsBbG73i/PQ+W0esBrAcFfp0To77YtWrDQYllKNZSN14qVA3+xj69LBdDt0s9/Oa+xZPDBDSa3oImfZAKCw+fRKp9n5jD7LNr2yw9UJp2MEQ787yVK3CeJTIOs+fDNiLMoOyANFZvOB7YoKhpfdVwNk5+1BtJP/fAecwr2L2rBTMkprsUqoarhrxtdFhH8nahCJitFsO2+vNCoUsN52hHBM93RzuyNvwSYaxdR2sEvMcehRjFXQrYmLhRFgI5vsD1OnZfW4iFX7QwAGoxPLUBxwW9sde6xwiiYmr1biJyLBWeKMzq/t7VfZ7Hqie9ko7wzMxXdDmsvsPrVMvG0p9U9sN/YVeisOwb3n1sASkY4Ta44MStuF/zvIe
X-Exchange-RoutingPolicyChecked:
	g9gvrBGcZRyN0hfamZabr+Jic6wjtKVXXcGSui5XER1ngN1gmC7UTzaXlfR2gNbacN+2YDQjBQGdSrQjUuq6SGfantX7gWa6juWScTNkdBPbHE1HV6Ms0U+1H1gCgEkV5ZnQQNNP117HqSuUN/YZ3rGvC7qa9HVhgDPurrBMz79yJLCjalzqJJ68ckApp2Dz3cvi8NV/pMrEF0y5UgGJ36AmUEUl6ByoeyLxiYvrvXqOoxqBR+E3UeVVMiX9DhEMk2S2lXQg7s89SYNQi31Y+vwjPLZ7YXpMZshurquHzeYd4ACP0PGzIh3+ppm1oPG79M9TrZZhdL1TGppuGcPngw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:48:06.6557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1e7fa1-4079-4c09-94ed-08de993961f6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9698
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4NSBTYWx0ZWRfX056+zLkDhPPt
 07YxcArEMRe1QHeeK3VmbTg6KdUdTRD/EL1TM+u0m7wnA7VjaIqcMq6BmHiMjxGP6p9FS6qMM7w
 /6UgoFhFPGp4wEde0R8n/H1syyN29oUXZydl4seQaTxLN0T4Gx2gFkhIoA1hlSgOngiSVLGGOLF
 SG4QjeYMrjBoJPrxUCzSnrg53wbTAm5NO2qKVbxvHFDx5IMoHMsAvYL42VAjnSZI/fAZ38KNZL+
 w9xKtnlgcpeHl4Ju8gcpo2Rv2tX/WZQZnHw+WNj9mPa+aEz9CgvfqdALhWyWRjn9TM+tRNBByYb
 TfyMIkOhe0nYDViJ91MrxblfAU87kcwJUvsWMH/RB1TUJG6mqslx8S+RW8TlD082zm8tJ+ftrO4
 LeIQBdH6Az6wjCwQmwMOeYmE1MANjGdVCk8wcaEgkC+z8f2K+bsRQpX1Ok9nwwkihFIhbBqNeM0
 tKhlIHNmI6H+IwEMRBw==
X-Authority-Analysis: v=2.4 cv=TdumcxQh c=1 sm=1 tr=0 ts=69dcadca cx=c_pps
 a=iRxRSAF+HohKiaZghI2QEQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=psJDo4f6x3kvlLlBYl4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mlzcb7mK9gS5zFuaIexJSXdlaBTGlIaE
X-Proofpoint-ORIG-GUID: mlzcb7mK9gS5zFuaIexJSXdlaBTGlIaE
X-Proofpoint-Spam-Reason: safe

On 11/04/2026 10:57 pm, Mark Brown wrote:
> On Sat, Apr 11, 2026 at 08:04:11PM +0200, Khalil wrote:
> 
>> This is v2 of the patch series fixing dual CS35L56 amplifiers on HP
>> laptops with Intel Lunar Lake and broken ACPI cs-gpios.
> 
> I can't work out what these apply against, please submit against my
> current tree.

Also please put V2 (or whatever version) on all patches in the series,
not just the cover letter.
