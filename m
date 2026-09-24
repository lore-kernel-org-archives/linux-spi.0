Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886753B9DAD;
	Thu, 24 Sep 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245534; cv=fail; b=e5WtxqjqUsxG+TGsweAEOp2ylTRntn83hoRZQImu0x8YEaKUbYhHwhOa8As95JytfzA8x1ywOz7xOMRVU+mNTOfszpSWboS+25nL1GQYk5Z6akowsvp93SGwCh2+0/xZVZl1OpvRMeW4Ozes3O+m4RbL7AV3/Yyq5ZmfYxJiAsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245534; c=relaxed/simple;
	bh=cOGFbkHhuC8aumJdBOiFB2gJuyIHlLy3ZyR5s/2bg0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryqTHT3cLX7gcXzBZwrfDQp/42r2znk6uHq3RN1tvh3WSIm2Sy0IfVJ7B+adQJDJt+qIm8SwLlnrl/VHp/F9bYf22TqiXhUJS7e8z+oeGc8Jcz+o07QIJ4Iev4CXTJ33y8pIvM7oNYVpvv3meNxZta17dCv+JnWiXqaYU3Lizow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=viZcL4Rd; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="viZcL4Rd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnzMs+k6VpBSEyvmiuTh0dw+3KEbSKAMowXTyymnEBp5HuBecLU0WcK2bSt2LX9SLWNVop3InqMbl879A4wW77XfjPhBG/K/Fx7nUIx3w6Bm3VzvGjUmMKONAG3bP316bCFobugUSnguRbReIlmNXJoDiXRD4j/xvFzTHBKSE8q2um4d8TBjhKF1FSPkV/K8KpNpe+PQ30awKzXJtAMhbVhOlhmtF/8Y4hqJ4nkCY+u0oj22yHXj54JflCFfxj4mSgpdQDg+M+2pP3ZOhDOxXphiztNlbjZxtKrnX9XTy905eXl0VZyGJgEu5/xGVB9YtZHFEuF5FNiG6Ecd+o/Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOGFbkHhuC8aumJdBOiFB2gJuyIHlLy3ZyR5s/2bg0g=;
 b=vNSKlPbMvRQ1vOg3fTiURMPZrnUeHVPmQbISOj27wvz3TZatxtHsKENjYNlrBom4wH4qhpJlwgVhuK4r3x/U9iQaX+oS7M5//RskuO78ZhJH17hSJgETBWjcXtAFpQ6yv1kVZoH7q1Xi3mVi1Zm9z299Z1Pjf985j80afId7KF/ThqD5qtADsGgdoI5hC3h32gaq/2OVvk2aCWnJ1wVZCTIEkZ/P4q5r7fizbj0Alj6eTu9hTEal4QawEPDi0YMT/CCMVZmpaQ7OPOiYdNWVFgOFRJ7VQB7+++2eCBcubjnxjnD898kqb0Ia7S4/qqI0u6ujxpHJlIA1C4rghnSzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOGFbkHhuC8aumJdBOiFB2gJuyIHlLy3ZyR5s/2bg0g=;
 b=viZcL4RdGJzNv1jU+1ONYyANqqcaFI9t+0yMHS+iW5tjPMY1MAWE7VhpiJ7pji5GAtLLHIMiioaq/ixiuXsAwwWahFoq6Nm/Gj78n++IVbCQvR95cgKAbbK+SzptTjdzbDie3+rD388jnTB1Ty9YZXwrujVJACwNiCaRzC3hX2fdtwlon2+Q2SCe5X6U+1AU9FxJtE542KDz2ACPGeT0yp1Ld74LpcLY3HdunZERhvO8IdwiSLmbDoFNEmcR7f/723dAIApbaFK7+ESLBIswBjtrZ5WJnaL7staokcXC2lH1DGdJJ+Qxy2P17v0cyl80fuIFJj1aGntThdKKMaBhcQ==
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13)
 by VI0PR04MB10877.eurprd04.prod.outlook.com (2603:10a6:800:25d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:25:25 +0000
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb]) by AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:25:25 +0000
From: "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>
To: Michael Walle <michael@walle.cc>, "Bough Chen (OSS)"
	<haibo.chen@oss.nxp.com>, Han Xu <han.xu@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
 reconfiguring MCR0 and DLL
Thread-Topic: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
 reconfiguring MCR0 and DLL
Thread-Index: AQHdHnn8mtV/xpfGAUqE7UZWq2EG2rbd3BGAgAAE/gA=
Date: Thu, 24 Sep 2026 10:25:25 +0000
Message-ID:
 <AS8PR04MB8820ABF469B46AD6AD36AD2490812@AS8PR04MB8820.eurprd04.prod.outlook.com>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
 <20260728-fspi-clock-v2-2-dbe786a4a6eb@nxp.com>
 <DLNGOZHD5KI6.26QUK1IZB7UJY@walle.cc>
In-Reply-To: <DLNGOZHD5KI6.26QUK1IZB7UJY@walle.cc>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-24T10:21:23.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8820:EE_|VI0PR04MB10877:EE_
x-ms-office365-filtering-correlation-id: e75632b3-f38d-4188-abb2-08df1a2625da
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|366016|38070700021|11063799006|3023799007|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ni/BWHqHupHqsFl25Le0uaXRwCR4bX9glcRDTTQqzxXAVWp3YsZ/GAMZ5KciMmsGjLbm4X6FagYC+82GxA/VPI+ygn8iAlInBXcYR6/4jncRxM03mTbE38uANAZ27ZpK0ydmX4uUF20jE2ugDJQeg81U0NQJxlUihoQgaVWq/I1f5T8QB9POdxXNllhfJ/mn4luKJMjA/f1uFLiVZSumVI1GNhcefy+cfDcA74JqR1Qhwg6AR0k/ceDfEPdywyBU+CD5+Mtet90Eq+8tgyG1Y5YTFqDgC1FkVs0Bts6klu+x5euv7Mizjs0c0KaioN9xRykLnq4ck4MozfwOgcxI7C2slgwbOlD7Lp3da5//tzHFCjljcLCSxbLGT/9vmDhm6TXc4zcXDX0euwMUNun9J3WhTAfAFQPjk+N6VCJx3uvfWSKWwE4UCKqCy9gHNmTRu7eGg94WUB4vIPbIPblIYS73AoS8ssWJyA2gZxvrt3kU2zMn1GsjUhn4Q+NROmyXsMI8XvKyzhiz3BmA3nuZMqorB3fN91Oty9h4xNugEgb1jtWCi+Cdl43mtfe/lb+uciuJDKOItjL86zYlEnoVmle9UDYoLStPSl9paknEwLPEfzy/SUPearuGvoyMNfrzdPIiWcBxQSTQMrXcXJsD7ZbW3b+aqXFPk+kN7hFy2EnTjDqcOS2UuYnHe9fV32sJLotkWdlsMXE/7/s9bZUFf0uk2v3Kenhe1zSwMHcLmbg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8820.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(38070700021)(11063799006)(3023799007)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjFrdlBpTURRQ2labkdUZEg0eWZtQ1pxaklXZFRSS1dUd1YwWXZWaU1Ja3d5?=
 =?utf-8?B?emVBK0tJbmI0eW1MMG9yYjhxNFlRMnRmb3plbXN0RnZTeUNtNktIUjQwZGdi?=
 =?utf-8?B?MDZNd2l2V2hPUGh0azlJR0wreXFtNVpybmZlNVJhUkNnbkVicXR2TXkwVFgx?=
 =?utf-8?B?WGhjNWlwSlVTWDM4NkhxMWtqWUJ0UVNEM0FnOW1TaHN2cEkyS2dSQ205aWtm?=
 =?utf-8?B?RVFZazc4MlAvbGJqY25FWG1zdWo0bkpVaDhKOThpR2VvQTNDTUFpRUhwM0li?=
 =?utf-8?B?bGxRV3FzR2c1N1VUbGhBS0xaREd1YmFYZExic3QxRnNJSURsSmZXMGJaQXFT?=
 =?utf-8?B?L3VIWi8vc1Fnbi9keFJ1L255MkZHQWtwQWJZWGVVM0kzWXhKblVnK3k2RHBR?=
 =?utf-8?B?T3d0ZU9xYmJxV3YvR2l6TUlreUZ5WTNCdGxPZnU0MXJGc0liT25xekVjcFY4?=
 =?utf-8?B?bHE2MkFaVW9LdkNRbkxUMlJ2SFo3ckgxVmExbkEweTUwTkhpbTNtbG9STzVi?=
 =?utf-8?B?MStQYkExaGNNNDBzSTNud01vQlAzYy9sZk1rcjgvQkdwYTR2Y3ZLQ2IrUVFh?=
 =?utf-8?B?TGZmd0lBWWVLTnVsVFF4emI1UmRmS1dlZlQrTGU3N1A4RTh5MityMjF1dUk4?=
 =?utf-8?B?SWFjOHJ0M2FBUytYaVBQOXB3Ui9XUS9JL1poY2hHdUhzdCtnRXY5bUpGUko4?=
 =?utf-8?B?YzFOTWFBM1prU2lOOGZnU1YrckltVVZxamFUZUhlNHR6Q29KY1dKS0ZFMzAv?=
 =?utf-8?B?UlB4UVNqMDlSb1Q3c0g0OERvMktvYU5TYlFTdlBCQVByZDJhY0Z6M3R5SjFG?=
 =?utf-8?B?emd1N0pmVDcwS3JzUlU2aXVOM2RzUGpJOWlvQmdXTmNpbzAzMGtid1J3SnJr?=
 =?utf-8?B?MktjMHYxeDlOYk1Nd2Ryc1ZyeVdyU1BLVWZoUkFDRDNHZ1NWTE95WEY2di9r?=
 =?utf-8?B?ZGNrVTZFTTFzNHJvamdYZWN0Yjc2bUlqL2g4RjcwdFVpY1Z5a1JXNUhGS29x?=
 =?utf-8?B?RlZDbVhvQlQyWm14emM5bjF6dmZxRCtudkxreXZHbUtrSWJ5MWpyM1l5VEdt?=
 =?utf-8?B?V01sSGE0R1JrQjJIMTFCbzV1VGFkMjZsRWtWVWpjbFgvOHF0MHh0VUdrMVE4?=
 =?utf-8?B?SXI1UmtoZmhFU3BFQmZiUi9mSFFhQjlFVEJuL2hKU0cvZ0VrbGprOU5oL2NC?=
 =?utf-8?B?S2t2NjczRmlBV1hjeS91aTN2V1hndkllVDF3SS9keXB4UE9zdm11bW1LeGpR?=
 =?utf-8?B?QXErZ2NMM2hZbjhsRldVeDVDZ1hkUWpLVGZKSk5DMjBKazBKdlRZZlVWNkJZ?=
 =?utf-8?B?NVNpbENmNkUwa1Q0UzFaWHBIbklsSGJ6Y2thVmliK29JS29UMmRxam92V1dC?=
 =?utf-8?B?UGt0bEpYaDdoZlVaWjJ0TVZUTFhNY0lpYlZCTTBBbmhkVXBVa1JEUkljMHBr?=
 =?utf-8?B?NTdFbDd4dzIrR3BBSWgycXFrSEtuc2xXT2hONHBzQUxxYTNWSWs3VU1qUFdS?=
 =?utf-8?B?M1VwYS9WbEtlUDVlRzBsdFd0U0U2ZWxGc05ybVlCQ3podU1ydnFrYnIxeGpM?=
 =?utf-8?B?SzZJall0TWRkYWRHdXZvVlVvKzFmb3VrNi81QzhqL3pWTzFSS1pYWU0wOUtK?=
 =?utf-8?B?dGZsM0FoTXBkMnVxb0x1QjZlSlJVeVhJZVdCZXdTbUZEdXBLanAya3hpWG9n?=
 =?utf-8?B?OUdHeG15d3FNNGJsSHdXOG5ORlRSMXM2WThrbFZ3eEcrUEkyQWtvcHZEWjZp?=
 =?utf-8?B?bC9rTHZtNFJmYjRPM1BVdkZ0czF6ZXN3OHRXZ3NTQXZtWSt5TlVOZ2pIdlRC?=
 =?utf-8?B?bXZNWFlyc0RnekZlcThmcUhSRWw1eERZaUZJd3p3bENpVGE0cnVEdklReVlB?=
 =?utf-8?B?TzNRZitHK1FuVzBSVjNRVEpyVUQwaGkvRFNhWm9sTWhwaFNIbi9WR05wZDhi?=
 =?utf-8?B?dDRUNTRFeDNrNjhqMlVsb2U2QVBvWUhzcTk5ZFFQK0J6aXQrR2VJcVlmV2RL?=
 =?utf-8?B?dC9nRFNFbHNHbmh0TjdvaUNwbSsyellCSmJUa0paZys0byttLy9ZaEhraE9L?=
 =?utf-8?B?ZGlJWFRtS1k1TEplZW5zWTB2VUlWaXdIY1U3aEtnQTYzQm1OVjdkTjlUdW15?=
 =?utf-8?B?Vm5QYzBVVHE5aVFiRVhpUlZjN3A1RUVuSWRPUW4vNXZrUGp0bVBrQlpPZjcy?=
 =?utf-8?B?NTc0T2FaL1NwOXh1QWVBUGR4SG1hTXJ4emp3cmF5QmpPdHQyRnNtUG5lRUh6?=
 =?utf-8?B?M0gyLzFaemhBWkpWMlBKR3VqRGZid1k1WnFxME5PQ2dYZzVhT3NYbEZ1aW13?=
 =?utf-8?Q?Epc5LwWvF7d6+W5QR1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8820.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75632b3-f38d-4188-abb2-08df1a2625da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 10:25:25.5461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0n2KDLePWzSn25CuTrug9moURxK4xnwZ9mY/7JVrJui2KIW808NntDDnQ6OkcGoF5ktZKCOTYubm3nqp+6oLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10877

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0
ZW1iZXIgMjQsIDIwMjYgNjowOCBQTQ0KPiBUbzogQm91Z2ggQ2hlbiAoT1NTKSA8aGFpYm8uY2hl
bkBvc3MubnhwLmNvbT47IEhhbiBYdQ0KPiA8aGFuLnh1QG54cC5jb20+OyBZb2dlc2ggR2F1ciA8
eW9nZXNoZ2F1ci44M0BnbWFpbC5jb20+OyBNYXJrIEJyb3duDQo+IDxicm9vbmllQGtlcm5lbC5v
cmc+DQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hl
bkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvM10gc3BpOiBzcGktbnhwLWZz
cGk6IGVudGVyIHN0b3AgbW9kZSBiZWZvcmUNCj4gcmVjb25maWd1cmluZyBNQ1IwIGFuZCBETEwN
Cj4NCj4gT24gVHVlIEp1bCAyOCwgMjAyNiBhdCAxMjoxOCBQTSBDRVNULCBoYWliby5jaGVuIHdy
b3RlOg0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+
IEluIG54cF9mc3BpX3NlbGVjdF9tZW0oKSB0aGUgUlggc2FtcGxlIGNsb2NrIHNvdXJjZSAoTUNS
MFtSWENMS1NSQ10pDQo+ID4gYW5kIHRoZSBETEwgY29udHJvbCByZWdpc3RlcnMgKERMTHhDUikg
YXJlIHJlY29uZmlndXJlZCB3aGlsZSB0aGUNCj4gPiBGbGV4U1BJIG1vZHVsZSBpcyBzdGlsbCBl
bmFibGVkLiBBY2NvcmRpbmcgdG8gdGhlIEZsZXhTUEkgcmVmZXJlbmNlDQo+ID4gbWFudWFsIGlu
aXRpYWxpemF0aW9uIHNlcXVlbmNlLCBNQ1IwIGFuZCB0aGUgRExMIGNvbnRyb2wgcmVnaXN0ZXJz
DQo+ID4gc2hvdWxkIGJlIHByb2dyYW1tZWQgd2hpbGUgdGhlIG1vZHVsZSBpcyBpbiBzdG9wIG1v
ZGUsIGkuZS4gd2l0aA0KPiA+IE1DUjBbTURJU10gc2V0IHRvIDEsIGFuZCB0aGUgbW9kdWxlIHJl
LWVuYWJsZWQgKE1DUjBbTURJU10gPSAwKQ0KPiA+IGFmdGVyd2FyZHMuDQo+ID4NCj4gPiBXcmFw
IHRoZSBSWCBzYW1wbGUgY2xvY2sgc291cmNlIHNlbGVjdGlvbiBhbmQgdGhlIERMTCBjYWxpYnJh
dGlvbi8NCj4gPiBvdmVycmlkZSByZWNvbmZpZ3VyYXRpb24gaW4gYSBzdG9wLW1vZGUgd2luZG93
IHRvIGFsaWduIHdpdGggdGhlIFJNDQo+ID4gYW5kIGF2b2lkIHJlY29uZmlndXJpbmcgdGltaW5n
LWNyaXRpY2FsIHJlZ2lzdGVycyB3aGlsZSB0aGUgbW9kdWxlIGlzDQo+ID4gYWN0aXZlLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPg0K
PiBUaGlzIHdpbGwgYWN0dWFsbHkgY2F1c2UgdGhlIGZvbGxvd2luZyBlcnJvciBvbiBhbiBpLk1Y
IDk1IDE5eDE5IEVWSw0KPiAoaW14OTUtMTl4MTktZXZrLmR0cyk6DQo+DQo+ICAgbnhwLWZzcGkg
NDI1ZTAwMDAuc3BpOiBETEwgbG9jayBmYWlsZWQsIHBsZWFzZSBmaXggaXQhDQo+DQo+IEFueSBp
ZGVhcyB3aGF0IGNhdXNlcyB0aGlzPyBJJ20gcnVubmluZyB0aGUgbGF0ZXN0IGxpbnV4LW5leHQg
a2VybmVsLg0KDQpIaSBNaWNoYWVsLCB0aGFua3MgZm9yIHJlcG9ydCB0aGlzIGlzc3VlLg0KDQpJ
IGNhbiByZXByb2R1Y2UgdGhpcyBpc3N1ZSBvbiBteSBzaWRlIGFsc28sIHdpbGwgbG9vayBpbnRv
IGl0LiBJJ2xsIGdldCBiYWNrIHRvIHlvdSBpZiBJIGZpbmQgYW55dGhpbmcuDQoNClJlZ2FyZHMN
CkhhaWJvIENoZW4NCj4NCj4gLW1pY2hhZWwNCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zcGkv
c3BpLW54cC1mc3BpLmMgfCAxNCArKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1u
eHAtZnNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMNCj4gPiBpbmRleA0KPiA+DQo+
IDZkZTZkNDMyY2RjYjJlZTM4M2EwMmQ3MmYyMDAwMDA0NTkwM2UxNzYuLmE0MjZiOGQ5MjE5M2E0
ZTMwM2Y0DQo+IDExY2QxN2MxDQo+ID4gNmNiMzFjM2YzODczIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW54cC1m
c3BpLmMNCj4gPiBAQCAtODY3LDYgKzg2Nyw3IEBAIHN0YXRpYyB2b2lkIG54cF9mc3BpX3NlbGVj
dF9tZW0oc3RydWN0IG54cF9mc3BpICpmLA0KPiBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLA0KPiA+
ICAgICB1bnNpZ25lZCBsb25nIHJhdGUgPSBvcC0+bWF4X2ZyZXE7DQo+ID4gICAgIGludCByZXQ7
DQo+ID4gICAgIHVpbnQ2NF90IHNpemVfa2I7DQo+ID4gKyAgIHUzMiByZWc7DQo+ID4NCj4gPiAg
ICAgLyoNCj4gPiAgICAgICogUmV0dXJuIHdoZW4gZm9sbG93aW5nIGNvbmRpdGlvbiBhbGwgbWVl
dCwgQEAgLTg5Niw2ICs4OTcsMTUgQEANCj4gPiBzdGF0aWMgdm9pZCBueHBfZnNwaV9zZWxlY3Rf
bWVtKHN0cnVjdCBueHBfZnNwaSAqZiwgc3RydWN0IHNwaV9kZXZpY2UNCj4gPiAqc3BpLA0KPiA+
DQo+ID4gICAgIGRldl9kYmcoZi0+ZGV2LCAiVGFyZ2V0IGRldmljZSBbQ1M6JXhdIHNlbGVjdGVk
XG4iLA0KPiA+IHNwaV9nZXRfY2hpcHNlbGVjdChzcGksIDApKTsNCj4gPg0KPiA+ICsgICAvKg0K
PiA+ICsgICAgKiBQZXIgdGhlIEZsZXhTUEkgcmVmZXJlbmNlIG1hbnVhbCAoaW5pdGlhbGl6YXRp
b24gc2VxdWVuY2UpLCBNQ1IwIGFuZA0KPiA+ICsgICAgKiB0aGUgRExMIGNvbnRyb2wgcmVnaXN0
ZXJzIHNob3VsZCBiZSBjb25maWd1cmVkIHdoaWxlIHRoZSBtb2R1bGUgaXMgaW4NCj4gPiArICAg
ICogc3RvcCBtb2RlIChNQ1IwW01ESVNdID0gMSkuIEVudGVyIHN0b3AgbW9kZSBiZWZvcmUNCj4g
cmVjb25maWd1cmluZyB0aGUNCj4gPiArICAgICogUlggc2FtcGxlIGNsb2NrIHNvdXJjZSBhbmQg
dGhlIERMTCwgdGhlbiBleGl0IHN0b3AgbW9kZQ0KPiBhZnRlcndhcmRzLg0KPiA+ICsgICAgKi8N
Cj4gPiArICAgcmVnID0gZnNwaV9yZWFkbChmLCBmLT5pb2Jhc2UgKyBGU1BJX01DUjApOw0KPiA+
ICsgICBmc3BpX3dyaXRlbChmLCByZWcgfCBGU1BJX01DUjBfTURJUywgZi0+aW9iYXNlICsgRlNQ
SV9NQ1IwKTsNCj4gPiArDQo+ID4gICAgIG54cF9mc3BpX3NlbGVjdF9yeF9zYW1wbGVfY2xrX3Nv
dXJjZShmLCBvcF9pc19kdHIpOw0KPiA+ICAgICByYXRlID0gbWluKGYtPm1heF9yYXRlLCBvcC0+
bWF4X2ZyZXEpOw0KPiA+DQo+ID4gQEAgLTkyOCw2ICs5MzgsMTAgQEAgc3RhdGljIHZvaWQgbnhw
X2ZzcGlfc2VsZWN0X21lbShzdHJ1Y3QgbnhwX2ZzcGkgKmYsDQo+IHN0cnVjdCBzcGlfZGV2aWNl
ICpzcGksDQo+ID4gICAgIGVsc2UNCj4gPiAgICAgICAgICAgICBueHBfZnNwaV9kbGxfb3ZlcnJp
ZGUoZik7DQo+ID4NCj4gPiArICAgLyogRXhpdCBzdG9wIG1vZGUgbm93IHRoYXQgTUNSMCBhbmQg
dGhlIERMTCBoYXZlIGJlZW4NCj4gcmVjb25maWd1cmVkLiAqLw0KPiA+ICsgICByZWcgPSBmc3Bp
X3JlYWRsKGYsIGYtPmlvYmFzZSArIEZTUElfTUNSMCk7DQo+ID4gKyAgIGZzcGlfd3JpdGVsKGYs
IHJlZyAmIH5GU1BJX01DUjBfTURJUywgZi0+aW9iYXNlICsgRlNQSV9NQ1IwKTsNCj4gPiArDQo+
ID4gICAgIGYtPnByZV9vcF9yYXRlID0gb3AtPm1heF9mcmVxOw0KPiA+DQo+ID4gICAgIGYtPnNl
bGVjdGVkID0gc3BpX2dldF9jaGlwc2VsZWN0KHNwaSwgMCk7DQoNCg==
