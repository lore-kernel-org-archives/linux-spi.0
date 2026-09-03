Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161E38838B;
	Thu,  3 Sep 2026 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415994; cv=fail; b=K3m2fx4ZrGMR13wiTj7ffMP9gfTIlgun0mvl+uj4NLhfCxLiEP68x6zRGj1OOsnZEdSPUWRbfC/YKizoVN2LBV1PGrTpPPFnlUwJLgqiCPCCsoYWuTNGVpNMD+BNLnCf17cidHs/8VDZ+CkCngTQIiT1WQl+V0keVGLVu6YsESY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415994; c=relaxed/simple;
	bh=kw7PKqgLm+1SKejzzHvy1Lxf5Pn2WLEqU2T29/7r3vg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iwa/t/PkPrtaZbujaj//vJW31bTio1UCn6kIbmxbO6dQ6oAZqMPFEYrvKxVj59wcCDi8ofZL8k7t7aiR2BWUXbfyrMrbY5MbluUi+2AOjO01nr0xjPJ/bTiM3GHkqaupM7GUJLvFmNwACztLhV0NgfldqDpEwBlkh1HXji3rb/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YcpaNLGz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jxLKsC4I; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YcpaNLGz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jxLKsC4I"
X-UUID: 87911e84a75e11f1b1788b6acf885367-20260903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kw7PKqgLm+1SKejzzHvy1Lxf5Pn2WLEqU2T29/7r3vg=;
	b=YcpaNLGzhffhop8Ifzchanf8u4lKRTOV3YK8Hs9oT6sbH563+kMjXvHc6CFGDuteBCwJPJckz1vJFJ/0+KotL+Wb9QLQiWtyGD1enw0rqd3HoXzSqTPQEoHqi/9I3sIcQ0JkXalmC0Bi1CgEa3XRf84TQ/6zAYoGQFVFNbLoLKw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7bff213d-9e82-411b-be7c-7fecad4ef60b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a4a96296-8382-4d0c-b42c-b0965a0d23b4,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 87911e84a75e11f1b1788b6acf885367-20260903
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ot_jingcheng.ji@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 35136598; Thu, 03 Sep 2026 14:13:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 3 Sep 2026 14:13:05 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 3 Sep 2026 14:13:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyjehG6g8qzIgm4/0No2zsCHM4pS99NdrmPzGNJnEdIeBAgJmS+k48J6SDW61FfxDIibCbCZ188dE5R+aZqt04vlsEyAWBTCcHAZM1SF+DyiDWLLf1t4hzlN2Sa8N6roReH8Tx3YdYCSP04ukn3221H9PLMzrHSAwZ/M0L04z8EIRVmpFF1HIPgXiVjrjNINprYGMBKHAknQlT3BD2H2spk2JIvUFAmVAh1K5XPDlw+LGOcl1qBwcL2XqFt3aXSAXdI3SxA2H0SEpmn5jQ0GME3ureiCK+uYlzGK38CwoQuP0c0LbDvbWG4A/oJFH5vlkkNeuiXUgOMSAKfQVWVtjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw7PKqgLm+1SKejzzHvy1Lxf5Pn2WLEqU2T29/7r3vg=;
 b=Ly68x8v/hYy1ayFKMUK00WVWCLlCxdVa2wtNIAZXBRl7Bm3zWXxmcDaqbVPxS3V4m4W7a1JlGd32/RUymXwvoY7Em9dp89HMo+nVkWNKqmG501cIC9gDGS6JA31/1Up+Il4XB0cm3P4uQKUZTFa5bqZcWdhUTWhB2C2eOzbC+PRGH9nk3zFcMF3JP+oprQp+OU3752Q08Z0AVQT4Vz0dsdKr2moNAlQ3gxm6/FbQpQT6Ynvege30LmQxRnTId/NlnQUol0/Se5DCsgSvlSX7QdKr5J5sDK8+lNh17xbwZi+m1TCCp65hw1JdeonwzlUrHWqQZaRk+b7lJgZ77xEY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw7PKqgLm+1SKejzzHvy1Lxf5Pn2WLEqU2T29/7r3vg=;
 b=jxLKsC4Itu4PNAKRwgMvqt8OuM1zJXJHtkahmAmjiienl59WgHpH0Amfyxb8vY/rDResM8ja0x2uWHMFyXLcR68OIVSJNKuqizfeuLPWqmuI0DtKzhxW5pj8GIJaXWD2i/rlGVc5Pcm5a7hoBdxP0ELIehupbA4vs9+28HfDZu4=
Received: from SEZPR03MB7703.apcprd03.prod.outlook.com (2603:1096:101:132::12)
 by KUXPR03MB10381.apcprd03.prod.outlook.com (2603:1096:d10:6a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 06:13:02 +0000
Received: from SEZPR03MB7703.apcprd03.prod.outlook.com
 ([fe80::6b83:8640:56bb:d507]) by SEZPR03MB7703.apcprd03.prod.outlook.com
 ([fe80::6b83:8640:56bb:d507%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 06:13:02 +0000
From: =?utf-8?B?SmluZ2NoZW5nIEppICjnuqrkuqzln44p?=
	<ot_jingcheng.ji@mediatek.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	=?utf-8?B?SmFycmllZCBMaW4gKOael+ijleWTsik=?= <Jarried.Lin@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?VmluY2UtV0wgTGl1ICjlionmlofpvo0p?= <Vince-WL.Liu@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] spi: spi-mtk-nor: Get clocks from devicetree in bulk
Thread-Topic: [PATCH] spi: spi-mtk-nor: Get clocks from devicetree in bulk
Thread-Index: AQHdMUuVkRfkMayYkUeIKpHoM9I+v7a4fy8AgAP0xYA=
Date: Thu, 3 Sep 2026 06:13:02 +0000
Message-ID: <556d2a683646776d9ef08f790aa118454739d994.camel@mediatek.com>
References: <20260821090046.2353986-1-ot_jingcheng.ji@mediatek.com>
	 <b03aa685-3632-4a8e-a292-4d0897ba2c3e@sirena.org.uk>
In-Reply-To: <b03aa685-3632-4a8e-a292-4d0897ba2c3e@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7703:EE_|KUXPR03MB10381:EE_
x-ms-office365-filtering-correlation-id: d4e716e5-3991-43a3-3c1a-08df0982695a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|11063799006|4143699003|38070700021|10067099003|6133799003|56012099006;
x-microsoft-antispam-message-info: lwgNFYYARHvX8HMPM2+ALBdBLQaG+AdJ907SRpvSUAWsRJysDf7OUDEWfBlVK8Ki3IJIkfnOHc5XI6y9BhhaI9B2/Jxnv+g13FCs17mHjoWPTOQzs9ebnFEnc70AR+ah2C2reElUR3u9HPWPzTA+X3NAHRP+wmrXWiGUSxslLub01RkV3BRfbyte4XGRcufp2gT06NGyuo59vRWcymHy4+Z0EdQQZkOl+OKkCptI6U1hO1/R2rVFeeU1GWz/jaXkQsD5CSlH0zcrAYP0x2/8GjBzw4xa0rZ0QW1zrQKAKNX8j78/yKDh+mdNNoejfUPBiaBlE3kz54ZOnmnwsdIhouZ5pHPyPVReeI+8ZB1OP53a8KPpMT8G7vUKxx2RVLG1MujXzlgJs4yYKW/UBq1ehLCDRjLz2p0h2vjCALDuWuZg8GqdyTOyJRt4xo9zDF9H27NUSb11brX8a4C+pLoNobHF8RnIRDWLuJaDg/hUnREdOy61jHTPXvOha/oeEQTMAU83jTaQkUDJaT8ISE9TGwGG5OgE3AOR7XuytP5bDm91N4Iu5lZ+IIXh7fSttEXePZmOWCuN8uzKyf5xYvUwxmH2ovB5l9la950POLtdzHcYy7EvyU97qXSsP4GMrjIP6vP308paMv9Vr04nujTgCcHVcQ8DUpqJz9wmJgl7NvaS6A91hyoDbBdgg8wjdQ8V0b8uCUa2MqcKRQrRtCuAYVTc3Wpxs6mN7QFQG5JmvB8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7703.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021)(10067099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkJrd2NJOTk2NmJGWXhTbysxbzlwZGxlQWF5UnpyNmRNKzZFSjVrMk85aE4v?=
 =?utf-8?B?cHcrb1Qrc251SmEyR2tsRnRCZmZ5U0tZc3FUVTgwWkNIdG5kMEJ1cHBpNk9h?=
 =?utf-8?B?TitjbmVjMHZvQU9qcE84aDBnWUlaYzdSd2NqbVNVaDMrODhscnBEenZRUHpR?=
 =?utf-8?B?amxxblIyS2RKNTZzajBvd1FVOS9uOHRKVUhra2I1TFdWc2NyRXQzNXJwQTY3?=
 =?utf-8?B?ZnJkdWh6YkZLNy9tdzhkYi84V3g1MzRhOUNXQzhZTDM0WHJzWGQveWl6OVVi?=
 =?utf-8?B?SFFONTZ5aEQ3dnVhMEVHazgxOUlka2RRUWdIT2dlM2IxK2tKd0ZhZUkzSnhS?=
 =?utf-8?B?Z1c2VU5RbysrUDR1UmpiMkYxMmppSmVLVG4yOUg1R0JEOGo5RVNGWC8wY3dM?=
 =?utf-8?B?TXFUNlo0d2hCSTdhaWllaC9HMlZoL1NGazdEMFR2RXY3eE5DS050N1RYUzJO?=
 =?utf-8?B?WnlqalcwNEJ6ZlZNK3ZISGtXcmwveGgycWQvNWhGcm02eisrWFJuRDUrZ1ZW?=
 =?utf-8?B?WE5ZM3VwVnBzRGFsakVJVElFYlRTM0xhVHdmOTJ5Z2lUM3U1RTE3ZTd5UUVa?=
 =?utf-8?B?YjFDTnU0QVg3ODVWcWRCZ1dJNmZibjMwUXRvQm1SeE1pbndiendnY016Ni90?=
 =?utf-8?B?YzIwcjV2S0RjclRPZ2wwTEgwZ25HMHRCLzRvUm5pVXhqVFArTlc1WFpmNTNP?=
 =?utf-8?B?US9YOU9rUVl0bzVsOUlCTGgyYjVBdUZrV0Y2THFmd3NVL1pEOUR5VFNjbURj?=
 =?utf-8?B?QjdvRmdaSnFiZ0dtSVZNRWJ1ZXdvYnNhbUdwbE1CcU94bTJkTGdWSkFtUUpX?=
 =?utf-8?B?M1pqelM3TmRzZXN1L1hFWmM1QjR2OWlvRlFkVE1VaUMvNndHYmt6dlNMVGF0?=
 =?utf-8?B?d0J6OE1GaU1XeWwxbjFueWU1TjJvMy8wWkhuWTBIQXhUM2NxVTNwWXRMdHRG?=
 =?utf-8?B?QzhoT3gwZUNucGdPYkFwZ1Foc3ZUUllBRXVES2QxT3FOa1lxZUlPSTZPWlBR?=
 =?utf-8?B?VkRrYVhaRHdXTFp6TEpKWFNIWFE4bGgzSFFUemlOWDZtb1FVdVFLdHI1MGZJ?=
 =?utf-8?B?UVNJTlpVTVN1TmxGdVAwOEEyZ2pEcGtuNHBuYVRIQkpwMUJBWFRrclB2T0VU?=
 =?utf-8?B?S1ZRNWc3STh2bUhVNC9GTjI0V2NnSHM4eStRVC9DWW9DR1V4NmN5SXdkenZz?=
 =?utf-8?B?ek11dVY1WW5xNVl0SHQzUlJxZ0tncHUwRmIxTHFGcHZmRWpSNW9LM1RCZFJh?=
 =?utf-8?B?bUQyVVNmd0VCSmpEOHBJUmZPdHpvZjFNYnZWYmxaWG1USW5WYTRlSm1UWEY3?=
 =?utf-8?B?bFJmN085S1psUldKVG5YbXpsd1ZPYkFMUzBCaXpFSS9EdHhjNm1DN084cEhG?=
 =?utf-8?B?SDNoUmFTa21BbEE4ZnJjMTg1YUNDa2dlSmNRZEV4a0ZXT29xSy9qSGwwVlVj?=
 =?utf-8?B?Z0pXK2VrUHUwRHZ1QU5WVU5NNWVMaituWE55Zlk1VHJIMDZhRFF4R21USElp?=
 =?utf-8?B?WFVQNEs0SUYxRG5xQm9mTVFENnBJQnZ4Sjg1cW9DVnVMTGdJOWpOd2doSjVP?=
 =?utf-8?B?Z1YybTJ2UkVJZ1kvaEI0TGY1TnFaV1VIWFpuOVN0S3Awd1BSdVFLR1E1VjE2?=
 =?utf-8?B?aUQwOE0zWjViZERYL2ZRaFUzb1lZdUhPV1RMS1Evd2hwdHFET0ppL3I5ZHQ3?=
 =?utf-8?B?T0hYYkRRcG1OemRtMHUyRHV3aUt2RVRMeVFNMk90Nm9ITTJIUmVja1FqaW1v?=
 =?utf-8?B?R0RHcWptWFVaYit2bHBtS0c4bXF3OHk2QjJzNm0yVDZqVXp2L1dETmdTdmlZ?=
 =?utf-8?B?SkNmSVJhL2NxUG9zcDdmYnpkczI1SWFhOWUyQm5KdnNWOEVETG8xQytqQWcx?=
 =?utf-8?B?Z2RSSDdCejFUMlJlM0xkSjRrLzBGL2tzTXQrWkFiMllrZFA0NG9yUXI0VitW?=
 =?utf-8?B?VmJuR1pQeWNleFU0Sjhxa1M2ZWJwNHpia1RuazZMNG5iOVhUWncrWEdVc0lj?=
 =?utf-8?B?eWtYaWlFc3pWSHJLN3RmQ0ZLb0JTUUltbVNqUDZ0QUV0WHJLRFVFWlA2SkdW?=
 =?utf-8?B?NHhYTVY0M3lNd3lZL2lBV0w1MGFKcURBdE92VlQ0Q1pITEpWQXkwRHlHRjJI?=
 =?utf-8?B?NmlMWEI0dVVsOGp0b3VHWk9aQnhORHM0TW5FazAwbmVlTnU2eE9WK2Q3TG01?=
 =?utf-8?B?RjdSd2MzR2QzaHFSYUtFTW9UamF6VGVDTlZmaUFVbGhxTWZrUDBBMGFRTkJw?=
 =?utf-8?B?Q1BDNHl0M0E0WFlsdFVubVhob0dEaSs3ODN5N1RsTjRqNmVkaVhlVjZGNis3?=
 =?utf-8?B?dzZVaU1tbU9vWU1qc1IvRThSalRwQmFMZFpPZnB5ME5iaU5ia2Z4dTlhRWlk?=
 =?utf-8?Q?7hzkMEgODJjvFXKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE39AC469999B046A946BB0FF24D7EA2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U7RUgEB1qshDRG3VJ/46bM1oRKRC/RdO/mjaZi5U+6QPsCMm/qHhO1KBHKzfkaFBZ/g+10GUi4a7VrUwGIGnCq3EVJi1xQLizS6FUeqVeAvABjRMHwOCelQUIx7JDChGb/dVHWdkQrE4KWNvLQvd1ccohnfak93hh3FpvXxPftEvrr7xwkfYhFc/c9m/4/ZmpvDZnIAQp/Sro9gXt4oJmJ8T0yFfCOphOphwuN1sz3PqRT+KlBPoRymvdZiJ88Vregd7SU6iCN8KnCE8DoPzz2mj5w9t2YzpAl7IXQaF9FOSBEq/h8lDGvTfIUqmcI8++cGxoH1SLmZmZIiYfeKQMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7703.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e716e5-3991-43a3-3c1a-08df0982695a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 06:13:02.7301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHLw2ZCJt/hiXP2HxtP/AAJzWl903JpW/m9sExiTmJecFiCY4t21I8TmIT8s5EfTWjDkUS+W6pPxVhNUu0q0MMT7E5zidbpo2+CD0ciDYlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB10381

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDE4OjQ4ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIEF1ZyAyMSwgMjAyNiBhdCAwNTowMDoyMlBNICswODAwLCBKaW5nY2hlbmcgSmkgd3Jv
dGU6DQo+ID4gVGhlIGRyaXZlciBjdXJyZW50bHkgZ2V0cyBhIGZpeGVkIHNldCBvZiBjbG9jayBp
bnB1dHMgYnkgbmFtZS4gVGhpcw0KPiA+IHRpZXMNCj4gPiB0aGUgZHJpdmVyIHRvIHRoZSBjbG9j
ayBuYW1lcyB1c2VkIGJ5IGV4aXN0aW5nIGRldmljZXRyZWVzIGFuZA0KPiA+IHNpbGVudGx5DQo+
ID4gaWdub3JlcyBhbnkgYWRkaXRpb25hbCBjbG9ja3MgZGVjbGFyZWQgYnkgYSBmdXR1cmUgcGxh
dGZvcm0uDQo+IA0KPiBUaGlzIGRvZXNuJ3QgYXBwbHkgYWdhaW5zdCBjdXJyZW50IGNvZGUsIHBs
ZWFzZSBjaGVjayBhbmQgcmVzZW5kLg0KDQpEZWFyIE1hcms6DQoJVGhhbmtzIGZvciBwb2ludGlu
ZyB0aGlzIG91dC4gWW91IGFyZSByaWdodDogdjEgd2FzIGJhc2VkIG9uDQphbiBvdXRkYXRlZCBz
bmFwc2hvdCBhbmQgZG9lcyBub3QgYXBwbHkgY2xlYW5seSBiZWNhdXNlIGN1cnJlbnQNCnNwaS9m
b3ItbmV4dCBhbHJlYWR5IGNvbnRhaW5zIHRoZSBlcnJfZGlzYWJsZV9jbGsgY2xlYW51cCBwYXRo
IGFkZGVkIGJ5DQp0aGUgSVJRIGVycm9yIGhhbmRsaW5nIGNoYW5nZXMuDQoNClRoZSBmaXhlZCBw
ZXItbmFtZSBjbG9jayBsb29rdXBzIGFyZSBzdGlsbCBwcmVzZW50IGluIGN1cnJlbnQgc3BpL2Zv
ci0NCm5leHQuSSBoYXZlIHJlYmFzZWQgdGhlIHBhdGNoIG9udG8gdGhlIGN1cnJlbnQgdHJlZSwg
cmV1c2VkIHRoZQ0KZXhpc3RpbmcgY2xlYW51cCBwYXRoLCBhbmQgdmVyaWZpZWQgdjIgd2l0aCBj
aGVja3BhdGNoLCBnaXQgYXBwbHksIGdpdA0KYW0gLS0zd2F5LCBhbmQgYW4gQVJNNjQgb2JqZWN0
IGJ1aWxkLg0KDQpJIHdpbGwgc2VuZCB2MiBzaG9ydGx5Lg0KDQpCZXN0IFJlZ2FyZHMsDQpKaW5n
Y2hlbmcgSmkuDQoNCg0K
