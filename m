Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403351;
	b=EBP0NMEfLBktbRBTImie7Fe9mTdiXCpaMQtuU1bmLMrWk9lHxCqIlC5vmnJtzMH7U4Dv
	 1R2WkXQ7gSzBeSNJqd1m5cYOjUft0JXZCUvcmsm+p9eA9n1PCCoo56oLcYPw8gInjzyMB
	 v27GYFx9fL+KQmzSFmHn0CTim1752XklcNLvcSpWgFi8uU0jP8XpTGQCFKyy3Ap1Ci90Q
	 sLv1l4zev0SdAASY+WcHMFMBBCoOqjF8LhoGzrDhhH7X6Ur0Z2Hy9HLCGMyehSisJpeqe
	 EqyYZ35xs8Hv8ABBXBidc3D+j2RCkDmuEb9VbB4BBkGZY20jXcDxQg+O6kMmVa3Udaw==
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=N6lX5xDRE7N6F9+5G1Yb+2nLVY+E/EmRnR1dWvKdLI4=;
	b=2xjQjKchtRYmpZ8x8y0LxrDjdF7bGYCo/vNqbPJXXXwNechBex2B9iMpt1KZmftLCRPD
	 7hkFkW3zUOnBcViVs78BQLBhusqteFTrwJ1RrGjOKkiQVrOnc2Q9UsaBAPegPXa308ag8
	 yzXGHzw8L5U1k+1zO3tXMmr/0lEtim1/Ixq3YzSx9arcsefJsSjpor3Wb8cfOkjhOskPU
	 axXK+1LIzhZ7WfiFEV/pBNcKbVgAYZZq1O9fqxW2GQLAaNA8jYrGv9y3gcTEghYTaWRPL
	 eVmOw3kXdkgDOpxTpUq4HlYgFmrIX1vGeRaRVLTSxkD+jSXGd+55od+b2OWBVue1b1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=urepYpIj;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="eX76EE/S";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A1606A334;
	Wed, 11 Nov 2026 13:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB3A1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=urepYpIj;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eX76EE/S
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCeRij1010435;
	Wed, 11 Nov 2026 08:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=N6lX5xDRE7N6F9+5G1Yb+2nLVY+E/EmRnR1dWvKdLI4=; b=urepYpI
	j+gwLTFzS2Jyg7zH8ntNz5GWTq0lIk3oCzqNrYvzXydYuR7Lt/lY3tEAD32m7jHG
	1wuf7SDxZGCRwuoN99OsYQtaon4oJjZJ8Q0buSgDrjT/6uEk+793qYHTiEh7/NZP
	8nJGUN9odATTrAmWvVnqjVu+Q7SpDGBmKVc9Fnjhk0m44H131Q5LZo/tABTHVuGo
	4FNvf/JqnZDzfufHQsb99wMSBhyvz8WieL6l6djunhP3awixmeO5yYNYrhSX/ty8
	2vs2wkR7XtTt5WsQ8ALTsNYLOzkf+ew585/Gnhdb41c9piN6ASUhUgUyk8APkCHK
	hDNmLDhQszP6zfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=N6lX5
	xDRE7N6F9+5G1Yb+2nLVY+E/EmRnR1dWvKdLI4=; b=eX76EE/SORlNVZVFAGh9S
	jAoTr5/IpVF9C0Fj56BUxBOGAEkTz82lT9HowoHrVk7LjIBMXqV3AJqOquKLtzOd
	AcF06MQ3Bck5SE+l5c2HZjh6dG4fGlbGJYY00K9+B/v06zVZzurC9/+F6It+3Pzz
	lEez+WDT7PirMfGVxx7MgyRJ+hIVi78ZCprvP40z57pme4p+0/u3XVfAnjBRU4Ia
	n1ysbwuBky75BY9XoBZ0Wq0ZhxUDS1rgQ4QL0YbMSKw8S+AGK3GLHNu+2PYLQeOa
	U/t0rhEElIN2+M3W74BZLXCl0wDimXSBGzOwxQNAoWf+wwg7N3Nmup0l2YJiBNdF
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvrjx06nq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:22:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYqnHtVpRNKkDH3duHB6I+rZy9Hr1IEOqp8HxqFf3xGvtsRPdb4Emht7s5mqR2qQUEHiilXOlftv6UjKulLzixB5Xk9CRjkKEuDEH7PcWf7XVB7IGc83w7i3ChgJ6L55FAH9rhpx15tbxdmNV0sO2OaluvxPMbGSUeBy4ecpq536rB3EEpiEhQctNgcNFPkt7lef4IEnF75Tb6lWhHfJZE5j7vkEwNjVcpd0I+IWaxiJZGv3/awA9DEx5cuAIXUngYnk3kicG08jT4lC98HNN0dIdpMhy8tBBjq4NKgAkdh7AlukmbADYXEeACD3iVJf6siNJaC1J7LaxBYwZvZUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6lX5xDRE7N6F9+5G1Yb+2nLVY+E/EmRnR1dWvKdLI4=;
 b=vjN3zL49Eb76x1fVocetuIglnJojQsJsGXb5FEHCo6YhWCoRXswsGDGhJaj9MtdaNVpW3b6+NfUsBNB4HxmC+Xi/jdMrTrXsWOlNg29THIOsfKfukV+xgPv9woM7EHEXbD6Be8M35B6CK7dq6VOOam9z9/RwmPA2VbarFRF3rzoW0qsgRwLGq76D9u9B8rqp+NArjDx0TY54432c8fVOCKcysgb7Vd0FQoiwiaPa+QMF8FAgqWsvrB2KTQlaxhIfEzmyE/9rv/XTlahJLGMkiy+N+3cOHuJi8q8+w4vNl0zjTSLBAnsqNbog0rnTBaIdNR1VaAtZCldPgCI8EJKOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:22:05 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:22:05 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 11 Nov 2026 13:23:07 +0000
Subject: [PATCH v2 6/8] spi: dt-bindings: cdns,xspi: add ADI SC846
 compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-xspi-cadence-add-acmd-v2-6-d339046ada8b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=1330;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rUM6XL/1xJn4dokycTRmcqdilSCgOUuTs0WKkHiJpsY=;
 b=77A+lmxcyazruooo42J2wE0VHXLnqi7dsrA+di4KNCAPe8g0iA/1QeB5mdbHDis5EcIOThoAN
 Zr0PydZS5d/CoUmSlluVj5qswjVfCeMBSILPZ6qvY1Zi4OekWAzRZGx
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e893d51b-9387-4cac-5802-08df3ff6c744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|261026140227099003|261021121427099003|261022075727099003|261026121527099003|261009223027099003|261102123227099003|11063799006|261028144727099003|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	05F5uquIP0APlKlOTLubVUEiS3w3RN9sCkkgd8Sy5CpmI8pZVg3vbYvTwFJIwSIeZNVBX5yaTwLlLywAzb2As/WuLHWBu8X1gtIuQGQnct9IOyTD2s0Il8TobBQG9ZDKdpEqZiUI7q/4CgEuVch3Ta7lPHJXkmfX2Ldl+mL1YKMuOP8cioDa9aH7BsZ6keSpxKOkn97NppY5N1MnTrT8xi6PAkshr6RGKvRzfTjkJ0fFIbgvbb9f/uEwPjFLKXcJP2woQv7uT5LkdPNiiw+mf/P0rGqKRoLDHdleEnEd1QqYtOt9X5k0q7xLDZVGLmfl0g279BCaWt4Y8FxNv/sr6Z8+ZMWoLZR0N5PZ5dWEQStXO1Oe267EOBcCr6u8dDmm2WR4MDaNsyC6tCEDxO8Iewh9R11T7nMxUtlkXPd+ZfGshIQ66vrsAyJEHBa5B/JZll3el8eEXZaMi82EezSHNNANEkKf3+HgXIA48BGYTBR6Bn2HqNiRzc9HpgeQ2VEZz7oIpA3dsEZ3WEDIVGF3DmzW3e2zklcdeR+xFLVEuf4QpdlqqTlZ0dJQEJmuRJStsKZ1fILDVRSgfE7b0LfHjkqnchlImQmxrfdxRE5jdmNhdoJpjN3O5kb0Qj2uTnxNV6AQz6JzKVi6cl8nQmz+pgoam9Xx8lhVvBa1Q8F2ZAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(261022075727099003)(261026121527099003)(261009223027099003)(261102123227099003)(11063799006)(261028144727099003)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHAwRDZ5OXBJSjdLQWh0VTJ0aWNVRDFLbmhydlh1bUlZSjlBT0RwSUV1NWh2?=
 =?utf-8?B?bXJZQkxjcDJBd2J4VTRTTngyR0RMc1pwOWd5M1FNNEZlMDBoQzN1N2tWci9N?=
 =?utf-8?B?dTUyMzEwRm4yVlFIUWxxb1BZdXhtd0FVOGVDSU91bnR1cmV6MlFXajkrVXI1?=
 =?utf-8?B?Y1kyNUpORE1VRU1HMDNzK2I4NDdMdU84K1Bob0JMcXlBRTk0WmQrNGF6RHZ2?=
 =?utf-8?B?bUh2RE02YVJjRXFXV2Z4dVoxLzBkWUFNM1o5MHJqQmNncWo3dkZYY0NTR1Vv?=
 =?utf-8?B?MXNPakt3ZnNTTSszclFsMlVBWnlmNEpOTmJMNkJxSjA1akpnRzNaYzN4U2lR?=
 =?utf-8?B?ZWdDOEtqQ2RVRkpESWdndW91NlQ1S3hBTFhiNnQ4UksycWR2VXpSMFBsaDR6?=
 =?utf-8?B?YmZwZjVTVTNkbmtoc0VzSDlycnhGdVk0S1U4WHhoYW00UUtVV3JXaU10S2JJ?=
 =?utf-8?B?KzVpNzBpNjlhMlp0VTJiYjFGcWlFYmljOGt5MmRIY3J3Ris0emJxUWg0OUp2?=
 =?utf-8?B?U3Z1bGdhaEhoOG00MWxnbUZiYVRrQVVzVlFqcGMzYWgveVB2dDNEZlRsOVl1?=
 =?utf-8?B?SFF3b09YNHRBMUp6dnphTkhQKy9JSjZFYXd1MXlycmFBZzNDN05UV2ltY1hY?=
 =?utf-8?B?OWpZOWp4aUJ0N3MyWGNVb2kzdldtQ3p0RkpuTHBxZWxkWWlhZ3BtejRMRjdT?=
 =?utf-8?B?TzBTczNFcHR2bFJ1c3doempCSFk2VndDcllZRmVNbUdsUndIQ3FmVUlWK3c4?=
 =?utf-8?B?SUdTdmVnL0Z6Tmp2ZlRFenpHaWlOWFNBbFRxaDh6djhCQ0lPSGg2T0tlZCs3?=
 =?utf-8?B?N2JCNy8yVkZ4MTVGREhhWHFFQTh5M3FRdER2ekx3bkhIenQyTnlVR0NWdTR5?=
 =?utf-8?B?NzlNT3B2MHNkWmJidTFScXE0bU9WY1gvMkNJTG5YWXU5cjUya2dyS1JXUldp?=
 =?utf-8?B?WElVaFFUQVJIU0RpSFpSTVlCWHB1eU1rY0d6L3pEVENVUGgvVVpsaGVBTWti?=
 =?utf-8?B?ZFVJVmIyczhvV2FjajY4dTNvZ0FuT3YwYVNEVlRhUUlsYUtNS05TcTFFMnNQ?=
 =?utf-8?B?MGZMZ1VYcTF0NGIzb2ZkTTE4Y0tSdU5Na3ozNkdBL2U2ck1SWTB6bVU0SnFK?=
 =?utf-8?B?VElsazFsVmJlN1hBQWVhcjFycjBDSkVRUWJEMFhnaHFBdDBTeHViNVZ2enRz?=
 =?utf-8?B?VlBKdWVzUXBFd3JOMEVScXliVXdFSDdSUUVvMDNaVEN3UmkrUTVwTmZaYlls?=
 =?utf-8?B?bEFjVlFGSndGOENkcFFrQzFzanFtTnl6Zjcva1l4dmFma3dheFcwVXR1QmJH?=
 =?utf-8?B?a1p3UlFIbkdRM25yT2dBRmZKaHN5akdCajlxTXBYbGNGdUxacHFpMy9JU3N5?=
 =?utf-8?B?ZU41WHhyWUtZTWsvc3Q1OFNPeC9FdWlCL20wamFJa0pMejRxTU5OMVVOdEhL?=
 =?utf-8?B?TDVWV3YzTHFpZXdTTC9HMnBkY1FDTW9oVkNaL2h2aGU2dVRrKzNKWVZPeU5J?=
 =?utf-8?B?TUs3RlIwdjRSOFBrU3ZXdTVIb2k5WVE2M1BlVUljNC9XU21mQzJMRG9IeFIr?=
 =?utf-8?B?YlkwWkphNm1tM29jUnN5UWZGUFFWbU5Sa3A5NU8wRi9ja3BPUllFUkpQNGc3?=
 =?utf-8?B?OUdiNm8xdDJ3L0E0VTlBaFNUZ3ZESHhxQXVGeTEvTFpiWlgrYm41OTA0NWV1?=
 =?utf-8?B?MTQyaXBUazZBNVRRUEhoOVpreWcrRGx0VjBhbEEwbUp1blpoc3VPKzZDQVkx?=
 =?utf-8?B?QzhPcnNpbVcwa3JpaWZpWHBtS3FrSDlTaVBRelNqYXNETEE1eGYwOEtkT08r?=
 =?utf-8?B?Um5QU0dtR0pEUmtQdHk0cHJiWjBxNWJXU1F6RCtLSTJ4WGZpUGxWZU5MaEZH?=
 =?utf-8?B?WC9qdlZWM0Ryc0M0cGRES0t0ZElVWStWNXdIV2pHQnp3RXY2dkVIeHplU1Jh?=
 =?utf-8?B?ZGtDSlcrYnNPV3V4NnBINmpXTkhtbVNIdUVrdjJJTjQ2eEhjS3g4M0tBL2tK?=
 =?utf-8?B?dS8zR3FTdi9kdi9DYWs4VUZMaXhxZldMRU5LUnQ0VkVaSkZ3WUdXeU1NQ0ZZ?=
 =?utf-8?B?bzU4NGs0RjdxS1hEek40Qit2Ti9mdlpUc2FJZXl6c01OdHpEZStxclZTbzF6?=
 =?utf-8?B?YWhtMTZqRjZrZmxzMFRxNUV6Y0o5bCsrS05xR0MybGZwY0FOZ1ZEL0Eyay8y?=
 =?utf-8?B?TmNSMUt3dmhiZGJrWFNCZzZBQStZUFRnL1hYR2hEQ1JoSm5pRnRtTHBXZDdY?=
 =?utf-8?B?QjcxSmZZUmYvU212TkJmOThTZjFKQ05nMGUyMXRyb2RpNVhSUEtndHE2OTZl?=
 =?utf-8?B?MGl2TzNhWDNGZXlrQW1OcTFZQ3ZBUitRcDlXWTlqL0d2bHZjbnIyUT09?=
X-Exchange-RoutingPolicyChecked:
	KtRGTV83VV9MjwuGXmKMcY8CYoA4wzE9FNotOBD4dQcWVbCdOX1KW6kZgAPW38YtsLqiv0+XtILtnlVadCtFGcsHTgej0Tli3twCmdocmwk4gQt+D2o1u8avX8Bm6IjPufEN8+47rd3719wHiy7nniaUBKRFx28LogwQSzqo4okVcZ7YdZpa2+cKjy8V7qu+W7NCpgLLGn/QQwXS3ofjgIplXPFLTKZh2yLUkhrE5LGOWnvjU3T4/kabrMcxHFhKwQ0MS3fJOsZMax0D8rQSYxZBdUxr2dt6x8Sgfcv2UeJKNQDm+gLV7S5GkmGWvMl2brDzOK9rAqiwIcPM6fpM3g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e893d51b-9387-4cac-5802-08df3ff6c744
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:22:05.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HrUBq0CR8csVsFTQ37i5AuhS21IlMvd5wbgnOOA2Mr+A8fgBBkjkFS5XPzCWJIeW/sobRmjSXupv2KK+rq0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Proofpoint-GUID: Sx_ff6fX_6dcDvB97_5Wpbtm8C0oaZbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX1RKAwKKtVhCy
 f7GSoUy8RN8I3YPIG01Xsd1P0ecMmen9MdW52Fey1ShPwIfsquraZcEDvxVZnnb0suzu+eXDCCK
 MgUS5cyTVtxQnlSHQWJv5h8msv5YvFLJTQrsvK29MlCMvLjNTBIGxlPHYXn5y/mbAp/FnXKNMAj
 TPnIB04LWw4l+CW/CEVfBfq/xLyNgUvBj3Y5GsTRy/3IoatkTDh8Nm9VrI1edQa0ku0aQQBg1Qn
 oYYy5EGZBSyV0Uhm8IBOlQb75zRl6YkRrkCINeh3ID8eDuBtl/vCN11vDWAlHF8OFZqjEv81Xgo
 8iL1OZRlRu0wSuvor9MYomonLtKxNeYYN1DDJZIVGsZnc2HbkMjhshp9gbViJoFCyuwGwMf3tSY
 dAW/go7oiJXKud2zSbFM0WIstUGWLGK9ec7T4QR9Yjw921e8oAW+2ulwKH4oYTRPZYOksCYUf4j
 Y44Z08Aq41OAbyYGo9Q==
X-Authority-Analysis: v=2.4 cv=P7KvFSAu c=1 sm=1 tr=0 ts=6af46c01 cx=c_pps
 a=qSo88s0AsKk38onbse8luQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=xcO0IeydglBJy7VQheAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Sx_ff6fX_6dcDvB97_5Wpbtm8C0oaZbI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX18WUK0FHQepv
 5SPu4dl7RwsOZmrEK0PAxq9jJcLWX4dlYXVecAua5NV5F++3ldjyz/OSZivLhiPTr3wAoAB37Lf
 GBbwrlpxbEBq0DhqHyZsm9hVZ0YbYaYspvfNxni5Xf8QRJSjzoC+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110053

The Analog Devices ADSP-SC846 SoC integrates the Cadence xSPI controller
with its own PHY timing configuration and with the support needed for
the auto command (ACMD) mode with the internal DMA, so it cannot be
described by the generic "cdns,xspi-nor" compatible. Add a SoC specific
compatible for it.

On this SoC, the controller clock and reset are always wired, so make
them required.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index 3cd7321319bb..d6ac05b2efb4 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -18,6 +18,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,adsp-sc846-xspi
       - cdns,xspi-nor
       - marvell,cn10-xspi-nor
 
@@ -53,6 +54,15 @@ required:
 
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,adsp-sc846-xspi
+    then:
+      required:
+        - clocks
+        - resets
   - if:
       properties:
         compatible:

-- 
2.56.0

