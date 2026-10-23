Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792752156;
	b=E/AndwFXQwn+dHu3LLYwSxk+0RzGTxw8gqy7btjf6I/szq3OugeeeC2bg2KrZG4Xk9PH
	 RvFJJyJGT0o7GZo8/ttRuE/NSxlLEmvI/19/bhpY2Nma7Z2678zQN/8ugnOxwVxkNk5ev
	 F50GavCgFxIdiyDH0Qci23Upcfkp0Z6GbiZ35NdQw/Avrh/wUvBKXx6/wAtkiTOn6UuNt
	 gLW0ckGq7qZfmXpivBNEcy31m4HGwX/IS9td1kiJAVHpHMC4pV52jkUpLbPeHMZhn7kqZ
	 dC8nfdga0h/hoq6qpguummca6tIYhFxzR5v62JCBcAw4x1ZNGDko2jsqRZGBLMtmj6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752156;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MimV4n8Sl8+4fuAU7ngqHrVLtCu88LROd7UIOI6J470=;
	b=DUrx66guFCpXXVnbqL+szHOxX0NBthfTzDnL7BVi6xK+mtmq8BcRkGbbuIT4DUFOZrpl
	 QeJIYZLqdBHLaArafIHEHN0npHSZi8mgrRBy1ThWvBoi9gVYXOUg7vsbFIC420ZrwBpXh
	 Kc/tm3WcA0bUmuOrzifZ5sdzHFmtHRhsQYP2KA505OgcbjVoyI4bPQf9Qud6vt43j+q2W
	 rfhmCknyPtqzJnXGNDxC/tEW5BZhOT7IhwQa8t19iSJtrpxnWUcbUySNsqGYTWh4R3FJ6
	 0svQM7va7jxhqL/B2fIQ3SurrHriIITihtjMT7YLGqoVYkzZPZA2KlOpTX5N5BATqlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.117
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E05606A31A;
	Fri, 23 Oct 2026 10:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkjwQFEQTe5S9b2JLSxyhcsUSEPThXX7OWF6L8lx4OKKxy5nDTQTPYk2k5dXyctEQmZzW/1FDe6AnHvTKQj6WORcDbwGhOuyKowuUrOIwKy1kuxqa2bhZSa5x3aFFzSI8Ws5F91DzxT40sQJpWgRSguzQb4RE6MVgu2VJ/F4ezmz66T7QAWXnWn7Ax76GCjZB61WLy4Ay8mKx15ny6YJmCGX4wYQWfp7UzjKB7EReMxSH81VIIVg0Pwe5bIjvnQnMKcwkhF5KdeL58tQF2yTnG8v5pvi1XzPd75UwmtuEEc+MgTaLn/Sx/j0ot3ne/KOnLbg/SUb0NHrQrQDT3Na2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MimV4n8Sl8+4fuAU7ngqHrVLtCu88LROd7UIOI6J470=;
 b=G8n0xhSOWTAlU9yyq9M71k05s/Hdv8S9ALDZS9Am44nWD1WvDoq5/h1PNf1BM53pFimmLcgURoO0hPZrX/nS2cBnOQj/YC5xufkFXG1+Vqc6szumOAieuf0DUbh2LYdWh6tUXlCXCY4Rruc0Y9UcwsH/6UZeLJitpI4lUqZMvN0PBW7Drf0G+VA2u6LZdUYo5Ff4fAkhGGYxBO2NZXJA7f/4bQG1Dwdl+ELc/etsXsi/7vxBocU10koiEidmAfPHouPXMxNBl4Kh2f47YhQWzQjayH6q35/l/GjwjqgpzRAA8YOjjaRYM0XbofeqosvUTVqbqPBEmUzr1E3ZWDhDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1172.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 10:42:23 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0546.017; Fri, 23 Oct 2026 10:42:22 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>, Mark Brown
	<broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 4/4] mtd: spi-nor: macronix: Add 1-4-4 DTR read support
 for MX66L1G45G
Thread-Topic: [PATCH v1 4/4] mtd: spi-nor: macronix: Add 1-4-4 DTR read
 support for MX66L1G45G
Thread-Index: AQHdYg/KVZfybvK8TEC2m9bQP1XDNbcJfCYAgAF2GCA=
Date: Fri, 23 Oct 2026 10:42:22 +0000
Message-ID:
 <ZQ4PR01MB1202579E830FC73D87BEC337F2642@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
 <20261022102614.75696-5-changhuang.liang@starfivetech.com>
 <DMBD4AK6UXKX.23K3797G1OUS0@kernel.org>
In-Reply-To: <DMBD4AK6UXKX.23K3797G1OUS0@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1172:EE_
x-ms-office365-filtering-correlation-id: 61ff48c8-f6be-475b-639b-08df30f25238
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 zLM68qCoxyjN59UyO775kN1UkZw//41c4YusQ0X/tOZ4WQlbZh9+91JmnskxmmWxE6EY7K0qQ4/9+Ohd4fV9WpO8mah5Bh3etqZD9zg3VrnI79QwOf7WxHnCq2J9BcTIB3PyryWPNRt3W6Nsqh5v43inUtkVCTI9929ivtWcktXuPxooCjHPn0uX0L1nOg59Vsid9vS0izqLZD2oj7A6MlTOvsNEX1mohszcxYOoTwAUUNBRdcLL1FRIlFkGcciH1diegFI2MNYgdV1t8SnYK4ft+8yxX5/6qAnDGmNyF7V9f7nBnY2u5x86jTm+ZP4P9fHQbVlLYQT7UOMBms5aMRl/D9TKdpDuCG8A9gJPkGxKTGLzFGGAbuzwMj6bzeqIUBdE0LbkzrH/i7eJe0JDSMaHuQQsw6s80sF72rott7TNaBD0+nidcSsib1E3HjZlb/9urVv8Rl9OvVzS0O6ii2vbS3qypoFAH28ss2ypS1JBIMlKv+PvRrofQyxUWESs0WYBxV8TcHme9AIIwQDXj5mVoYqrXBWnzjVzxHRwl54=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVpBWTRoTXI1RHFsQXdMUER0R3FVeFhyb0RINk9WNHRJdE5CQlJaUmdtQXJm?=
 =?utf-8?B?NTFSUHJnU3k5VDBlWHpGRFlQWmU4NDFEQ1RFbWFtTjNtRjZKQ3hyY1dxZklQ?=
 =?utf-8?B?SnJ4Q3BaUG92NjAwRTF3WDF6a3B3bUkyaTdqNmpxQXBNT3VjRjJXdEJHdWRQ?=
 =?utf-8?B?Nm8zRTFoU3NjeGthaG1LcWY2NExpUldFd3RqNzlNalpUVVBDbkNmOThqOVJB?=
 =?utf-8?B?Tmg3bEN3TFJQNmhocURSbjNtYWlON3ZWejVUakZuZkdtTVVPZmhLNEQxMHpP?=
 =?utf-8?B?UEtsNVFyc0NlR1dtalpzSmNyTVFBZEd3QTdDWnJNeUk0dlR3N3gzNElPT3Z6?=
 =?utf-8?B?d1BKeldQbHNmZ0NmN2RpVGJaTEFob2V1NEdFNXp4M0xWc0d5cURmdjNkb1VO?=
 =?utf-8?B?blRaM2ZyQlJMZGo5RGVnNEtZa1pPUjRzc1RJVGc0VTl0Q0RjTHg1MVNZRHpP?=
 =?utf-8?B?V2tGcHVGRFF2QWIydmt6T0FFUkpUeHBLOXVkUHlJODAxMEExdWFkMUVIMytI?=
 =?utf-8?B?Nk8rUjIyUDRGcUd1K0JTUWZVSFRkeVJjQnh2RHpRTExxbEMwb0d1MVRKQTdN?=
 =?utf-8?B?Qk56UXhXWU9ES3M4SFhSMTcwck9mbXlITzI5V1BXa2FKNXhSOWtzYjRJMm11?=
 =?utf-8?B?a0ZIM3BrU09hMFlWNGZGMjYrQzVGZ2FnYXNQQVhPT3dpVjhIOWNhK2crbklm?=
 =?utf-8?B?OFVwYmdkNzJIQ0FSRFdlVUxvYmZ0a0lCYlcwanlCbDlnMDFpckZTZDJPdnFT?=
 =?utf-8?B?TlVOUU5YWUdlOXNqeEcwSjBPeGI2ZHhOUlZOWjY0WE1hMzlpMFdpSEVQRCta?=
 =?utf-8?B?WEZtRW8vNzBZeDJDcE44V3lFRUI5NHhNNm82ak91QjNFK2ZkU2xLc3pUeVNt?=
 =?utf-8?B?eit2aSthUXAyd1E4ZXROejFlejhzYVpNcmpkVkJseERhdTlBWU9rd3BTczdr?=
 =?utf-8?B?RXYyM0ZqcVhpQUhSVThOdWRQKzFObWxQMGp2N2VicUJBdGV0QmpTajRuWEQx?=
 =?utf-8?B?RUtuUVB3YUxsMzNvNzg3a1ZsY2Nvc09wQW5RYzNzSm1nNDF0RXNKTWQ1VWFu?=
 =?utf-8?B?bXR2Q2lrelR3cTF6dXVhL2xQSmtFb3lQUVBBZUVYanVTUTY4STV3K1NoVmtT?=
 =?utf-8?B?QjNETDVOaDZTT2NpQXg0Umh5endxQmgwSGUxMFJZM3ZTYmtuMWdrVjVCbHdL?=
 =?utf-8?B?UTllbDZteWxvMmlJd3NrQ09aZndnSDdPNmFwWVZlUVZoa2R0dXYrRDZjQ21R?=
 =?utf-8?B?dm5DaFdnNmQvblVBZDZseS9CbE16VlNzUEpLaUN6R3U1SkpKOWwvbk91K3hI?=
 =?utf-8?B?dGJ0MWc1VmU3SHZ0MEQ4QVhDVlpEeXNlbmZtVkloOFM1U21PUGZuZGM2YklK?=
 =?utf-8?B?R25wa20rbUlKRXowdEgydWJETzFBZmVKNkxvWHVmUFFnUjVFMEZGQzNRdkhI?=
 =?utf-8?B?WG1uNTRxMlBZL2REbk1sSVdvWWYyV1NzL3R5dTRMNFYrUHNuTzV3d2JXRkNX?=
 =?utf-8?B?NVZPMGZyaDVMUmdKaE1ReUtTbmQ2NnE5SUFMUW9mZXFmb3FiU0JTV25JRVlm?=
 =?utf-8?B?NlZEdkNrRS8xZ0FHTklnanVkMzV6RXJVNjMrWXgxRnBuZjM5eWZUcUpJU0dZ?=
 =?utf-8?B?YXNza3BMZlZsZ3hQS3RTYWwwYjRXOVFMa3d5TTNvcm5NU09jZ1dVSXF3MURY?=
 =?utf-8?B?Q1lxSm94T0xxdmMwSldkSzdiRjk3VEp2KzB0UC9pQTNEV3RDK1lrSkZGYlBD?=
 =?utf-8?B?Mm1RTlZWWmlRZjE1VXN6TnlBRGQ0OXBZV0JoRzVSZEJDQjljUHptckVLOEpq?=
 =?utf-8?B?SDZuOTVSeWhSUFlxWVFaaFVzVkVEQWgvZkFaWGlSZlQ2V05mL0NQRlp1RGJW?=
 =?utf-8?B?QUdySnVyb1FUWDNiMytDaUYwc21ud21ZV0NVWlZMMHVYZjFXN0pqeWdkVklY?=
 =?utf-8?B?UmVkYmlZOGdxRzN1NVRNV09xWmhGSjNTTUk1d2l5eWJWbEhGdmdKcStFaVpM?=
 =?utf-8?B?cEFjRWFrV0JQTVBmcDJNKzRsdkN3bFJpd1VoTVR2V0UzUHpUeEtlNGJKcm9G?=
 =?utf-8?B?emJ5MGZFTndNeEIvVXF2TSs5QkQxVHhQWXNyR0I3S2pWbWNrdEJSc0VmMmxl?=
 =?utf-8?B?MkFwRThOdEZxNm1HdHd3ZlhNNkFoR1NTSUMvK2ZFZ1NpY0I5NEp3Qm5YSmxw?=
 =?utf-8?B?ejlyQlJYQXVYN2dEVU1kTG5veTZVaVhKdnBwejNOdnJyZ1lpbG4vMmovZE1k?=
 =?utf-8?B?Kzc1eHJPenBoaDQ5Y2xNQnBRUmJiaHREOE5xeHRscnJWaXFWbE4veFpTQzJt?=
 =?utf-8?B?YmRUNnY4QkcxaTAwdUNwK1ZRYjZLRWpybEMvVzR2NHdOMTdIMmswUGc0c1pW?=
 =?utf-8?Q?SlxbgEYGpughU/vc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ff48c8-f6be-475b-639b-08df30f25238
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 10:42:22.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnRZ6cC5740W0pYiiCzcTqeLlK6x3L1ooJTyWNUls93QdCW3A/SZ+j7DG32mI+dhezY9gKdJwspd39fI6VlME8lCD8tnlGjhYRwkau/KpStOFug/iMK8AFlNJw4POwaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1172

SGksIE1pY2hhZWwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IE9uIFRodSBPY3QgMjIs
IDIwMjYgYXQgMTI6MjYgUE0gQ0VTVCwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBUaGUg
TVg2NkwxRzQ1RyBzdXBwb3J0cyB0aGUgMS00LTQgRFRSIHJlYWQgbW9kZS4gVGhpcyBmbGFzaCB1
c2VzIDYNCj4gPiBkdW1teSBjeWNsZXMgYnkgZGVmYXVsdCBpbiAxLTQtNCBEVFIgbW9kZSwgYnV0
IHRoZSBrZXJuZWwncyBTRkRQDQo+ID4gcGFyc2VyIGRvZXMgbm90IGRlcml2ZSBhbnkgU05PUl9I
V0NBUFNfUkVBRF8xXzRfNF9EVFIgY2FwYWJpbGl0eQ0KPiBmcm9tDQo+ID4gdGhlIEJGUFQgdGFi
bGUNCj4gDQo+IFNvIHdoeSBkb24ndCB5b3UgZml4IHRoYXQ/DQoNClBlcmhhcHMgbXkgY29tbWl0
IG1lc3NhZ2UgZGVzY3JpcHRpb24gd2Fzbid0IGdvb2QuIEZvciAxUy00RC00RCwgaXRzIHN1cHBv
cnQgDQpiaXQgaXMgaW4gdGhlIDIxc3QgRFdPUkQgb2YgdGhlIEJGUFQgdGFibGUsIHdoaWxlIHRo
ZSBkdW1teSBjeWNsZXMgYXJlIGRlc2NyaWJlZA0KaW4gdGhlIDIzcmQgRFdPUkQuIFVuZm9ydHVu
YXRlbHksIHRoZSBjdXJyZW50IGZsYXNoIG1vZGVsJ3MgQkZQVCBvbmx5IHN1cHBvcnRzIA0KMTYg
RFdPUkRzLg0KDQo+IA0KPiA+ICwgYW5kIDRCQUlUIG9ubHkgZmlsdGVycyBhbHJlYWR5LWtub3du
IGNhcGFiaWxpdGllcy4NCj4gPiBUaGUgZXhhY3QgbnVtYmVyIG9mIGR1bW15IGN5Y2xlcyBpcyBh
bHNvIG5vdCBkaXJlY3RseSBnaXZlbiBpbiB0aGUNCj4gPiBTRkRQIHRhYmxlcy4NCj4gDQo+IFdo
YXQgaXMgQkZQVCAzcmQgRFdPUkQgYml0cyA0OjAgdGhlbj8NCg0KSWYgSSdtIG5vdCBtaXN0YWtl
biwgdGhpcyBvbmUgaXMgZm9yIDFTLTRTLTRTLg0KDQo+IENvdWxkIHlvdSBwbGVhc2UgZHVtcCB0
aGUgU0ZEUCBmb3IgdGhpcyBwYXJ0PyBTZWUgWzFdLg0KPiANCg0KIyBoZXhkdW1wIC1DIC9zeXMv
YnVzL3NwaS9kZXZpY2VzL3NwaTAuMC9zcGktbm9yL3NmZHANCjAwMDAwMDAwICA1MyA0NiA0NCA1
MCAwNiAwMSAwMiBmZiAgMDAgMDYgMDEgMTAgMzAgMDAgMDAgZmYgIHxTRkRQLi4uLi4uLi4wLi4u
fA0KMDAwMDAwMTAgIGMyIDAwIDAxIDA0IDEwIDAxIDAwIGZmICA4NCAwMCAwMSAwMiBjMCAwMCAw
MCBmZiAgfC4uLi4uLi4uLi4uLi4uLi58DQowMDAwMDAyMCAgZmYgZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmICB8Li4uLi4uLi4uLi4uLi4uLnwNCjAwMDAwMDMw
ICBlNSAyMCBmYiBmZiBmZiBmZiBmZiAzZiAgNDQgZWIgMDggNmIgMDggM2IgMDQgYmIgIHwuIC4u
Li4uP0QuLmsuOy4ufA0KMDAwMDAwNDAgIGZlIGZmIGZmIGZmIGZmIGZmIDAwIGZmICBmZiBmZiA0
NCBlYiAwYyAyMCAwZiA1MiAgfC4uLi4uLi4uLi5ELi4gLlJ8DQowMDAwMDA1MCAgMTAgZDggMDAg
ZmYgZDYgNDkgYzUgMDAgIDg1IGRmIDA0IGUzIDQ0IDAzIDY3IDM4ICB8Li4uLi5JLi4uLi4uRC5n
OHwNCjAwMDAwMDYwICAzMCBiMCAzMCBiMCBmNyBiZCBkNSA1YyAgNGEgOWUgMjkgZmYgZjAgNTAg
ZjkgODUgIHwwLjAuLi4uXEouKS4uUC4ufA0KMDAwMDAwNzAgIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgfC4uLi4uLi4uLi4uLi4uLi58DQoqDQowMDAw
MDBjMCAgN2YgZWYgZmYgZmYgMjEgNWMgZGMgZmYgIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmICB8
Li4uLiFcLi4uLi4uLi4uLnwNCjAwMDAwMGQwICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgIHwuLi4uLi4uLi4uLi4uLi4ufA0KKg0KMDAwMDAxMTAgIDAw
IDM2IDAwIDI3IDlkIGY5IGMwIDY0ICA4NSBjYiBmZiBmZiBmZiBmZiBmZiBmZiAgfC42LicuLi5k
Li4uLi4uLi58DQoNCj4gLW1pY2hhZWwNCj4gDQo+IFsxXSBodHRwczovL2RvY3Mua2VybmVsLm9y
Zy82LjIvZHJpdmVyLWFwaS9tdGQvc3BpLW5vci5odG1sDQoNCkJlc3QgUmVnYXJkcywNCkNoYW5n
aHVhbmcNCg==
