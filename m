Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289737;
	b=eElAY9OkG0bwaea6lbUdXKRdLlMu//Ti6uLJPhSMnpZWrKx6R+ElTqZOdC0Hc27pClIx
	 ru5U7vooTpHUx7fQ6kwG71bJQOfK/JXGuh3lyqGkRkGoWXPhKqb+ZYih/48C9Z+tLpKaS
	 CRaluYkXvBzRt7uyrnIdXHh4fRiIqvZr2MDAPJVDggERDFihHXcrE8/56a84E8NS8aeod
	 We1520WYnRJiSP0Um/602RpVZAzPqEL/5C8sJ30Pj13uA4duFC84e8q04vliVP0QbFPEA
	 /VITNOd0Bjo1vr1iXlzwUHfA143cbAZrqTR/CWPbXg/S4Srl/udCm82f94BDsjvSLoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289737;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=biM7bQOcTDl00cip61cyv9ujuXgTRTcHlCcT9JeYeUU=;
	b=mcYqA6wW2g6uaT39qB1OZCTQ0ZK2/lwa+rkD222yYwBPmBfYxsQ0/aN6LIi4cttJ/80v
	 /q9cmprH7Yc2obQkDAsz883h3lES5NX+MbUHVXw5RQ2QB3AiVNetfTWk/VDC2GgieGwG9
	 EJcEg2LxO+iIayKIgi4P8erVAqmt/lVa8O4r1uGB+OJ40sTUMgP+o+pmIeS+dsUZBJ+7r
	 jSme+6Ds1IZoadsmInlFqCJRrAE6CtKGW5xk1ik5hT++r8Wgb+9Gv1HOCX6ioD2x6E1fh
	 50vHap9uZcgS7dkCtbZfIszGspgayDaItMKV4A6Zu7CZt6kgmhswuh9iuLON7/6oWnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GhEjdEqW;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IJKB4a9w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AE606A31C;
	Thu, 29 Oct 2026 16:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD9AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GhEjdEqW;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IJKB4a9w
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TEjRXr2845702;
	Thu, 29 Oct 2026 12:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=biM7bQOcTDl00cip61cyv9ujuXgTRTcHlCcT9JeYeUU=; b=GhEjdEq
	W2fiwwK9h58FUybhW3D2mJ/gF6WS//1AkzrxNbceYAajyEUSnscSxyvYwpoHyRCJ
	L5N6KBz3FtVUVST1Wz8qpf/sMiShh7+7SBQy34agNcquwlANzPJL1I7OTKWdLUTE
	NHRNcBkRzn6PJGQGPtde6dMa19MBMUJ+/hgpHRUCS3y0nm+pLz1Rn7BwN7AbBs46
	IkM/3fDvdmhi+x8Q5LGgOPN+d9kydmtrm7VCZByeE7Y6FXGSm1hFXHjoTtsXlY81
	jc0OGgRGtOZ/eun96w3u3IT/FpbJwH3on9ZA0UhpcJce8HZ/ig5sFJNhirggCLPN
	SfvV29GX+ZaNo6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=biM7b
	QOcTDl00cip61cyv9ujuXgTRTcHlCcT9JeYeUU=; b=IJKB4a9wRf9CM6CpTqrPc
	SdpnGauH//+YRMuvKFPUnjNa1/FhQUESt/qhBpOob15BPcKcCWWB4nbaK3TsFmOD
	nTCmJEe/pQt6dH+ty5+tXvGB5/1j+md5Bw9Cyz/BarYVoexKxWJZbuVSS+vrV7VY
	YM2gcFR7IKZXmkVnsco1A1y0yx9B0QlLDYTG26wKkW5LTnXDO89H2yONmMFFSQUh
	v/0vduRKf4g0oP/XGpU8cRwmMTscvv3pzDmx8KDaMzkdryW3vlBd92ltSDIXPlsS
	+rbI0W+fBuM1vGsYzrJ7Tqrb7Pxu+XuRP6ojpguDOSbc+n+V5MrdFHKygp9wqJFM
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hkrqh5qsy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:02:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ear+vaYeiBqhjsHXrUyXzSU0ihOZcrE8rW4TN02IEqRZoWvtScsLyzcBqt1e6m9C7kvLD/0S/mmAaEg36iHOGwNKQB9cEuQDW62WcmijxLmPXIDfcuwD9CEy3ZYKyFslpgHgSPNHuOV88o+mOYYZct66nXEH3lawWdIw4umZOzCW5YzKp8fniJm87poxRlEsn9pdLLcSUefidWKjbBhxTXQCxeUwmotB60r0b4vA+9HhDjKAhnsJCtpwg5pqAZdkBxIIv99lYBh6MNo68RMzq6/vogI70J5OuHYnrJ2Wuc16J/Lszpkea9XY4gzVggazXKlXgOqgxmobhhA4u57DIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biM7bQOcTDl00cip61cyv9ujuXgTRTcHlCcT9JeYeUU=;
 b=bX+L95uAJkJv6VO0rIvcWf9cvLndKyEpjBXL89gRUyP7QmRaSqLY+2UkTRVOKov3bc5Vou955E6Bi0IgAdem4BJnZBuDWHQ3f9YbuIH6I7Ug5MKdBptETzmjU0iPY+kIMExrDim8G9mjQCyrQnfMVhqQ0I23e9VXNn1GJsGOkR81zZt8vE2U0Ermew72IIXJOcKVCcxrD2DOlPXKaFD2X3H2ugl8Pdbu0y3uM31FJ81CKQeNDd3ZZvjmC1lmysO/QppRnAWS8XX+fAt+9dC2zhzoL9v61i3CkeOOlKuNrtf0uL4+c7CjR0eyL4pvdu0Bfs+93VSdqzs/0tsQ2+E8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB5207.namprd03.prod.outlook.com (2603:10b6:610:9a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 16:01:58 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:01:58 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Thu, 29 Oct 2026 16:03:16 +0000
Subject: [PATCH 1/3] spi: cadence-xspi: rename sdma_error to xfer_error
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-xspi-cadence-add-acmd-v1-1-53cd44690e04@analog.com>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
In-Reply-To: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793289797; l=1837;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Fv/4IvLpLaVjV5HX2s/lzSv9t+uYql0kjqAb0W1uiN0=;
 b=NCWlpAFa4hvQJczOhg4vEEXemqupNczyV+KFRfw3D6o05jc8qe/AfJUJZAFUSJvLyk3In7z+D
 A6LLaCPLw5vDQpRhqDXp/vcdBY86CIfu+X+7zg+PL0RZ34clK+nWe9S
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a7ee31-0946-4c42-bacb-08df35d5f614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|261009221227099003|261022105027099003|261009223327099003|261009223027099003|261021123027099003|261021121427099003|261009220027099003|261009221727099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	OFVNXT7ALoMlSZhcKy1A4GZETcwOnoKMRx8FQzVkPrJawoRcE20LzQFBKlO5TsxopUI7SQ9D2uNY2rvekEtf8KZQg81ARPasrxUXJisLSOQg7eThh2PsBfEROJOx4lPxfUZrC71xfjalxsGW2onkhvDSRMcyztw88E0GT2ycynXaJY+AFtbVTI6RLHI1F9vHEKy+SQoFaB2woPcEn28eorcRbsmfrBvaJsQ88CeeypDNtSBy97lr+45EvoYzbbEG2VCYTOsIsQ6BZAiwRhHmGgcCkk7YnEr/zmESyGHgaNlBRdWKYc6ExQmt/7HQQ5D731qo8a/t39PXE8kKQ3wDGaH1/eOF44SzRIu67aabBg+sqBU5t4nM+ZcfqldSuU2V64AUeAZQoKNnRdtKndSXIS6+dbnIsY93tAkfgETNBdCW0ZcIj3MzeNusxQGjAZG1PiQDEVyAy97dIpyhJWt75tiJtNdjDTzILJ3koKdWxpG2dE7PHIJV3Ccil0F87VV3bLosaX9l/qtAIqk3qnJ29jlJEnEHxAUdfqMxRDDg1y75fTEhLu4X4XUo0VGkNeZqnbjY8rz7UKrQirXmzDqHzui49L9CTtgmbOpRvTerq5Vi0WdvxVIde7LS/A989NS19Fq8/SRmZq+6kDTPf8rYjaiI9ot12D6WkdUylRpHMYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(261009221227099003)(261022105027099003)(261009223327099003)(261009223027099003)(261021123027099003)(261021121427099003)(261009220027099003)(261009221727099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVCWVRicGljdWlpT0pnNHQ4eE13SGR4cmo3TDFCZjNNUUh1RWpIa1Z3UkNp?=
 =?utf-8?B?Z0p2YUpUR0J3QTJabHJHUGFSRnJna3ZzblN0RWxGalFQOUkyTUdxakxTWUdP?=
 =?utf-8?B?eVdZeHNpenlDMTlMS0NKQzBpNnM2OStiVndiNTVkc3hNSEoxREZzOFlWeGRI?=
 =?utf-8?B?NmVWZ0VRL2ZNbnVnM2VpbXJvWnJyOWZGRkVsOVVPZnZvazYrdCs3Mjd1OHNQ?=
 =?utf-8?B?VUtFNUdDSVBBOE1xZWZYb3pKaFlvOCsyTDRWOU8ydVNJVTdNWHNsK0xWNGNP?=
 =?utf-8?B?OC9iYVNRZVNpMm11TTYrZ1gxQkpSTjNlc0U0NmM0RTAxZWxxSjkzUzd2MXJW?=
 =?utf-8?B?bFJ2R2xXbEdlYzlLdHVDdk1PTVFvZklQb2ppZlFkMzdXcndwL1doVk1QaFpD?=
 =?utf-8?B?Z0hrNmZGT0V6cmhGQWhmVUNCQUVqSFhLSUJob0JFczUyaU5BS050SFdIdWhU?=
 =?utf-8?B?ajJlZmR3L1k3RklJREx4c3BDUFVpMENGVG5NZ2MzcU5VSFZEMjBMQU9EQXc0?=
 =?utf-8?B?NW5aYkhzUVh1Q1hrRlY5Um42SVpPRCtNVE94UUF0dDZjdFpEZDVpSCtPMENO?=
 =?utf-8?B?VDJtTTFjbiswSFJUOTEvc09FTlRydUxwTGVSRWJGVVJ1anFEMGdmNWxicTBn?=
 =?utf-8?B?Y0xTdDNTa3AwVWg5cWdySUxHUU94WHRnRjZJUHkwck8wTUdYWlFDeUFVLzd2?=
 =?utf-8?B?S1F0d3p3U2NBTVhyL1AyS0NGMFIyQVBwejhmaHkrRWZVVHVpcnBhR294QUxk?=
 =?utf-8?B?bmNNQ0l4aGRXRFpqVlVnUE8wYTc5MWVmTkd4R1FKdWdtWFlWdWNMSXY4a1RK?=
 =?utf-8?B?S1pUd3diMkdJTDI1L1hXR2M0TkJqNUZzUDhra1ZWUDJwTFdiYkU3eUNlNU1l?=
 =?utf-8?B?WGdHdTkvSUtYK05rQXJlUVNlM0p2SW1HWVE1RFF6NVRJWXBUajJCUHZEcm80?=
 =?utf-8?B?VDFtMEYwZldkdjRaY0RLWHdFLzRPdHBtMGxxSmd5Y1EvT3B4dnNUdklrbmNi?=
 =?utf-8?B?ckFJbUxLTzFVTm05L3c5TEtxU1AzeUN3Z1o3VkQ5MThTaFZLQXpINlZhTzNH?=
 =?utf-8?B?WW1RUmlndldXeUwxWXFjcmZNMG9oUmtjN2hDMjkxbVVmSlpBd2UxR3VXOTZB?=
 =?utf-8?B?aDFQL2thNGVwclM4cXd5RUdPWUViZFcwbTE1THhuTWdTYjVZcUpwbktaeC9y?=
 =?utf-8?B?ZVlCQ0xVRGF3WmtKcHU5c2llL25DWGhPaXptaUtWTFByWVY3VENZOHpMb2Vo?=
 =?utf-8?B?UkNCUm12cXMrZkVaTk1vTE1uc1JhcXZDMUxzbkFXYnlESkNnYVVneFMyMW5n?=
 =?utf-8?B?bWlBTDZycVAvajlONW1JNDYvSjc1UG4wNXpod0szMktyd1ZaZVpLbG9WVkto?=
 =?utf-8?B?MXdIaTVnbVdKa0Ntc2pZa0ppR3VONDU1WGZFMks1TW1pZ1ZHZTc0Z0lRc0Vn?=
 =?utf-8?B?MlQyeGcxMHZZMlVUU2xEMFZQeFJsaFp1T1c3a1l6Tmh1cmJHcTA2aGc4b080?=
 =?utf-8?B?TmFnMjdZTkgrNXBQcmhoaGg2U2V3VWtCNzUxZStsd1RBd1JEQk9vWHVhWEp1?=
 =?utf-8?B?RGJuakRqQ09tRHlYbHVvemFLQmp0cEtIS01BL21wY05xWFJQOE9RQi9YdjVR?=
 =?utf-8?B?VUJ3L0NKaG5EbFhXTU9meVBLcC9adWIySXU2TVdTVklnSXljVjd1emUvK3FF?=
 =?utf-8?B?STdmYy9ScmFpeU9QWWF6S2VQKy96OElYeWoyR25wcEZTcEMvZkhBT1A5cnhU?=
 =?utf-8?B?NHoycGU3WVhnZnVoTTNNeWNZY3ZFaHZiV24wcGFJTDlqN3VsZHlCbDlhN05k?=
 =?utf-8?B?M0ZGMTR3MFJIUk9peDN0TU9HQ0Z0TGpNS0REaEIxdE8wQjcwV0daVlY1SWJv?=
 =?utf-8?B?S3Rmb0ZIUFYrUnN5YjlxUWpUSUtSbGN3bHhxZ2JiN3VPMTROeGE4VU1zSmNY?=
 =?utf-8?B?THU5MzFmTk9lRFdxbUJDSjVTWTJEekFvcCs4MHJabFRlZURlUFg1ekFDZUx5?=
 =?utf-8?B?L0tTdkJUeGo1WXBCdzhCR1g5Z3ZFYVV5Vy9nb0ZycklvRjZvMjNndlpLVCtm?=
 =?utf-8?B?Z2hrRm9JUlFaSkdaYXpYdzhaMjQ3UFlwT2tmaUFRbEVMWXFwUUp3R0t2SFJD?=
 =?utf-8?B?QlVBclNTemI3VklHUW1qWkRXSzY1eFNUeEcrdGNvbmg5Sll5YnZWdnYvQjZs?=
 =?utf-8?B?ZTBsTVlYV3k1VUhrVHo4RXNFcUNqNk9aeWUraEJOd24wc25sRFdDQWpMRXY4?=
 =?utf-8?B?M3NtOEpvRFJuN2RoZlRIVE1MdGtVTzNRcEFhdWIrdFgxMjhlNGNMbkhaSTBL?=
 =?utf-8?B?K08ycGJWVGF5WEdzYlFKOVgrUzBaYkNRN1VqRkRKZGc3eEJsd21KZz09?=
X-Exchange-RoutingPolicyChecked:
	jG5Xn/2s5SNIxgvaZB4QairjAk4+ONvRGfFxMgaj8Ql8MXgUGBr34Sozd9dxeRg2R68p3mLT+sjMafOwKShcS/tOeqq9Zleuhs9zVPrupMjzSOAJyPrIFUzWFzU9sQQ2dInOrQd4g2FS5vbN99E0vet2/Lgi4ZbbdAQ3n9X612hrIfQRI+jVt6rFcimJIcOhK3epS+yMsnn4ShvMQ4GBX4nN7IWG7iS5/Tw5aZ2KqHe++OQx445qAIOy0eS8x1S26qHl0AH8r/VwicaD5ALAfJN/CYlSBWFcmYOd5ym35Q9D+iNQjUKZkIeoxMJ2c5f1FSzs0lvjYagO5h03AL7q4g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a7ee31-0946-4c42-bacb-08df35d5f614
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:01:58.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZKyrZiSwU0/1uZAAqu0B/95j6KCuOYcmI4R2fMXuaxim3tpQlo/6gE+njX084OkbRfTa9f9jIbqJX1ptx+WYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5207
X-Proofpoint-ORIG-GUID: ge-oD6fr4IKywmDZ-iW-85ROfU5DlsL3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX9hDAj/cknlcb
 hdBg+XXNS2HkDuQm/DksbqEL+2y7ARJpxVZ8dYooIXGqQonjFfZM6fj10Ey+VtF4tcGuh98otDv
 04/kHlEPc3HItsXYJQUZzEehG2IP3Kp/zS7HaV+tCKb8UO6ABepl
X-Proofpoint-GUID: ge-oD6fr4IKywmDZ-iW-85ROfU5DlsL3
X-Authority-Analysis: v=2.4 cv=OK+yTiaB c=1 sm=1 tr=0 ts=6ae36df9 cx=c_pps
 a=uJxR2RjB/d5PFa0hjvWx4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=ZUcPtMoNdDkd0U4e6REA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX/Byn1bb8ip/W
 2Q42fMbSqi07STjbfN7PPI6T2VTu3QMxAUCVR3GzmIUCYvCU5eqR6UVjMTj74tDYLwTU5S9PyRM
 0EmX5BK8ApT7OnXgFcAYI1aIuKW/XYsGeHWYlZ+gNEOo2UVaZG46gDtsCuPOyfQOFDcu7Ix1S7c
 IDzE5HADODMaRulpYITojsQVqMhxQIyP9DNPFaZOH5kshGykjHfwUh2iMvADb7N5BonQMJfifr1
 V2OzYJRjSep9qO/cfIJYFpP7gkRtkGEnpAPr7vFsqDAzwftWTho/3DUeYVHgJ14t7T8Ak3ftrMP
 pvqtcNM3QPGVZc1Itt29Rs4x5+5I81qh51SOp3GZKDOEm4TMORqtL/ls0ZnRKjg3Jc8Y4Mv+q8y
 LpefPOjnvsqvvFNQoOhm1y0N0PcrPSZltU6YC627xNMR274XKR3Jiz66nHBaEokehJlk+TUqYaY
 OzeN/WcQLqP1qpPi0ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290062

Rename the sdma_error flag to xfer_error given that a following patch
will support ACMD mode. And so, let's keep the name more generic.

No functional change intended.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-cadence-xspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3687853e4ce4..905292fa50a2 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -338,7 +338,7 @@ struct cdns_xspi_dev {
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
 	struct completion sdma_complete;
-	bool sdma_error;
+	bool xfer_error;
 
 	void *in_buffer;
 	const void *out_buffer;
@@ -544,7 +544,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
 
 	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
-	cdns_xspi->sdma_error = false;
+	cdns_xspi->xfer_error = false;
 
 	memset(cmd_regs, 0, sizeof(cmd_regs));
 	cmd_regs[1] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase);
@@ -575,7 +575,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
 		wait_for_completion(&cdns_xspi->sdma_complete);
-		if (cdns_xspi->sdma_error) {
+		if (cdns_xspi->xfer_error) {
 			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 			return -EIO;
 		}
@@ -703,7 +703,7 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 		if (irq_status & CDNS_XSPI_SDMA_ERROR) {
 			dev_err(cdns_xspi->dev,
 				"Slave DMA transaction error\n");
-			cdns_xspi->sdma_error = true;
+			cdns_xspi->xfer_error = true;
 			complete(&cdns_xspi->sdma_complete);
 		}
 

-- 
2.56.0

