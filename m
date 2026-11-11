Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403332;
	b=x95yVApJdvIWWsArH6KSn8v8tquuJbrf8EB2n+jth8vdiJm3oyguIpWilQxaNyVe8Fz2
	 +vWriKkazn4hFM8DBr6YpPb9RSlOIyyXFDW49CN4fgs49gIbz0+u/TxDPKsC9FbkbdlBf
	 dCqiFL3TNej1tvXUN2+g0zoadu+BF4od3ElTLvmALgi2Zjc2soDkEPXcK5SnkjEFGRPoI
	 CnHE+gnK54EjvOZb7UbTT4vj3ME8Md3dC0Q71TLUsABXnPWUBOvAyUq8URVgeshcAva3S
	 MI3rdCc9gpGwPpJqbXmgn1/+kXSXls3fMSMCw1c5tjNZGEU+LsQIzBArT0HQi4wStdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403332;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yAmYKXjQGXK36mkmtwiOf5fRDspl3nnJJVU0ottRIps=;
	b=OefIphYeZnndZ0d+MkBidSK9ZI3zMsRhi+eSAK9qwQn4qNJ309CU6VVvyYPPsZ08f1aQ
	 tWKgWrSWeI/S8KTxphtAfk6Ajkzo6roR7XiqtUDOEyaJvIBR8vTe5Lf2cOPywgT5Yvx8k
	 /CjLo+fHe2wjKWKXg7Xm768+ASUuXdJbT7aqctnc4L5PACfhrBWB0fY0UtUT9EIjMLty1
	 33t1fKPZf7mBTo/vGEWyzL4l4yDmgg3KN31GsBo1qbNJ1pQOMDlzR4ZJGg0E7CoNn+zPE
	 Lu2u8cJNiiFF/yRLRKr+4AuB3a68h5iMSJx/uP0TfFYPLncbCRiU4g4xyCARQZIT2LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tOqGE4dx;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=P4uElkbv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD64606A31C;
	Wed, 11 Nov 2026 13:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD64606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tOqGE4dx;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=P4uElkbv
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCeR7e1010439;
	Wed, 11 Nov 2026 08:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=yAmYKXjQGXK36mkm
	twiOf5fRDspl3nnJJVU0ottRIps=; b=tOqGE4dx4XqKHWQkMc+1VkHQ8t7Qmgdh
	mwGnLZNC7h0uQRgmEzMqWvJEeGaUNPzhcuk1nYIZN1OIVYWLDNQmaqLIz48yAZ+S
	ghNT86HZOI8K4spN47GEjPRFI083+vJOO3BCraL8NJr3S9fjZPI0gXti40jYwJgl
	+HXB6Gmw3sx24rOy17bMYIIqldeeJxUJ/pH+1q8EdpU5MgxZk39Q6UgSBRd+RCc1
	GoDbJVuPC3gC6FKz0gQGaDMAgHhahOQoEn5yIWAB7QhRyxKpygGTI9npsg9gDlhe
	MqMSrpfrHOEsyCQqTLSQaDiqi95dKYXRVZHqZ25LRENrfO2+lkTQFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=yAmYKXjQGXK36mkmtwiOf5fRDsp
	l3nnJJVU0ottRIps=; b=P4uElkbv3XZLskgquvBJpQQ1mSIMzTjEIHVbvRBYPWy
	qJ9P3A5unJNNxStr2/9VeK+nPEImoByR1uChNn/98dN86HDvF3caxdUeEl+OWwXr
	Mw5Wu3BhxJMJofXAQ8hJVDNcfdsXE24jp/yRKS7rJ4YEN9N82taIrl0GN6z409VN
	cboMVc9n1VDTCX4bhTXWVPYdKgui/UGLFoEJnNcL35tt7qnZD4MKEppu9w+4v4Gs
	5utzy1mLAcJujgGiGXWVX/Q4f67sraIKgFB9p4/sAdLaV3caTygZ2nAFDaRQGank
	YxTiwiskjNWe6mbFoxu6CmuUXG7lIgm6fHtq92HfoGA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvrjx06hn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:21:42 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq2ZEO9EfWwerNVwTGr9gEhu7/bjlfe4C6CWPaweQ8JmTHD/rg9eh+vockWA5HW0fAT73Btx8UOR+U9b6ZomophPnQ1DuGwCHJ7Q97UPZWrzZLzz/8fBj7qu9JE1phwVabErh8wXRPuwxb26zkYHrPhU+kIx3DpHw7VJoHp4hVDmuWd0thZlYwEHoDviGbCG6xutLv2f9gmr7Oe2vpYLBBXImQ6Xk6lspTpyBNDm7NmL05yNf4o9JhbxrUjgVvgAVMr8CzcGAdQqpmJKiRpp5Nel6JmJVXSMr7QcDpUYes0cYz2MgkofXjR+7M3pZN4P3FC0gMm+WcnkM6jE9mhhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAmYKXjQGXK36mkmtwiOf5fRDspl3nnJJVU0ottRIps=;
 b=wtXzlTvc2YRVhffoFauO09kvhhiRETkj56krkkNAhPtOhPGSW4s58Ghla6XR2yXsr5DIgJpHPT0WUi3z1pbduTdx1mWVeTf/IEP09/rCH0NloDWDX6SqUyEzx1VcncuqYE7hoCT9wcLsix2WGb5UfV0e2eBwzQ87DPfyNwoEqBd1CTTsxDwFgcqnqRUkh+whPQdPgGHqXF3cL+mEJsf8ymQMUBLDHx+OV41FpjzoQfJnQscYDcWQ9OR5iqoDT6/QmpTU+7TMxr1FbJqbI0s28sQqNieXuvHQ0mY0vWldKP44Ywv+7OhAb2k6JjDjxPNsB4zuVpDTLUl/o/ptXyKFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7348.namprd03.prod.outlook.com (2603:10b6:806:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 13:21:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 13:21:38 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 0/8] spi: cadence-xspi: add ACMD mode and ADSP SC846
 integration
Date: Wed, 11 Nov 2026 13:23:01 +0000
Message-Id: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0K6dkwpFYMr7mFYlOkAY6QlLRIM4
 e4CxqXLl/z/3iIiBaYobskiAk0c2bsN1CkR2BnXErDdWCip8lSqK8xxYEBjySGBsRYM9hYylJR
 phbVutNi+Q6CG58N7r74cX/WDcNxl+6LjOPrwPsJTuu9+jeJPY0pBwiVDq3VeSJK6NM48fXtG3
 4tqXdcPgRZI080AAAA=
X-Change-ID: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794403385; l=5855;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oa9txaHmRPXCSX3V0Ky2VGpJT62fpXHcEnSzFf2IRq8=;
 b=L4e4Hsb/moBnCfkEGkoQyPtWPDH0PcXFKjx79hTlnqdiGHxh9EfIt6uQDXgy+26eqr2CE8XgV
 qglhZXaghdgCSUIz50mSqbMMNgZNKc4gB5f6t9czWVwQY0uexF2JkTP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0204.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 80b8ca66-caa0-4d1f-fa5e-08df3ff6b7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022105027099003|56012099006|261026140227099003|261021121427099003|261022113327099003|261009220027099003|261022075727099003|261026121527099003|261021123027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261102123227099003|11063799006|261028144727099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2X1GCqMRHVxwUggvdFxcWa/8CsJkIcgwbzy+ZDUThUcmYh2+LfCUM5opivPdUjTGxr2mVzAAOU1qbIVVYE6ptEFRfvY4oO735tqP82Gicm9cLCQ983/52g9C6KdOwT92c6Hr5j7u3gXi2rnlCVOzsktNIRhrrUWufs5OQIDVJYGzk3mHJmOYHHblrTzQi+1kbBH5x0KoNQWjnw4clHQ9aiZ101A8RR4rS30V8DlCq1avWU6hgzzMcTJpwczzRxxuXz2iFBOtyradHOTVIVkPO5YaksZp8OZiiEq9l7XANVc90+EY4MJ3/VXkcwPhOuVoBpsgIqniXSKlprWmitDhDFvFIIuAYie/U8H5QakwxmQBew7UiPc1IRTFE+KIUdYXqbR6oW6SQ6fw+khHQG2kmAGBj6R8dCYu0awgH4v1o5JCVIo5BNODm2G6Z53iwiVs5BsErsDZ17SfqPpb9+IHU+XkpJhTM2LmQEsv9v6FehrEGJeiU5q+0/NSrOhLxlbElR7+HAV83HFU4kSLDgfk7c9+u8O2JqtWtabyqp5qU5kt/YKHjei32Psi6TnYgwJ1D643DnuTLHyfb3qhVFYZnJzlLWV7lde7n8jEu+FKVoKYwj7m4UDdWBoYj6n1u7G7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(261022113327099003)(261009220027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261102123227099003)(11063799006)(261028144727099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnBXU1ZsMEVjd2l5djlPUHRtSDZqQTZqR09TL3IvWmsvZlZBQ3FBaDdiVDRO?=
 =?utf-8?B?T0w3UW5MYnRpRTY4V2wyaCt0K0hmMkpNTGhvN0ttMm1uUE1DYUcvcWFrODZh?=
 =?utf-8?B?bjU5UHliOCt1MkZEMVRqNS9IUDQrSEZRUnNiS0M1R25waHRNdUkzUjJaTlNN?=
 =?utf-8?B?NFlXNFZweDg4UG41YVN4eWpxWUpzRUE3blVWMXpmZFNUVVFvQ3gzQjF3ZThL?=
 =?utf-8?B?ZmJ2QllHM0FrN0tVUmx4QWR4Nkovb3FQMWpZMm1PUUp0MEI4b0xIVXk3WDh6?=
 =?utf-8?B?eDBVQnl1QmRMQjQzMmVUNDhPbDljL0Y5SEN4MTNuRE5KZVpqeXNwWnFodEdS?=
 =?utf-8?B?eVY0My8wTjQrR1FIR2NtYzBFc2JRUWQxekRxaFVEemVSMmV5Y3JzV1YrSmFZ?=
 =?utf-8?B?Z0pMbXpzelNWRzAvSGZvazl4TWlxWDR4UWdVaUxGV2pRbmdFaEs5SFlpaFBB?=
 =?utf-8?B?YVc2ZTZibmk3VlV2VlBKamhjcnNNNVBTZG9VNGhkajNUSlBKbVBBQmZpUkNp?=
 =?utf-8?B?N3dIVENJZGNOcEJmbnRJTTdtZ0FTWlF5OGE2VS9IQy9WV1VhQy85bnU2NlRO?=
 =?utf-8?B?OStUZm1RaUFvWUZyOVl5NXZNV2pXNVowNUdXTEtBaHRmQTUva3JXdGZhdys5?=
 =?utf-8?B?MHZuM09sVzRIcENOMUVTWXhPZVBtbnBOOXM3NFJlaEtJeTJENDlyMEc2SjFC?=
 =?utf-8?B?TGlKOGJrckdNQUdqbFhEM2IyUnR2R3JJVXhENVJ1V01CbFpoUGxmV0lHcGF5?=
 =?utf-8?B?YWcyL3BsbGFoSGJMY2xUMlRGT3FERUFoVmZQTkR4VnR6WmVjWU1CTHo4aU1T?=
 =?utf-8?B?NklIcVdXV0c3KzQrOVF6T21MU0sxbC80ZkxMb0ZJT0ZsRVhIOUQvSEU3RG0x?=
 =?utf-8?B?T1VyNnptbXdKSzNHaTR1QVozMmRjTXg5WFM4NFV0K0Nyc0RYc3BNQXNMUzFu?=
 =?utf-8?B?Z0d2ZWFCc2ovZVFpdW8xKzh6U3pDcWl5TEh2QzZFL3hEeEFMNVIyWTZLRmZX?=
 =?utf-8?B?WU1tOTdwY0tEc3hBT3VMYktZTnlnM3ZlNmpYZENhdE9oeFRHWkR0WkhQSEhM?=
 =?utf-8?B?NUtlYVlDOVptbEdsMXNnOWZyaFlJa0haMFQwTmF4SitRalpKTzdjdVcwajlD?=
 =?utf-8?B?NjNwRjg5TjJaUmNOZ1JnTDExeC91dTZkVng2bXNweExscEhHMi9janlyTjJo?=
 =?utf-8?B?STNBTzlLZDBnWFN6bWh6NTU2cXA0N05xUlRQTitNaWthbDBrZUxDc1g5SlU0?=
 =?utf-8?B?ZCtLVlVFbG05dTV0U2JBUnovWHYzR0N0akJUa1ZGUENZQnRCSm1QelNPdjVF?=
 =?utf-8?B?dTc0ekxVeHVFNXA5T0gza2dPa1VUMWgyWWs3TnBiQjF4Y2lQMitBMGcxbXU0?=
 =?utf-8?B?WXdjTitURU1sZmtwQXE4QnhJSUd0MS9QRHUxRWVKNHQvRzllVkg0bHRrQllZ?=
 =?utf-8?B?RFFCb0VEMXN0OHJ5WUVwb2hRRnpGOGFVK0Q5bmttcTIxc0xLb0dsVEdENVVB?=
 =?utf-8?B?bmJVYytkNXJCM3pXbTFaQ3k4eHFVRUFmcTJOeWlzcnRvZnNZaHlVUnpYK0JJ?=
 =?utf-8?B?QldCR2YydGZSS1lrejBQcnBTd1Z5ajE5U1ZidWxKYVJlYWxxWnhLK1NUQjJ3?=
 =?utf-8?B?b3M5NTFLdFNxeUtyZVcvanFOa3hYYWdTK0lKei8xUUlvQXZjYVNEc1JjZHZO?=
 =?utf-8?B?WG1wdHFmYzFST1NKR20xS2Vaa2ErNjVDRStMUnNXeWppZ09xRDk4ai9ya2ti?=
 =?utf-8?B?WnM2Ykt3U0V0WkQ2QlhCRS9wU1VEUGN5WUE5dE9HcUVOYlhnN3B5RkphcWR5?=
 =?utf-8?B?WWpEZEoxdFFHMEZZQ3g2M2lhZHdKei8xMnZrelJRcXNESUVWcG9iZGFKeWd4?=
 =?utf-8?B?cDJBbEtuanFCTGZhdi91REwrMUZGczl2V3VEa28wbmg2YjBBbUh1aDdnZGhG?=
 =?utf-8?B?N0ZldDFzN092aXprT2JFNm5rdnVicEJIOHMwSlJ5SXhtL0ZDZW1PZ0wza3VW?=
 =?utf-8?B?S0dJVTd5SVdLOUxYTkRQb2J6VmdLTWk1Zm10c25zZGtHV3RSSWtWK1lmV0pK?=
 =?utf-8?B?aWsyQnNCQldTalhvTGtna3p5Vzg0L2RaenpER1NlU25Ock41andXRVZudVYx?=
 =?utf-8?B?OG5RaTZjNWRuTUFzS2cyTlZhbmt4N29uSm5URmhjd2l3ZWc5RElCVmR3a0Fz?=
 =?utf-8?B?SWxaYzFMNWtFQWxGM1hFMDVuZm1TNjh4MUZLZjRwZFZGdDZqUkdwWTYzN3pG?=
 =?utf-8?B?bWZ0SVZDS2Q2Zy9qeFZ4c1lQeVVsQ2tVOVFtNEs4YTI0R0dod2RIaU1CQWh1?=
 =?utf-8?B?dzRPOWpBb2VLRmJTajNwOHZMbTN5NllqbnFoSkZxbC8vNEgxVlR5Zz09?=
X-Exchange-RoutingPolicyChecked:
	PjogpG0M8GHzhWjAn6b55W2TpyguHbFiigQUwnIz3PX4exPAfFt33AG0YDyIfROfktC1HMSPiQ30l9G5cVf4BmAy/WhRSLHkVrQC2ZxOsPONnvBewhksNLOzmG4RTbobmnzf/545BNYOukqY5Hujs7ccZDAJW2OfFUHn57x5026rYM6IfLvtez0wNjNA/FBuMFgyJsTlbRek5XP3AbnucV27kcPrO1wyBJ+E28RzAlFP0na1GryMBszS4//BsWoU39eVZ25UtggS6ab72ejANUpByl+181bIhnd00XnoG4jrRz4pJYVWjJBjNrCHonFMD+swQAJA83sAwewLCcIMrw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b8ca66-caa0-4d1f-fa5e-08df3ff6b7c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:21:38.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: En0hmvTCJM0EB+VBkvYlVyuIeQ48/WWUFNVkDTPXSHG6MuUPNrXiIM2kBH8OM/JRZbwQoly0YsOu4I9hFKHsUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7348
X-Proofpoint-GUID: VVrv_TLfLn6QdBnj_SITUUrhTKQexLnd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX7vi8O9RfYGM9
 aKzD4GkRRrx7hPz/IqbtPhJzXOLziLwpRA4nOLak7wgOOgHbQ7ykMDfeOMwulmKX+L58KObKS55
 TSMBUfYrTa8jGUQBba0Rz/WuDywfYuXjLNXquwzhcEv3sHsJQAjKjAU4PnWE76DvsE259Ebv5wk
 KymD5zafkYCcyRpS+q1Gbu6VVQeuxuOJypOaCHEZcHDFnXSmYQ/wco7njulogwWmSxNBcdeOV39
 tFIEq+HHEj46dC4q/1l3JLX3qEvy6L93zBoHVcWr7Vqj2nZesCu4r6W25MKP9ARsOEYpnchcBMS
 t2/loa0jVMXB4HiT+f8204UMXHpVpNPyP2qI2oly0renOQfG4aZ4W+QmmHcwvAU86JNnVmHyLEJ
 n7M/17xH107aJJgpMVkIcdknZhyA0g1kddP/RbfYjxGOkXR1zcXjZVWIpnjGYVprqd2LLfsclJa
 eMJhqXGcwuyYuy7tbxA==
X-Authority-Analysis: v=2.4 cv=P7KvFSAu c=1 sm=1 tr=0 ts=6af46be6 cx=c_pps
 a=To5YXH8t/p3KPg3XNsFgJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=6CiEp5VA-OZyjRT5JY8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: VVrv_TLfLn6QdBnj_SITUUrhTKQexLnd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MyBTYWx0ZWRfX+oPhHZkX5WGl
 AdHwhLsAOpkkCaXxbRVWefMDGDLd8c8AC76egKfs3ZDm7tE/ecpc04C7QqHIguT6DzYU70B1IV4
 WC0ChhhTv6j97k6P9ByKcT+hFhBBCwM24RWPLziyqYG7cJ/uk7UZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110053

The Cadence xSPI driver currently drives every operation through STIG
mode, where the CPU builds each command and drains the data. The
controller also has an auto command (ACMD) mode where it runs whole
sequences on its own and can move data with its internal DMA, which
pays off for bulk reads.

Whether ACMD and the internal DMA can be used depends on the SoC
integration (external SRAM, the DMA bus requester interface being
wired), which the controller registers do not expose. Hence, the series
also adds support for the ADI ADSP-SC846 integration, which enables
ACMD through its driver data. On the way, the platform specifics are
moved into the driver data and optional clocks and resets support is
added for the IP.

For now, ACMD is only used for reads of at least 2048 bytes with an
address phase, using the internal DMA, and only on integrations
supporting it. Smaller reads and all other operations stay on STIG.

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

Changes in v2:
- Patch 1 (new):
  - Fail on command errors reported without a known cause.
- Patch 2 (new):
  - Wait for the controller initialization on resume, as the IP might
    lose power across suspend (Mark).
- Patch 3 (new):
  - dt-bindings: add optional clocks and resets.
- Patch 4 (new):
  - Get/enable the optional clock and reset the controller at probe,
    waiting for its initialization after the reset.
- Patch 5 (new):
  - Move the platform specifics into per compatible driver data.
- Patch 6 (new):
  - dt-bindings: add the adi,adsp-sc846-xspi compatible, clocks and resets
    required for it.
- Patch 7 (new):
  - Add the ADI SC846 integration, PHY setup at probe and resume.
- Patch 8:
  - Infer ACMD support from the compatible (driver data) instead of DT
    properties (Conor).
  - Invalidate the cached work mode and redo the ACMD setup on resume
    (Mark).
  - Always report the ACMD error from the command status, the thread
    error interrupt only wakes up the waiter (sashiko).
  - Comment why ACMD reads are not size limited (Mark).
- Dropped the sdma_error to xfer_error rename patch, not needed anymore.
- Dropped the cdns,has-acmd and cdns,has-internal-dma properties patch
  (Conor).
- Link to v1: https://patch.msgid.link/20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com

[1]: https://lore.kernel.org/linux-spi/20260921093701.1341766-1-fei.xie@horizon.auto/

---
Nuno Sá (8):
      spi: cadence-xspi: fail on command errors without a known cause
      spi: cadence-xspi: wait for the controller initialization on resume
      spi: dt-bindings: cdns,xspi: add clocks and resets
      spi: cadence-xspi: support clocks and resets
      spi: cadence-xspi: move platform specifics into driver data
      spi: dt-bindings: cdns,xspi: add ADI SC846 compatible
      spi: cadence-xspi: add ADI SC846 platform support
      spi: cadence-xspi: add ACMD mode support

 .../devicetree/bindings/spi/cdns,xspi.yaml         |  16 +
 drivers/spi/spi-cadence-xspi.c                     | 530 +++++++++++++++++----
 2 files changed, 457 insertions(+), 89 deletions(-)
---
base-commit: 7da2aca123754c0e06092bbe179d58078b58d8d4
change-id: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
--

Thanks!
- Nuno Sá

