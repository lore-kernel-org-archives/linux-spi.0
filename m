Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007920;
	b=RCbrIrw/sVCxzDomOPKLefJ1K7VdfxargyATtbVBYbRHpXyPAVkw9QJRU6JTNRWMmlkO
	 AumLvsouiQO+n0gXlN47tocGJQjer79ONJf/4K1RPM7SBqg8OYjL3Sl+lzbwveWLTH7JF
	 qm5nfbDo6js0JDvZwTReyFulK2iZVUuEtR5s3On4G9AFuvljrPCnkTssbhIl71MQ3nRie
	 b620as4rpOHbu5fkMBZf4eqLSciNbZNfxugaBr50sBhbyqeXfTh0uoJaKqtYGfECtQ4x0
	 FmKDA7Ybt5MoXMTVRqT0XrlnPdALtJlD+DrQip0PfGmOSWYH2becn6WSP9FXPqYdaFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007920;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Reason;
	bh=dSYIyePOQLTOBaq9TJBK79iJPGdfEwU1Cth37U9pCZI=;
	b=ipQG8zHk1C5puviZ3LyQ8Kjoupjxz0swfHreX6J6vmclp2WPtX+uUigTKpOPswbyNGm8
	 uJ4uGze389Bf7PtSUZg7ibQhnGysaju2TCQamJPqGFUvOtgb01+GsE138lISAudQxcreu
	 J7jC6ua0NABV1SabVnD7+NiH9dL23J+fBz1EkXTR06gSgl2NZOkobctBJoJ71e+JYsijE
	 qRyJl/q8wz8z04BuYKr0al9ClOF/u7lKZa19yWj3+8PTm+XsxvSKycb/IFRo7pYOF4y/R
	 5a2iZ4SNGIOXV3NiD6ffkRWmWEFpCKebXbiJcXChbMx8RG35zWTFqTB5x6YHi2IAhqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=LvcEFl6A;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=wUvl4C3F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77260A260D;
	Mon, 26 Oct 2026 09:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC77260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=LvcEFl6A;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=wUvl4C3F
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4KFq01595820;
	Mon, 26 Oct 2026 04:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=dSYIyePOQLTOBaq9TJBK79iJPGdfEwU1Cth37U9pCZI=; b=
	LvcEFl6A4tBjn0lkZ/zyKLuXZaI0t+MlDaykpl0xyAZP/7IpVXVkNNf9yHL14NHC
	V8lDLFWixFp9dI/7XJRCRdVcDaHryikCQW0/94JC9gckcpODt2ShT136Lmo1usla
	Vl9GJy6R+aivazj3acxw0vtAonS4jxGHjN0tXQi/c6p7AqHW/KlAZEDTeskb+VzU
	svrbgDDOvhEwZbi5z7tS0ZORHz05WWM8Z6Kn0mwVlA8o0Mp2ewT0qCve6f0Iw4ze
	UdkwJ9dFPBcV0bSAyUd3v2yr/zMiqcGyogV+cIjDTxgF/jta9rEg+5NnRpQswOmA
	M5Md7k0sugrNM0qI7Yeu5g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023104.outbound.protection.outlook.com [40.93.201.104])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hgs3j9w11-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 04:45:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy2n6TQeKt70gds1dkcIH0u92HeY+UvIgg0eYW9BUEyuZ7arPKXoR9fDciPnsiLU0OjQt3Cs6+geBVEOM/N2wzQFJZ3MavRopVVr0PKOJnovXlLZJLHt6Et1/9RpzFX9C9usdxJWVJ1JNsPxATgmnhu9ORUWPA7rEo+gD9Op9wrgvK77Zk8G84/mIVRMjMd/7oLt6TXpu1zqKTDKJ//HhMDVGshaW5vWH4GwSRMKSx++47RiCUTwBVOPJ7fiEyTX/Eg6Io7QaKPCjpVepM5oe530crmFeIRnXJjlcrJzt1DK9kmjf5nQVNAxZMOHI1KW0JIRcHdBnrF8NGI0srWwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSYIyePOQLTOBaq9TJBK79iJPGdfEwU1Cth37U9pCZI=;
 b=nN1Kc/fzG3ztPEvADluPBFW5PvY/IlqGuh54yYU06AeDCG3fbuAkRNqkW+eutKYi5YAhaO02C35YYpeewhJO9wT4LnXc6ExdExj+O8H8LXxd7uaXGnWplMNniQWRRccPlC2Y26G9LZd0WzXAh2/EDeV7hiBYsqq1KrOa7HgqSVuNT9RprEe2u/3FocHkxhdLv8srUUUL7ILYb9E/81ov9Q5s1wO+YFB1xxEFXeGfF9/yYbNrZWxlY0h2JCn39mpbmy/+QO9lIp4SrFrzs9N0PD5+XWULcnI+1Lj1qemCm+nqhvBVGyo9pj4oqCwOY4H+Q7nm4J8efZsPRuvau8zp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSYIyePOQLTOBaq9TJBK79iJPGdfEwU1Cth37U9pCZI=;
 b=wUvl4C3Fm2cz0+vyxkv5hfVldZLAgWtlGXLZYfVEbi92KLuyU+GFwgVmzQ0u8Y1KgrjAnqO8eRzx7r+ut/VWNUqhRugOzzM/4znFayBo0/2ISfqss7PCHivygUJ74R+HkZ/GyQlNOJWgQxM4sa4UwSGwLrTDdsb0QhtuVhg2hrA=
Received: from CY5PR19CA0005.namprd19.prod.outlook.com (2603:10b6:930:15::27)
 by IA0PR19MB7289.namprd19.prod.outlook.com (2603:10b6:208:439::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:45:00 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::5e) by CY5PR19CA0005.outlook.office365.com
 (2603:10b6:930:15::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 09:44:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Mon, 26 Oct 2026 09:44:57 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 55780406540;
	Mon, 26 Oct 2026 09:44:56 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 343B8822556;
	Mon, 26 Oct 2026 09:44:56 +0000 (UTC)
Message-ID: <83c01495-7c7e-421f-81ec-4b09ed56f8d7@opensource.cirrus.com>
Date: Mon, 26 Oct 2026 09:44:55 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cs42l43: Add speaker ID quirk for Dell XPS 13
 DX13260 SKU 0E54
To: =?UTF-8?B?SsOpcsOpbWllIFJvZG9u?= <jeremie.rodon@gmail.com>,
        broonie@kernel.org, david.rhodes@cirrus.com
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-spi@vger.kernel.org
References: <20261025095037.18891-1-jeremie.rodon@gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20261025095037.18891-1-jeremie.rodon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|IA0PR19MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2a49a1-d70b-4955-55a2-08df3345cc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|61400799027|36860700016|82310400026|56012099006|11063799006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gpeG6/FvQFlTcuSqZqhHMKGOMs/yBww7Yi0P82dqtpY/DAHCfD7VNbvRhc8VyugPx2rdAhCzmWeaU38wmPMwnXGqEAhhb2KbvVxy61e4HUXeR7oqy/5nbyXPHWEAQYCJ1UQDreWznpX/6NQbN2quGhs/DZZH3sV4xSSRWtNjLkDJ3nUf3U24cL/1tKcVdHd0vWaDKpyDJla+jDUAkdgMbnIZo+agjfLcqi5Ma1/bCSym/WLGPiw0ySzwZO+DigQcvSs4BNsJRCeD5iUR6GoHfYkjMXKrzsCH76nlis3EYG439guuxzk58z2nIFzNFf6g5AKrqKW7B55Q4NVNba8djN77NOiMOCtORJ54XnDTG53Ag+zTFsMMrX7k/LJLUubpaQykCRPFOl3TY9dTyI6iHcYMlTy8/HxtzNkDGQJFrmKZaS8N61swZLV0/36CHR8xrRsdXgu4N7mTLh5ra1ZP3Jpa33dAynoQ5Arxn35yt2a8qr+ct+YRCLzE4iy6dp1tfuE6YfW/3YbVVZ5m08xO9cxvm46W5vjhbH7+ElTI5cgMs1r+DxW4CwKBkCSUTNt/YiulHUq9henIBwFXKfA/9evAAtpd+8f9H+W3E0jlO0rhRZn8K0tK0H0B6TbC1KKutlH8bwZvLsw+gc3R4lF5mJyDik2r3CcF+uh200PKhUQujsyknqrj4pEIegUGQkZnQf39ad+lhhPw3MqlR1yU6Q==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(61400799027)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oxAqfaXlhGbUGUseWoU36pdqMaoMnlij5QmmENZdA64FNQ2/mw2yCk+e7foDSYv0ird9MQo8JpeuI5kDlU9FojjOziXy923lwMLS1PgSPm6VFakUPTKx1v++am/hD6LNZiu3HKNh4OlTiebQv5p5afpI2fnRVuuIvheDaEiXUTrEguJuGI/js8x+Aytv+tFghyLfWChyZOH8KJVjySWtt42ByikNJT6NRDFIvymMrjU2kDQlfV38eBATgFmZxHt6c+2L7Z1+yxqcEc0GdMeQ3G7Gqyf0K0ZAdgczgiGkNwByr0TS8M+p1PcacwbmU/NE4lwsSMQ+JwhQz+x7kZrNiFvv2gjONf/DxxiOgGr1iz38sesuczAs9fpfk0u37RsfKi0BINSjnGqVIgxfkYxJvSB5hStfT0kJTcx8jLZCf+VV3U1ezADYDTQbmjwF7/iP
X-Exchange-RoutingPolicyChecked:
	VzleuXponIb8GcyJMts9RLQ/QboHnm+hGgXHhJLzxBzRx8gMO0gm9MZNy28h2TkgEVKCd5J7hjDl3oMw2ifopysAVAId1dsUq4NWroCNtZwtP1SS9zjAFI98DytwLmZwn2xCsMrCjcw68iCLKjyQI1z9TkNMIRp6Gu0CpNzFk/uLIn42+CtyiuYCl1oUYX5Cbwv6FCTx3WP2ME+ySUISDSTQlwmvTNysqogekILgjx+6r83SzRXQa2LRP5q2ySFuAuyCOFCIdgNPe1IZTeWMP5vqbkucQB+FpAP7tnNTS5LJddf0i2IigUGG7Y858lPsp1ds17W+oCTXBGgaO0O3jA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:44:57.8432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2a49a1-d70b-4955-55a2-08df3345cc30
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB7289
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX3YxnzfBW8FKB
 rWYObkSH2ktIF0GQb63P6vSMjsJfyYYf16sdw9lqsZf9n5BF7IjWI8MBk9ET4MBZiW9HUYR3acx
 VKZHgC6GdsVIDvKCHZMbm2f0g+VXvnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX6Cna0IQjv5gu
 0Osa48CLZih8rsZEJadkBEkjuv4eXsp+QS3/Lx+1PRSEFwrVR8n4kNUznq+n8Rzpx1fSnbelG6v
 I75gpyd0FcA66BDVyDEIqUIwr+qpX+3YeVRcdtk+9RuPIj+VDpJEXG2Bft/XF55r9iwYwjJas8x
 3cEKTjsYW48Y0/zlG23GEtcWT1j+3kXgJZKlTR+lsbm8ag9fya8e+7jDV8rESl0zJIlstM2z3yF
 d7fhnLcS0k0NFf8W6H/bmxznQQOl38KRj6PzxL0A0CjddDd0KhfmDwwmuFCEgDv9Dww4laI+cS2
 0PpY2xNIb16BVNCSqpNrdH5taz5XvYHp2jhnFrJ9r6iBuUgASQLRl2GDEvz6PuLfmxFtawrKALA
 JSDeXNAKiXbw2OUfViVuK3psKUKcN/FyVA21keQr7lzhbVCNPREPwYjg/GIeumyEWyiPTwuAIwg
 ytnvEh4FedMCl9RScWw==
X-Authority-Analysis: v=2.4 cv=dbIVTnXe c=1 sm=1 tr=0 ts=6adf2120 cx=c_pps
 a=0zbhqlog1HYD7RdPDvTXcw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=CHSkyznvRQZZaynByEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D6o0HNCGxFjB0UCJ4Qh_hnjD76dgoaJh
X-Proofpoint-ORIG-GUID: D6o0HNCGxFjB0UCJ4Qh_hnjD76dgoaJh
X-Proofpoint-Spam-Reason: safe

On 25/10/2026 9:50 am, Jérémie Rodon wrote:
> The Dell XPS 13 DX13260 is also sold with SKU 0E54, which has the same
> ACPI speaker ID layout as SKU 0E53: two pins in one GpioIo() while the
> spk-id-gpios _DSD property references only the first. Without the quirk
> the speaker ID is wrong (0), so there is no speaker audio and no amp
> firmware is loaded.
> 
> Add a DMI entry for SKU 0E54 using the same handler.
> 
> Fixes: cad16d850e37 ("spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260")
> Signed-off-by: Jérémie Rodon <jeremie.rodon@gmail.com>
> ---
>   drivers/spi/spi-cs42l43.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
> index 6772abb483dd..46eeb44130dd 100644
> --- a/drivers/spi/spi-cs42l43.c
> +++ b/drivers/spi/spi-cs42l43.c
> @@ -301,6 +301,14 @@ static const struct dmi_system_id cs42l43_spk_id_quirks[] = {
>   		},
>   		.driver_data = cs42l43_get_2bit_speaker_id_from_one_gpioio,
>   	},
> +	{
> +		.ident = "Dell XPS 13 DX13260",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0E54"),
> +		},
> +		.driver_data = cs42l43_get_2bit_speaker_id_from_one_gpioio,
> +	},
>   	{ }
>   };
>   
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
