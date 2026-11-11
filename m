Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403351;
	b=it8ATXHi/1M8cy71/MBZECqxidWQKsUDyqZlXKAeCBUH/hjTLRIjmUf8U41Ot1OBIxNB
	 AJMxBq+vVO8hQtNhhWf6wSpOanDlKgV2gaDGhZcbNLI918YEiGIpnbMv5s9gwqH+RMY5u
	 J7J2Lx26tnsxolvnu4yc2mzCZwG9+tERTAcbk54j9rymfk0Wm+4gM9EoLSdU8UANiUw0U
	 5K5YoDzq+J+nrMYWbLWHPq9n+rGQgIgTGdcGolNuRTu6CDTKE8Xm0kk70nIxpS9AYa1Vo
	 gD16R0VyadOJBrWX4a2Lea80MdtUHYj8r0vjFXPA40npK80VMOizTnJmJnwv2k1DDrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403351;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gkYoXR4oeTKCDWN130knzxGXSHR+p93v4zj9VeGriZQ=;
	b=vO0iJYSAv3Mssz8H9gk5qH3vaAgS/HGFEX8Wgt7FIYFLrtDOGMq7hjqfBTWfTld0Ei36
	 oc2lZxS1FlF410JXGIhTZ6Oqgfm64VGZkY2qi3jzdR1KPF2fY0ErTg8OQE7HAZGtdGWVX
	 pvA2qL23AS4ZQ6kXroeF64rTp3+zPUsiyGnKhnowur57N2YJXwwRlew09MarlU7wdExyE
	 hOEHTE5gQVT/SXoTVHkL2XqlcsOJT79XU2pJMqxZDdROZrq2vMFaKQt2ZgsYTAC0cgWHq
	 BZVgWbfJQCY9eZv5Gzqiu8TIEKTU4Kcl27qB+HE3H8/T/ELgbrLTUobWMdyaMEFDSzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=fP1Kfufn;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QpeNHXlD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4569606A326;
	Wed, 11 Nov 2026 13:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4569606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=fP1Kfufn;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QpeNHXlD
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCWBNC226328;
	Wed, 11 Nov 2026 08:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=gkYoXR4oeTKCDWN130knzxGXSHR+p93v4zj9VeGriZQ=; b=fP1Kfuf
	nVqfdvK4uKHjq2pr4y974LMmexiM3bAOF9aApHsH2O9XKKz2HRHZVY4qdbghwPlW
	A6unEDou4ueiEchImIK6sbqZ+r61bVDhemKhs2OvInk5Kl/EQS5PgC28RbAelEzA
	7iHkCoqLjPycYPTGqL6Duxg4P1+bIbulzuCPzcYIZqDspqWymU+iPbBZx73do+Sc
	fMUlHnglpkXv9qjsoRydNOKlMUY53JI2HxWk+dZ/S0gDpWUqz62BpLdPvU1jSwGc
	5eFlPKJTf0hIHLaFps81b509FE7lpSAoF/o+fShmXzAxx/iltHNUoLkrq7gbqnun
	5VHipEal5R8sA0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gkYoX
	R4oeTKCDWN130knzxGXSHR+p93v4zj9VeGriZQ=; b=QpeNHXlDJQdsiRTIKCx5a
	oNMeOcoLawAH2oO8kRUcS/cE/henPTdm6tPnWRl2UG5fVxwahX9Rc43PvAe3JnC9
	+74mE5c6hkjdS55Kb7m6g//TERoJt01jJRL27jUlqK9PnEGa2iuLq4LsQ/BreeH6
	/zUeLA6jcRj1D5vktIYIPPF+2odIGkd42LZaTj3E+KFBzWLGO2yLK6YRDYk23mNd
	GNOpclm3irLwAnbG79wxP3OhFFQa279f5QAq6hB3HUmRGdbfrtgpFtbaelJZIwiT
	p7hvfbkPHzAmLmB9UhgKiqdpkf0Ti4cxSAGAaOt2RyO02kP3JrAk/56u+dVZ6G0M
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvhw3aa6g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:21:52 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPAsCUmRehLqM2pCzB7qS2tmjHTuLdLi5FGviy/QGOAlF6aD+auMjdDgiRd0CbB+HG8SHeTVKx2seQ1d2T5QMRJi1ivsf99gHGKN4KWGwsyCs45l8NcDAMCo2woBaurrpOFcki5VxwufIV4f3wW9AioZkHfEsDET4R0/MjvWFZyk36exgYTW4PrBa3KyAeVaNGHmthJ77f/FnUKkFIdFl9zmdp/SEyo7DKPY2xvqdEET3jzdv1BXgLgpMQ8gpcyTbvgDmhDgjjJFvM+h6ZNOucNDov71qragLh5Ah2ZnRdaNtDJn+CZx9xhU+cx0pkY82qXtQ/2CGrlGk5jEzopmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkYoXR4oeTKCDWN130knzxGXSHR+p93v4zj9VeGriZQ=;
 b=LIevwGs2f26Yc84InV+anEE/gaUP27U8TKVICJuRYzLK7buVuDh1+ulHzJvWPKH6SURnXtcTO00y0YvQXM28vazcodRKzSpswRWfycb8Gx7UauKVY2rvX1Z70fBrHKGZEvXDuardPogWFNGKN7QsGaQR/Kw67jkVFSdPwpD+dL+sB7qQpC+ho6V4sMKQXtH2E0ar83VFBHc6ablCYsDoGho38klR8WkeGCy1lGDis2vu6fDsPuPjR2d5tqwwMm9bQFcnT0ThSggf9h0WQke79vm1P67mxyqynGElmEZWSasl+8dBpFv7/g6pRk7SG6Vz94aUznr2e9ecZG6Es5fGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:21:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:21:50 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:04 +0000
Subject: [PATCH v2 3/8] spi: dt-bindings: cdns,xspi: add clocks and resets
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-3-d339046ada8b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=994;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6vPUWTkiuH7IHpa3QYtjd2Ybe2PQlOYdxMDJKpHZJJE=;
 b=gj6aIPeMgP6FgMhRWGzJ3dh3k22/DpmLw5UG21rvSEvTVYVsamduAnFPryEmn5rZQccPnIw3b
 /Sq2MzcKBLxBBwbShMrY5tnLSCRarI5NDL6OLotknpnuISpjTXFosDk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::22) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 49e02649-b7be-46d6-3f2e-08df3ff6beb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|261021121427099003|261026121527099003|261009223027099003|261102123227099003|11063799006|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	sXPbPSdS3VzsUOZ1fohVPmmfEoc7Wu+6nv5Xtq0v4JZNOJi+RaDEfZSDdH/ICOALzFSzU/vJNLf+L9Ghv0Dv5Gi4DICDZcSXT1Lldj2VSFveaiv0nvWKt6MeS3WkiOFBTAUwa/eZWLzlWvziHoimmNNztTeeu9J9ozvE3pDFIsAfrTQ2Q45tEVEFBp+danx+hKdJqoNv/a2eqkmYi1QVwsw/A1w7dkoJmfDe0r3c3pdUv+yStvsv9uMC2J/giOAU0Vdh/4BZ3inNGvYOQpxH0YlefDnK1XTIK3976IieUODbyK5V7S3xJpjEu7Vz7LFqS973XSDBo/bU6QWq3uHP5G4OCslGjU3ovHGwBen0njMOg7wbUms/2eydktX382NXSkn5W9HrAHtEOOzk5SzCQjZqP+kwfmWDnSWbYnz1lNFfsE91TrpJ8k8uRvyUhIaS73LKtWHbKNwGaAbfvczxCPRvWEsGpXa4ZT1QLBSdUmulD5m9f4s69jzmkgh8L6YCntCprGd2XMwupoRwqhoyi9Jvrb7ou8CrHdttxQUQHJugDCrSAVbwhcq58S+NYOwotuG9EbUmnaTZQ/KrqRUqRWvB5KWOtrfGhNKNcIzHnM+Y+zt8O5GeeahLx5BDQ/ZZbebRsrdA4D5TO01BC1/0SEnGfu7Y8hElgmGZHEQiE4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(261021121427099003)(261026121527099003)(261009223027099003)(261102123227099003)(11063799006)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk9XdkFJMFpZSFVrM0R3RjhwbmNZUjIwa2ZKaXl2c09XNGtUYi9oZFIwRjA1?=
 =?utf-8?B?RnBZZWEyckRxUjMyQXRJSXJVbjZDU0hMeXh5Nm8vRE9FK0o1QXgwRm9WeFFy?=
 =?utf-8?B?VXlQQ1A2N2xMQ29uazlRMkdyMmUxVzQwYzJOSEdUdnFBQ1JqcjJoS00ranJF?=
 =?utf-8?B?YzA0RXhySWJtaldldy9mcnZLWEpzemtBT2h5bWFLaXNlY0EvcTdzSXB6SjNV?=
 =?utf-8?B?bXVtQnlybThUMzJIaGNDS0pyTXlvQ3RVR0JnaW4rS3liakYxUHhhR2Nja29U?=
 =?utf-8?B?OGM5NWpWVFpONDNsenh6MGxFekhjUkVqVDUxVGNySDRla3BTRHZ1N0ZHRnZ1?=
 =?utf-8?B?Z2x2M1gzM1pwaW1XQTRFdjhVNzVYQ1BTTXFRMGcyVXVLK0d1OU1ub2ZqN3Iz?=
 =?utf-8?B?RlJiL2o2KzUxWkZpa2RrQlBKaG5HV3FPM1hvemRIeTE5MGo1c0krWGx0bndU?=
 =?utf-8?B?K0dxWTIyc1hnV3phOUJ0K3U0RExSdTdKN0kybFlOdW8xdEF5Sm1vdnhxbGVP?=
 =?utf-8?B?ZzNZMUlqZzlKZEhBeHNYckVOR0V5L0RDai81VkRXRlRHOFI1R3ZBbHlkZC9P?=
 =?utf-8?B?c0JVUHZhQ0VXdEM5VTBYcW1jQml3OXJJdmhTdGx6QVdzV1ErUElXVFA5bzVQ?=
 =?utf-8?B?L0ZueTBadThGeVYvY0JPdDBHYlRIb09LU3poTXFOdjRFSm50Z3l0azNad3ZT?=
 =?utf-8?B?TU0vQ2QzR0JTWEhXREd3UWFJKzBJZk9MVFZpajUvSnNPRisrY1RGamp6TEdK?=
 =?utf-8?B?UDI3UGxHSk1DWTFtTlVoNGRyNUpvcUFCZERMeHo2dyt0SUVBVGZXSmhKaVBz?=
 =?utf-8?B?c3BQSXF6WldhaWdMRTlOYU5HTUFRcjlpcHNvRVp6cHJyTmp3VWJobGtXcDNj?=
 =?utf-8?B?cFA4TFhQZXNwbmlGTmdPZUxWZkFUbmJaTlFXcklpblFQNzhCUjA3MGc2RXky?=
 =?utf-8?B?SnQvZ3l1alJ2b1ZnUlJ5T0NiWXJpYlVwYlJuMlV1cks3dTVjWnFFQURDK2pJ?=
 =?utf-8?B?VGRmR3g1alQvVmlHSkVHb0szb0prdHhDNWFPVkxjWVFDd0pTV2VYZWFGOG96?=
 =?utf-8?B?TDFRMnJWQUQwUHhzRGdodkttbDgwSUlRY2ZEVWFaTWJnd3NYMGdHbXRsYUhh?=
 =?utf-8?B?bTZKelZyWmp3UENOd1g5blRJb0tQbUdLQjZYYUloSUt5T3Nody9jSDF2UzlH?=
 =?utf-8?B?aElTMnZqL003cUNUYjVPN2ZjWk9ZY0xaWmRBWDhIZ0VlOTlZVXdMVG5qYWk2?=
 =?utf-8?B?Qm1DNkswMGFWMzRzejVWYjg3bUt2T001VHBtVU42bWpOWmR0T0RnVFlIYkx1?=
 =?utf-8?B?U0NHTkxuNW85K1JUc2ZiNTA0eGFjNkM0Nnc0V1pUcE03RnQ0WUZ3MGVJK1Aw?=
 =?utf-8?B?Vjc0QzJkdDRYUDY1UkNiL1lIeHZuY2ZiWGFKL002Ui96VFQzVXNyVXh3bTAz?=
 =?utf-8?B?eHl6a2Jid002cXdiSEVIdWhYQXYybTlVSGVJQk1FRFZUam8xVjlLRWo1VTJE?=
 =?utf-8?B?bUh4NzN2Z09PcEF0enJFVVBIMnZoQ25KS1FLR1pJMnJYUDVTd1d5SnM1TkxY?=
 =?utf-8?B?NFFJSHh3bEFLQVdHdDZHYUwvVDQwYXVHa1JOMTFSemlvbEM2LzlYY2xQd0oy?=
 =?utf-8?B?cVlwd3hXQ1dUT1hFYmdRVi9USDR5VGx0VjdXbGY4OGdqbG1zaFBHRmtHd0tZ?=
 =?utf-8?B?V0RpYm9xWVBDanVrekpUd1JUN0dPZDZWbHhrYm4wV2NldlZkd3lLOFc1Sldr?=
 =?utf-8?B?OEc4UlZzeVJkQ3VoNjNLdXAyVlVqNUZNWnF1YTYrdUM0VU9UZlJXcHJzd1lF?=
 =?utf-8?B?WHA1VkwxK1lDeXJDbVB5Y3RGempQMkZtcFpmc1RSWSs0M0dmUmxwYjBJS3hl?=
 =?utf-8?B?NEJRMkZFODZtVWtkcVIvdWhkeS90N3BHTjgwNmtVTlUycjZpbStZOTdjcVNZ?=
 =?utf-8?B?cCtId0FPbTJYM09iR3JNTkc4U1QwZG45dmdSZ3lCaVdIa2RQKzJ2d0MxV2lN?=
 =?utf-8?B?QXRtc0VrVmJtSk5DaWFheWl3RGZ0R0QwdEgwV2M0L29wUzFicDNYcUx2WkY1?=
 =?utf-8?B?NnNGbHBvMElFaG1aVWRmOU9jNTVaV0U4WXAyRTRVVWUzbGJjeTNSeE9Mcjdi?=
 =?utf-8?B?TlNYOVRSbzBhNm9IZXJhK09INFBrQ0FpVXJhVGFiK1Z2RzExUW1tMlZuWFNV?=
 =?utf-8?B?Y0VYaTFHM0hPM1JlR1JhUW9id1RjT1NMTTljSEliOWFDck9KRjJ5bFhMU0Ft?=
 =?utf-8?B?U0hVanNybDh6UWRzaVRZQktDbHlGbzZmZmtaazBsNUI2eHFXbVh1dWlsYmk0?=
 =?utf-8?B?Z2RaYjI1Y1ZRc09VWnFnNnlzc0l5QnpZZVJIREhCMWdIM2dialFRdz09?=
X-Exchange-RoutingPolicyChecked:
	csmvR8ixLfyjMxaDbSLGAt30ZL67HaLeeBDVepaCGYUA2CxFZg69pyHTcGSomqpNN7RZjOOpeF4RHsGgIt6tqGm0Ed0009OA/fvHS37wW6V5WhuuHdKWmIgJfc7GbaItZ6oxn8EbAC1Yt6rDQq6GZC9bJT6SthEQ+/aOU67UW4DeZyaoTiTBpYK6Ca0WCukTGhhh2ixvVl1hTcDyfrY5U7m3/zJ9aLDn3GuXoIaQD3o2jEiObCg+Q8IKhj2P36JWh/rDr6gunliDPOAzs7j2xZ/vuVYkfBoOOy37ZfbwJn5jUjBovVpaDPUlPWK+91ramyOpgoWB3FfEVLYblPVkOA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e02649-b7be-46d6-3f2e-08df3ff6beb8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:21:50.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY5d3DKREU9O/+pZFLrk4U6Wc7qNh5UQB0T/cGE8HEdDLEc3dXM9fU25hFXlMb49HNi8AhPGRvg1fzsM1iLctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Authority-Analysis: v=2.4 cv=VJhIDNPX c=1 sm=1 tr=0 ts=6af46bf0 cx=c_pps
 a=sZdM9mINdKJOQAUOT6RFRA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=jrqF0TLIeXwg2e91BD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vv9seF0IVCkItoV3uKUwkn88SY7ZOLM4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfXzenTNED1gEvZ
 aCHBpOqsc0i8TFrMVvpCsUFU+MZ5uHGD6lR++Pt+lKFISr/apHDL+8cIykH3VXBrO6OvviH9yU2
 lZr6XBt33RQTZCQEXace7HDFC+BliRkQ8uV6FdJfhef/7z/MgQG2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX3qfcqtrYrq0R
 elAsKpmM8pSnxc6VWtrWcjD68dskMpQedu2gXbTDj437hFYahlDvlbYxRkeCWNW/XnRWElip3fF
 naNMm1s4bQe4nVtX0IP8zxLV3qZA4MQUD14AbgXY2EEJ5ukrQq/X3O4s/evkUWYdkGBkIULrSqN
 9m09WmbJIC3JDV0hJVeSE+fVTSDxP30yh3/i/GXjsjQs5Ot5wOezeJcp1Og+ql6gH6xpxT9YXp+
 YYjZSx4sUCv3rKDBMd1sgX8hh/QnwNog8YQw3zcgqAspQN5KQb0t7EhHT0uJ/m0S/W2qwwPc7mW
 bK0weDGfy3siPlEuTmBqbD0A45zlX+Jnpmp3Say26YTcMq72cYrBMW15HQMKEIDUXvzeoMx3BuN
 yglnsH4E2JDBw7rbpP074jEgMcLOSK/pi8KUmcq5scd1YGUShhphiRoIQEzaa1jDdB/6CaBMgBN
 fKD83+VmAG+onVgoByQ==
X-Proofpoint-ORIG-GUID: Vv9seF0IVCkItoV3uKUwkn88SY7ZOLM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110053

The Cadence xSPI controller has a reference clock feeding it and, like
most IPs, a reset line that the SoC integration may expose. So far none
of them is described, which only works when the firmware leaves the
clock running and the controller out of reset.

Add the optional clocks and resets properties. They are optional to
keep existing devicetrees valid.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index 38a5795589de..3cd7321319bb 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -40,6 +40,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.56.0

