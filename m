Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403334;
	b=CNVQZ75ATUhG1kzaDUpAQ6WfWbbzhsnr0OpMj2Nj6d3jh04j89psijN72y1WVrnGJekf
	 DwGaxqkWWVKCLi+jjiW6YHRw4RcXmv+XGVk35bzLhEKFjE0+RM5tZYje/RRyZzbjCIBdU
	 JjvAK07FKMjSgMt6H91TiEMTFq49i7mSejkPzU2/hCD8gxv6g3UfC9BaL3h9Sl/KiQABT
	 BP4zPHRS4EgHi4AhrPbdNqlp5+CDHVFSh4CfQ1UL7ZiFAzaoMtFxGX8OcS+K5X5wPQ1B3
	 LOTlN+h7FxN+1RNXJcX/zaDPqPt06Vc7cAZ06AbeXmO5ZIHqBugRRjDzMWsd/jU+8Fg==
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PE2eJVXIMc74kZmnI9gU2cOBQfL2+g9sG+to4U8e/ks=;
	b=0unVSYqiw8KJG8QJ8SVYioA964amIn09i902QKYRjs+g9Pfb12wxESW9fuzLhh8ARVQb
	 htZiV32r1qqyEXdk9/ozUEuSJNSyNwKvu6raobwj5By/03XmKoOtXYToYrgHgPwa2dgH4
	 xBtkGDuADmsZIskLQb8qzH6Ox7cwJt05D9ZRt1vMyZpwxwdUP6OcACKFEVcy8SuDtCiqF
	 bezhQUNa2Qo2lNN3JGOkExRWQ3Frm5XYY3MmCo7n66cnChzvft/K40pg5ST3LyJS1roj5
	 IavbgYhBkROIRtw85R78LPev2+yuTwS/UP//weeNUCcohwaEEPFS8xz6OC4TFJfW/eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=O9r7os6p;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="CSvQb/rw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57521606A339;
	Wed, 11 Nov 2026 13:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57521606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=O9r7os6p;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CSvQb/rw
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCWS2D1686364;
	Wed, 11 Nov 2026 08:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=PE2eJVXIMc74kZmnI9gU2cOBQfL2+g9sG+to4U8e/ks=; b=O9r7os6
	pkGN+9dL+daPMy4dN5f/mDuU9uv6hmrIhHcFJDHgs+Z7DptXUWSWL1ZwV6rnR6Qb
	6IBcTS2UENn3genV1jhqHLaMPL+GZtV4Dsleh9NSRwE+4b9b4au9pAkWA1vw0xl1
	YYtHzI/bdj2AIKkKutqfj4NgZcVU3riqfUC90bGHGYtB5WgBzuueSFBuxN4NzZjf
	YVnOWsLKER0SvKetqNhMrQFyxEHnegNVRP/z+OoFxIH3gb3ZaxaVlq7mAfowInZ+
	AsPICNePAL45FgSjdGaI25Spxg8ZL1A/ldZpRD+sGJx6w7Y8RJCOl/yy5hl/i1Uo
	pmd7IxJ/6lqorSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PE2eJ
	VXIMc74kZmnI9gU2cOBQfL2+g9sG+to4U8e/ks=; b=CSvQb/rw3dMiGwdGKZ7JC
	eYT79zH6Ydk/634eS0oaprwPyEwwg62VtRjpvRZSjYHx9EyrPyZgiwjZLWIaLfrZ
	n5pE5iJdlTx5Me7/nygsQIWiVJBxt8aIum6Z5UJHUg5gWVjDTmsz0sOlvzU84kfu
	zDw+JYwVcRTCdoil0hMMuIuZF/3IULmBYoOM2IDEz5yfrLQ4PHs/odiMZnVMjq6d
	eDPxHVJvkJDPYZkegxDSvd1bXzM98i117WCsfXsw5r/z1VLSyXD+T4KjCUbFQLGt
	BJhSpJwpSALfYU6kOEbKBMmM3oZvmnpAwQGjRUl2ix6g8drKENmMTd/iresr7Kzx
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hv1nr0tjx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:21:45 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSiIdz5kD/a+MZiO0WF8HDpKz7eBl5JIqBO3UPedrZaJR3U4Q9yXMOWtpkp6tDeYl9zwVC38OleYAxncwLFk1EqhC6QA7VJrbMpo13cMtwKwHd1e9DlvFNf+ZoE9R32jkRuuqO80I500ob6YGcFlaDKhOzvFYtFsqY5TcSZ+Ahn+8kx8J3c7+klFF5wy2sEZWIVd2ZB2XkXJcUY0IaMis252SWvz+pIGKLMkex87FmfiCbJ9D25Ow1tluFrddILm0xDi8z0Dbwqz8Dd0wT0YQSyOn2ldoObgMm6Z6a54FDykP5qWZi2pjXuy7IrbPxxQnZJeUYSF78mM7sgHtbBWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE2eJVXIMc74kZmnI9gU2cOBQfL2+g9sG+to4U8e/ks=;
 b=KhToZI1veZcWTYyes8bfAAASpYpVlRwo+ycHZoYq1kc6vnmfwINX7gQrSPSMOaLLJKytP7DJVVCfIUMKzDNjARxWt0TLbGoc0xHmA9bTgRZsLqw73F/QH/AqyRg9+1htz/Tj6tjWlDQDwT2e4Ex1qq81xS4BY0E4Yi2HowkEoJky6Ne6qiFr1GuFULH0bqBOl9EmRrm940yY83HJDE/Wyma3I/nfv27Im4J8r7pRGV+njhVAuPs5NZ0g+oC5f/f9a9j4KrsitoaZpTQzr8LV7wYaZtkiQ7xRcYtYVl5N11HVqgHg9nKQem+M0Nbt2Z6u2LAcMVVJTL6QP7zAzaSUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:21:42 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:21:42 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:02 +0000
Subject: [PATCH v2 1/8] spi: cadence-xspi: fail on command errors without a
 known cause
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-1-d339046ada8b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=1208;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=g7y933vWnkA/E4U/yikSuHNdHVhN2qPDNiMHM6PAx94=;
 b=EGiY+qA6h33sKAWkVklxNXRNIQqbm3vP4HqqYmx2TbP7fHp3xcoym50TGvN79mseOdhX3wzmG
 vjLJoCPUy3eCIenUDrhFj4RN9hhrmzZ7qqovbV3bTUwbryNk72QW06G
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4bb81e21-7ada-404e-8876-08df3ff6b9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|5023799004|261026140227099003|261021121427099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261102123227099003|11063799006|261028144727099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Vc2/3SVE2uWmZ2qGaVm2a2FsjMxYEXepFBQmCcH54Qd0JLlnOIyeiLu0nA9L7x7O016TaeAjkiipc6S41mNnmpd851QlAfRu4sq8gSWNxXE3pI/9UI2L0B80DST3wJoMWV2/taIo3zqTllCHcwgk4s3c2JetXswHPBiH2oZ1ka7wqc2mzUSwq2o1QrTUcmH0g9luN2FjHchH2vvAdGOUszJT5RllEIEenqlLxo78wdRwHkA4P/pKn5Mb06MpnViApapMpW7qECDVz2ghn5OMSSBnsvdm9qBkXtWRT+uWFSW8XJBNOO+bcl1J9kom/SD7X8OiNtKGAOnGe+GOFRNiV/rYC5lFYLJ/i3lhABaFsLlhcO3Buaw0YDuskZTDE31WAVzSzKa1TcTGkIQzPxijwLQ4oQ7F5SsyhQrcVqnS6QnCrpYpOtYZloDnsg/WbynOM5Cd5+tijPbjGdmdM+yBo4lmE5ZaMaklJ0XwQbvSOJvApvejxNOccDlJehVSQbJ7yDL0wNE+t52/KoIFDue/dNUFCGOfgtkoVa4jM66BBZ1RsbdgIEEOi0egQuZEPULnvULuppnPw2tCSTi2TMHvsDuiD8rSRBTTF+HutFJyaTX2Ah5x1Td1CkYMzGSHWoF9lhYrCRCKUhFi5vDLgX0c1/MILjYBhVX9KgGC9JDuxNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(5023799004)(261026140227099003)(261021121427099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261102123227099003)(11063799006)(261028144727099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGtaUWtrU0kzUit1VXZzd0IwVW9OVTVkOHNaN2hKWlQ0Wkk5L3FMamhIUGVx?=
 =?utf-8?B?WUtNNHlFM3J5YVBoU3hFV1ZMV2c3RXN5YS81ZE1jWEl3SkJMVFFzOW8vV3o1?=
 =?utf-8?B?WHlHMDZHbGZkV0xwVjRVczVyeWF1M0gxQTUrMnhpVEphREdjRFBDUDI3MkFI?=
 =?utf-8?B?cjlZQmx4Qm9JSGlZazVjSlNXNVRvSndPYU90MjcxNmhBdUlKZ2FOTFRoQ3lw?=
 =?utf-8?B?TEM2UFRXQU9WSmk3UldWQXFoZldtdXRWZXludUZQd01RT1I0a0dzeWJLcjlK?=
 =?utf-8?B?TlFQd0ZmTmFWNmtZMElFb3hxaisrV1hHTTQ4T2s5U3pXb2FBMStOVTBxRG1n?=
 =?utf-8?B?S0h2VERKL2xNMTAwbW5IY28yaGRISm9lYW5ybURvdTJOblNVWnRhMmpoVWJn?=
 =?utf-8?B?cUZNcXNWbmZkUUNTV0VrZTVqRUc3bk1ubUM1cU1LOUkzSXA5OHpXQnQ5MlJJ?=
 =?utf-8?B?aEpFVkw5YkhUbW9hWllVa1FOTlFxamR6VEFwVXM1ZWsvYUN2VVJ6MzhlWjBZ?=
 =?utf-8?B?V1FaWjZDcUE5OCtxVURUYWV4MkdEdjhPVGFNNkhzT1o3YjNBRHVGYVpxWTA4?=
 =?utf-8?B?SzRNVm9qNFlqYzc3M1BTOVZScEp1eUdGQi9ucVBBcWFEcjA0akhVRjFTdU1M?=
 =?utf-8?B?S2IyVnBhM0ptRVE0SXdVOGFiaGNORzhKNEFYQTNGd0pQb3k3ZEZaSG1UVmls?=
 =?utf-8?B?cjJjSWpYWDdOdzUvemRMRUN4QVBPejB3dFV2emN5cnFsUlBNam82djgxdms2?=
 =?utf-8?B?Q1RXOWtEMThPZFU4Zlp2ZDM2WFp2Sk1DUmt1NFAya1M5anBjTHhGUFVKQ2FX?=
 =?utf-8?B?WWJMVjdYNDdhTlcxL0EyWmRHQWx4K2htVlMyTWNWRFpTR2dQbkdaVC9TcjFv?=
 =?utf-8?B?Z0JIVXBuTUhFUUR0QnBWeTlwNFpTRWZnYzVLYVJmdFJManUvZGx6RTJOTUhk?=
 =?utf-8?B?SkJHeHhhekZSaTlMMTFWWHhuOFV6ck0vUDhQUGV4QVFpOGxVbkg4ZXlFZkhU?=
 =?utf-8?B?dW04NDNOOTFRamg1elZuT21XdmkzeXZ3TmJpMlQ1MWJHaVRKcnNZUGRwWFN0?=
 =?utf-8?B?eXJWR2JybEtHS0NkY0hBMjFwZHZRalMyWk16UEZuR3M4ZHZueS9jenYvSzNo?=
 =?utf-8?B?OWhoaXRIZk1VWlZOSjJ0VHVVTXBQNytWLytCS0hXV1YxT290WURCOGtIU1dr?=
 =?utf-8?B?ZHY5Y2lwM3h3WllwMk9JaXpJNjNmQjVVQ2FrYTVIWUpXTWllSXBDWnNpbjEw?=
 =?utf-8?B?WnRPV0xYUHhYUnk0cmVTMjVwU2FuMXYrSDFFVUR2cS9qVG5uRmVNZWY3TFZj?=
 =?utf-8?B?bW44UVNhaU1lN1I4bU94UEFUbWQ2L3dCL1o5V09Vbis4WVlNUUcvWVh3Vm5O?=
 =?utf-8?B?VEx4c1c0bWN0QUsxRTk4Vys2Vk90Rys3ZnhySHhTa2l0bkZNcFpPS0FJR0FN?=
 =?utf-8?B?ZFUwbU96L2tuL2NwVS9VVHg5Ris1ZUhUeTlaWVlPV1gzaElpTkRZT1ZTL0pt?=
 =?utf-8?B?TWVCRHViOXRndVdZb0JCMERmelRTZ2M5ZnpXMHVJTVZNNWFES0ZZbVIxR1NS?=
 =?utf-8?B?aUw5UlBiMDlSQnViTlltL0x2aGQrOVlGMjFZdi93TjByT2NrTXBlU2NMVGxG?=
 =?utf-8?B?ZWNleWNRYmZYbkhJenovVWtsZHBNeUhaYml6RFhBdkoxVlpCMzUvcyt6RUNs?=
 =?utf-8?B?Rkw0Z2hENmVvT0wxT0MyaThOeFVOYU1Hd0FCOHJQcE5ybm9YVmxmZ0xUbktM?=
 =?utf-8?B?djJIU20yem9PakJGUE1BVHd2dGtmd1pkMjJYL2QrZzk3a2sySlE0bDU5MGcx?=
 =?utf-8?B?ODJkK0Y1T0kxZ2NHZnlITmdFWGVxQkx5ZjM2Z3lCUmxuUGJaMnV2L09HOW52?=
 =?utf-8?B?SGxFcXlvSGV3Mi9XOHovQXhla2lXRWFtVmM4WEJyY2t5RTRtdW1majQrTkp3?=
 =?utf-8?B?Z21LaG80YkZORGRwME8vVmhLdVVWWDlSZkJEZ3lGNjJGY1h3VC9ZUjVsUm5S?=
 =?utf-8?B?emNTVENIaithZ3dSYlhzOWYrSEhTeU5rbzBNcXB3dFduMHFVNmpMS0tUc0ts?=
 =?utf-8?B?dk1RQnYwdUx0WmNseVpMVFFHZ3lZdWtNUmVQNGcrMUpYYWJnM0FLNlBSR3dJ?=
 =?utf-8?B?YTkvRkN4WElXQWZad0FNcnI2TzFrRmcyQkpCTzdyVEk0WWd0Z3lQcVMrSGhG?=
 =?utf-8?B?Q2JsYVV6aUw2NGt0b3QwRmNCa2czd2g3Qk9Ta3hVdHhVVlhxMGUraXFpNWRV?=
 =?utf-8?B?b0hCbUNHeFBoNXR4QXlBOWwzdzlpOWNwaFgrOWkvZlhMUkRUTzdIbXVIaUxy?=
 =?utf-8?B?VnNia1krWnFOZ1NFQjRNb3liN1YvcXA1cm5GczdoeFUycERFdHBNdz09?=
X-Exchange-RoutingPolicyChecked:
	m8vSKCsk5FeIjPnh+ZylgX+fsAYaJefOkIbfqh+z0SOe5DXkivrB5RaBknIsKx+xUzIYOakvjgpiyzUp9wXeR3GK3oDXtvvzelUyXVnvcjEBR0b76GT+cENBpVx3DnlBXjMDkC89XXf3yEcoGfpDwUesfQ0C5Jpwk6c6QhN7Ag6jbSGRw1W415jp+JILjJtlbToE+4bWtFl3R8ao3fjkAiIlNVlypKkrznKEegO6Ayd/iWRP1Ruo/aQNQ9OBRRxcYx+5R+A+VNYLhLeEgIpX+LvKYODBhifZ7nzkczxV+Ki3Wf8CQvYuXKjtrTtTxaGGQGoIkM+BO31Fb4ZAPPCdhA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb81e21-7ada-404e-8876-08df3ff6b9f9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:21:42.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFVihjPJNj6YbJNvVPQZQ89jNkrDGkAPUbJOE2w9cxg6DXWWtqhwtg8rqCknzLXPKp/ooLCIyppSCTaut9/O8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX7owFrntPQSO2
 LiQzaJSuyH6HFddTDzP1D8vT0rLDAfm5WAFYuH6aFJk5UUwI9n6ig6kmpC6qsHYDvjIUejIxmGM
 j4dz/1JJMnVtWd5L+8tFrxMZH5ivry/26+JdKHKGpkCGGlM87DUsx3pkv7Cctfg08lx9dP3XSVT
 vx0IyoJr1lNbY3teGUL8VeWc9qoP91mgxR7JM0DSV3hr2iRerem5ioEEIY+vtXJ9K7s2SA7GQ/X
 ON3eCaH1TWprOig13/KY73Cc9kZVBkFinosuNAuBqWeVf4b8VjA7D/Vp2YwbtsDOKU5t4kq3zMc
 zqLJShB0VSFI+nWQwSBl3cD4Z66UsC173t+Tyj55icZi07y7zg1r78Epfl1JvNyj43/qlz9gmon
 J/nQHVP5YX8SWaOGB5mzbJlxQKmR0KD9/uLZP+fIrf0419BqQbzQteuvx8V6zMIewo2mA+XaW/6
 LxWOFdTxL/H0Axq8pOQ==
X-Authority-Analysis: v=2.4 cv=es5KXYpX c=1 sm=1 tr=0 ts=6af46be9 cx=c_pps
 a=ubRrNrA1i3DLWGMHTGxaeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=nzlqlIeCWRxFGH_8wJ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PnhWv0GYDvs6YYUx5PKad9XnDPkJSvd-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX1w0mqjAVmdqJ
 /ZQ3z5Wv4A1bKWGFRO7Jzkd7eoUgwCMLAeVxw9EXGLDX289ekcwrpEWJVMw59uLs87fCbMBjoji
 oobJcDnGlPMFevMr/wN76mCUhXgIoHMFJV4w9+YPKAuTH/m9S0nv
X-Proofpoint-GUID: PnhWv0GYDvs6YYUx5PKad9XnDPkJSvd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110053

cdns_xspi_check_command_status() only returns an error if one of the
known error bits is set along with the FAIL bit. If the controller
reports a failed command without any of those, the failure is silently
ignored and the operation is reported as successful.

Treat the FAIL bit on its own as an error, and log the whole command
status so the unknown cause can still be looked at.

Fixes: a16cc8077627 ("spi: cadence: add support for Cadence XSPI controller")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3687853e4ce4..85cf5cf81c9e 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -405,6 +405,12 @@ static int cdns_xspi_check_command_status(struct cdns_xspi_dev *cdns_xspi)
 					"Invalid command sequence detected\n");
 				ret = -EPROTO;
 			}
+			if (!ret) {
+				dev_err(cdns_xspi->dev,
+					"Unknown reported error (0x%08x)\n",
+					cmd_status);
+				ret = -EPROTO;
+			}
 		}
 	} else {
 		dev_err(cdns_xspi->dev, "Fatal err - command not completed\n");

-- 
2.56.0

