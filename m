Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A5385D86;
	Fri,  7 Aug 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114178; cv=fail; b=CKjW8hlfMWVrjXTDuyEnFJxi5Pwer4QJtucwvCv/ELsEtO98wX+GnQwN0ygcVXKzSXP86efN1oAvEVBphvFm8HIyXIWFdpRT83HlLKecQ8AD1cpDnFTMDt9jXU8buOFUv29NDswoCHgAgTHm2N7yY1xjiz2B4BhjUrwSN2sATvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114178; c=relaxed/simple;
	bh=/gmxFTrr5mHm7YPv6GdMQtw9Si18TtG+btOAxE3mrzQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=GSayUFNE53RtzlqpnzWwA0/OAsWMWedUVUp2xcdaycteRDJU53nk1HvF2KU3jm96krd9m56t/FsrTvP94pOEjRYuVBf4xUW4YRkhqBUHy5SQqbLYV5Ox7Ydv7uuwUQEJHcSCAqCUqWll67CTI3Zs0MILTkT3qMzsfwezaXkAqe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CpgLq/rh; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CpgLq/rh"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CfKOO2060170;
	Fri, 7 Aug 2026 10:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=m/P5t
	jUmi8y5/b7HcbI23A7yLcKPDfNsLqClc0iEj0U=; b=CpgLq/rhvPRY3zqGOPjqj
	iT8IB71Q0LF93P5J3WPvd5FhZJ/zoPVGLIthkdLtpZ8HTzTxTLayHKlwK5dvIqrR
	XfAn5SroDyyoFDK35JI0QvBYc71ii+O+PZsAaK3UTBObKrYYDjAxj0EndbeC+bIr
	Tj2eRIoXQiqSlIhNWMN3L7af/tA7sc5vWwlIdtFl0G9x8yLT2cJp/HpIVLKu2Uno
	MtfXG/k2eAgmWJnWS6n1FRU3G/cfupNS6koNS56DOvW+KJ71ZYfaTF6z5fZS3Z1r
	ND49v6cW1lh3L206vwelAjAQys4KmSAqxk6hy9aJob05H4CevPh8Guro0R1yShVn
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fwb3gtd33-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:49:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbxpTxxTz4o5kht5D1iDLFGvUdbMKPMM1kpnwJFJBWlnp8ozccKG/Eu4hgS7QkbdAUZm/iRMBmH0+t9V+IhE02hs4wUDsqaXWJbf485FoVWO71B8y0LfC0hFlO/W4K/J7gRzWrJgQJzk/Z9gDz88yp8gOv4Ei1pGSF606BKQsJjTJIRM1awffraZRDwdPeLG5Zl5Rj7qD4InHw2N2LzIPSsqruBjHzhJbesNxzG3eRPUynTFMABUl++cK6qZ5tybCw+OODEXfZ9ryfwhvG0uZXKc5amVq86krXJ4/cTWWoBw4KsJ0S4hcSv706GKBEb/CxI0zBRND6yU4DWMuO8wEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/P5tjUmi8y5/b7HcbI23A7yLcKPDfNsLqClc0iEj0U=;
 b=TzMQ+TVHWQ3H+TCv39bl03oAfpjUHp/N1TNDTlYj7Xs4H0YQfiL03iMp+a9/JRUbSQ6wUil7IzXEd6UeIM3XYEIdQDSIv1YhRqywnte8fyNHMov1DDtC8t9hMh+NKeiVD4eCgrrggKQUPDZGDorF7YEoSk+Ls2HrQo9L+KPUc0zzQm+0Yk0uBMJH1o4xRVXnQL7l7SCacPnlRKjl8lhe0qDOg+IVMCxmj8cOI6CViSuwMiweXDAIUiIkb5HhkQ3b86fr+MdF/JxGHpE+lz02QlufGcb1fPqPf4/YGw67sK0Bd61LwnyHDlZLhlYpT47OZHL/Wqtd75NmTxfTkKmgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS0PR03MB7251.namprd03.prod.outlook.com (2603:10b6:8:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 14:49:26 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:49:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/5] spi: expand device name to include all CS lines
 for multi-CS devices
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com,
        michael.hennerich@analog.com, broonie@kernel.org, jonath4nns@gmail.com,
        marcelo.schmitt1@gmail.com
In-Reply-To: <897e40907207bf151f0f33937d48ac11a30a024c.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
 <897e40907207bf151f0f33937d48ac11a30a024c.1785725359.git.Jonathan.Santos@analog.com>
Date: Fri, 07 Aug 2026 15:50:22 +0100
Message-Id: <178611422284.552144.682342197592135692.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786114234; l=671;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/gmxFTrr5mHm7YPv6GdMQtw9Si18TtG+btOAxE3mrzQ=;
 b=u2txHsu12LfjJFROqrDVhksDqDHLk3s1dCCJSaE6pJxgfyCw0FirzIwLk0ztJ3B6GmuiDaU0b
 5P+QMc4O16EAp3k7Q33FwYvMAKmnIMuvrE+bX5Ey5RRxs6SmLO8nsJC
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS0PR03MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 80461b73-fe28-4c3a-af53-08def493137f
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 cNaHOBE643ovAebiFeyH6E44kHdMqOc3r5hYv+32ubuS7gKztoGDbA3lwqjAgWiolXOtrJnO3QRZxBLbiRpFisVBvGQenJ0RCL3OFa8n0jMK8XLADwnpVQ4gkPpxSwia/SH9n8fiCW3rA5D2kjaPcIOBSuLhwNOhnLrKv3SzjklSN8ht+YjYVumD0n+6X8QL7ECCKvMmGrnRyAT/h9IrnztGKXuSVl5skZgR2fqV9bd2SkIwD3zKQ3YMSK0rKfDXZ5qB0o2eEGqdp/0ZX6xRYjYZHvmxTq/TnpCXBtz5aGqFCv+zeojIHu6F+PetRa9BuPS+gDDDKnkq7kTLFKlHwpkGHeADrbu3YElSVnPMj6Ht7MacjJToiC0bmueAPDBhATh3/QDm3Wg9wQ1Nk+7dclWjp+IpV1EXuCsdRvnrFzlH+1mLEtRo5vMnt4NnU9CyomyXaC7Xap9HFdI5nZ5VOlDwpvleTabbmLaS6lu9uoE1QKtnE71QrCmlkCCqwoQfnS4mIUiBok5icCe/xe5jgUml4F7cLF2A3KnDm5clvpUHrScIinRt9CMw0S1A66ahmJRW8SP0Al1ilz6607ruW4SoV4ikO0246LE5fHSOJloDMSl+1qCvAoUCM9ZAnAsvCLQIO/oy5qMShXzTlLlvZDOXKcRYAJ1WaDKwOG3Q86o=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cXFvRFFMM1N1eXd4SXRTMGF5ZXoydU5tSlFGUkZqeGlIRDJ4M0UwVWNWNXRE?=
 =?utf-8?B?bUtVRXBUUldIVzl0bHlWY1RoeFhzR2hlaG8xMUxjeTVYVHI4Z002V081YlY2?=
 =?utf-8?B?T0pZLzdQcDZoM25ENEdyZVJ2N0ZGR3pVZ1BRY0o4bkM0Q056L1c5dUo0ajNL?=
 =?utf-8?B?NTdOR25kblVadDFIY3BrMDBVMU9nb21OYzNvWDhKWUhyTEk3R0MxeERoODcv?=
 =?utf-8?B?aWw5QSt1NWZ4R3dOaHNGUng5cUFEYkg0L1A5T0tOQW5ubDNZdjFGRjAwQmR2?=
 =?utf-8?B?S3hDNDFyNmZreGphMDBMMElTQWJGRXJOUmRaK2g1OEdzNFVjbHZmQ0N1T1Ry?=
 =?utf-8?B?RnlOU2VmZ2xDQVNZTUorRlQ0T1VlcTNoN2VhdiszS1gycEl3cG15RnkzNitQ?=
 =?utf-8?B?cFc2SW5QMTJLRVlxZ0lVOGQ5QS9mMmk0MjVrcTJEbFJJSjNLZzdGTGNxMCs1?=
 =?utf-8?B?MmIvRkFCSDdzeUs3ZTJaL0NndzZhQU42OWJFR2tDbW9uNVdYTGJjbE1BU0k4?=
 =?utf-8?B?bXM2czZyZnBqWFVOMzR0TEpUUlpJU3c0SXAzNHJ6clFJVlVIaEVTdXpaelJt?=
 =?utf-8?B?alh1bi9JZEJvM0dDTGRUK05jMmxad0RCVVI0UDVkRmJBN055QjYwMjlYa28v?=
 =?utf-8?B?anhxc3ZRQi9LRUZScFprM0UyR1g4aXdmWWVMVlRLS21JQkFQNVpwUGRUZ28r?=
 =?utf-8?B?SXZjNkErSktuM05yL0lnbWo1SGd4YVZWRndST3prUUFuRGRPTnFVWEJpOEVB?=
 =?utf-8?B?NTBzbUphbjh1VFVneVdNUEI2cUQ4bjFVS1ZZN3lZTmYyUHFlcXVaREYvWEdk?=
 =?utf-8?B?T0kyaEZ2UmN1SzREZ0REWUhtY0x1YmwwTTIrL1VtTXNEZXBPbU1yUUlEMGpS?=
 =?utf-8?B?U3h5eWNQMGFDZWNUb2lraEg1ZFp0cWN5WkVDZzJSd1N5TGI5K3haSkttdGVD?=
 =?utf-8?B?a3oxYXFNMXhYRWRMVE9Sc1h6bWRBZWxxSDlQV0Y2ZTMvRlJXQXpUZVNuWG9R?=
 =?utf-8?B?bFRHb1E2N0dwRDBQWHlJTVkrR3N6SFo5c2ZBNmxEVkE4bFhFbjdnd3ZPOHVQ?=
 =?utf-8?B?S1JTajN4NUhaQk5Iek1TTDIydlQwQjRIUGJMWnNoMktYbEIvR2xJYmpXNkVl?=
 =?utf-8?B?aE1yNUQ2dGdPZjROQkQ1MURMSWVPMGcrR2puQlhiNkVGeVRjdFFUTGNGb1lM?=
 =?utf-8?B?MzBXUWZBUGlITzBVMDYyM1dNRFpIYU9UbWsrVGE3TzNrTC9RQ0E0eTFMQlRj?=
 =?utf-8?B?ajdad0J5b2hSQ3ZWTmZzZ0NNTm1HQ1hmQk9NMHh2NEY2N3FtTXhJdisyWCtY?=
 =?utf-8?B?RUdZUVh1dStTT1V0RU83bVdCN1VvcVZ1eEZQZ0hxVUJQNlB5VTZLWHU5VFNS?=
 =?utf-8?B?dTZabjNCeUdhY0JmZ0dnc05UcG5aNTVodjR6OFVwNGE3T2hwRGs2Vjl3eGpi?=
 =?utf-8?B?dlZ1ZnQvSGgvaXErZmZpdzhaZTZPMmpxZzlzbVZkQkMvTDlxWUZ1aTVFcWRF?=
 =?utf-8?B?M1kvS3JVMHhYN3RTbCtGNkRqT2RUNE9hbkh3b1MvUTI1a0hndndRRm82blox?=
 =?utf-8?B?NzdONmJWcnZhM1Z1TEVBUEg3cHY5emE4TlpPQmpTakxWZGZGTGtGM0hqYTAy?=
 =?utf-8?B?NzZpOGNnVjhWMkkzK09BWHM3Nit3V1FRRFVhRnZoeFgvZTg1cVFDcDViTFdw?=
 =?utf-8?B?NmhmU3NnYWpaK21hcGQ5allWaDc5RWVkK2swNks0R21oU0o3MDdXKzg5c3B6?=
 =?utf-8?B?S3VwMzhsTDZnZjF0RzV1MGNtSmtMNnBXc2kwSnhtUGtWNUVWVWpEdlRYZEZP?=
 =?utf-8?B?V3Q3YmFaUnBZSVlMU1lZdFZiNXU4K2hVOUJSbkFtRHZyRE1qdjZwQzBoekhJ?=
 =?utf-8?B?ZGhWcXhqdUVKaWp5ZEhleU1tbVp0ZXlQWjRraUJHc3NUM0hsNE1RVTlKR29L?=
 =?utf-8?B?SEVrZldTMEtaNDVLYmN6TzFvb0Z5NkVBaElZY3hGOGhYM1RqYzVIYVFpQmxr?=
 =?utf-8?B?RGhwVmVwb0RwYmt1eEUwd29ia1FQaGN5VWtvWk9SR0Zmc3JFNit4N0srbkVr?=
 =?utf-8?B?RDVxclpsMjlhZE54NENrU0E4U2FsWW5oUVp3U0k1ZjkvUVczY1JGOFFCb2gz?=
 =?utf-8?B?WTI3RDFrSWNSL0I4NDdGb1hDU0crK0NDL01vRmRGYUhMOWY5eEk5ZmtWVWxh?=
 =?utf-8?B?Zlg2d1BiV0Y3bkZueXpmNzJncEhSY2VQcEdIKzZVaUZPdFdhY2ZDcFdoeHhl?=
 =?utf-8?B?Y2RkQThTS3F3akVDN2p1dWZ2ZDl6QmNJRnNBdXpHWG82L2RQMXFvdlNQTjNE?=
 =?utf-8?B?SDYyY2Qxb001TkxlWFI0WkIvZ2ZudVJ4WjFhS0RFS1FvQ0dMMmhRQT09?=
X-Exchange-RoutingPolicyChecked:
	MEz6Ty7dt9qulsVb8HaHudKFY9ToYcPP/su5NPvxTbWLTOyPdCGkyWcm+nj07E/cSxue50IwOk96bL4jAzDF77Tk2ZeiMD6cdwmiExJrfVJxoq6VqxK+gigv75w8/0RNoRm77n9HtcBuoY91/YDZAbjEDWNVgZXAjwty7OuZDynquUWneK1H2jQm5RL7PbjPJJGz7wzDBp6FCjYn/N7uZAxWAb+5q4SdarvmSApZcYQAmLA0mGfCRzg6Y7hHiUmKVn423iGMkSo6mfzp8/KMZQIhRGpg6VBSebmDqAGIAALMp7rQMfMt0+tn7DOkOc0QlTDzn6IMqLhcpIEEIXfK4w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80461b73-fe28-4c3a-af53-08def493137f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:49:26.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmwnBSVc7RkBWHmDsTMVwf62TE9ZP78kQFwr2Q+R9v3UyoR0KI9RhxcA8bmyOrb5a2ldodrs/ipTOOF3YBW/2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7251
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfX4Xof7dF8/Sf8
 4jTDVFt9+PBWSv1dE6q8pZJfNDACQOpHQScDTESkmOQoPb6xOAnoNgYHTwFn+epCFUeQQHn+JcM
 fYGH6GD4VcJaR7dPg7pis+mPHlouyEUNGUMJnwMamlg/q9jtvbc0
X-Authority-Analysis: v=2.4 cv=IKMyzAvG c=1 sm=1 tr=0 ts=6a75f07d cx=c_pps
 a=gS8+cbQEeirDoRw2OPG9zw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=HjhDrwHuf_q7IZVXQ7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 693blLn6Tr2niGiDan0qMco0OkbmlSVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfX0YEaCmB9tAin
 aZ/tAomMvKUjXeMR5XpQAg5Sva1hEtV/aJI6eD3eO8EqMtFEIi2VR+BhqRHf1WgGVmTAZ74N0vP
 SrRfSQJ/vgSokmMZIseZCGd8nHyKSIE1cEZ/Co3S2OMCrrOIKs5aAM9o/xRXzxG/VbIaPxNi6To
 fRXlDhPNPf3KEto46K3BwOcHdmbD+S1NNlDyivZo+opYF5og6Xx7fKdOXsKEVlJoi6uwRkqF8p2
 +qj2fU+04jT0kpeEe/MjJPo0d1ChfalwJKAxT/2j8UZFQiIMW29wj0ap6Vc16MaIye3+B0CNQ+I
 uyBAE5Hx5CLmwBnJ74P/bI4MKgkDHFG5EmaBQneW7fmQ0z6HcQeVeHJSL3Fu+PsQjoBAOrQNqIc
 8CmezjXieG63oFtvg/jLkSxqUoo8k08+wCaETM3qs0hpgGnv0GK/jErxEYp3+YguHSaf43JtT5u
 VRd9X/+c9pVT3j1XNaw==
X-Proofpoint-ORIG-GUID: 693blLn6Tr2niGiDan0qMco0OkbmlSVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070116

On Mon, 03 Aug 2026 00:02:02 -0300, Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 55fb96fea243..61423aee1525 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -605,8 +607,12 @@ static void spi_dev_set_name(struct spi_device *spi)
>  		return;
>  	}
>  
> -	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
> -		     spi_get_chipselect(spi, 0));
> +	cs_len = scnprintf(cs_str, sizeof(cs_str), "%u", spi_get_chipselect(spi, 0));
> +	for (int idx = 1; idx < spi->num_chipselect; idx++)

Why not unsigned int?

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
