Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792748589;
	b=dXXnSLCyHwL9nQgfE0sBEAjIn0esXbD6vLdpq8x66zUxm9FcRA2cdgSs1EZ1zgfPZVkO
	 L8dE/jUaq8hMXZyhT/sDMdobpJjpmuJCivWgONHsKt38S7DANSaTi4cZShNRyMsUCi5vf
	 AwYBE43XEy2PtgJYnbkf9fJXyESrZ6qJabE5PvXWZ28y6Mu30NYg6oczddEHtRKsSysfG
	 7ae3g8aZHpqUdR2xXmRrFlgsNozxKTp8XoDKzu7d55m3l4wQ3+qzkNXuBuTsmSZB7DYq0
	 xes6b1oiGaI81x0ZhX40hz8mUrx2AuE/vI9J1PASE26Bsz9dvuCewrja86fTYRNPZXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748589;
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
	bh=kSMZ0ATQoMLyX8up0JwHEaAZh1U0fNciko98yR1SdU8=;
	b=pfBmVN+oXKZBQAGBX6B94P1ecG2ZSAbV+QWqiIXlN7ZjyELZac+rRs8s0tRujir0udRr
	 MP1hEqANApRvMWRPvFeXrGwvQrVCg+4F/QaftWxGMHpThzwRU6APZ9wiV56HYA9W9YKSj
	 LqPFloKioB+pZNGwRaduEx5wlf5ePHVXk7botuD0RDPn6XsF+7evOt3EhX4RXuE5xPZ5r
	 9MEExcv3rFqWdetqkpLXI8tlP89oS78PzqOLjtzBrWwLqHQfv5xnx+uVGYnKPFEwh4epU
	 Ei/vg3dShgzzgssGBFwch+NpeH+NOHhJb68Uf+I6h1jNS9cwdQ4S6bI/WuzqDelB/FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.126
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4101606A31A;
	Fri, 23 Oct 2026 09:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4101606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNk3fqhMEPlob7Ulrmti4sym3crq3raNE+Lwx+j9uKRX5BwzP9gyH1CMMXZpLIrakFSK1G51rq2vwNbMgTtnTFJAxMx1GWTTJfqmjlB28VJE9cCmBDhc4nJVv4v/aHHIeBJ7tY3CVLcl1FPuB6BolHppXhlJEDZ1SAirB0+ik/TlR2Fy9L/K3pAcjikgqxgx92UhzkNYliMWQ/Zezx3rXNc8NHH8UKyCRUeldoBu7QjUYYUmLm4UFt4E4yuCs6AdURRfoHlzjUM5pqb5KxMfDft7Rm2eYCkjLmO+Cqf7A2gejy1DKIaK2gLuRN7PNi0PpPE4gwIY9iloL1ecH6IwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSMZ0ATQoMLyX8up0JwHEaAZh1U0fNciko98yR1SdU8=;
 b=aO8eQAMpZLBgR7Pt5ywzagFV7JsiYrAmQXigyYxl7rG52mtUJAFM8Qh8j8MHe/PJdyzcBTLZAQzL90hI6rakTvFkGfvBfQA2W4QNLxhLJP+WUfj/6atr4l8X1ubM27G+b/S/1e1G0m6c4Ei/pOVvBDyyoG/fjA8DQI67KsSSJPyXemgzIZIZvHKjqHHEwsZ48Q5kbtFzlwozzMuj2mVkLk7OnHliWvCf88QcV7SJcARiR9S8cO5VMKHRijXzWHgV2W4tzOH0bt0R+Mn8UyQDbqrXWW9ka8ypVZw79tCo47C3xBzT1cxbSkodralqQJwlCj+yccKi1edess9NfVcWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:42:56 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0546.017; Fri, 23 Oct 2026 09:42:56 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>, Mark Brown
	<broonie@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 1/4] spi: dw: Add DDR (Dual Data-Rate) support for
 enhanced SPI mode
Thread-Topic: [PATCH v1 1/4] spi: dw: Add DDR (Dual Data-Rate) support for
 enhanced SPI mode
Thread-Index: AQHdYg/J0rdlsgMyL0SIJwAb/cmFb7cJX+ZJgAGBvHA=
Date: Fri, 23 Oct 2026 09:42:56 +0000
Message-ID:
 <ZQ4PR01MB1202C6B2531173B2D395C619F2642@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
	<20261022102614.75696-2-changhuang.liang@starfivetech.com>
 <87bj8mqaof.fsf@bootlin.com>
In-Reply-To: <87bj8mqaof.fsf@bootlin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
x-ms-office365-filtering-correlation-id: 32033548-ba0f-486e-2eb1-08df30ea0448
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|38070700021|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 O9/oj8f4dg1ctoFttT3er/rrpU1KvhZlj2D4IdayZhBNIWA2cHjQVbXIGusNvT8gIlCC08crZXSECONnyvslpJGgS2vlxxNzj/MPwvqIUINCGDZ+mv9IE2szdCsxUGSwnt+0YB2ihjA/c0sG8GC8GG/jnoY4iD19u4O4BDiW81tG99H3gEv2dzpeXzHLQtMtkAio1rVFfOAG3T7PGZRT/9UjkcTnSTfVHfptECTy9lP0PdmOtJTp7uizSux5kL5L7bRGgnEn/Gt8ZbHQrEedFBNigyf8p3P5p8qDlYtlGFqjPtBrLYvM7OC/XN6c1DsTHcsiZtjscHlN1pp+PbKoHEedf3dRW5/eUbrI8L0nRkRGCK/5tT7S8xsOavg66wbZPOwEAv34aQxr9NOpFTTGko+YsXBrOeN1dW2R4Uuud1px3mAJIyOaRvFrDuq2Yy9BgnxffbE3BeY5vumGAk6vuK0/1nl4l6tGNZuBm45yUD4gZIOKiBHN3kQcBPTBzVwAZTgXK4ms7NRJbC8ZU3rtK4m1DAA/e/ib74O5DSeuFab+FqS948XdhEpdj2u4sHPq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG50ZHlIUCtGUURIUld5alNITGZoZHIzRG14NXBpQlJueFBENDN3L09aVEFH?=
 =?utf-8?B?R0diU1hXZXVMWi9Gd2ZpUVNpK2pEbVRFQVUvUHJBbFg2NWJwOHNURUtBc25M?=
 =?utf-8?B?ekFGdHZKWDRkU0J1ZE9nY2dGb2dyTlZ6RDhxeGlBVWNlSlloSmtnNUlrUURq?=
 =?utf-8?B?YVJzTGxjRXdGelBSVHJBM1NnSUMyWXBydlFJb1hVdW0vT0F0TFRSWGZ1VE9Y?=
 =?utf-8?B?UWo1TG94OGVaVDZ6NFVYWnlkNjdpdTh0K29mTXl1RElvUWd3eHR0cjZGTTlD?=
 =?utf-8?B?UVk2dk94dWNoYWRvaXdIOWdBekI0a2JnWjYvbkVMUS96VkVwK255cXh1NDRD?=
 =?utf-8?B?cHNsTDE4azY1djlYdXBrelZRaFNHN3l6L3Z3c2JnbzMydWlCc29jWjA4enZl?=
 =?utf-8?B?ckZiL3liSnBENHhkMC9MSDlDSzFSVXd1N3NDZEJNd09wTjNCZkNtQU1lTkhY?=
 =?utf-8?B?OTVQdVdpdzU1Y2w1OUVDQU0ya21SbjdPaXlQanZSUjJ1eWpPRU5DRG9xTERy?=
 =?utf-8?B?V1JkUXdwM2h5bXR3bXRtN0VHb1dsbFNuNUpxTFZHMVZBbys2NVAySzVjakl2?=
 =?utf-8?B?OVRXajhkRnMrczJyRmhmaFE1VkVZRy95aHpXMUl5M2RETkgzTzYyeHlYYzFn?=
 =?utf-8?B?bEdzakM1cUl3aWVycDJpU1pYdFVVUmVGOU9kNlI0QlF0cnhJWE5FOExCNUdC?=
 =?utf-8?B?cWtBRjNDRVBKMis1MmdlU204Uk1lVm1XNkUxVmNKYVhlKzFtcmY5U1M2cXJD?=
 =?utf-8?B?UlVuYWt6TkFHWVMwZUF2OWd5VnI4aGhSWkRUYkhxSHFxRy9uQk5ObS9tbjBy?=
 =?utf-8?B?a3FqemZzamJ6WERLY292bmIzZVF5Ky82TDE4L052R0R3Ung0cjBaM3F5ZTJG?=
 =?utf-8?B?ZnhESnpYM3dQU2tmYnNNQlUxNGlQTHdzWjNhZjRMOEFIQlpLQWIvUC9aeXFy?=
 =?utf-8?B?Y0JBd1E4RGNnOEp3M0l3RXBQeENZTzN4UW0xZDVQQWo0bC9Remg4MHZCSnUr?=
 =?utf-8?B?OVFzSGkwcVBvY2M2bmN4M2lQazBMMjFURmlvRFRoS1paQ0xQQjFsL2RTS0lT?=
 =?utf-8?B?RThKT2lSQnFVcUlyQzIzK0lhcFVxWXZqTmRXOW5GUTljdnREcVovRkE3OExO?=
 =?utf-8?B?eUFCSmxFWHdCN3lkMC8zakhvMSt6UElsaTlyY1gwMEJwbDVCYXRNY2JVQ3Ay?=
 =?utf-8?B?VW1SVUZzbHAyS1JiZFhvRGhlNnRuL1krbkJobmtIbTA1SS9XZWxySUpYa2d5?=
 =?utf-8?B?TCtKWnVKeHUrY2k3K1l6c0d2bmJjcUlyY2RaQ3NrY2FqeFJaS2ljc2FkMjEr?=
 =?utf-8?B?RXJVeGJxakY0TkhYMnpyTTJ1ODJSOFJYdW50Z25MV1V2Nnl5Q1grRHFES3pE?=
 =?utf-8?B?MGg5SEFDeU43Z3JOYkxxcWtaRldyODBNZEJzMk1TYTBOZVJpLzhYU0FWRTcw?=
 =?utf-8?B?TEpQMUVOK3g1cnJNU3h2d0h4Tk0yM3ZCa0tHSi8zVVRLcC85elQvdm9qbEhY?=
 =?utf-8?B?YlpqUjRuMXZjMTNCZ2RUcTJBK043YVNZZWpYQmE4YTBFVlNDRE4zNjFkTWtT?=
 =?utf-8?B?MkltSHN6d1dlZGZjbzI0UE9TZVJ1c2tuSWJ2cTA5UXU5WDFxMGdUbDRkNEhX?=
 =?utf-8?B?cnFkRVpqekdhb25RQjJQZk9FQmoxRWc4aWlId2N4dDg1Uzl1YzlmclhadWdO?=
 =?utf-8?B?ek1iNnl2Z2d0emtJbi9wYy8wYlpHRUpTQkFrb0htVERzazkyZGhxT2UwcEFL?=
 =?utf-8?B?TEo4dklLRmJHa3l6dC9ycXdEZyt5ajIyN2ZKOWpsYWtxK29jV2lUU1BSWlRN?=
 =?utf-8?B?VUZnQzBRNTV1V054QWcraGVsNU1Jd1pVMGFnWWdUejhjd2ZvTFFBOWNsZm1J?=
 =?utf-8?B?SElGL1R1enppNGFvNWNRUitNanh2cHhoL3V4ZXN0T0xaNUVXMDRPZ2hEOVhY?=
 =?utf-8?B?RTkvTVhWb2NETmxnVUM4OEhnZXphUnliR1hMYjJWZWp0bG0wV2xvNko1Qlp0?=
 =?utf-8?B?R0kyTW4vd2pmOEluWnFjWkZpM3BtcTVvcVhwMFVBWHVQU2xPUW5EOWlLUGpi?=
 =?utf-8?B?MUM0elZWbjU4K3FacXh5QnFLSFFoVkZoaFArdEtoTDQ0R3RwemRHS3VHWXdC?=
 =?utf-8?B?Z3JmNXgxbkcwU29nT0xrTlpmUHR5YzlHQW1heDhZdWRBOUYwZllCRmlqLzQy?=
 =?utf-8?B?TDFZMHVUVHFLY0VWbkNhbGhwUnRVQjJiV1BsMCtqTlliaXhCYkhaeFdUZXBU?=
 =?utf-8?B?L2F5TGlwbHQzZm5SSlNMcVR6SHozS0dGWjlFOHFMZHUwYTVodFpmOUs1V3lP?=
 =?utf-8?B?YWs1elpuMnBYSDd4eEhIK015WlBnakNZdWxNRUEzWThGdEVBTkVKN3QxcVI2?=
 =?utf-8?Q?CIIolwfd2nxYpkPs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32033548-ba0f-486e-2eb1-08df30ea0448
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 09:42:56.1814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVBPstQl5S5yzCze5zuRc4WKlDmewfyqb15oM9D1Sal3Xyu0z5mid44fr/isjIHTflOeV7iUNPNaYuTjkTCzwayl0ROrVxd3oxQliGOg7FPwT9oujVB0XnKpk8ydAU/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

SGksIE1pcXVlbA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gT24gMjIvMTAvMjAyNiBh
dCAwMzoyNjoxMSAtMDcsIENoYW5naHVhbmcgTGlhbmcNCj4gPGNoYW5naHVhbmcubGlhbmdAc3Rh
cmZpdmV0ZWNoLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEFkZCBzdXBwb3J0IGZvciBERFIgKER1YWwg
RGF0YS1SYXRlKSB0cmFuc2ZlcnMgaW4gdGhlIGVuaGFuY2VkIFNQSQ0KPiA+IG1vZGUgb2YgdGhl
IERXIFNQSSBjb250cm9sbGVyLg0KPiA+DQo+ID4gVGhlIGVuaGFuY2VkIFNQSSBjb250cm9sIHJl
Z2lzdGVyIChTUElfQ1RSTFIwKSBoYXMgZGVkaWNhdGVkIGZpZWxkcyB0bw0KPiA+IGVuYWJsZSBE
RFIgbW9kZSBmb3IgdGhlIGluc3RydWN0aW9uIHBoYXNlIChJTlNUX0REUl9FTikgYW5kIGZvciB0
aGUNCj4gPiBhZGRyZXNzL2R1bW15L2RhdGEgcGhhc2VzIChTUElfRERSX0VOKS4gUG9wdWxhdGUg
dGhlc2UgZnJvbSB0aGUNCj4gPiBjb3JyZXNwb25kaW5nIGR0ciBmbGFncyBvZiB0aGUgc3BpX21l
bV9vcC4NCj4gPg0KPiA+IEZvciBERFIgdHJhbnNmZXJzLCB0aGUgZHVtbXkgcGhhc2UgY29uc3Vt
ZXMgdHdvIGJpdHMgcGVyIGNsb2NrIHBlcg0KPiA+IGxpbmUsIHNvIHRoZSBjb21wdXRlZCB3YWl0
IGN5Y2xlcyBtdXN0IGJlIGhhbHZlZC4gRmFjdG9yIHRoZSB3YWl0DQo+ID4gY3ljbGUgY2FsY3Vs
YXRpb24gaW50byBhIGhlbHBlciwgZHdfc3BpX2VuaF93YWl0X2N5Y2xlcygpLCBzbyB0aGF0DQo+
ID4gYm90aCB0aGUgc3VwcG9ydHMgY2hlY2sgYW5kIHRoZSBleGVjIHBhdGggdXNlIHRoZSBzYW1l
IHZhbHVlLg0KPiA+DQo+ID4gV2hlbiBTUEkgRERSIGlzIGVuYWJsZWQsIHByb2dyYW0gdGhlIERE
Ul9EUklWRV9FREdFIHJlZ2lzdGVyLiBUaGUNCj4gPiByZWNvbW1lbmRlZCBUREUgdmFsdWUgaXMg
Y2xrX2RpdiAvIDQsIGNsYW1wZWQgdG8gY2xrX2RpdiAvIDIgLSAxIGFuZA0KPiA+IHRvIHRoZSBm
aWVsZCB3aWR0aC4NCj4gPg0KPiA+IEZpbmFsbHksIGFkdmVydGlzZSBEVFIgc3VwcG9ydCB0byB0
aGUgU1BJIG1lbW9yeSBsYXllciB0aHJvdWdoIGENCj4gPiBkZWRpY2F0ZWQgZHdfc3BpX2VuaF9t
ZW1fY2Fwcywgc2VsZWN0ZWQgd2hlbiB0aGUgY29udHJvbGxlciBoYXMNCj4gPiBEV19TUElfQ0FQ
X0VNT0RFLCBzbyB0aGF0IHNwaS1tZW0gbWF5IGlzc3VlIEREUiBvcGVyYXRpb25zLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQ2hhbmdodWFuZyBMaWFuZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFy
Zml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NwaS9zcGktZHctY29yZS5jIHwg
NTINCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIGRyaXZl
cnMvc3BpL3NwaS1kdy5oICAgICAgfCAgNiArKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUx
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zcGkvc3BpLWR3LWNvcmUuYyBiL2RyaXZlcnMvc3BpL3NwaS1kdy1jb3JlLmMNCj4gPiBp
bmRleCA0NzQzNGZhNzhlNGIuLjZmZjE0MmM4YTZiZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3NwaS9zcGktZHctY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWR3LWNvcmUuYw0K
PiA+IEBAIC00Niw2ICs0Niw4IEBAIHN0cnVjdCBkd19zcGlfZW5oX2NmZyB7DQo+ID4gIAl1OCBp
bnN0X2w7DQo+ID4gIAl1OCBhZGRyX2w7DQo+ID4gIAl1OCB0cmFuc190Ow0KPiA+ICsJYm9vbCBp
bnN0X2RkcjsNCj4gPiArCWJvb2wgc3BpX2RkcjsNCj4gDQo+IElmIEkgdW5kZXJzdGFuZCB0aGlz
IGNvcnJlY3RseSwgc3BpX2RkciBpcyBxdWl0ZSBhIGJhZCBuYW1lIGJlY2F1c2UgaXQgbWVhbnMN
Cj4gYWRkcmVzcyBhbmQgZHVtbXkgYW5kIGRhdGEgZGRyIChidXQgbm90IGluc3RyKS4gQ2FuIHlv
dSB0cnkgdG8gY29tZSB1cCB3aXRoDQo+IGEgYmV0dGVyIG5hbWUgZm9yIHRoaXMgdmFyaWFibGU/
DQoNCnNwaV9kZHIgaXMgbmFtZWQgZXhhY3RseSB0aGF0IHdheSBvbiB0aGUgcmVnaXN0ZXIgZmll
bGQuIFBlcmhhcHMgSSB3b24ndCBjaGFuZ2UgDQp0aGlzIHZhcmlhYmxlIG5hbWUsIGFuZCBqdXN0
IGFkZCBzb21lIGNvbW1lbnRzIHRvIHRoaXMgdmFyaWFibGXigJR3aGF0IGRvIHlvdSB0aGluaz8N
Cg0KPiBBbHNvLCBpZiBteSBhYm92ZSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIHlvdSBtdXN0
IHByb3ZpZGUgYQ0KPiBzdXBwb3J0c19vcCgpIGNhbGxiYWNrIHdoaWNoIHdvdWxkIHJlZnVzZSBh
bnkgeFMteFMteEQgYnV0IGFsbG93IHhELXhELXhEDQo+IGFuZCB4Uy14RC1EIG1vZGVzLg0KDQpP
SywgSSdsbCBhZGQgc29tZSBmaWx0ZXIgY29uZGl0aW9ucy4NCg0KQmVzdCBSZWdhcmRzLA0KQ2hh
bmdodWFuZw0KDQo=
