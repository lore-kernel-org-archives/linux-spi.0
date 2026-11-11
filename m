Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403334;
	b=v/grMD/10o6wd8K8uPyUD8hf1Cb4lx+F4yTD100yYyTr6xKIgdfs1osUejK2zQ9QlRip
	 BQ0WtiVeEX6QU8abNESLvTk0nqHVIj+0j97CVSqleyg95fsYUk8XPwq0RLgNoT9VCCd01
	 y/95k6YeBwxLTXtg7tu9NLpVZaj3OrwqvPTX2plkFlfLb6ORbVHzT+vfSjpKWuESFWsjL
	 EFVspR6+5rgGZFrJo+ObVHq/e+9C5+0bgapGyPLLzfW8XfkjTpMlm6BpFLmCmxBWvFZWG
	 So6RtWPjpEGzb3rwL09UZYKC1XVu4mlV+bLYeN6laFt7xlJGG5aj9gAs88X4UR0cjBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403334;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AvrsDcL8BG9pob64q5B/MoKDxKYRy+/EmRwG0/imGnU=;
	b=1TFzAL4MRjHYEj2Ak19HF7CmHGPboswch4vtdAv/YEl/AYYVPb5R/HM78GXnLmLBTodM
	 2zuNSxiJqhyWk3vVwqOwVrHzgSGdEUjqCN2oQRVyZ2lvWtRxGgplrg+6ZtMy47pO8LQlr
	 8reaWQsodNd65dsvPkD3zpgmFQAuDM7IKfAbj2jp/erJRCx8q9HUOndAibiylBLQDPZlL
	 X0GrxOeMrZhA0xxxJTEGbewlL+6DJ7p6eFfcoERN6jn0bgSOHi4wtVrPsvqbYoO3eiFwm
	 neYEYQN5O6YUa9yJGVd7dBHOylKyJnf3aWnbY01NOmaEhRWWFgZmbqGYM1eKTdMXMtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QiIxFnbs;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="pWU/ks5A";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F0606A337;
	Wed, 11 Nov 2026 13:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0F0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QiIxFnbs;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pWU/ks5A
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCWDo83230230;
	Wed, 11 Nov 2026 08:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=AvrsDcL8BG9pob64q5B/MoKDxKYRy+/EmRwG0/imGnU=; b=QiIxFnb
	s38/J1Fft83zYStLmfbD1ufGDsaCguh+CnQnivKHwZYVxUrsr6aSRXF9S+/nY9dw
	L1heE15FDIymqZecD73TrHZGKB9bGSjpktnoIgRjG1AydeUK2uIyDzvhJYkMEzaV
	BghomRSggw6NisHnWKXxVz1aItXajn6Bj32216oZZC1YpGuDKM6Y56dSc99zCgoY
	og65z9xR0V9DehwJpCywZSIMuL0YsPnMxEfQvhB6OcXn6OpFTYe+g+h5yANXDTAS
	6dY1lORwxo33Pzq9CuV9Hv3cM2Frh1KjJ1rkkvpnRIu2IwRCtDtyQS/o9MrgD869
	5TgD0A0Ls/6G1uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AvrsD
	cL8BG9pob64q5B/MoKDxKYRy+/EmRwG0/imGnU=; b=pWU/ks5A63b+tSJnVw1b+
	53cpVZmgjlA9weYx+TeJM+iVgjuAR/WkRjRP2ehCclnfbc0opLB/nf30WOs2/c0/
	yxjKtKxA3jbFaTggpmtt02kgc1msrtkZERgZ154RTIkkU3XPCEf6z9D1CEf7SrR4
	HCaeW5utQXUeCfdZKOHsd4Mu2tXCiSIo0M80vPL8bS8Mr0FdyB+7m2fxsirmdYIa
	Tqe2MQ/lI9yGhRcy5LrOq+I04Pb5XuL+axVrYMTC3moRFYK5uXkcY8oRQS0zDRUp
	tXYhMN4NJzLml/Qa8df+RAqpdptjakOt1Og2IDwXXL5f/f17eahSpIZKNkQ14Oh4
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hvjvpa8gb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:21:48 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMBK3g12mCV0vXsbdf8badPvk+HumKMVfNvfC/KDBIiQu21qi8Iqz/mQjC2Tm+ZNsHbGhG04xjzGiIm8MhYisvzVuNOQWs0PZ7chrs7RJcYMrmek8KiPFDnbdg34pXltWV4iR5Yh4yhCtCdWrme6zi62BR59Y6ZWPRzCSK0bWr7/0QbAojI8swYtHnHHDld4+Sowcm71lBlnviBuhJ9gnGb4UwZFV52jrdRKQFMqXMz8Ja1mDJdROzkG3q88C1n7l8d3PBkkojsDEadrQAAjCZjfHbXzaX9FfnInTsSxqJ8eLap8lF0bkGqLaNsrR3GIz/a38SbLFXnLSAw/ovHU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvrsDcL8BG9pob64q5B/MoKDxKYRy+/EmRwG0/imGnU=;
 b=UdaOjpX9KjcZAsaN+1dtSwsiVG9ZKuyqvYuhwY4faJC45uq6ln78VLQ9A/al1e1MVEfcwTRf3am1dQKKc23WwxbqjbymoMDAOr+u04J0yJY/MGDGji+uWNeIlp92+az/5B8Qv6Upgl7C1gHzefBzZvuZ+qISe+4fWDs9AR3fHK8TKBcB+okz09pGuWHvqSrfaJd9yke2X0P/E2aoHZUHZhajnQ3FuKo8959J7x7tkSIvWQB4MlW8VOHZle4voxydqneZ8q72KQe/buRL8gIMglYjjNGr1V39DyeKlbYQEXQlGt6+//k2dUhKv/UcF1Ssl5sraclHjwdPX/iyM0UWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:21:46 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:21:46 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:03 +0000
Subject: [PATCH v2 2/8] spi: cadence-xspi: wait for the controller
 initialization on resume
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-2-d339046ada8b@analog.com>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
In-Reply-To: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
        Pratyush Yadav <p.yadav@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>, Mark Brown <broonie@kernel.org>,
        Jayshri Pawar <jpawar@cadence.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=2138;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BRv+wA+gDUQWLNkO42RuQo+d/0ScwymRyZTp+0Rpe+w=;
 b=+dEkXY+urKTY8KIfj2Ha6pgmVwKhkhAoqCEE+gS5P7RY2k3GX8st8N+o4xpaJlkHjZNseHCU+
 TCxjephzkNfAmXPHUCtZXMjmaKZAHZvZ7fdDDTneEWB7r0ARSu8cI6X
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0006.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b10e171-5e53-4e64-a2c7-08df3ff6bc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|5023799004|261026140227099003|261021121427099003|261009220027099003|261026121527099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261102123227099003|11063799006|261028144727099003|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	O8G4sRH2xNaX+mq6yCucd3Bi6iGQI7fxsl/bqccFM/khi/XSGFpN3ao00V57QfUWcxawQLXHhYJUOdHdZqTchyTyiFellAROJqNoMALJcJRh1naipJTcSlyjXAyBboLmFJsEGAqn+QadSv8P4/r/iPz36g90RNDwZMqMkGocv7yOY6EaCl9rJqcY4eCdKBq1W06iUJj5+d3EFR8vwqTXhUDUeZZOQQ60i2Q7be1xTCMFxStUfik2FKtCoZkKVr/maw4c2dWb5Hp1COtUkAjqNzotJnAoFqPJRy3yZHefoFaTmgEVJL5GsgmVe5Rp8T5VlBdCnpxOABDW8v3PD8pgUpLnnuOteHvxAewpyDEXEDurqBNpqyxbBUE2xF2upgHYMUzzxjQUEEKOMvpNhfAzBp2rCPpfPzYBTtPZ+mkzDlR5SMwMGncQfSvknzSdT8L5sAwrUaymCQxc8ri+jFAmNNwKcEpwiFMYwdyqzLfMpgrMrjakJjo7Rh1XxjwPeozo/6sZYROCKc2iMvSQI05d2W/x9BDhnH/340vGagjPx+Y4T3NwWz/jIfwdLswikeBGdmoUFmm1IQnYvF/3KcfpR1qJugqHFixRPVGW7pgbNkSEZm4QdgZjqgdZqqGkzEfx1QN1rHPdgila379lzsgAydi6EmkMqO3rRCZnHQr0Ug4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(5023799004)(261026140227099003)(261021121427099003)(261009220027099003)(261026121527099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261102123227099003)(11063799006)(261028144727099003)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlFnWkNUUVRhcG5VbWcwU0w3MWozYTdZbyt6dGdnT09FV2p4eVBPVElrYVRk?=
 =?utf-8?B?UkE3YVRXL0pJUXg3UjV1MUpucTVWcHdSOUhyWkpyNG41bVEySTZMS0JhNUg0?=
 =?utf-8?B?UFp4WkpMM0lwUlRWclFOL3BNRnkyckpGY3lDVFZCZmVEL1BkdS9PcTVGQzNY?=
 =?utf-8?B?SThMQmtXTUhmSUkvR09TSkVGd08yOW1oZ0RlUFlTVUkyYVkrWERzcmdNbTlF?=
 =?utf-8?B?a1Q5aHBickpwQ1dlWmIzbWRxbmJyRTVCR1lGTGNQbGRsWkxIY2hrREN0MjRt?=
 =?utf-8?B?ek01eGx5Q0hWOEQyL3d3Y3AvbTNaSkxBL3ZoTEtIa0YvaG1LQUJFYWt2SStJ?=
 =?utf-8?B?WWpVYS9XY2lKa3BFcG1uUFljbHpxU1l0bjVzNlNkdUtRSEZpRGtJNTdseFFi?=
 =?utf-8?B?UXZpWm9kbXR3ZFBpZFcvWFdsSDNPY1hEc3hVSXI2NnJ4Ykx5NGU4cGdpV04v?=
 =?utf-8?B?YlM4ZE9CZ3hPSGhTbTlnU2NTeUwzZks4UEl4QlFBd0x4b1gvN3dIWU5MRlN2?=
 =?utf-8?B?L3dYVVp4ZUh3TTMwR3MyWW1YOUJIQ1NqY1k1dE8yclN2aHprdHRKRXlCMDBS?=
 =?utf-8?B?dzZzRExYWm91alRhdEZXN2drbGQ3K3RPdWR2N1lEcWt3Z0VRcFRWRDhWU1ZS?=
 =?utf-8?B?WCszbTZQc3FlVTRIek0velJqN3hYdklaZzlRdzFXVG1kUy9oMmNOalJvVlBl?=
 =?utf-8?B?b2N2WWRDT29ZanFIeXVEV1NxZmFSdEp1Y3pCM3ZXTHlPOGNaUzhteEZibTJL?=
 =?utf-8?B?bHJ5T0hVTXpLeWRTZG1PR094ak53clk3eDM0d2Nxd3k4SCtpaVpYY0JGcjha?=
 =?utf-8?B?cGsxRjJ1b0M1dmhXSnZEVTVFZVNlUVZNNWlTS1JTUFA5eFJQZFZnWTR2MERT?=
 =?utf-8?B?eUNpcGhNQXlJS3IwSG9MVWxLZXg0djRNamtUSlhyR0c5ek9OUDVtZitoc0E0?=
 =?utf-8?B?SnVIc3NuK0hHSnIyMWk0U3puLzFUTjdkUHlRYXFMUXA5ZG1WVDNpRVJZZHFT?=
 =?utf-8?B?YVE5ejliWEpyOEtHcTEwaUlSTXZxZnZSdEFQOU9oYmdWRmZ1NGdnRHI4Z3RK?=
 =?utf-8?B?UFp4YjRjU3ZUZHFHVkRhYTg1RHUwaUdrVWlpNHpDeC92ZnI1QktuYmtiTWtv?=
 =?utf-8?B?c09sL3NJWnZwcFIrM2UxcVJ6cDE4TmpXMUk1Mk1ETVExTTVRd1gwcmhrNFk2?=
 =?utf-8?B?V3NZbVFaU3Y0UGliUWI3WUw5SGh3S2dUakVtY3BhRkZFTEZjYzlVRHZRaDRM?=
 =?utf-8?B?dlQwQkpKR0hOcmJnM1FCazB4V0NPUnZrWURJVTg3UkJnRDBOMjFxUWZORFg3?=
 =?utf-8?B?alh5SGJCR1JkbUMxeHFQY2M1MndIMTYxaG01dDdINVVkcG5VbzVkU1YzamdF?=
 =?utf-8?B?OWUyTENaVjIvNGRxS3Ztck1pNTQ4Q0tHOFVoYnZHL2duTi9Qc3lrVm1rWnlB?=
 =?utf-8?B?NUdYVFdtZi80anJzaHI1V3JCdzhpTEsvMGNNRE5RR2lsWExFRENBcFFpSXl0?=
 =?utf-8?B?a08rOHBTUkY5SUVXY2ZhNmE0bkpPbVlhOWtidWZld29FVXg3SElWbUdPSVAv?=
 =?utf-8?B?YUVvKy9hRktBUFN3ZXFUMCtSbmxGMmk0S3NwREtDSWZXK1A3Q1N3dUREZ1FE?=
 =?utf-8?B?aXc1a0grQmxQNUtPQnp0czF3dFFHY0cxVFRhdTVZdVBDMWZDVDNDbjNZeUcz?=
 =?utf-8?B?RXgybFFGVXRiTzFJdlFJajArYkMzVFl0OTNKZ2VMdFEwTDB4eVNHZnREME4x?=
 =?utf-8?B?SC8yNEM5TlVqNTBoUmpmbGwwMGlFZjFYYndxYUpVa0E4Z2g0RGd6T3FtdWsw?=
 =?utf-8?B?MGI4d2JqRWxBcXBPaEFuQ1pENlhpSEh4cEFhUFFqbnhmcmdqZ0NlZ0p1a2g4?=
 =?utf-8?B?Y2pHZ1l2OG5ZUHprOWhLdTlyR0Yxdk9NSTgybS94ckYxTkR6eEQ0b2o5RnJK?=
 =?utf-8?B?T3l1NGl6SHNxSzZFT0xJaEg1aXBvdTdlUTFhVTBxTURXVkM2ek9nSXc1WW5E?=
 =?utf-8?B?dDBZV1NhaU0rTWNsNzVsbHRnL2hGUU9ndThacFVhWWwyY0MxYTBDcFBBeklB?=
 =?utf-8?B?Smg2bG90aTFQS2x2aTllNWdyb3FoS2Q0U0pZK3ZWU0x1MjJQckdtQ0o5dCt2?=
 =?utf-8?B?SWhodjF0akRaZlIySS8raUprMStxTUJzUVlEZi9xcVhLQ1VpVElEOXVLTm9k?=
 =?utf-8?B?S1lHejJTdk53OU83c1hhWkNBU3RLaTlIM0laVzh3VVJzNmZmQTFvN1ZDTU8r?=
 =?utf-8?B?ZUtxTzJUVEI2V3dXRWNLcWJPRytDUHk5WW0yME1KZGs4OXI5cXZDM3N2S2xw?=
 =?utf-8?B?MDhOY1pXRmlmSXJsU25vU3E2RTcwSFdwcFl4dCtuYnp1TFA2NWhpdz09?=
X-Exchange-RoutingPolicyChecked:
	Cnqp82T6Sfge7rlBQX95kz3hHdEpUkWpKxAGGGv58gM93635mvLZtgHgpbUkve0niWr9CM+zbr4J0TF7cb7E4w5aB1laaiSdMCSR7hBiDhFu7LZpa+xn0MfHZpnXtwf+8BtyxcfQaYEb9iKKaqoZ9+hxN0lJnBg2NeU1bmFHoMocfsQVB/SlOvTQcZssvX4YwW1Uh+DDMRTCxGvDJUgDT3z0KGtPTYA35k9osDoIjQez0MdqDNlmpQUIxfE6SPPr114i1TzZwKskzNzoE72ei+J4yUkawiOj6VQOyX2D5OZ4L6NIzMDhSASYO6gHyL2uBkvZJSTTPCi24RyLIMI3ng==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b10e171-5e53-4e64-a2c7-08df3ff6bc05
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:21:46.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwv8fqulW6CE2cQNmtv9c/o07zPYbgBYlG+VKKedUOohik1l4d1Yt89CG7u8D161/dLV1yU13Fa8Fao/cbpObg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Authority-Analysis: v=2.4 cv=bvnZl0ai c=1 sm=1 tr=0 ts=6af46bec cx=c_pps
 a=bMdnqNz3r98bn56uXvEeDQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=rREo-dgawr5xeW0aYWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZZzCwDHuBoLtU7Pa9riR4t1kgY5vHcg8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXzIQ6XiFDzTYv
 FKb4LgWcg54lq71dqNBxiT4SpcMbCOy1a/xCVYKkqVviDjzQGQEeuVmgubK3OP9Yd0RNYJpbz2o
 FVR2NbBl5Kg+wZHGIMym/YCIjiHH0/eKkF2CB1gHROfCvGEuXmi8yFo/4zyPyz03a1NjTR25imQ
 zGtJUo6PCQporqtNKd7eNUOuKITpYFj+f6ckYWiCjsuDcC/N9iV2pLvZFsOUR1M8GuC8uBfwUZe
 mJr0nAwyRFUPr/3IzCmCQqO5Kzns4hQcpBO5nPSSMoS4W3yJ4k1Y9hnSug56wyREQpBaJjRBO8C
 ARdm6MQMUZ7k/Iq+xfTb6C/JQq0k44moW7vqADM/zEp43mbhn+YZO0qoXzpS+ykd2Jx6j1mDUcO
 wxkf30UvONqLiIFBU7Bt20w84HcD2cTLmkXt7Ng2e933qjKSzCHF0I1NTYIrdgJI4KW1/edHgWr
 ymK3c3YL5wbqafH6Sqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX3NVRziqA48fS
 6/uVg5u6reUrLlkpCPH1rhgJ7fvVXf3YMf2ue4fnJV0Fbzi7vTtqiVQrp1XgBJhJpFxopcvwOG7
 IIQ0cpJfjAViUYVYfR0zrmbgxteGS+wia7sH4RRgrJYWM9vYM+19
X-Proofpoint-ORIG-GUID: ZZzCwDHuBoLtU7Pa9riR4t1kgY5vHcg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110053

The controller IP might lose power across a system suspend (e.g. its
power domain being gated). In that case, it goes through its reset and
initialization process again on resume, which is only done when the
INIT_COMPLETED bit is set in the controller status register. However,
the resume path reconfigures the controller right away.

Add a helper to wait for the controller to complete its initialization
and use it on resume before configuring anything. If the controller did
not lose power, the bit is already set and there is nothing to wait for.

The helper will also be used after the optional hardware reset, added
in a following patch.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 85cf5cf81c9e..c02069715153 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -367,6 +367,22 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 					  100, 1000);
 }
 
+static int cdns_xspi_wait_for_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 ctrl_stat;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					 CDNS_XSPI_CTRL_STATUS_REG,
+					 ctrl_stat,
+					 ctrl_stat & CDNS_XSPI_INIT_COMPLETED,
+					 100, 100 * USEC_PER_MSEC);
+	if (ret)
+		dev_err(cdns_xspi->dev, "Controller initialization timeout\n");
+
+	return ret;
+}
+
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
@@ -1355,6 +1371,15 @@ static int cdns_xspi_suspend(struct device *dev)
 static int cdns_xspi_resume(struct device *dev)
 {
 	struct cdns_xspi_dev *cdns_xspi = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * The controller might have lost power and so, be going through its
+	 * reset and initialization process again.
+	 */
+	ret = cdns_xspi_wait_for_init(cdns_xspi);
+	if (ret)
+		return ret;
 
 #ifdef CONFIG_64BIT
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {

-- 
2.56.0

