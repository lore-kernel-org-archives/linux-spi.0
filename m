Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486734D2EF6;
	Fri, 25 Sep 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350139; cv=fail; b=KHEUWqLr/X0+1C8cD+IWTVwFvjek8fCGAplsud59rZXEdaJOseudAk4cDmJ5nAQzdfPDBvboHzyiyaD9km9yd1RLmomeDBzKpWvj/92OeNVbVMfgrPtqEPGkbj4gCihdKN5BurmP6dPm4JeK4SFUJ0SDknre78wTaSmdZ/ZMCZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350139; c=relaxed/simple;
	bh=QqHxQHy30RMaux78p8GX2FjCDsYY+1txSJ7kR261ywA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8ou3vh45XbTr2wyMfZF1/cpM1SJfKSfCFUlij86y19qEAlx4O9qzOVCpUaIFwB+xazR6bRweiJqsvs1NHnnNDnEC3Or/0mrsXc3+aNUFIRm1UF0PvHXOTZSTT7NlDXSreRdSAjQhV6kYzJfVyJxnQRI+XACxxvk/a65BTx1Udw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GMsx19ia; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cuRQW39I; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GMsx19ia";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cuRQW39I"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDVoOl2786131;
	Fri, 25 Sep 2026 10:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ofOvl0ghdOj9eEBryijDvrtjinew4ekM+mIfEW6FMeo=; b=
	GMsx19iaMHeRy8YkWu2SGR/ixyZ0uzMTXKthFXGSMFq7LqjneewQ/g06RO7RX75A
	0a7RH69FaL/YoiGyjAitYGkIlZUP3ZFttvbGHIjoW2105xRqJPJbsIVi55K5V9ys
	CvDXbBLs7wE1z6cmv4Tnav/c53SxQTp6JRnppSSIslmumZdisGuOLamFWoyHkxnL
	f/bp+SJjmvio7Jgj379noMkpKJKOFImI8AWvIIV6N7R82hTrSbIa5OGjAJ52Inu0
	XdU4s3qKeLxpiUcHW8IJ94Sfn5IgA4fodrXcIsoAp/E82JVfO1/F65S23AOEttSN
	k9xZ0icosE3rb+kKbVn/NQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022101.outbound.protection.outlook.com [40.107.200.101])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gw698hgdm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 10:28:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9yaUGE5jnQXyTYtp3g1G0/AoxNekXNnpdyL4mOGxO9CRWR4AYrGQ+qiUIrsyqLdME1LFo+AuQztPUbDTVu9EaHdkPvQWZthktbn0oCAfSeIYirIDENzqiw8pd/BnD4ibWphfORhB6Ltp8NFFvnPnqdTCxVzQyXt2unOUSVAMmlbC6CdKU34jz3CUuvF2Xnth/mUu703kMlvpj/ZjK1NaSQRJaj0h1fptJlbj8AFuLYO5OoPgEQsY96F6kY+u54eydccQa56w7IQOSIlXbcZUH1ySSSEgIzBMs3dOc2olTm28ulfagUCWcpCESUOxjrloIpzozH61ycNIOJZvkTlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofOvl0ghdOj9eEBryijDvrtjinew4ekM+mIfEW6FMeo=;
 b=Jx9X+6zFlAEy56XdWkWlPWaV4LQoGpQFBAQ8/baPI9fORJwTNZgDvSgCKWFEkzhAoL5awAmlWpG2bcs2CD90YEuW1k9SMhn1BQQnUHh74DzrGLSYotPXm4nEmadKN1bM2W1MuYDA2aG5j/3omMnekgM3Dgc0EPe8ItK/hH++xmSH1CClifp5TEnPpSAD6GnSqQUO24NvYMFe8mlF9uRrQ6n4oQr0mr+gl8wjAnzILxSvAFu7osvESvbgsdCsW2CEgEbcygo3VLwR8uvYgRtUTcRAG/IzNEgmPyjapvxIYND+f2l0MdJobzU1gB+DnSIPeEc5eS9sjYlYd+l4w6SwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofOvl0ghdOj9eEBryijDvrtjinew4ekM+mIfEW6FMeo=;
 b=cuRQW39ID4m9SsFn8qCHXBlmPWaavclAS4yhAS59ivJAofRAEMYWNoypt2perzQklvpOYgOAb9mAtDIDogS/26siNQv81igxlQhbcF2TF0jB4E6w+TSPSWX9mq1ct5WZWuDJUc4PeofhLTgc/7ZfCR2+B6K4oCEQajzNxue2auc=
Received: from MN2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:208:23b::29)
 by DS6PR19MB623802.namprd19.prod.outlook.com (2603:10b6:8:410::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:28:51 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::20) by MN2PR11CA0024.outlook.office365.com
 (2603:10b6:208:23b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 15:28:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 15:28:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 22C9E406540;
	Fri, 25 Sep 2026 15:28:49 +0000 (UTC)
Received: from [198.61.68.157] (EDIN4L06LR3.ad.cirrus.com [198.61.68.157])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 78E41820247;
	Fri, 25 Sep 2026 15:28:48 +0000 (UTC)
Message-ID: <40393c59-fc33-49be-a67a-1ede7df67b62@opensource.cirrus.com>
Date: Fri, 25 Sep 2026 16:28:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS
 13 DX13260
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20260919134730.895381-1-rf@opensource.cirrus.com>
 <aq_4PuwVngaLZ3_F@sirena.org.uk>
 <24c995b6-44e9-4225-bcd4-b4e7f6ebfcb4@opensource.cirrus.com>
 <537aaad3-685b-479e-800a-a5abb94acaa7@sirena.org.uk>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <537aaad3-685b-479e-800a-a5abb94acaa7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS6PR19MB623802:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecd2ebd-cb6c-45fe-650a-08df1b19b34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|61400799027|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	nAT4uIaYnSeBDQ6hRS4zsIHNyaTVfyIdhlrxHxFTJ6Rfp4RBoW/QlFWNDR/HHIdRWwvc9vNmc92d/zioio8WDisf78HTRgtUNQzJdetg9VkRcLUjz8/McY8D1ZshObpwkAXy831wulDznyhhLipeVbVPZ6bS6UMFu0JQsFd9d86b5cMZ+EN9N2Box6X1TJgt1uYcKIB8RGdPgE8MpRq/Fo4w1cFej+/zSkVAKLTI58H7ofC91Rz3O9830SPFpnTlzBGNGu3+hBrbQwAYj/noq4i0fQRGylb10PsAPoVJatijxZlzq5eZbeputd6gwyBgakOvWpgJ+1tQozl0c+K4Bz0mH7Yp8TRJbAH4vJjsQZq3RPPUIWoI/IcDlgkpSoUP584GX43/CowV6dSDKWWuuL5nNjU2u50IMPNo+xRZWcdhf4LudCrXys6yC8sfHgr/6oNoZs+fsJ6evAqM/P1QDd1R7k5hjqAAUAA335nCo5/84vONJ1SoOGml7TE2XFKYG/vxrV54jaOknx3dsrSUviFgoE8/LlsBnYHnSwsWuhzqgsFpYGPJEuGk6Nw44qxfbVYfzvGIaxPSLT5oXIxiUovyW6hi8g4EKld9omrF93cBrgjGvEdndvEl/VfEjT2Q0DbXb2EluhWdURch9YNlVi7B8YHur1VUJPDSfSWUnaMwMQNuinDWffijRn2o6NtpDvqPpyLsdbQVxyUYoTqZpA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(61400799027)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Iw+ZDs+IqvcCipBMw2dNuSJhsmbvu8DlNfUBa+flPlfQ6fbioUIqMeClJ0WQ6OGt4bpmEmNoEKqTGN5k/vqIf4hZW+f/eDyaRGG8jy3iBnfx7PGpCzbe60AxDDmDl/A+m25WciZNkm0M8CxRSAp2fFHLMp/k4Vv+g9xaq+zv3UVzW/7vFDUHdcFgKa0FykIHRmQS22V5c++tYc2zmXDo00ZM+hoijFSvzPTXRukCtt2j3DwACc/QGwbIv8aVoAhUkSAGNB5QKsbPph9/alobC+ebX+chiAQyX4W6ztU3BdA3Ijiia3xQ2Z98pjMW/PaTVX9O6h+Soz/rFT5M20r+dHxKhADPDsRdO92iRVT8bwSTlsSenRx091+23bL5n08sVxtMChB+UkJ1wowb/7tbv9c9bUpeIA3A5Vpo44PS/k42mmDkNfiAKx5evYg0adwy
X-Exchange-RoutingPolicyChecked:
	vgF0OxWtO7mPRXiLYLYLxTzvb/+0CVcJnIZN9tsu6B5IpY8FVfXVeAedl0Q8K5tw/uLVr4xe63JtGgKrfApVHa9EAYf8Tw2NcM21V0SrDh6Ig50PkD6JcdEiYxKmqNoQ3NgOTcpw6VEj4LkPTorQYmumK2jYocg7D+F3zA7pi3PVPp+vZyn+Mj8GxOxBhrpOeRG/2Mc1VBr/1rRzNukdjIseO1hwtHyaHQvqgz11PMYNL9yAjlxBVX8r4DGgkNWPIV2pVvbUwLWxgV5UXnGMpfQsC2ydtcupTfMCoG1r7JiGVYrw8/in+arPwl8rPbwgiTJdf7qnILQoDMLAwF6jhA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:28:50.4153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecd2ebd-cb6c-45fe-650a-08df1b19b34f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR19MB623802
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfX3WbwGS2bVM0U
 +72Un5XGYUpnJSczyTIH0MoozjqJS4dVnT6zhxGNpy27P9TzBLUJYVYQGIH0UNsqpVR30ywXg4F
 rqN/h/Ialc92FLYbkRlDIXSWnWH9mzqf3Vo1tSQz/8qCiTnYgs5BBW4QTiTk6RiEBpzapoWJElu
 uYxi9ETyn6a8j7KdPp7tQ+EHp25MWlRpsAjydKvPBXKp3vr0m8S1KsracRgqoO4J2hLNp1E29mf
 WCF/x9jJdsvV3saShVshFUGs44ZEvqZNmhukxfAsHf6L7UhEgEm5LoSLjIv/uys355PWH6/unGv
 NETwVRp1ln48OCdzcvJpw1KAuWdnxUXerHNGlCLBitCJar3uI+svOqx+mJkakH1IJzusPh4yZww
 1UVEGY6vISLpIQflTATBttskLDrB6QgZajKXu7nlDOksgUbkHGdyZUoQph0jM5Ouklv0VsGcurm
 MUkC+6k2KO+tq6TFEQA==
X-Proofpoint-GUID: P6tZrqGC014gUZiRHw52kVg8WmIFv8am
X-Authority-Analysis: v=2.4 cv=Zu94uN7G c=1 sm=1 tr=0 ts=6ab69337 cx=c_pps
 a=aqjypfCBT7xgBBIDtMg2Ug==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=XFPpdJ1vUZ1MkrzRSVEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfX+RdmpyHUv8P2
 +C2l6iDl+MPDv9lUjDPlab/sJvQYEts3K3FX3DdJlfQNyGGR+M8+G5rM9h6C+tXYxEAJQvPKqat
 tiOmHrYYUQgl++L1U0N1ikWI6+yfTvI=
X-Proofpoint-ORIG-GUID: P6tZrqGC014gUZiRHw52kVg8WmIFv8am
X-Proofpoint-Spam-Reason: safe

On 25/9/26 15:51, Mark Brown wrote:
> On Fri, Sep 25, 2026 at 02:14:34PM +0100, Richard Fitzgerald wrote:
>> On 20/9/26 16:14, Mark Brown wrote:
> 
>>> Could we see an -EBUSY if there's something else using another GPIO from
>>> the same provider?
> 
>> I'm not sure what you mean by "another GPIO from the same provider".
>> If you mean can the codec driver also try to read the same GPIOs:
> 
> I mean we're looping over all the GPIOs from the provider, what if
> something else already requested one of the others?

This is only done for ACPI. We're looping over all the pins in the
consumer's GPIO request.

In DT the "x-gpios" property points at the GPIO provider.

In ACPI the "x-gpios" property is a Linux-specific compatibility fudge
that points to the consumer's *real* ACPI-syntax GPIO request.

Take a look at Documentation/firmware-guide/acpi/gpio-properties.rst

GpioIo() is the ACPI way to request GPIOs. The numbers inside the brace
list are the pin numbers being requested from the provider. The loop
is walking through that list trying to get each requested pin.

