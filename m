Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289741;
	b=VtjByvcE9YoMopeSLFR5WgBgnw8l4Pko8HNDR2Mjz9lh11mcmEucDZJ2ilDZ6rF82CfG
	 Zp4mEETwS/7pKy/Bekgx8fkGXOT8NaiIiLpog1c2LLJnd36F8kK/yBzjwsSsRkCHzyon/
	 Bixe8wiyW+Xt4PCVbqXauNrA/srp7C0IJsUWcl6E/WNmt+MEYo9vu08AyRHy4WymHDtO1
	 xOpnbdLMiKFVcS3fOcF9DVcLTUpYzOTNgira1LmURSY/iUpe10fkxwJyGdKNnyL9gTyEv
	 KYl61pTULJ3x49p5F4lhmMLkRMTf23hXUFUYppLZIdsRZPRJzwDwl4ezHH70OPhxiyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289741;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Subject:Date:Message-Id:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QH2UZ/H4fY9LztefMJAPbtIvjqm9Ye/lPmm8qGgtbXQ=;
	b=eIqiqohsTZz6KXqOFDtmkO267RkMyCyH5p/M7E5u+eE9TQpi4GHghUxgWCTdPpghMVCU
	 HiSQc6exPO/oX7aRivAXYyQiD4pOsrNDnDgnNtb8sVza7VYOkpzRMec1cDxAAx9kk4P4b
	 ipHwXIfsXEoQFSpX4V2eWKHfH+mgd4n4HZxdObKKCF9RKF4u7OrjbtJJ/Nfp+b2h2TTjp
	 FyCSxA3vgUdY2zbROvpfOhQiQqbLipOJDS47zSnieITs9iauEVqtn+2FHq1CTrV4+6lck
	 PHftrZjvAPQulqpvYb1M+x3Do7I7aBbJKwvSF3ou9o+8yQKmDVd6i00bRReI7hjuasA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=K6EgBnbK;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Fj9yRNjP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B1606A31D;
	Thu, 29 Oct 2026 16:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291B1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=K6EgBnbK;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Fj9yRNjP
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TFVk8c1496922;
	Thu, 29 Oct 2026 12:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=QH2UZ/H4fY9Lztef
	MJAPbtIvjqm9Ye/lPmm8qGgtbXQ=; b=K6EgBnbKGDzdZoDjkUMuBoGifFUPxVk+
	LfhSJ4I09Dkna/ZVq4zRHvd7aUpcyzT83dRZonh3Ew4DAekTUdKFPZdevgGpTzgZ
	+sfh7xUHBWQaFsDe5EgqU9uhimaByqcteEQqd7Iq1oZhMi4uy6TJY4zUJuiiHSAs
	FHOGxJow4qwVfSn91cmLY3RhQ81CTFviuddb6R9GZYMdMUFIpCEYkO/bz1AVQh07
	wCADjPK/RbKa337XbhoSSbqD/S2slyJZCyJ1gDYFBOSKNHa8a4vITseiGctIzFdE
	06ExV/MiSYJVuFriRSU39Y9rfMpZ1TKKzPYq8R66mQVwoqAECLyPmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=QH2UZ/H4fY9LztefMJAPbtIvjqm
	9Ye/lPmm8qGgtbXQ=; b=Fj9yRNjPNmNwEJEw/qG3LfmGU1hyG6ePyldxonCcrVR
	BLkhSTMbZR4e3SITkGfi2uMf47nMEmmaDIinEPaxuRq2jhl60P6I/klNKcP82wRf
	Ayg4BHXr6NFUB0WfXxoOS6uJDnaUjINKF9+Li5X/1Ih7oMJUYcuISs9cOnMY7DFA
	allbQy6okEBKLGPMr+87OVnU5WNyL6cJfLFH+RrFzLj15H6BtWgEG33nPcgq5mWt
	bZUpqu24f+s9J+Dr8x6p6y+BOkFQpPuz6l9PR63FnjXjt7vsfc7tiD3IWzvxKFDF
	qJWPLbmTZtTa1/oxwkjbaeUrb2QxWicvCrrSD1k6now==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hm1d0jv6q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:01:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dnghqf9ROtNTgK3h0L7I9n6o6wyJYzblBBIHPb3qg994xt+5zU1gj3h18ptNerzBcpQ3DK/+JAspc5KETz0sXzJxNHFZ8GoSaf8ny51cZfNWo/0jCMFKnymRiFAvJi6zJW2Gm2Jfz+6VfCc65zwhhgscIXdy0xXNkM1QXl3bbyYlBOZawbBapt9yO/2nBscISTnV9DQyiPf3MMT0GkxRpPBRWtMaobpnTCAEw+54zuFqvld42EGUK4Gs/r0CZZZsJ9/EBV2JwlAGbc9pvGbpln36Y6NLeWS2GOj426qLOJWp5bksBrpXUWCmir4Cc6NKvHXlTgsGr4IteEBwBkA7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH2UZ/H4fY9LztefMJAPbtIvjqm9Ye/lPmm8qGgtbXQ=;
 b=mimEJevdv1bRqL0MfZNTfwlx/6ZE/jr3VlhF8PTviabFVWaEGq1umzUGLBq1jvF64Gxq7ZtanG0a+KaOsVDxJRmTtwHi89Jyt5SR35IJAgIFX4aTK7cQLpJWFmSS6j8iFUdykbgL37FRD6Ysq2+yaUKGu+GShe/GLwYDKTBgqITHiJDA0+iTqjLbqTfKEyAvFc1l3Fanj+gHlkxPSXgBMvjBaO83xhkQUUunZBSZeHNwdEKY2RyDOMQpyfn2uKdPiEWApVWzYeL2m6iOJFUzqxcEDRs/qb3E4vwZuSHKcZFErjARurjyZFw7rur15QrupCGgC+dhtPm0XkwBYW092w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB7367.namprd03.prod.outlook.com (2603:10b6:510:2f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 16:01:54 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:01:54 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 0/3] spi: cadence-xspi: add ACMD mode support
Date: Thu, 29 Oct 2026 16:03:15 +0000
Message-Id: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQpkHBq4iLdOavjmAsGZVC6
 d2NuvwW763kqAanY7dSxdvcHqWh33Uk11wuYNNmiiHu+xAPvPhsLFlRBJxVOctdeZCAIUUZ05S
 otXPFZMvvezr/7a/xBnl+Z7RtH60e0dl5AAAA
X-Change-ID: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793289797; l=4025;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ea4vrjPf97DX6ystWfrFNof1PLOJUKpNnDo5F8DgLeM=;
 b=2M+9yY/KvRIwatx1KGjG6+5KochVowWI8sa0Sq3DgnUsIoo9v1Gd05/MUFcLKzbUhtodkkv/a
 lDvOiPM7H1pDGmxaBcOV9UFy3V4beVxG4VHtke4g5FzU7pPu1qk9sxR
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0067.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: c031ccd4-9e4b-45c1-3d85-08df35d5f3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|18002099003|56012099006|11063799006|261022105027099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	E1+L8JMlvuFtH5GDpIVD1jYzYths0IJ4UWxhYd90nux6MY44AgAbIYDhxfu4tJa5EHuOqYwa3n5ywJhHz01C1TuYLLRTPhrp7B/22v446K2L5Ly3uw1uT4ULY6j4w2Qu1CYFv4Ukd5IxIfeWn4AcpAMJyO3D5sOHoYMJSSBZF5eaB/AO7SiewcC22jbs+lKtzPDkZWfP4HFInU0nQepJBqPi7SVS/NtLxpRDH3w92LvJ+THTvW8jLqNrOhZxy6FfzPZnKtzI2ruifbDqDVUdFXIWylP+BfVcNJHtrG5Tj37r3MxkrQoX4QDB2S8QRl2lCOef4i7WsA8Hp1sGIO2dILQSgqO9rTTeabbFJU8coFzM2slZiXqdnM3j5UDawXD1DL31pYBlOQ85wPKNtqbBd/WJ444ZQviVAV4dyr3oAynmqtn+tTf4Mi11E5thH+oqmVFNSyVPaDwL51zIChwan80zNb1DQlP9fG7+FF+mPo0FWS876gWgJHtNWpaGPmNTVrbrndAnOV6QStqqYLKorl4bCugdsVZWEYBGVHzHS3NKCXrcu3wJKp5M1iOBFCR0nrXNY5zTalgaYEsjyYXIpLhMgEmMW/e9+vYk2aN/A+wrFvnjLx7gfVRiSfjPiNX4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2gzeUhwSkxOQ2pEbnN2cWJHVXF6M0ZlUjRMREIyOU1GN01kcTVKV0U4ZXhT?=
 =?utf-8?B?RlhjWHF2M0RGenhwQXhUYTV4bTlLNTBsNi9zcWRJaVJTejE5UDRiM2JUYkl3?=
 =?utf-8?B?ZUlSM1VVN0F2d3dvZkFHN0tLWFFMMGZQS1c4VktxUjN5YnhpK3NuUjB4ZGlJ?=
 =?utf-8?B?Y0FNWGdnU25pYTVDQVFsRVorSm5kRXBqOTZ3NE1CWWs3bzRYZG1laFd6UjdL?=
 =?utf-8?B?Lzc1RUIybWkrQmxGOUhVV00wVE93U2c3bmFUei9qQmFEdGNSY0twaTNmbzNC?=
 =?utf-8?B?NFJPcDVScWZlSnBBODg5am9SOGRXZ2UrNWc1OWNwTkc4N1Vqam0zQzNRaWtK?=
 =?utf-8?B?MXQvQW9PZitNVkdweUUwNTlLei8vdk5xNndmREVNWWxmSGtPRFl5WDIyalpY?=
 =?utf-8?B?MzFSNGJRSkRaVG9Rakx5UVdLMXJWMnVJY0RlY0FuVy9ZVFRDK1VQaGg4UTZB?=
 =?utf-8?B?ZDUzNnRQY3lkL1ZzSjdEY25ORkFxajVlcVhMTk5qZmZNU0FjUkVZdExjYmVq?=
 =?utf-8?B?cFJLTldtS0tpaERtQXZqc0RxdXFDdVRCVG9FWVF3b1luMWNJT2k2QW1JUUlp?=
 =?utf-8?B?ak1uZ3dHY0JTNWNxRFdScGsvQkJ4dm1vMWpoQlVKVWJUeWNNMmVuK3dmN0NI?=
 =?utf-8?B?WUNCTTVuc0NwTHZJV3ZIZlNDbFJiMU5SL2FJQnkzM25MWDhwZzYrRVBycjEy?=
 =?utf-8?B?NU51bTFLRFpFTnV4amFWMGhxcXJnbi82RzR6Q2NmbXFYak1iOWExbkdyb0hH?=
 =?utf-8?B?emliY3N1UGhpWE9VUkp6NGttaUdESFFtN2UyMDVldXNJc1d3ZVhwT0t2aXor?=
 =?utf-8?B?L1pPaExJaE5jSzZaVERUTUgxcE5ZL3dxOXl5Ykl3UW51V09xNnk3QXYwSXg0?=
 =?utf-8?B?OHNIRzQrTUtnYzZHNHlYYy9DWlRZTlNBWGpoTnBVM3JPZ2NZUTQ2UWFGUndV?=
 =?utf-8?B?RkZuam8xb2RXd1IrM21wQ044MFhscExYK1RCU1JoaEVQWEorSzcrOHFkdFFK?=
 =?utf-8?B?TDNnc0lDd3dPeFZaT3YzRDYxSlJ2OEpxN0FTNEpTcDlEZ1pKQ0ZVaytHMDF2?=
 =?utf-8?B?UU5kbzJ3OFBzUXV3YmJrNXB6cEtFMm14OWc0bUozNkxPNW5XMkFCUnREbnZr?=
 =?utf-8?B?NllQN041aWhab2E3NzFDeTdtdlBKald5c3B3VVlIOCtjSkxWVHhoMlAzdkV2?=
 =?utf-8?B?QUFRWWE1UmZWQW1lMThaTE1CdnpwTUwvODZMaW12TXo0eWM3ZGZoMCtVNnlM?=
 =?utf-8?B?MjdpZlAwalNrTEFXcHp0c0VSeC9JK3NkckdOSHFNV0NZdWlyL3p4SDNOSVlC?=
 =?utf-8?B?NHFFWlFweWNWSFVsaEhZZnEzdnF5V2F3OURMOVE0QXh4bzJoR3dxOWJGRE5o?=
 =?utf-8?B?SjFwcHZIR1oydllnOUZHVFdDOXhYQk83cVlYSVA1MmlITDBTZEhRbmN0N0FZ?=
 =?utf-8?B?ejk5TzhoR3ozVHhmaEdvSFowRVRZU1FKSmtoN2l5a1E4ZUwyOEhCQUVNZ1hI?=
 =?utf-8?B?OFp0NDRsWXBiSThIUUFUNnJjOVgwUEEwSE1iM0YwL2Z3d1RMcmtSZ0k4MURJ?=
 =?utf-8?B?Zms3LzB0SzlXMVhUaXNRVnBZbDUvZFVDNzVlKysxRGFTcGR4bnptSW96NGhI?=
 =?utf-8?B?dlhmS0RkSys4cFpJNjV3dDJUWFZVREpjQzFyQURzZW9LUVRsbkFSbXZ5aGcv?=
 =?utf-8?B?VndodTVZL0VJcXBOSytqQ255STA5ekRhaGY5cm9NZGZPTTRsNytnU2poRHk1?=
 =?utf-8?B?K0NwTmN0S3NuVzg1cFhjRnBadmx3RGI4VmtPUEUyUENGSkkvYnRPV0loYjhn?=
 =?utf-8?B?ZEtKN2JxVlRFcy9HK1Y5aDhvTW41L3VMbDB5bmUyeHlwSjdzUWJ1NGxjWFda?=
 =?utf-8?B?d2xPOVE3SXJWSUs0V3J6VXZvSmNOdi9PMUhDNy9Zd1IzMExUS2xna0d3eVZU?=
 =?utf-8?B?bjhQU1NaTDNaS3M2L29mYWZxUm5CNHgxcVdpMERWQ2ZOMzY1MVBHSFpQTEZE?=
 =?utf-8?B?VnVuV21xZVdZSGpYbG84V0Z2QkxxbGg1TWptVjRac2F6aDVtSVpDRjErWjNJ?=
 =?utf-8?B?bGVESGg3R2VhTjNlSzNHMXlreElmeSs3ampoWDAxcnQ5K0lSdVVvNmlQcUMr?=
 =?utf-8?B?RzA4ajRSY1d6VTg0Qm00OVpXczZPVGswNEpMOWhBNEhvT0N4dEZpbjhOZ2ky?=
 =?utf-8?B?MWZzUldQRGxNRjB6amVTWjNPTGZYM29TbHVrZFlQVmduWEJnbFlwN3phNytX?=
 =?utf-8?B?ZVMzWHc3ZEVJdHRwaEh5L2lWa04vUnZIMC9rdWNUOXNWM3NRbGNIVHZaeXVj?=
 =?utf-8?B?WmhKNkQ2elVwZDR5aWpyNktGajZ4bWNZa09UTmJHMEdTU2svQm8rdz09?=
X-Exchange-RoutingPolicyChecked:
	jqGJZIHuQCXS5ftMLFuPJHuDA0TRzH0c4qD3RlvrRyStWbFdnK0vzqrTof82ANWh8j71lQkbOM/8oROMMsHxKmGBMUwKXbPdyMJQwdWD9c7Qgx9rnxV2/K3owZadgfu4jKV1DrWliE4XAs7S8IoXRo2bdY2/vYfMVS4XPD98VJg2Unw7NrgZmU76jDMmptTLQl1ZIkId4T+nfsID6DMu0CxLYBRV1KxzXSVvaIONUwpVAc5Syu9xg3kaDL6yKs7QvJz/ijGqm64JhxjjNVk7nTBKUbwKUvE4jXWGj8R6j+mWka8s6GXgbW9JIU71X6n6vSbjpJMiUmc5xLXsz9rkPQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c031ccd4-9e4b-45c1-3d85-08df35d5f3dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:01:54.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fs0IKHdFVbkkFZZJjVIQqFwfhcnaj4/IUBdgSQv+ZcujuoJkf6xkEEQzNl8S/iS/qrWWET/3WaG6bdUseCSeAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7367
X-Proofpoint-GUID: ElinjHtEoAKsu6sTwdPuBVgIFtBWJbPI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX6flOMZPvZCbf
 RJJCVEGkWtjdWXovYwr+EFuDqivMzXwUwua3Bwa0lBny0zI/Z65MZSS70c5nLmRZXvzV9+oKqMJ
 Josy7PAwHYmCIp9kV4OEgQO3jv+1hoaMxd8H/Y280+P4P0vWzep7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX3ZUpETaxbqnu
 itBV64AP2d2bT0+iuHUsaUM/mXntbjAeGVGUiC5jcSLGqsvTkRnlQFGeI5ACXEWeRBDKBwj0zg6
 CFrz59PIk0xor3bu+jS6vIH6U0nYJjtKYkJAUSsE4ThPdmnMen3oT3IPS/A2yx3N07nUOIC/6Rg
 j08LPYS3JouVeUBJe9+ijAFw66PdNkoo5WICxF7q++fBMOyg4RDQdguBtOVmYRz8UC8OYCO1yXb
 wz/wn6vbJ9RkZqhn7h4zmCngDwT3G625j/5xaa+1ZyFOFfXQPcCnJgosO/OX6RcqQrYQ3RH09Tj
 b68olRrYJkm52j0jCqkdXZSaqrESIxa71Oc36aZjDyHiQu617rRB5OAWa4dq+Gp8uE7lP9Eyj0Q
 Zdp77wegxZ5NhLmnxPAjK1mAyU3IYCndnUdArCh7+eZmLFg8uNZspVnErd06ECAntiIBkhVgu/a
 tnJsMkUmnq30XnzOIzQ==
X-Authority-Analysis: v=2.4 cv=M7XYuCws c=1 sm=1 tr=0 ts=6ae36df6 cx=c_pps
 a=fdYRkKHAJehZsuGPaltaPA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=AGvDhWosoQo0MtVFrpQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ElinjHtEoAKsu6sTwdPuBVgIFtBWJbPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290062

The Cadence xSPI driver currently drives every operation through STIG
mode, where the CPU builds each command and drains the data. The
controller also has an auto command (ACMD) mode where it runs whole
sequences on its own and can move data with its internal DMA, which
pays off for bulk reads.

Whether ACMD and the internal DMA can be used depends on the SoC
integration (external SRAM, the DMA bus requester interface being
wired), which the controller registers do not expose. Hence two new
devicetree properties: cdns,has-acmd and cdns,has-internal-dma.

For now, ACMD is only used for reads of at least 2048 bytes with an
address phase, using the internal DMA, and only when both properties
are set. Smaller reads and all other operations stay on STIG.

NOR and NAND are handled the same way: NAND operations are still issued
one by one, not combined into a single ACMD sequence, so no NAND
geometry is needed. The real gain is on large reads which, for NAND,
means chips supporting buffer/sequential read mode.

Another attempt for ACMD was sent in [1] but that relies on knowing the
NAND geometry which brings much more complexity given that it needs a
proper interface implemented in the spi-nand core. So we agreed on
starting with this simpler approach and then build on top of it if we
agree it pays off (mostly on cpu load).

Some stats:

ACMD
-----

SPI-NOR - is25wx01g (only reads > 2k are done in ACMD )
-------

flash_speed -c 5 -d /dev/mtd4
not NAND flash, assume page size is 512 bytes.
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 1054 KiB/s
testing eraseblock read speed
eraseblock read speed is 106666 KiB/s
testing page write speed
page write speed is 1035 KiB/s
testing page read speed
page read speed is 15238 KiB/s

SPI-NAND - w25n08lw (all reads are ACMD given that page size is 4k)
--------

flash_speed -c 5 -d /dev/mtd5
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 6497 KiB/s
testing eraseblock read speed
eraseblock read speed is 44137 KiB/s
testing page write speed
page write speed is 6336 KiB/s
testing page read speed
page read speed is 16842 KiB/s

STIG
----

SPI-NOR
-------

flash_speed -c 5 -d /dev/mtd4
not NAND flash, assume page size is 512 bytes.
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 1054 KiB/s
testing eraseblock read speed
eraseblock read speed is 64000 KiB/s
testing page write speed
page write speed is 1042 KiB/s
testing page read speed
page read speed is 14883 KiB/s

SPI-NAND (Cont mode)
--------

flash_speed -c 5 -d /dev/mtd5
scanning for bad eraseblocks
scanned 5 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 6564 KiB/s
testing eraseblock read speed
eraseblock read speed is 18823 KiB/s
testing page write speed
page write speed is 6400 KiB/s
testing page read speed
page read speed is 18028 KiB/s

For now, we have a static threshold to decide to use ACMD or not. I do
understand that's not ideal. It might depend on sclk and number of lanes
so not sure if that value will be accurate for everybody. So, open to
suggestions if someone has something in mind regarding this.

[1]: https://lore.kernel.org/linux-spi/20260921093701.1341766-1-fei.xie@horizon.auto/

---
Nuno Sá (3):
      spi: cadence-xspi: rename sdma_error to xfer_error
      spi: dt-bindings: cdns,xspi: add ACMD and internal DMA properties
      spi: cadence-xspi: add ACMD mode support

 .../devicetree/bindings/spi/cdns,xspi.yaml         |  18 ++
 drivers/spi/spi-cadence-xspi.c                     | 269 +++++++++++++++++++--
 2 files changed, 273 insertions(+), 14 deletions(-)
---
base-commit: 7da2aca123754c0e06092bbe179d58078b58d8d4
change-id: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
--

Thanks!
- Nuno Sá

