Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC23B2FCE;
	Tue, 24 Mar 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333241; cv=fail; b=bqBCwpvZUK1GZZ9Xy5KTPm7+IixDlc27YTzNkqESAhMmCwInqOXxkNIIJtbhAwUDpC+Yr4RHQIheajHjWGFZeqjLnjWiw45U+lKeGDcS/hEQJWQajotF1mTUfjIiO0mfcFttkVxNMZt4UCv3YzRjnHfjCx+NGsA8sg3iabmG4u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333241; c=relaxed/simple;
	bh=yL9iidld712OO1FLnIOCBpJpXkek35DemAg8upuoIEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smNSK9YBuYLj3B4zgUKVes/6YI+0YtG+CziZGS9fTKcb+a0ADe7e6aGp4VLJfuKq6BJrWwpAp+Jr6DTy8KoJFtON3+MjoZcWhhl7Zpo+5e5EJiawfaSns4PyzGAvTQKMfMpS5prxnKmXUcaperRlMeKVcEuK8TdlhiMGoHuEbwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uBfyaFJA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cwP4qOQc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uBfyaFJA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cwP4qOQc"
X-UUID: 903c3fae274911f1a39cd589f645bc18-20260324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yL9iidld712OO1FLnIOCBpJpXkek35DemAg8upuoIEQ=;
	b=uBfyaFJAIE4aIhowQSxzRS8xOHi7velxESdsoZPSHPsEfMke8TYvDOdFoEKcDdvu5yBO/PNAp97xIdqfdlvsIgX5ge10zYLdlil5A+dTWw4Y0nXTOCGh4cokufDBzihny/Wg2+1oahiwBSisGaYJO0VJzZmM5qLWjeY9H/t09IA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:009f2ec2-24c7-4618-aa86-714165f0c9b6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:de022494-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 903c3fae274911f1a39cd589f645bc18-20260324
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 350470536; Tue, 24 Mar 2026 14:20:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 14:20:31 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 24 Mar 2026 14:20:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuOHV5UVTqzLvhs97ee9XXZ5dvEuhRhtMSXW1DS50JnQMxe/B+0ImbYcb9kCnYOeAz/t0hFpYYNbFYoQwyJ+cPe8YryWYypm1SvhKMMBn2PTE8TgTFyaNBdg+MiMtCvew9Miwaw5gmdoFjg0BxlRr2mjpmlUQMWFzfmsMg1LLcoz9jXcmI/oWehh94lcjIwVYoI7SvJBuKIrFIpjxUFTi+j8r6OOidTAXz9NW9u9ozold6tB7lpUjrRzqpKkTdjkGaIMTLXyv8U7WBnyWhgIj6CO1l0ewF+JdfO7dFT2F0kjVDPCX+siFcnXOxymax+tyH0MxjfVitcoPsmC3E91Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL9iidld712OO1FLnIOCBpJpXkek35DemAg8upuoIEQ=;
 b=JbZsCNhhX/I3AeeK1D6GGuv9O480bYc4IYxbzgSWEqlVLdzTm2XvkBSUNeWOn/tQil2f0jHgTL4CaWravcjPKH6McxlevNSdkwwnHVgoohvRyJYHe9xe7j8S3Y3+/o7+vChJipbJpVqkAVrbNIC1aXwMcfpcW5VhvoTw0J0gPePc+cUehAiUrk95tQvI3KrvdbGvUS8usi/D0fqs/CxVMewv0AAtrllqow4EBlF97nVlMp+kerimlkAbPoHu9zQWDMkrx3EgLOT5mfLvXq8XwRbCxY1IBVhwDsKLaBnPYn39NFZFEVFuB75qu0o2o0T6DxhS6wKnP+0YyJQ+tNWhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL9iidld712OO1FLnIOCBpJpXkek35DemAg8upuoIEQ=;
 b=cwP4qOQcvTk/MrjEHLwSLn0NhHBpefZiQ/DHkt69VRveSR+WUbHANlzf3O+g17uH0CbWgIZI4TyhJYsv8zo6VqI7kjynPt3fecvLm0G/dlP9U07YQIfwRWMRvdaqGDgZEDNfSJgShORPcgqT30GYPFU2CeATn54J4kRtb1QLO9M=
Received: from TY1PPFA7F8C6C2D.apcprd03.prod.outlook.com (2603:1096:408::a64)
 by KUZPR03MB9568.apcprd03.prod.outlook.com (2603:1096:d10:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 06:20:29 +0000
Received: from TY1PPFA7F8C6C2D.apcprd03.prod.outlook.com
 ([fe80::5af7:8fdc:3497:1294]) by TY1PPFA7F8C6C2D.apcprd03.prod.outlook.com
 ([fe80::5af7:8fdc:3497:1294%7]) with mapi id 15.20.9723.022; Tue, 24 Mar 2026
 06:20:29 +0000
From: =?utf-8?B?TWVpa2VyIEdhbyAo6auY5L+KKQ==?= <ot_meiker.gao@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	=?utf-8?B?SmggSHN1ICjoqLHluIzlrZwp?= <Jh.Hsu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= <bayi.cheng@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?VmluY2UtV0wgTGl1ICjlionmlofpvo0p?= <Vince-WL.Liu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 0/2] *** SUBJECT HERE ***
Thread-Topic: [PATCH 0/2] *** SUBJECT HERE ***
Thread-Index: AQHcu0BG3PPNvTKcZECHCJwktrel2rW9Nh0A
Date: Tue, 24 Mar 2026 06:20:29 +0000
Message-ID: <e0f3de24c2a3fec1c05739f51c37d31a8f3b718a.camel@mediatek.com>
References: <20260324032624.1708029-1-ot_meiker.gao@mediatek.com>
In-Reply-To: <20260324032624.1708029-1-ot_meiker.gao@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PPFA7F8C6C2D:EE_|KUZPR03MB9568:EE_
x-ms-office365-filtering-correlation-id: 735412b9-cb7b-47a2-bfe5-08de896d7226
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ac8PGGZM+NC6hPYIZMpaZTgOq+xvCXE2Rnf+vz6WsKLrmEBi+DnVHTKDDzrZ5gqVlKQGPu4rsVwu/SRLLfnyFEDMII61V8VrSvxtGoNgIEZNhm5SYg8/fUUZPLkcj/BAKnT9Ae6fciE8euAJWszc/T+BPTBDm/3uaDBxBeSlMDgN81i4Nv5QQOuxyUwjWm05f98abrK7eyutePdZg8hBfk8us9c3TquMefstWH38K/gofxnDpSd8Tq/1qLpN3XMVreHX3p1kivqWdTrS63jxjVhGnZtSeEdMmmfWInn2TJDZwRCPlJSdH0hddYp3KtblVqHJM4ecNAkClZx+EID4JkgnUwyMVe5Ij+reRZ7Ed9hOidxV+X0THrskjgbZujpGEKsabbJaaiHTRNb+7Y318LpUfIxcNaKhABzVSr+3cctqs6Hp/VDWaezbCCarEazCnliw5STY/JDaAkqYiF2UvJvHlg7AKUaaE75IcJwL4goU3gt157ItAbLwOfHqZZV5OjUfcWMcKCVjM3ms93F3uDl9QEpD5EM5wnPoocYmXpHN/m8XoK/jBHKT0Z1FiZc5JPR/+vjF5RHZaYu34Gf+A2PDpXEgqm8nKqiltDK82zBrDN1L+DfCCPfFkpNrpck/hjB5ny8x5cj1AtRfL+iEATmW4QmEp8Rwo+J19BT96D75zKNMOpy69u8VocLG99WSulXdOIQ54dDyc6BzJO3432ub9lHiCsh9Sj+idxC0Cq0O6BjDzp0zgB8F8OBdDdaWwRfv6AKAro8sUB4AvSTjHJWi2HLhXPU1oqfO+b+bB34=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPFA7F8C6C2D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckMrZDRCWHNPN1BTeE0yaUdTQzlBcDczY0c4VDBhU04yOTd1b2xPMkNaOUs0?=
 =?utf-8?B?a3ErYUNaMlNtRExqWjRHdDRMOGg2WnorOFhRY0FlaExXQkh5YUU0bG1TcTZh?=
 =?utf-8?B?NHYzSTJURjVSaDNabjdZSk1kR1ZrNDhDZG9XbUhsQ0FMYUw1cTB1eS9MSlVB?=
 =?utf-8?B?ekdyb0UyWTU2eEVqT3JtcU9lYXZrNVQ5YWVQRGlvQjFqbHdzSG5ER3NSSzkx?=
 =?utf-8?B?MjlabUppbnBwM0JNdlBqeWFHQVlhaEFpUEZvZm9od2JNUVduUUVtWEppUDZ4?=
 =?utf-8?B?SjkrZUlwR2NZRnFJeDZPU1VubCt0cXUrNXQydzdybmxGcXFxZ2QrdzNJUHZH?=
 =?utf-8?B?MTNHRkNxQmh6RXl6TDlxWXR1VGRtMG9tbUZsWjhlaW1FNkE0VStMd2xZM2FD?=
 =?utf-8?B?b28rL0NVTTFZQzBoQnJucVpUMGErdmpRSStpczE0VWF2ZDBkbGVpMDNJVHRZ?=
 =?utf-8?B?aWZrZmxvTXRaVzA1OEtZWXlaNC9Xa3RSaHA5K1FpcEhtb0paaE1JRTg0c1Bw?=
 =?utf-8?B?c0J5THFEQ1BneU1PWHJsTDRqNTVpQlNsYWRFaXdtTGtudi9xeEhjeU04M1Ny?=
 =?utf-8?B?YTBrZGhNV2pMdDhqcU5UZUE1OGxRK0N3R1I2Yjhnald3ek1mejJrdHdqMUhj?=
 =?utf-8?B?UktGRGx3aVgybk1QNVMrMGU1NmhHeVRCazBZMG5FeXVVVFNYM0dibThnM3VR?=
 =?utf-8?B?Um9SVEViNXVORGR2Qy9NQjZGZm9qNFB1WnRWaHJqUFdKOW8xVlFxWnF4UktU?=
 =?utf-8?B?UkJiVFFiaDF1SUFKVlpDUDRWaXVCU2c0N05QSGcvajVSV3hVTnp5QVIrdWZh?=
 =?utf-8?B?dmM3MHM2K0xZZUYrMXlEMXdvVGFyaXlCSXdqRGFvRmNWMVVTWDdXKzA4SEN6?=
 =?utf-8?B?bTlRVXlEWVl1MnRicXZ2RkpaU0taVGdLNUI1Mk5Xamh4RWNHYjhlR3hVYVM4?=
 =?utf-8?B?ZERlQUcrU1gwUVJVbXRBWUFhbjc0N0taUVBTaDdyUXgyNC9LeTFnZXgrVkN0?=
 =?utf-8?B?RVBaaElMUTVvT1V4NmNRL2orM2QxYnczeWtsZ25MV3llT0V3SVEvNFNZSmtH?=
 =?utf-8?B?Vm1XdllvdDFzLzBlWGNva0IzSzJsZitOQkdWVnNVT0dGVlBBYWFhM1NSQS95?=
 =?utf-8?B?L0xjVXp6bUgyNzNscHM0eU5FU3dRdnpMRmhOaEFYaFlhYzdDWkh0akxVbTEx?=
 =?utf-8?B?UHZscm9GT1RFcTd0NU9pUG9leUNjNCs2bFA3NmNKZDBMVThLcUk2ci9nT0FJ?=
 =?utf-8?B?bWRoSktQMjB4d3lxaDhGQmNZa1djNFJESGhtQXF4Uk5tZE1tQVZadVpjK1ZE?=
 =?utf-8?B?TmUvbHE0SjFObjdBN284MHEzZ3FiaC8vZU1hY05hTDV6K3A5R2EzWjZWVjk4?=
 =?utf-8?B?Tm1lQkU3Vk52L0lWM1lReUNyUEljTE9xRFB3eTVxdEJJMGprb1FqZzBpL25u?=
 =?utf-8?B?TloxdkwwMGlmQTNOWWVDa3g3TmxqaVBkVUdVdVdPMWNRSlVyZ0JocHJHclZk?=
 =?utf-8?B?RTlkWTRhOG5aNkJGbnQybXpsY0VWblptL1orRk04NG54VkZ1TkoxdVVPdFhM?=
 =?utf-8?B?M0VnY2htM3ZqOUt4aThDWGRzRmlIajcybWVjUFZLTm1TZHN3RUVLVnJLa1Zs?=
 =?utf-8?B?aDQ3NzdqaWY1Uy9uVDgyeVRBS20yWEZLWnRUZWNOaHJjR0ZEMS84bHdoSHlQ?=
 =?utf-8?B?S0ZaV1VWNjFoalIwNlJid0lSam5nODBCeXFHS01LMk52Q2dPSEZNQk5FUWpx?=
 =?utf-8?B?VmU1MEFidmNINjRDeHFXUVNmOThabGg5ZXB1MlV1RGdLbkFuU3h6UC9ISVZQ?=
 =?utf-8?B?SWRadkJMcWZ2QUsxa0hHOGZ6bkU0SnNPOHZlV2tzWXNkWENuZ2psV05mVFhp?=
 =?utf-8?B?L2ppU0NoOE1leUNOYkFTR2RsSXFmSU5XR1JpandSdkhYQ21keSt5ZElHL3V0?=
 =?utf-8?B?ai9PenZkYkxqZS9KR2UySlFkcU96ZEdWK01wc1ZwdmRwb3puckpWOFo5ckJh?=
 =?utf-8?B?aTRrNkJ1VVFQcnhGd2o0U25uS1grOERFTkk1MWdRQkNWa1FZWTdNRU5mbTdy?=
 =?utf-8?B?RWhocHovejdBK3BIaVJhVHg5NTJUaGp4S3dFd0dVakxoV2djdWdXMmV5cldz?=
 =?utf-8?B?Y2hkUENYMFBSR2QvU0NmQ0NKaVlnOWlDQ3NWSXlJWUJwWTFuNWFPZVB6NHVC?=
 =?utf-8?B?bk04TmZYUmJoejljL0R2QWxIMmFpZlltcnBQMGx0a29XSE1vLzJtUG5EbGRB?=
 =?utf-8?B?bTFyYldlMU92WWlFRFV3bVJKeUw4ZmQzM00rVUlnQlNVUFpxVE5vK1FBNTds?=
 =?utf-8?B?bUNOOGFlWmVsSnc3cVZBRERUazJZZ0pUdzk4T1poWElDVVRDVlcxZkFvNlVK?=
 =?utf-8?Q?o7JoO42uvOkIowJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39BB680D174865468F227C028B066C26@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wKeAzhzCickFGQin+XW3xZm6BKGozNY+4qQ9a4ymGvRAh9KVjTzXmXVR3ayhTJ0/iItlBAGsbY3nzvhVZXo3X+xniySslgHeqpOG9QhoYyNA/SDggJ+S2OsZfB1kbHNI1psnvLBNwGViasg8RgzWpCFUpNwDxmJnpzGeqOA9jY/OX0Ek398c8cPxs+Q7DCGWdSDsImNleRZ2skQLfR1hfxRO7+cAZ7DA/pC17PRIOHUB2G/dFnjJnLIHUqqzKg5GPCq88F1x+a/EY+6N/5tKG3/foXYKuxX4ACXDO7HiyqhCkF37oIvf7NwoYd5tqpGGJd5/EJHBuBCW9AaWKzoxvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFA7F8C6C2D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735412b9-cb7b-47a2-bfe5-08de896d7226
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 06:20:29.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfGNsqUxYCHQUhjWCKX696bpYWbCoIbNheUrwta2YmACUOtknlsms967A1sgkM0kQFvF6W8Fx+FunP0pDCAra8LjLc7d+ttu0NONL7cKvwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9568

SGksYWxsDQoNClNvcnJ5LCBJIGZvdW5kIHNvbWUgcGFydHMgb2YgdGhlIHBhdGNoIHdlcmUgbm90
IHVwZGF0ZWQNCmNvcnJlY3RseS5JIHdpbGwgcmVzZW5kIGEgbmV3IHZlcnNpb24gc29vbi4NCg0K
VGhhbmtzIQ0KDQpPbiBUdWUsIDIwMjYtMDMtMjQgYXQgMTE6MjYgKzA4MDAsIE1laWtlciBHYW8g
d3JvdGU6DQo+ICoqKiBCTFVSQiBIRVJFICoqKg0KPiBUaGlzIHBhdGNoIHNlcmllcyByZWZhY3Rv
cnMgdGhlIGNsb2NrIG1hbmFnZW1lbnQgZm9yIHRoZSBNZWRpYXRlayBTUEkNCj4gTk9SIGRyaXZl
ciwNCj4gbWFraW5nIGl0IG1vcmUgZmxleGlibGUgYW5kIGNvbXBhdGlibGUgd2l0aCBkaWZmZXJl
bnQgcGxhdGZvcm1zLg0KPiANCj4gUGF0Y2ggMSB1cGRhdGVzIHRoZSBkZXZpY2UgdHJlZSBiaW5k
aW5nIHRvIHN1cHBvcnQgdmFyaWFibGUgY2xvY2stDQo+IG5hbWVzLg0KPiBQYXRjaCAyIG1pZ3Jh
dGVzIHRoZSBkcml2ZXIgdG8gdXNlIGNsa19idWxrIEFQSSBhbmQgb3B0aW1pemVzIGVycm9yDQo+
IGhhbmRsaW5nLg0KPiANCj4gQ2hhbmdlcyBpbiB2MToNCj4gwqAgLSBEeW5hbWljYWxseSBhbGxv
Y2F0ZSBjbGtfYnVsa19kYXRhIGFycmF5Lg0KPiDCoCAtIFNpbXBsaWZ5IGVycm9yIGhhbmRsaW5n
Lg0KPiDCoCAtIENvZGUgY2xlYW51cCBhbmQgc3R5bGUgaW1wcm92ZW1lbnRzLg0KPiANCj4gTWVp
a2VyIEdhbyAoMik6DQo+IMKgIGR0LWJpbmRpbmdzOiBzcGk6IEZpeCBjbG9jay1uYW1lcyBkZWZp
bml0aW9uDQo+IMKgIFt2M10gc3BpOiBzcGktbXRrLW5vcjogTW9kaWZ5IGFuZCBvcHRpbWl6YXRp
b24gdGhlIFNORkMuDQo+IA0KPiDCoC4uLi9iaW5kaW5ncy9zcGkvbWVkaWF0ZWssc3BpLW10ay1u
b3IueWFtbMKgwqDCoCB8wqAgNiArKysrKysNCj4gwqBkcml2ZXJzL3NwaS9zcGktbXRrLW5vci5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE5ICsrKysrKysrLS0t
LS0tLS0tDQo+IC0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkNCj4gDQoNCg==
