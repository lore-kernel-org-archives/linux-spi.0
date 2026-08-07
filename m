Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C18378D70;
	Fri,  7 Aug 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114178; cv=fail; b=d07+ZqvPfPTx2TqqOGVpTcULdkAZT7jnhVNyRs7UOLcklFziy/rhjRujZxEZ9U6BrsBwb/nTx5fgoaKYFEJFMvtVhR4tMneSFdMUZygUxwNruC3OWLpUXzeOMVuQks0sZ87U8kl3FbKM4DmvH+j6wZKYUmp2bQDgIuvLQaMdUxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114178; c=relaxed/simple;
	bh=6eADDyitJeVSUyOLnaFBRMCH9CrpOySriD/76QN3QKc=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=T9LsYZr41CP8id1a6kc82UIqlT2d3S1zLxGqI4VIjn2EGweVBKfukIhBvAVh+Wbr9g3QtNBT0epUQ7KHxwOdwxwCIilXXnS58KrcKP5ZcIR6uVMIb+t4tYaywuKBSK1U4FWC71fUY4O3JKXse082MZNd8GzvJ9fATm3sPrnt0xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OjFpyPNJ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OjFpyPNJ"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Cdh8x3924324;
	Fri, 7 Aug 2026 10:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sXJTe
	jCPKzNAkpyACPQaYbpS4iIYfq8bc4kfOUK9os8=; b=OjFpyPNJzlHl7g7oebUbB
	GbZi2hIsq7KTOSLVqgjBXo4iRudoDyQa68DJo9Uorm0wmrLsCh4RjaW6Zk50FDNO
	8J0cLwjvfBTSbmg6sDwlcnBE60zvurPca/CXX3Mje0ya8ZCIFUGLumx6LFO1tB/p
	Vm4P7ThQB6mRnnZ6iXIMRz7B4cgSnVTluglTUVuMhIJTk1GRiow1gxxm+rI/e7Np
	phjO4ro6b9dHM4uteCNFQs1ZCFxBtqrkuGqnYjYQvKY1owkg643it5pvpbCP7xyo
	AbXfNGdYKqNsCCa4AYIf5HpzXcgvLNUeyAzWCl0BCVKvnhfDeJVg1hU0BopeVHjU
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fwdm2s9qx-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:49:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV/plnxiUKXPmOA1hGiV3Hle5TdEpqqgpDBrtRlh4REANKM/Wj1SOREo2Y07iXYYaV9xzyR0LdS7ixXd4hqxQqLUHJTAWbUZd0xnJOK0/VKWjpQPXivg153RGcKDj6ig+pPc8uhJxbXLoTZIrup/D65SIGGfZgDEmVQsJm++hzhZl7BqjLwHYLD9V8k7DDkAQCtRm7KtNpk80H5RUlB7Murpde4j8xi2vHHpw6t/Vy9EB+UIl20Y7xlNMEhqcn4FzI41ZLvY2qFIxHHNWGir0iNxjHA40Qjl5XjpNXHgO8O+hUHn9wsEuQXxJtrDTrn9l4KUsBAlxelA1bIZseF8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXJTejCPKzNAkpyACPQaYbpS4iIYfq8bc4kfOUK9os8=;
 b=pKYdtwr1BPsT7tI/2EL4codDCMioc81/Vs7WMAn1oGzZKyEYP7Rl4aLT8RTMdtInIg8qjAS7vxFfVft+LaPnDQoX7NXk5v6mhPhU+Z0TFgecmN4ioC1CTRJU7zRMptKAZB2hdZJQLgdccqL9L0uaGf6bK8fDXfaRRzpQy7VOfapBfs5qxKn0HIzMYwSAV7Qivk+pmU4JTWpl0YIyPE8NpRwz+Jicd/1VJbV0Nz10RAM3ZrDhu6yljSu0kSX2Ket5QhibUoH28jFGzorXHDCV8GFtgdvpQGURu89VyKCtARQy4xmwxl0NLryj9lRp1ZseJIivrfLUrHbWzLup35PbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSVPR03MB989613.namprd03.prod.outlook.com (2603:10b6:8:41f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:49:30 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:49:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/5] spi: introduce SPI ancillary device with lanes
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com,
        michael.hennerich@analog.com, broonie@kernel.org, jonath4nns@gmail.com,
        marcelo.schmitt1@gmail.com
In-Reply-To: <55c674601bfb3ba5495bc364cf2f7b86d0e4e65c.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
 <55c674601bfb3ba5495bc364cf2f7b86d0e4e65c.1785725359.git.Jonathan.Santos@analog.com>
Date: Fri, 07 Aug 2026 15:50:22 +0100
Message-Id: <178611422288.552144.8213427990927728453.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786114234; l=1019;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6eADDyitJeVSUyOLnaFBRMCH9CrpOySriD/76QN3QKc=;
 b=prpViF/F3fi7TRQRosz1XvzindXfCwCC0mEOf1g9nsR8kpBcUCJQFkuFHhNJVfYEh125lVvf1
 4QrJ/eobpk6AsModZWttRwxfxOt0TxqSnDT6PiWxTKajwxn4d0+FHLD
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0069.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSVPR03MB989613:EE_
X-MS-Office365-Filtering-Correlation-Id: 65da1050-54d4-4361-1e39-08def493164d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003|6133799003|3023799007|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
 dd+lmg5h/uBnVP8QwFJh27HLOvwFxpnIxxZECAHwGVsevrKMMLLMaf/UgvX1po35mtlkhjJzq1IjmtbzbusKuQURGOmcr99nTQrffPPkEwHsnWAFih5mwzBwHhGGhfdhly2jhr2iZ3Cc8T/a3Lw5HcdMGjJxBai0oFd2dkQTnnW7HXW6/vb72HcFW5lLL6lfTHrdDfw7B0jhhkDw5TjKFtnW01aX16OUM7Jl/JWxzjpki4MMWOFVG2aJjYyJybCRu5Dpg+i70vQHVdV2e/+HYp5hoxvhtIyjhHq2f/8JxhqdOds6EOS4ZBMLUng7DCQiv/gFUs3nMasybcZJEi9oq1lOnWDyLKZlL7eWMohwNUDBL+aJuyjPQ0GGRF7tQMnkrwqHJFZBOkSQzHoGZ33HfkXkgAcMLrTtrV0JUTh4hx00o5v12tGvaio8U8VOdAwSuWLL4QBtNaNzFSJrUxr+sGBgN/S6GgX7fAOAgf6h2tn81jSnqhDwvrD+xyS4ByosuRHuMwKuId/1nyRGOeLK4IKMiTKy1GRn4f8bOBt9NqQPg5lmrOv/i90EGUzdYtO6SVunpbxYqSc71lAUyo37AkNWt4r1XN7b7mRr3sYIbF2VfE0F++ysowIFE1RsKLMg/vrxXh+lmIRYhP3QeKq6iaaxD1CUw3HBKlu5Wx/PkzA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(6133799003)(3023799007)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c0dqOTlUelcwbENXMklqbzJrRVVET0h1cTdsdlR6VEtEK3NtczVFYW5qeVZT?=
 =?utf-8?B?RVk4aS9pQlFxdFBpUEJTU0toTFZvWlkvbUcxUklveUdEZXd0TUg3THBJdjV3?=
 =?utf-8?B?ZmNLV2lSMDZJZ1VvUXNLM201YjM2K3V1TlNsVHUvdzFoVTE5Ly9ud3ZJWXZS?=
 =?utf-8?B?QllNK0QwQlg1T2VRSjVxdWo0QTJzVGJ0azFRVlluWWpmWlB2eXZ4NmJiM0xi?=
 =?utf-8?B?M3ZMdkM0b3FocTQ2OHE5b0pkOUR2TW1WeHV4QUhzU3ZmUlVoSGVHb25TWjk5?=
 =?utf-8?B?QUhHTEJ3Wkw4MzF5NWI4eXRpV2xWMzNJU1pvZUFZKy9hdGtOQklST3l2ZE1F?=
 =?utf-8?B?ZWRzU0IxN3ZETE5mK1RLTU54a2phaGxxb2J3Y2NURXNaL1BnaUtSYVdqRWJw?=
 =?utf-8?B?RDJ0VHNyNmVJcEp2MG1KRGRsQnZnVGd4elk3Tm9ROGJ2d0xIbzlzdWtuaFNN?=
 =?utf-8?B?ZElBakFONmp5em9xblhtbUJCaGl4bkZ0ZFhSWE04bEdjZHlUalpyVWlWZXhz?=
 =?utf-8?B?aHkwTDVwU01MRG55M1VJa3psMU16S3ZlejFXRFFVcjJ3TUlPUW1VSlNFNVNE?=
 =?utf-8?B?cmNXQ1ZHbGE3TG5ycmdxb3Bkb1J6SHlZZzdwZFFESUVMOHRjTDdQVFVxOGsy?=
 =?utf-8?B?TUhLNWxFOVphcDBmQzhCaTZUV0d2d2cvbjNhdGkyajlqY2NlUnRTOUw4elMy?=
 =?utf-8?B?VzB6VFdwTDFqZndZQnRZVkRWVElocDdTOEhCam1HSHl0c3QyN3BSQURucGpl?=
 =?utf-8?B?eGswN0RWR2pPSnF4bFV0c3dkZENNQ2RwbkllcTVBZXdYTHgvZkZhUlpOOGxD?=
 =?utf-8?B?Z3k5Wm1Gc0t1SVAvMUJhNGgrSTZJTnI0d2NXbTVOMGpnNk9wQmVucDE3SUha?=
 =?utf-8?B?ZHdLRlQzSmVpYjZ1ekR1SnoxTG9UTTNGd0RqWENCMjFnYlNvbXRGdUF0MEVh?=
 =?utf-8?B?UlZzQ0tWNXRhM0o2Wm1OVkhGZVhLUmxaRDJNMEF6SVg4eVpIenBtU1ZRU3Jo?=
 =?utf-8?B?SFFkNG9KcnRWbkFiV3pSSkJzb3hYQ2xWN2lTNHcwZlF2bkJhMm1xZXNRUk10?=
 =?utf-8?B?VStncVBZMnZ5ODhkQm40RVFBeG5EeUw2N3JPRlZnU1BqaGNCWXVjWHRuNzNN?=
 =?utf-8?B?cThRM0dITFNiU2hNVjdXMlFYaExzZ2VpcTBVYjJEdGtudGN6MmNUOS9uZnJ1?=
 =?utf-8?B?Vm85MHpEbWRCQTd4NUpVM3NZM2Y1STJSbkZiWkVXRXlmdTZMV05mRjNKd1Yv?=
 =?utf-8?B?bmRwZFlWUThpQm03amlxUWE0UGpmdVIycGxIWjh1eEFrQ3IzMHNUdkM0UnNZ?=
 =?utf-8?B?dktWWmNnUlRySDdJM2FkOWFianFTS0lTWG1iSXJ4OGM4TFJlYVY1cUtYMVoz?=
 =?utf-8?B?T1REb3Q4UjZSd3ZKL2lGTTBoeVg3KzJWNVNDTlRTdElDcGE4M2RkbzlpMVJq?=
 =?utf-8?B?clVlQmlFUTVneS80MDBMN0FMT3l5NGx3dFFOcUtEajdmclY3QWlQRGlFWGQ2?=
 =?utf-8?B?V1pFR1RwY0hpbG5ZVFI0L3lwNHBCN3dYaFUvUjJhOWl3eExMSjF1TUE2SjJZ?=
 =?utf-8?B?bHFsb3BZOGJvSGtodCsyNFB4NHdXbUsrTE9FVy9RYngvWGN1b1hSN1VPbkxK?=
 =?utf-8?B?THFNZnRrZXJTME1lQ0x4VDRTaTdYc2VXYkhPY2QyOCt6VnhRQ2RGWkh1ckor?=
 =?utf-8?B?OEZlZEFpSWhTRlI3WVNNemNmbFdGRXNML0Mrb0cwZnJMdkwwenRPVVJtVW5o?=
 =?utf-8?B?RGVDM3NnZTZlU3pZQk1qbEZlWUx0dmxQTmM0OGRoV1h1VkxKYlZMdE1tbWFa?=
 =?utf-8?B?RndtdElXTzdEbkppN3YyYzdRR0YxVGs5dURhd1ZBT3hXMDBoMEFldTFnRXI3?=
 =?utf-8?B?VGZMb0FzeGlNOEtIR1lFZDVUVTRHUG9PRUM1SVZlVXdVWWkwdlBVM1VJZ1B0?=
 =?utf-8?B?QkoydUs4d081YlkyaGxmT2hlcmZnVjFMcE1od2lyN28vTCt3RzBjTjdjQ25X?=
 =?utf-8?B?d1lmaGM1emJ5TGRkWXpMYlVvOGZORlBjQlZMcytlUWV3UDJNek90S1hUa3hE?=
 =?utf-8?B?UG9zYitXZ09wY3F5RWNpNE9URnFVaGtlT05QaXRldUVIbDVxSVRhaUx4T0tO?=
 =?utf-8?B?aHNZYlo2T0tJZHJUWkJHRlhDbHJrMlhscWhUUU1wdWN0eXZCVVNQZ0NoNGl5?=
 =?utf-8?B?YzJkTHBwUUdGdEp0MXBrUy83cXcxZE05OFl3ZVNDdUJ1WkhvVndCemNJMk9L?=
 =?utf-8?B?MFJFQ01iQUxZa2MzYlJUUlYvU2FnSlh2RjRZeXEvQjNmTWFObzFFTmhKNlE1?=
 =?utf-8?B?c0lsdnJGb0FCNjRZWU9BOGgzUUVteTA4MDJEWkFkTiszOThOYittUT09?=
X-Exchange-RoutingPolicyChecked:
	VaYtcmqK6Vqqk/pjwh+lpz+na48T/z0c+v35lwklCvIwc+JY8uUBwzX1SFdCY3oZASoea9EQpXRUAOd+vQvxcdJUNEN7FYwGARszpWyaikJ6IJdjvKA2LEifxvsDJso4erRc9s3i2FBNoQXKOXir3oanRKvAlHF4S85r3dBPfcU+uanva1wfd2Dj39eR1DKsVJEhycdh8J7LxBRT6ElNJ9ENSHCp47SanRZK4YiogEFH7WVOAGGhxy5ia0NSDd7rEVRYexvJM11R+uKO6rMMHGgMUkFMXasDZlN3MDAmh7eFRTTioVpLMh9aRWxUgcPnWSGFseNQsu7G3NeNOLGtKQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65da1050-54d4-4361-1e39-08def493164d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:49:30.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbdjc1lHMulwD7H9MmHo17ZnaUjB5/rw/DqvrcUvCv70l2z/QNGAwyULIOS+7bYFzKnIXjUdThvJqVFg9MIDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989613
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfX8eI5XeQW5+3M
 SluIjiGQTi14yivSLcCKKDs2hoWYlYZiQoZSets7SUkpV06P01Fa+8Jc+u4KBMk1WBfxm43tBXv
 AXz6EhWfp6R7/jjkSg+qV8ZvotuP+uifzPeByCrHmwqUzC2l0IKv2GJDYGptAXFE94qusnrgsu/
 Sk7tFyh2FBdjhitxH+dk1pcGzPr+Vi3Wwd5nLpvvgHe+KqUc3XU3LtauFMYlJpm3Xa3VMWhLw2u
 ABx83Tko8/AtL/9o/C76lIY5b2/49P7+RCzIQg3FeRkBtqD9o1O5hAx4sMCF3znUtQjB9K30PJU
 Jek+k9OonEH3kdxP+IblSDQcnLZY+oBvBcTDzRC0mwoVkC8FitryWEzlitjJg0QX4pKWEjvShOZ
 hASICwD2pxEYKuU4C6vWYLCD7unY+pPFnQRKWOxVFdNr8vlo2kiCAwJooZwtVcVcI4CXo2rg4Rm
 81zF2Vl/OHExxn5OZAQ==
X-Proofpoint-GUID: WKNW_6gTpcjNuqOzYR2HYqboRCLJinvR
X-Authority-Analysis: v=2.4 cv=TIR1jVla c=1 sm=1 tr=0 ts=6a75f07c cx=c_pps
 a=cEhcA1GRg4KA0mca7hj4fQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=q1MWq6I-xEiWY0IpILMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WKNW_6gTpcjNuqOzYR2HYqboRCLJinvR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfX5V27phrsN09D
 zXIhwN9MNwJAZcKKKtlzw4L6BcApF6HM6AC8cT4x0AxmTufAoQWRvICJlhYzTH5QXI7tnfShceE
 KFoRU5uveoUgwkpGTtYJV90rcv2Z9JNRuy1X8ybKIXu1Em1HO0ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070116

On Mon, 03 Aug 2026 00:02:15 -0300, Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 61423aee1525..d41c9392c04e 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2749,6 +2749,72 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
> [ ... skip 47 lines ... ]
> +	ancillary->rx_lane_map[0] = spi->rx_lane_map[rx_lane_idx];
> +	ancillary->num_rx_lanes = 1;
> +	ancillary->tx_lane_map[0] = spi->tx_lane_map[tx_lane_idx];
> +	ancillary->num_tx_lanes = 1;
> +
> +	WARN_ON(!mutex_is_locked(&ctlr->add_lock));

Taking out the new lane handling, you do have some fair amount of
duplicated code. Factor that out to common helper shared with
spi_new_ancillary_device(). Maybe with some handling (like a know
invalid value for rx_lane_idx and tx_lane_idx) you could have mainly
common code and the public APIs would just call that with the proper
parameters.


- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
