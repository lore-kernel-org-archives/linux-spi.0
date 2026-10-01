Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A9457E64;
	Thu,  1 Oct 2026 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842538; cv=fail; b=HPtFV/Bx9ybwAbHz3bOoZ0tPT0nj/LEqK8rxXMlqS+X346z+xi9LIu3/nSTzDb5qpM4lqcWvEeNmiB+mUycC7i6ojPTXEviZEeY+W4qfEVfdiXlOrwnLH/YaFpGHP5GQJV4v7TN1iU0L45c5QnNHAx4E6B4QoiT0leI2QYMHy1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842538; c=relaxed/simple;
	bh=3sFGX9XBIIV7KH0pMYbIja2L0fRHC3bNgQLv16pCqOI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TR/6GOE2HL2ngJ2bPbTC0jbODHQfyZW0MOc0627qH8fQvfDYrBiiL/GGwV42guI2LUUJzYHoNw+f0dYKpC7TaD3nSuM8jWr6RDiALwh+k/ffh/NH0AlZ7BNiGPRXF150HfV79olZc/qVDNR7c2YsFBTb8BJomzEAQlgvUmHYhho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k6sRED7k; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HaIsj4du; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k6sRED7k";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HaIsj4du"
X-UUID: 3d89d01abd7011f1b1788b6acf885367-20261001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=3sFGX9XBIIV7KH0pMYbIja2L0fRHC3bNgQLv16pCqOI=;
	b=k6sRED7kgCpNMqZUP2gGl8CWZxZSKA+AQJVoEUuXq0OX/SaL8yspSztI31hbkFfWONVWM2kd65u7BVpt0MKQqL3QQdkMs2elrrZNGPJSWWNlSJpMRbe/B72cA32yl5YHqKt0H+X+/RDzY+Q9cUnx2WH95thpRGwdizbeoA1Y7N4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:1e1a6f2e-d62e-450e-beb2-ef1b0b2c83ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:48f0566d-880e-4eb0-87ee-48449d7001c8,B
	ulkID:nil,BulkQuantity:0,SF:80|83|102|110|111|836|865|888|898,TC:-5,Conten
	t:0|15|50|99,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d89d01abd7011f1b1788b6acf885367-20261001
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1881743346; Thu, 01 Oct 2026 16:15:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 1 Oct 2026 16:15:17 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 1 Oct 2026 16:15:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhNPkwrlj2f1w0CsZAnMPpYK1rseMwyo6IgH4mSJ0Ubt5hruMiA0h2KD8QJepuEVoYdttOoS15eog1X2z1nyHrqZSdSu0REMoeRWACsigtdhecOSqisUkvTQ9nCkjzFrlYWxYLP9YRBgNDQuSSidIVyDpUxI1NLaRW7jXQyoJvceBfT5ZQ5E9e8EWYNqs0mRhyxOjnCPR6IxGW0N14ZxEDoZ/ZfczieLnoekHpmFOQSwjyCBSfSgSMuNrVGChXvl2Cr3RAgNFQdoFDa1IHTKf/UwK5cGXZzcnNqJLZbzO/6xazlSnFbHBNkSzeA3+yZcOcTMLHXaAX52cqQrg2+tAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sFGX9XBIIV7KH0pMYbIja2L0fRHC3bNgQLv16pCqOI=;
 b=OP16yFRa0UpPB2cQ5hd5oPJfcUfpOUWoxGqOJ+adeArteknkPR5S+OxNWKg00igbVcn4MmMUT2chLKhVAIiGaO/5OJ8PRO6SF6aCWC8icmTTopMgN3lHOw3l+6Yys+0+aYAGT0Izo9PP4K+/UJdGBq3qH7M95HFZm+dNclOUwsd3QG82WdUFKz3B0cSZsCpc7RNVjiUDVdmz2sruyAIJ4CpSWkNwBkO635lLx7PY0vrUaMSuQ9tpNfh7dRAQHbvEqdwCgousOo5bDVXFfi21NyHl58h0O8kbFpqdjPUDLu+sDR3ai3l51NcPjbxVvNNmlXlhEXviYiJs5SO0ohKWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sFGX9XBIIV7KH0pMYbIja2L0fRHC3bNgQLv16pCqOI=;
 b=HaIsj4duAMAbZSciZ681yK3ZROD7rYXnObH514fBkH3nym+UsUTVGxsnI5tKRG/QTRk1LkYG+f4tdjRvTiLm8fY7sdZ0GXIwxIgWwx4rHQyd+grN5OP1d5Ze/sPK8qkmr/Rl0MdSnRJYj5hEqapuOiK0U8T02WjJsPqSFQN1L7c=
Received: from KL1PR03MB7285.apcprd03.prod.outlook.com (2603:1096:820:e2::12)
 by JH0PR03MB7787.apcprd03.prod.outlook.com (2603:1096:990:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 08:15:14 +0000
Received: from KL1PR03MB7285.apcprd03.prod.outlook.com
 ([fe80::ba5c:7633:34e2:ef9a]) by KL1PR03MB7285.apcprd03.prod.outlook.com
 ([fe80::ba5c:7633:34e2:ef9a%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 08:15:14 +0000
From: =?utf-8?B?VGltIEt1byAo6YOt5bu356yZKQ==?= <Tim.Kuo@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	=?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
	<Sam.Shih@mediatek.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: add SPI IPM v59 compatible for
 mt7987 and mt7989
Thread-Topic: [PATCH v2 1/2] spi: dt-bindings: add SPI IPM v59 compatible for
 mt7987 and mt7989
Thread-Index: AQHdUXz8G+J0jgdJU0CzUIlUyHSJfg==
Date: Thu, 1 Oct 2026 08:15:14 +0000
Message-ID: abb81c632793dd894588bf279cbce67379c6b3ab.camel@mediatek.com
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7285:EE_|JH0PR03MB7787:EE_
x-ms-office365-filtering-correlation-id: ce9913a2-82f6-4d71-3b34-08df1f941f14
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 2YUwsSAU+C3hN4dhBfetdFgRoov8gWT5iLGknAqzpjj2B6Pd008+418Q1v+ISbOBQ0DjYv+NWsSB4S1eYK5J1vj/CvBVuVa1LJvz+XwNqtuC7ZcscQP9bgdZzuPAGgyHCVgttHunmCfNwvxwlVdL7Q+M2Xp/7n0bkiN/Af/fPERUVHF1AycqLPUHTDrhw9NrHjdmk77v34Xf4AHCeFezHAFOHkhmROgfceLtwov8ca98PRejZDvgaOdHvoZ1k8rLCsrdNIi+z38JOHiJtQGAG//7U8KhRb/mqWBOOw/DNZ9oVE7HnH69IH4Dy6meNVlkf+MSMuTyQIqB9Dl1ISAhlxFttSUaJq3y8tm9QoqItIIHpmG+nsSMEwcpRxg0c/yuBjB9AxJSV9mZywuaXD2q1RP9aBTolnQqGuPHZ97BUyOqK6lAL/tA2FgP5bv12fq4ZXYqRqu+gQEyqscP/hO5VfG3BZv7MKeMMEnk6uHKmT8GnrJwnpKL8siVx4AouPngVxHAuQW0yZTQ/2cCFTzndmbhOQnsx2r8Bjm3KWO+dTVHo6f+hwWUeNySs0I8FqrZS+/zdpLDUkSw03Zg64DUE0/qB56feoxvslc4vvNntGfBJ9Ke0LD7cbCqQAh8YFVMH5Ni34f5pNTujOC3LOBjx0iHcLUeOJbFQ08yeS1bN1lPBW5dzpywhEl6SEeRD4fIvaLLbHKqoPhS89Wr8Xi4BaLs+JjydOKjZqyHJ6R/TdY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7285.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXdjczlQdUl2QTh5dVp2SXoxL04vOUJveHJDOWVHa21xbWlEcGx3VVY3V01k?=
 =?utf-8?B?QWd3NkhiUC9BZm52SFBYcmdJQnUwYUNQREZGZmVuL3BUOTZjMVVsTDJVeFlI?=
 =?utf-8?B?ZUdWbDVFT3dNTFFLbVgyMko2ZXhIRkVzbHhKSjBZc2dGdy94bkN6b1BXR3U2?=
 =?utf-8?B?YVBCK21kU3U5VldSUkp1dzlUNTA5SkY5bFUxWlR5TkxkdHRLWVJ2bU04dVN4?=
 =?utf-8?B?STVoUm9XUGhTRFErbVNldjRDbExvOGJBM09GUVBhL1VTL2VnQzIwOCtubDFm?=
 =?utf-8?B?NmRxSXR5bU1mczJoQjdvckR1ZlV5dzVJRmVSN1VqRG9RWmVjT0VpdUd0VXdy?=
 =?utf-8?B?bkVKbnA1eHZlY1laU3NJc3ZjY3gyOXJqTDdUNU5FZkNSa2NWMFpDMnFlbTRB?=
 =?utf-8?B?VUcxaTl4VHIwQzMzVEtCbTE1Q1dOVWtZMjF1Ty90eGxpR3RLeTZrc2VBanNa?=
 =?utf-8?B?VW5NRTBIN0dqN2tsaHhTRlUwNjRZbytjMU02UEVCYVdLVjBJQnBtWkoyUzY0?=
 =?utf-8?B?cjRmNm1xNStFU203WElkNDFYNjFXRERoNzczSFlqYmZyR3owdVp4aGM4WWx2?=
 =?utf-8?B?R2twSWpkRVZzVHV2UGVzY3JJTTVXdzNUL290Vnl3Mk1Ha2pTMlYzQmpXYVhU?=
 =?utf-8?B?MnFjREdnYlFva0hVV0E3aC9WM0R4bGNPKzlqNkduVkIybnlqbFY1VnlITEt1?=
 =?utf-8?B?S0JWZUE1bGFjWFRRTjAxUHQ2enAya09ETXU5dE5oRFVjMm5QZHFrSlk2dnh0?=
 =?utf-8?B?OTZQeUxoNWpVWjYycDhzUFhoMCt5NWdlZ1BYajNIcGk1Vk4xb29WSDFBSWIr?=
 =?utf-8?B?a00vWS8rdkxTekVVNTl4Mi9hVWp1ak1EcDd1LzBaU2Mva2t6T1NiMGtPNzFi?=
 =?utf-8?B?V1RZcm9aSWJFQkFObWpwbE5rWjRyLytpQVlsclJHdGRZVUM5elVTY3hZNERM?=
 =?utf-8?B?Q005OUdxQkRvd2wvK09hS0xSc29ZWnorV3Z6SEJjWkVDQ2lwbjVBcTVXR0lN?=
 =?utf-8?B?ZVhpNDJrd1puano3VVc0TnlPT3ZjamJxbHU2SFNXYW43eDVJRWlxN3p2TVdF?=
 =?utf-8?B?VzVsTlhZalY2Tjc4OFF2RGVIdzZleWhjS3ViQkFvNXIxbGFna1hQTlE0QjRF?=
 =?utf-8?B?VzhjTDFjZklUNHJjUGI2S3ZWdHdLRDJNdTVrYmR4Z0t6T0dJcW5MN1VKYmlv?=
 =?utf-8?B?QUJ4Y0MxeXFnQ0xrYlpveE5nbWZQbmdoWUdnaCtFV1c1b2o1V0hVNVhhcG1k?=
 =?utf-8?B?d1ZJRmJTYnMxT1JrK3ROLzRtVEtodVVtZlpQZnYvU2pabk5xaEt6RFc1S2hQ?=
 =?utf-8?B?RGdVZ0FzamNUcDRTU2VOTzhucDlaa0ZDYi9QVGQveU4raE04bS8xaUVHaHZ1?=
 =?utf-8?B?RjZlSGRrR0h5OFl1UzBuUVY1MXlDZWNJM3Y3MmNuWU5NT01kQzhIZW1SSnR1?=
 =?utf-8?B?b3kxbTRwcEgrTTYyQU9nR21LQkllcll6QWR4TjZ0NmFNNHRUM0FqWnlxUy9P?=
 =?utf-8?B?b3hQNlRpc0Z6OE1tYVl0ODMrNm81KzZ3UHFVTS9jZFZmRzZqZ0RHdENuZjhH?=
 =?utf-8?B?cE5PaXlCeWhvV3R2cE1RUEtTdWQvQytjSS9qaEoranBvOGtxQ3BWdmpJZkwr?=
 =?utf-8?B?bmtiNXRLMEk3Tkhoa1g3SGY4eXZQUjBBOEdPMGtxa2U1NEdOTmNLdVRKcXlM?=
 =?utf-8?B?a0loM3Rucm1IbjBFVHZoTnVqNkt6R2Q4S1haclVaWUNsc0ExVDNYb29QOVov?=
 =?utf-8?B?ejllN1F5TkxibldmaStqeXNNcEQyVG9XMVRmNERDN2FnNVErdnJmRkJSUngy?=
 =?utf-8?B?M3NCNFk0aC90c3pRN0wrL2hQM24xZStsVXdGUURSUFJ6N3lSd0V3azZ1QTZ1?=
 =?utf-8?B?KzdSTGJ3QlRldzM1WG1zZTB5T1ZuRTFHbWhrUW51aVkraDlHaXZkYmwwOGx5?=
 =?utf-8?B?UytET1VYSnBMR0J3V015VnpPY2lwQmthRjZad01WVUdFd1dzOXMvRjh2NUJI?=
 =?utf-8?B?a21EZk9BcDcrS2RTdmpMMzdmaTVUUjlyNHNkODFtTVg4MWJEaUh6N2pDVllP?=
 =?utf-8?B?bWF1MHNtTDRVV0c2Y0pNK3N3cFdUdXNaczFWc0Vid2ZsbW5aaUlyVERGa1FG?=
 =?utf-8?B?MmlhU0NxdVFIb1JmVGtqTFdIamxNY2lmVFlaZndWUFp1bjE1Q1dIMjhsZi9E?=
 =?utf-8?B?NVV4Z2s4NDRJOEdKVEdNZ3F4a1FGazZQL211OFRCazg4eFo0UVFJM2xMVkJF?=
 =?utf-8?B?b0sreXRuRmZnMDFsV2kvY2ozOFdKZW9HekNOR2FMYTdvTGJqRWZIRnhYREFY?=
 =?utf-8?Q?voCWVLv3Fp/D0NqRI/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oy35TlHESGwaN9nTYqKKzsyWz80QPNnvTYoAi/FPGfO3WVpaUpsH0Rz5N1csrpPjOQeQNKE3Z1YvLDY/ZT3yzgb27cwbheTZQIDDUuST4EDVLZCJRUTGXQixg7hOlaVLWnbLueRyiD7cK/WVb+B+zZDtHG439fWL1gEUQyqGLlh9IgznYUDqvywwgDjzMc1U/0cDGzmASr83sR1HGI5+/WFIOnvPlTo1FbKPlda3P3MCsrrVkr8WohEX3KiOE5BwxUocqhvwi57ntFjDV0K/om7O3ziAVP85+T1bUyOa6P0rWv0hTkLaOeAxzam7Vdx1aObE8i/g31wreYphN1k6Yw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7285.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9913a2-82f6-4d71-3b34-08df1f941f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 08:15:14.6224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Odfuky2rw1/G3L+b6xvwDMtBmyClsV9MNHKUk+Mxk+/T0NvJmlP0CBOterfgZBIRZsCe6ya5Jb7P08k+D//Rsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7787
X-MTK: N

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDEyOjM2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIFR1ZSwgU2VwIDI5LCAyMDI2IGF0IDAyOjI1OjE1UE0gKzA4MDAsIFRpbSBLdW8g
d3JvdGU6Cj4gPiBNVEsgbXQ3OTg3IGFuZCBtdDc5ODkgU1BJIGhhcmR3YXJlIGhhcyBiZWVuIHVw
ZGF0ZWQgdG8gSVBNIHY1OSBTUEkKPiA+IElQIGFuZAo+ID4gaXQgZGlmZmVycyBmcm9tIGVhcmxp
ZXIgSVBNIGRlc2lnbnMsIG1vc3QgdmlzaWJseSBpbiB0aGUgdGljayBkZWxheQo+ID4gZmllbGQK
PiA+IG9mIFNQSV9DTURfUkVHLCBzbyBpdCBuZWVkcyBpdHMgb3duIGZhbGxiYWNrIGNvbXBhdGli
bGUgcmF0aGVyIHRoYW4KPiA+IHJldXNpbmcKPiA+ICJtZWRpYXRlayxzcGktaXBtIi4KPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogVGltIEt1byA8VGltLkt1b0BtZWRpYXRlay5jb20+Cj4gPiAtLS0K
PiA+IHYyOiBBZGQgbXQ3OTg3IGFuZCBtdDc5ODkgcmVhbCBkZXZpY2UgY29tcGF0aWJsZQo+ID4g
Cj4gPiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktbXQ2NXh4Lnlh
bWzCoMKgwqDCoMKgwqDCoMKgIHwgNQo+ID4gKysrKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktCj4gPiBtdDY1eHgueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWVkaWF0ZWssc3BpLQo+ID4gbXQ2NXh4Lnlh
bWwKPiA+IGluZGV4IDNiZjNlYjFmODcyOC4uZDJjNzQwNTcyZDg1IDEwMDY0NAo+ID4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktCj4gPiBt
dDY1eHgueWFtbAo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nw
aS9tZWRpYXRlayxzcGktCj4gPiBtdDY1eHgueWFtbAo+ID4gQEAgLTM5LDYgKzM5LDExIEBAIHBy
b3BlcnRpZXM6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gbWVkaWF0ZWssbXQ3
OTg4LXNwaS1zaW5nbGUKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBtZWRpYXRl
ayxtdDgxODgtc3BpLWlwbQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWVkaWF0
ZWssc3BpLWlwbQo+ID4gK8KgwqDCoMKgwqAgLSBpdGVtczoKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqAgLSBlbnVtOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gbWVkaWF0ZWssbXQ3
OTg3LXNwaQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gbWVkaWF0ZWssbXQ3OTg5
LXNwaQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBtZWRpYXRlayxzcGktaXBtLXY1
OQo+IAo+IE5vLCBsb29rIGF0IHRoZSBiaW5kaW5nIGFuZCByZWNlbnQgY29tbWl0cy4gVGhpcyBz
aG91bGQgYmUgYSBzcGVjaWZpYwo+IGNvbXBhdGlibGUuIEdpdCBoaXN0b3J5IGVhc2lseSB0ZWxs
cyB5b3UgdGhhdC4KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gS3J6eXN6dG9mCj4gCgpUaGFua3MgZm9y
IHRoZSByZXZpZXcuIEkgd2VudCBiYWNrIHRocm91Z2ggdGhlIGJpbmRpbmcgYW5kIHRoZSBoaXN0
b3J5OwpsZXQgbWUgY29uZmlybSBJIHRvb2sgdGhlIHJpZ2h0IGxlc3NvbiBmcm9tIGl0IGJlZm9y
ZSBJIHNlbmQgdjMsIGFuZAphc2sgb25lIHRoaW5nIGFib3V0IHRoZSBEVFMuCgoxKSBNeSByZWFk
aW5nIG5vdyBpcyB0aGF0IHRoZSBwcm9ibGVtIGlzIHRoZSBTb0MtbGVzcywgdmVyc2lvbi1udW1i
ZXJlZAoibWVkaWF0ZWssc3BpLWlwbS12NTkiIHN0cmluZzogYW4gaW50ZXJuYWwgSVAgcmV2aXNp
b24gaXMgbm90IHNvbWV0aGluZwphbnlvbmUgY2FuIHJlYWQgb2ZmIGEgYm9hcmQsIGFuZCB0aGUg
YmluZGluZyBvdGhlcndpc2UgbmV2ZXIgaW52ZW50cyBhCm5ldyBnZW5lcmljIGNvbXBhdGlibGUg
Zm9yIGEgbmV3IHZhcmlhbnQuCgpTbyBmb3IgdjMgSSBkcm9wcGVkICJtZWRpYXRlayxzcGktaXBt
LXY1OSIgZW50aXJlbHkgYW5kIGFkZGVkIE1UNzk4NyB0bwp0aGUgZXhpc3RpbmcgSVBNIGdyb3Vw
OgoKICAgICAgIC0gaXRlbXM6CiAgICAgICAgICAtIGVudW06CiAgICAgICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ3OTgxLXNwaS1pcG0KCSAgICAgICAtIG1lZGlhdGVrLG10Nzk4Ni1zcGktaXBtCisJ
ICAgICAgIC0gbWVkaWF0ZWssbXQ3OTg3LXNwaS1pcG0KCSAgICAgICAtIG1lZGlhdGVrLG10Nzk4
OC1zcGktcXVhZAoJICAgICAgIC0gbWVkaWF0ZWssbXQ3OTg4LXNwaS1zaW5nbGUKKwkgICAgICAg
LSBtZWRpYXRlayxtdDc5ODktc3BpLWlwbQoJICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNwaS1p
cG0KICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLHNwaS1pcG0KCgoibWVkaWF0ZWssc3BpLWlw
bSIgc3RheXMgYSB2YWxpZCBmYWxsYmFjayBmb3IgTVQ3OTg3OiBhIGRyaXZlciB0aGF0Cm9ubHkg
a25vd3MgdGhlIGdlbmVyaWMgc3RyaW5nIHByb2dyYW1zIGJpdHM6IDI0OjIyLCB3aGljaCBhcmUg
dGhlIGxvdyAzCmJpdHMgb2YgdGhlIHdpZGVuZWQgZmllbGQsIHNvIGl0IHN0aWxsIHdvcmtzLiBP
biB0aGUgZHJpdmVyIHNpZGUKbXRrX2lwbV92NTlfY29tcGF0IHdpbGwgYmVjb21lIG10Nzk4N19j
b21wYXQgYW5kIG1hdGNoZXMKIm1lZGlhdGVrLG10Nzk4Ny1zcGkiIHdoaWNoIG91dHJhbmtzIHRo
ZSAibWVkaWF0ZWssc3BpLWlwbSIgZW50cnkuCgpEb2VzIHRoYXQgd2hhdCB5b3UgaGFkIGluIG1p
bmQ/IG9yIHBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGF0IGlzIHN0aWxsCm5vdCB3aGF0IHlvdSBt
ZWFudC4KCjIpIFRoZSBtdDc5ODcgRFRTIGlzIG5vdCB1cHN0cmVhbSB5ZXQuIEl0IGN1cnJlbnRs
eSBvbmx5IGxpdmVzIGluCk9wZW5XcnQncyB0cmVlLCBhbmQgdGhleSB3aWxsIGJlIHByZXBhcmVk
IHRvIHVwc3RyZWFtIHNlcGFyYXRlbHkgaW4gdGhlCmZ1dHVyZS4gU28gdGhpcyBwYXRjaCB3b3Vs
ZCBhZGQgYSBjb21wYXRpYmxlIHRoYXQgbm8gaW4tdHJlZSBEVFMgdXNlcwp5ZXQuCgpodHRwczov
L2dpdGh1Yi5jb20vb3BlbndydC9vcGVud3J0L2NvbW1pdC85ZGU3MTg5ZWQ0M2JiNzUyNGZlOGJj
YjNlOWY1NwphNjUxNmQwOTkwZAoKSXMgdGhhdCBhY2NlcHRhYmxlLCBvciBkbyB5b3UgcHJlZmVy
IHRoZSBiaW5kaW5nIHRvIGxhbmQgdG9nZXRoZXIgd2l0aAoob3IgYWZ0ZXIpIHRoZSBtdDc5ODcg
RFRTPwoKQlJzLApUaW0K
