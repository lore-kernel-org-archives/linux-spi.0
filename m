Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E03AE1AD;
	Fri,  7 Aug 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114184; cv=fail; b=fNEibMkU7d2hVugGA6hnYbRRaSAmUiOEx/GuCuSJCgd/ZlnVdlRGy8j5AznZhxTKdhMtclFZbMui4+u9QOvm7kN7uuX5gJVBKbemxIjZJvQtX3Rj8k/y7GMLpqwOr/RI1tyRNlkKgrQ4p1vEk8tahygXLMo1fqLTw+mPskZekS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114184; c=relaxed/simple;
	bh=8Eqeu8mA9j/YPRUGmf8/jYzwHiDKR2ylA9okNd8krrY=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=JLo82t9xzDBTa3b5z3DmAgWH1y3ZT0X08ZsuaOKdxlKB5gHei1lf2Gsg+JN2lcgHE3bv/BSN8gxlVbcgb1yjmHMCNWTfG/Wme4XGNWoBT1hQ4j9jio6cX0i+6EsvLYWiJRCxgz6KiWlVzNEwDIbdoNPP17DQkx43cM4M8USFQok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pRoJ3z0K; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pRoJ3z0K"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CfUf22060375;
	Fri, 7 Aug 2026 10:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=si7Fv
	uyPexRZtM5JioPFRUv//gU03DNbMxpbPI9Ulz4=; b=pRoJ3z0KD7M7tYKEBkMTI
	6FfDD+HmLa9gtbgcfkTa3B+4r8nUV/GQnfc3mUjnCvGCenx6FCaT7wYEU68oJcFX
	j+ssJpyu0u5rq4sjuvgwguIrTCZ4z1Jgv3V6MQ1rAhvBF4nIwcdGUPeClVkZLtl+
	/lytU3KzNCaQlNnAusBzgRsP7zYgXdb4BbcWYJFET9uFbzJTE0+EWEF1O9Qky1Yq
	AcqeOHfHCbgDGSJQ9zSeWvTnDlp6Pmg1kE2qOqmdzyJkul+MEmBsOnMCHGRnFw2n
	uD0PvCWMdnnJ2h8r0ACFmMtWJkIfezmSw3uteQgkWuQTBqrsWTbLFmetlkV/Q2Xl
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fwb3gtd3w-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:49:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAPcnzyiPbn0FlFF9NUVUozApX9ahYEnBmD8FuN8bDRVhellhs1Vy+o4ffra4oz9PLjUVceSTi3RsSrdDE/a7MrHZ6lDo+80ljD1G0biia2FxMRy1cBGory6S8VB6Jhdj9B4yx1unWRBtDYSK5htBd21P5q9D0xTS6TOCenm7rpe8bTBN6hTzWzDNmiKVxQp3JBRKQBXIrlg5UDOYzBVwSVtbTShl0o+UZN17oD03PhSRo7WplwM+N4aCAggB8z20hVEVg43L5v3CS7JPCkfaFvZ0FX2Um36NLT2ECwU5SWbHiZEqcNkBGli4BcPdl/GnBsuBl7eDz7BGUo6VWsj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si7FvuyPexRZtM5JioPFRUv//gU03DNbMxpbPI9Ulz4=;
 b=HDS9xe+YUnFp7N4d9mpRw+A12aaslCETabMozFsT/mI2aqieuCUiyxxB8SPIVmjL3fbzV68a5ewlyRQpx3Ev0byoUs94pP8HdBZMAMoRwtP52VjZCsJbPc5ECOlOLcF3yHxKnnMvll8UzULn4o98KdY12ZlRkAKcJ8oZBwbBYI260m3RfzfMcaYWLToH4FLR5PtEp0zRfHU9dEW2HW1kwVONfZS66yH4eDLtjfqoM10Jwyv7nALsVCYdAuK7rxQRIW+Kw16aqeU9vikE7lhwDyPcuxoeAk0wUfZJSqnt0YA+vPPg7xqHNaLyA6U274qBr7pvWlW8F8TwPKlPn/xPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS0PR03MB7251.namprd03.prod.outlook.com (2603:10b6:8:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 14:49:35 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:49:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 4/5] spi: spi-engine-ex: Add support for multi-CS
 devices
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com,
        michael.hennerich@analog.com, broonie@kernel.org, jonath4nns@gmail.com,
        marcelo.schmitt1@gmail.com
In-Reply-To: <a595944fda10f801dd3d11640f3a3726401c40d9.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
 <a595944fda10f801dd3d11640f3a3726401c40d9.1785725359.git.Jonathan.Santos@analog.com>
Date: Fri, 07 Aug 2026 15:50:22 +0100
Message-Id: <178611422289.552144.15127714056777916281.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786114234; l=646;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8Eqeu8mA9j/YPRUGmf8/jYzwHiDKR2ylA9okNd8krrY=;
 b=UGB2xkI7nqI7Y0ZkvBWNLsLkrvN6/KosIieKI4r/uCwMBopm5HRN5B1UTqqGt1R5pFdj6JDQj
 QGMEqT5S/RmCyG7BjdXj6OdOWps8wMxCvAFIkwyY6+oFIPvbDKlXXFl
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0010.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::9)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS0PR03MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfda970-61ee-4b1a-64fb-08def4931948
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 M9AgPp4UoSAYCQQgf3RlGrH3+Qvr2tY+cxIS4OQlu8EQ0v9uwag/RQ/LsX3j6AfRYYXNsLUI2aPUW8ojR8GUkvf8TIEGYUv572Qo+R5uKcgzdNZWKTZGeye91cHOdfebfdJdlTPYdzOG/rn+cOkAttlFfwyla1JDHkmSZHdDxeRXLKALFIpEHpukx862ymM/CmmzJrR47GgcPpGEiP+3vvA3lqwRyfv9e6i2V+exvLETCSGwegJ8ys8te05tblaUjp5G8o22meI9OaT8W9H7o3ks001LXiTjTzFjaIKTLEWCCcTC8CtONNUVXSNQ3EeyinNJ84NcM8D/1B5eqj0Eq5/SHl1aPrxdU3Hm7I1J86s6jCxFB/vAonCRaYk0ZhwPom5bsJ9NFJJca2p0+h1Xim5p4gTJM9IQM9LhF7IbpsBc3nz/HkKcc5IiGigzmsbLq5+95baWMaaklIJ6CjgwQ3bwfX5ZdRvuGNC+O6Hd33+uUt5zIyzcLtLM8rWa51Eemy5dQd9ialTEtofRcP59QX0MCTbMc0Tn5NuIy+voT0r35JXC3+4PA84v+r/a9B3SKq7TXPY6D7uodASuSOQdIQADR/2sd7ip3BgEfV5otveRB6TvDPbC88R8eTFtKdknRId0OIdmsbpVtYumaecQNjW3F+A0yuxSi2RQJFh/vgw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OHFvbGNERzdIeUVRUG5nY01tcjJmOVlkcm94dUhMTGhkdHhyeGRRMkxTUFNw?=
 =?utf-8?B?YUVNd2tLdk96eDZKenRjd0dQeWpjVFFOVDQ0SW9lQkhwcFc3SmJHejNnKzha?=
 =?utf-8?B?M2RaQ0pFSThUYjFOU0VXdDB1R3d4RG5sL1ZQVEYvTFV0SlMzRE9XLytXNzM4?=
 =?utf-8?B?T1RQMDZLZ3I4M2llaEhBUGhsUWlTdkhpQ3hUNmduakJqUmJ3eDBlSGdXb2Rm?=
 =?utf-8?B?YVczUmJTTW93KzRYVHE2RmtQSjlKTzZqaHNtbUlMckVxRkkxNE5aZkJGNTcr?=
 =?utf-8?B?WlJEQldNOTNXNzhFQzB3eE5vdTMyVzgxNFpLK3lBeXFwYnovQ1dzTkhYUko3?=
 =?utf-8?B?SXY3cFI4U2ZDOGlqcmlOcUNDL28zc0czQU1DWEpqa1hxdDJGQ3BIbytveDlV?=
 =?utf-8?B?d3JyR1kxdXVQVnExb2Jqc21QR1RPTVJRK3hjSnFZQUVnbDVoc1VuYlFPWWE4?=
 =?utf-8?B?RDJKT2JPVUpHZ3YySlFIYzNxOEhMVzNUOHN1Y0dwaVkyRTRUNEU2anBUNkdC?=
 =?utf-8?B?YXdBS2FyMXl2UFptS3F6Ynl3OHNjY3I5Z1hwalJ0N0dvL3oyaXJDWEVldEQ5?=
 =?utf-8?B?TUxybWtlNUY0QzIzM21jYlFkOUdVZWdtdVU3Q2FiTFVaYWRBd29CZDM0OEpH?=
 =?utf-8?B?RW8rYzVRQXJEZ2xyT0Q0SkwxSzJVT0VjOWFGUUhLVVMzcEZLVGltTkM2V0Zz?=
 =?utf-8?B?dXpWSjlQTzhFUU9kTEhCTHZHOWJaRFRxY3VnRUpHQkwvMXc4SUdSQXh1QUc5?=
 =?utf-8?B?ZzM0WktHcFR1R1VVT3pDdEk1WUU3UklrSDdrL2k5bHkxWExwaHpWTDQxM2lM?=
 =?utf-8?B?VVE3Nmw4YmdESHYwdHNpL2E3ajdUYnpLMGx5Z3RRc0pnWHBVMjNNeHpjOG5G?=
 =?utf-8?B?cFRkK1FxWURWcWVCOW9mYldqaTN2Q1htbldTajE1TTJFZDBSYjVxZU9uQkta?=
 =?utf-8?B?cCtMNkgyVE9JQ1htcmZpbFpsMTFNcjg3cGlIODdFNUZUWEwrbXIvcEF1WE02?=
 =?utf-8?B?R0lENHp1Z2xNblJTQmlTNDlVQ3hGbXY1dHNmaU5wMG1Ya2NURWNlbVlvOHJL?=
 =?utf-8?B?eVVodGZtZnZJVDk1RnBYTys1Uit2UHRjSkxmM1VrUFBNeERSWk9WbmFZUUVq?=
 =?utf-8?B?dDdoQVhMa0t1VEFnY3JlUWZRNldIeWcyMHkxUHhHSFA1VDh3bU0zY3Y5L1d4?=
 =?utf-8?B?NUF5MXY4a0JibnVIdFlvYmgyc2lKZzVtVHBCSzFDc2RYMmd1cDVLb2VpK0k1?=
 =?utf-8?B?OTNRR2JwcWlTQVJTZUY4VndNN3NuOVlwWE4zR0x3b1RpQW5Xd0ExMGtKWlJ4?=
 =?utf-8?B?bTBYdkhGMnNyRVp1UFMxcFhMODhodldSS2l5Z1VTeGdZNCtiYnhnUnVwWG9P?=
 =?utf-8?B?alZEdTBjV3NjbG5uMXlKM2NSOVFDRCtoa0ptVGZKS0xVVC81Z2JGa1djL0NI?=
 =?utf-8?B?amEyMU9XWmQ1UlhQL0RtV0p1MUhaZ0NHSHNRTU0yY2NkZFdyM2VTY0o1TFIy?=
 =?utf-8?B?cnhrNk9LNmRjekl5eXcwK2lBMFpYNlRrc2s2amxENWNZQVNKaU1xbTh2eUt1?=
 =?utf-8?B?RWtvTG5JS2dYL0FOcFQ2eEJrN3ZER0xuWm5VNURrckZMNmt4VG83RCtXemdV?=
 =?utf-8?B?SVl5L2dRZzB5d0NPNFpZdkNoK3E2c2M2bUxTeVR2cTJwcmlIa1F0bkNqbGs0?=
 =?utf-8?B?dHo5Mm03alZvMG1ldXh4TVNRNWRzRCt5cWFnMjNuR09qU0g2S2R0NTFDVGN1?=
 =?utf-8?B?SlBrREI4YXVudlIzcnluc0tEMDBSODQ5Q2VXb1Z0V3dkM3VyWm5zU3pGZndD?=
 =?utf-8?B?NjFCSk1mNUdzektjM0VZRGpGUzFyOVVDZ2hqek9DcE12YkV5VUZVNVEzZVh5?=
 =?utf-8?B?ZXV0Q3hCd2EvSksvcFUwR2lrSlJ3ODV0WUV6VDNQQ29SMDF6eWlPZUZ3eUR4?=
 =?utf-8?B?b3BGSzk0QkVJS2JEVldkQ1RsRGI0SDhkQWJDcTJLMVJiRUZjYWRDR2xFcEdo?=
 =?utf-8?B?NWVjaVE5RUpXenM0Zm5sMm1rOXVra1ZKMlFJS3VveWltVU1aMzlzM1MvaW0y?=
 =?utf-8?B?SE41YVgzYWtPL09Wa0ttSHlOcC9MVHFHQzM5UkxYa2libi8vMm83M0FYSGtu?=
 =?utf-8?B?TXlEVVpyNUJvMUFPRlhTWGlVOWZ6MVo0TjRiSWRndy84ZUkyejFYRmo3eHlk?=
 =?utf-8?B?ZWtjZlRnWTRGRS9jR0xNUjlWbkMvcmdzMUZLck93cDlXMmtmcUZRMnVaOGQy?=
 =?utf-8?B?RHZxbGl4UjRmdHZXREFlMVVReHRrVGxSUUZtc2k4TTVPT25VTE1hNXlzU2xn?=
 =?utf-8?B?RkJGZGNKdDN6QTdySXVZa3huYXhiL0RDbnFzZ0pKZDRMT2xINUtEdz09?=
X-Exchange-RoutingPolicyChecked:
	qBBytVu7XguWZxCav7Zt/6RRbMaz7MFm5uKmQXphjYa6e5jpt1Y5E3z6gRhxaqrMzOQHzELiIj6cC+H81D+St4fX48lAzRYWiLRq5B1ZtTP7q3mQXRd1heMgUxz3H8n3GawziaizDl/HMQkdUJ+WLARjYNtkB2UU1CyaLHNaCeHSAMs7v4cTSGT6OdprGWknSKs+96IOU5V4F8zwuaTJXmkWenqXKF44THgd2uLoLvYUjFtyehpFPBtcjhHqRo0ENpgyXekvxNwVizJHKrOohpdMixyDbo2nU9PMFMSXEUgSCV+ezamg9AeYxP4oQIoZDbkZDDNAFAAo9R3nyy7lmg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfda970-61ee-4b1a-64fb-08def4931948
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:49:35.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jfshSJrF/3bZLadpfAFmzOs5iWf+2yPmszkergEAAxlFXmMzr3jjlCTTE5tvcaXVSk6CWJU1u1DlGf26wBnAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7251
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfX7BkBcfL+FVXD
 iLl/2eHzhms88PsRYCfnuamXaFe2sgq7FxKpaoN+ETi0N/xSIbcMnCDCokW58f0nD9awomPkSfS
 daRn1kvqm6v7xu5PpsPyU9A3/qe0TJ1mO6ZcWAHZ48KRwO8sBaA3
X-Authority-Analysis: v=2.4 cv=IKMyzAvG c=1 sm=1 tr=0 ts=6a75f083 cx=c_pps
 a=Ess5LnjAiV6zB+80YbJDlg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=Q0cO3I0drLZR6jgnCU0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qpTqj10-O43smSD6u58N3UanxVymG3Dv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfXwWV6pzN8zfYG
 logf8vfqW5RmrTyB6F+Dp/HjdXBnknfGt5DdnpHbAKq7pDPvLl0gh7IuGC2trJcUc0bWcF0EL4y
 tLRMmeycHhMSahmKgJoZc6ilECgs5/7rTw8rpf3Vkd8y3dyk/wNysfnPaVKPTPsqTymyCaNOhUy
 48ouJKC1lIbgEQHZndr8rCuQpp7QY6pT7gzQcjF+E2B4039gjdmeGOY8niZplvDJKGcwvtV6bvd
 cv9D6I8hfU2ygxcuMqpNTJXydJA9wSkIy2uE1V6SqL6kRwZ+TO6ssFpTLGgNDfpWfWcpYZjJR4j
 PUc2Uz6rsFaFOHJkdWWRbsg+BhaWjtAWGWszskj8f/m3SSnfnFP4mcKq9w1Mc5Hge6e/3nXhTkG
 hLH8cHRPxgchmuJ8j4I1sGox8oaBPK9KyCzxAHEIVhNLjslTCLwhOz4hIV2mI77l3E5JESGKmSI
 bbDfgnIs9q6OlQ5llfg==
X-Proofpoint-ORIG-GUID: qpTqj10-O43smSD6u58N3UanxVymG3Dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070116

On Mon, 03 Aug 2026 00:02:29 -0300, Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> The SPI Engine controller only handled the first chip select when
> asserting CS lines and configuring CS polarity inversion, ignoring
> additional CS indices present in cs_index_mask.
> 
> Update spi_engine_gen_cs() to iterate over all set bits in
> cs_index_mask and toggle each corresponding CS line in the assert mask.
> Update spi_engine_setup() likewise so that SPI_CS_HIGH polarity is
> applied to every active CS index rather than only index 0.
> 
> [...]

Acked-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
