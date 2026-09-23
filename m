Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010059.outbound.protection.outlook.com [52.101.228.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE14395AF8;
	Wed, 23 Sep 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161656; cv=fail; b=ciOw4cMNZj4nqMHxLc5zZDhttvYN5j7+K3YKaBIN4XO+mgMpSGERcrHO+iKdTAZR3DA7spNpW9U2Pi+NkkhwQs3O+kXapA1oope/mXrO99emiQSYm3/2jj+2VUtVN9J63gBadBRPYoXvevmrBWgW/0RGSLu9NiaWl7khwmeMlG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161656; c=relaxed/simple;
	bh=AuMa4sfYW4aGiaLYcunuHHxjL9+IoJt+vCra8VBs6BA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlvbZxhRUa2KXOYGAToyPJAbPk6BBxV4zNl9q3iM/mgciLlZsOL36CDnEEj6tu9nZEWhd1OwMH0HEw6nnrKYWnu2RNamPmz+QhyOb4X8OPCx8YABwpA2wayUEhB0PbMqivelgDoDlnf7iHTVg5q0uEUyqXLGAS/Z/LYJfn3jXvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=A1M7p47s; arc=fail smtp.client-ip=52.101.228.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="A1M7p47s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYmHvtGjQsOuuVUuOK8NBF2X69OTPnlL2SsA4xLkOHmVuazRYdj83ltzbjB/qH4eLIgMUF5NCXKwLSwahYmOkP+OPAgvlK/CKuQtN4atVu2NJrnLrUn74V07KyZfZTPN5kzSXj1ZiuGy5ceHfx8ivm7rMdTMlPB5h/eMTjTR/aqQjolmflO3X70HzaCm7tIA3NDCyiKM3Af2kHDh3zqJ4gqv8y35b2yQmPrOfHsw+7DnsYRPdCB/6r61Wilt6A8Sxm0y6qWgmGX67tkAnomPRD+lxUfokwE4S75JBAxBi6TEztanwkALsIez18DupkS4wLqi9SmYXXI6WQ5Wd6Szaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuMa4sfYW4aGiaLYcunuHHxjL9+IoJt+vCra8VBs6BA=;
 b=wgilwfTpfhMfjwWkfm/Ts3Brc65zfsp1v1hWPlm838ixRw0cRjY9J+IgPFIcKJisl6FlEef1Gi6BKvY+AJHEEOHdDtDvO4uj/i1AVnS6sEMiYEtgOHAcNjPn+Sj/RPRjl1fwKnmpeRKCJ4uNsewMrs413lJpfPKviuarCc5ZMFi/ffvPCpN76ScB1DXpD5VfYqBsTIu6TtVSgGWzkyPl05totn0VqUaFxwabhbE5/dkGtMfIbn4ft0AXb2kgp/i419Tzh1QBEEDd81q0+Yt1wTDs+afP410cmxw13YCE9gxPEokUl5rAEcov1cssTFxmRdQBm6TTSo/O3p2y2Rjf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuMa4sfYW4aGiaLYcunuHHxjL9+IoJt+vCra8VBs6BA=;
 b=A1M7p47ssfw2PIoD2WT1UDc/fy/g4uBy5L3wkzjAFQIV8EP5lwQmUSNDvFhk5WYYnYlt+LDYjvctNJWCyjKG3NcORnpzZUamfQyuAg495wTjjQ/3bA3keoz+Q99mW4W9ME52naMAGulqDWa2kro7bqFi8RZJZSyaG9SVKnXCUc4=
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com (2603:1096:604:33c::9)
 by TYWPR01MB10756.jpnprd01.prod.outlook.com (2603:1096:400:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 23 Sep
 2026 11:07:31 +0000
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f]) by OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:07:23 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: geert <geert@linux-m68k.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: rspi: Fix DMA mode when the DMA controller is built
 as a module
Thread-Topic: [PATCH] spi: rspi: Fix DMA mode when the DMA controller is built
 as a module
Thread-Index: AQHdSgPQE5o2gPL1nUKVyIWm+PcksLbarlwAgAFNmrA=
Date: Wed, 23 Sep 2026 11:07:23 +0000
Message-ID:
 <OSCPR01MB1276943F1EAC14670506E6DF5D3822@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20260921195943.107247-1-ovidiu.panait.rb@renesas.com>
 <CAMuHMdUGwQXvtLeQZ3KfO0giAhyEBgWSLqmxqx=7yqGqMr+hDw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUGwQXvtLeQZ3KfO0giAhyEBgWSLqmxqx=7yqGqMr+hDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12769:EE_|TYWPR01MB10756:EE_
x-ms-office365-filtering-correlation-id: 0288132a-50e0-4a3d-eac1-08df1962d7fa
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|4143699003|11063799006|18002099003|56012099006|10067099003;
x-microsoft-antispam-message-info:
 mLmjsLFuXLmSv1GX5tyu9n0uRyCvHsWRwTHyAYsbh5gUMc5g/GGdv0FTqjb5RbTRWPPdUAWVqN3oyde37Upukrk3bDRIi10KZBbVSlaE6FtYSOezy8i5MxoHbVtaGL/qkxfhhjXem4jeLlJrbuJK4B/jLgAOxi2STM8TIChnl0Gdn0Gmqw/a3Eb/CT/AdQ+/plLx2Lz5MRURQc8a3g+W+XnqFUApUxWQGwKQ6hwZmx4szRJlae+Tv2IxWjNAHnhyC0kN4NOvXlpToNSSq4bMh3ZK4Qt2NAT4YhVgr87BMOkdAdUVvwNtmlh6EOKZ1hZBB6lavxNQHYo6u7k2bKApJnAuJwVvVJi7kamKOB81VGcnWTfUkieygaKxftXHLbYMw+qtdP6faZptxHO4gN2B8zSqIbUEdQveLHUd691B+OIZBc2rpdcrGQ1B2Ehgaw8K/IwXpsBDA0yNXvwg1uEBdZsB9aEl1K952sm/Q4X8O1MAxBpmu+0Zl2GPzZksYrDIMLk4nEywSYabAwuw1EqybF49ebLbRw/6eqNSDYhCsu4GWevurapigDpRJirV5pXZ9ahETZtEyD7Y70nTnJAL7eiMfy7y48U+3+Tl+KKwofGM4E7l7MtxhiwznSMCrVt557VmXxjzNEujkfcRwjl+NIV6XIAQIy0Jcdqem6hSEa9zHflYZCjc9OU3/hB79VKdby88OULW/fCPDwQQ9Ru3eEZFq3jr+gFqgMQLpRfO13Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12769.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(4143699003)(11063799006)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGkva1lIei94eTRrelIvdk0zYU1WSEUvZ3JGM3B3NCtpVVB5TmFjUjdUUlRt?=
 =?utf-8?B?Vk1wWkhTVWlZRVBlT01UOGlhTXRkbXE3Q1NNTmJxME1hR0wvNGp4QmI4L2Rs?=
 =?utf-8?B?NnRrL1NjeExPNmd6NHpZR3g2eVUyOGpGT2NtMm16VlU3L1gyaEpFNFZjNTVz?=
 =?utf-8?B?eHN0dFErcEptQ2pRUVFvaU0rVVo0VlNUTkhONDlSbUdsOXM5UDdEb1BpcExw?=
 =?utf-8?B?Q1Z2ZFV3Ulh6YnBUd0c4NmpXN0o0dzlLYVFkUFpKTE1ZWjdBNWg1NkxocEFj?=
 =?utf-8?B?Y0ZGcVVnMGlqb2xyYTdCMGVLWTdXaDNQaXBpRlNWNWNXbXZZZ1AwWExwWEEv?=
 =?utf-8?B?MGpyaHg5VWluUFhDc0hmd09ucTBZR3ZwU0kvUjRmSWRmeVUyWmhxTG1YZGh5?=
 =?utf-8?B?TkpOdUo0TTJ5d05tQzB0YkxCMHhydWhZd2JiNHdWOENFT2dNbTBuZDdsNlFZ?=
 =?utf-8?B?QzNoSGozNWNvQ21OZk8zbTJOb1plZUJ2ZVBVanlteEErYXJobnhpdXFrRjhC?=
 =?utf-8?B?aktpMXR0dWlDMVhCVnRDL1Q5ZTdBWmlzNjFBWWd0ZlU0MTNBa1g0T29COWYz?=
 =?utf-8?B?OUdvbDRaVDBhcjVYc0J6RTBvYVU0L1hleUtQOHFTRDN0TGdSMUFORG50Uitm?=
 =?utf-8?B?UU52dTFhYjBhZFdDbFZZVW92a3JsYXZ3UEx3eG9pcjlEUUQzTityM3dqb3FS?=
 =?utf-8?B?SW1wdGF1a3Nad0wxRGRCbnV5K0liazNsVVNheWlaanNlTzFWOWpmWjEvem9S?=
 =?utf-8?B?TE5pdlc2TGJocDllRlM2dkRRekJTak1KRWdiMjVYMVEyc0V2Ly9HS3pWWnBR?=
 =?utf-8?B?anI2M1ZTZDA0dHB6UEM4em5TcEg4aVo3eFZabm1zdzAxNlpMaUVlaFh1ZWNI?=
 =?utf-8?B?OE9oODRObFFqczFUa010Zml6dUVCN0ZyK1Vmb1JwMVN2RHpsK3MvazAxbkNp?=
 =?utf-8?B?Mm5oNGkxNCtrNW8xdXlyaXdwanh3ZjRVY1hheHppNmFJTXVaTVJ6ZWZmbGww?=
 =?utf-8?B?cHNXa1E0MERUR1pQZCtaUEhZdUNZcjVMYWl3dWdON3h3VDA3cXpqSUhsRTNu?=
 =?utf-8?B?LzZqQXVjdXBJL2VxcjRCczgzbEU1cGs5dzNqem9VL1VHbWY5M3NJUVd6ZjNi?=
 =?utf-8?B?dXJpbFRhRFNRdWhxeFhZdkNXRE1meDF5dXZiOHFmSFBONmp0QnJORThHQlQz?=
 =?utf-8?B?eWpNQXF4TUFDMWJSOGRndGVEL1ZIdDNKVFNvU3NIclQ0N0U5dUNkUENwNnVR?=
 =?utf-8?B?ZWs5Q2FSbnJlRkxhQVhML2F5cnZhMmdZQUZjZkZOODBkVDJ4V1ovVkpURHFa?=
 =?utf-8?B?NlA0Nnc5Y3ViR3RFU0luYVFpbnBSeGZ6bWhGZWZwcGRDUy9oZ0xrNVByZW1n?=
 =?utf-8?B?NFRLbE9zdlc2WDVmSEkxR0M4WFRRNkI4TDUwL0ZkMXQ2YUdWTVlPZXpkQklO?=
 =?utf-8?B?ZCtiM1R4cUNkMWlKcUR2QmI4NjMzdGZEUlFMVEo0dk9ETCtVUFBPWFpyWUVo?=
 =?utf-8?B?cy92NjR5S2NuYVh5bjRyTXpLSFJEMlo1Wm1Ia2sybHRGWDJLNWM3SFNlb2Vj?=
 =?utf-8?B?bEZXZlczMFBpRU90aDlSTC9ITVJkN29vMWp2d2t2MzFHbW82WjhtYkNsbnZl?=
 =?utf-8?B?WGdqbmtZUzRRaVArdXM3SXNVeDlQQkdDMFU5OVpESFJqdlhpOVFROXdLWDBa?=
 =?utf-8?B?MTVwU0dseFRQdTZFemRpdlpBdnViT3A1eDRWMFcrUVBZTnBGbEJsSXBkaWc4?=
 =?utf-8?B?MFBzUURua0dGaURqbGpJVitHNmh6bkxmdFlxVk54YWZkSC9obW1wS1IvYjFU?=
 =?utf-8?B?SU41WXFYQjVsa3ZMMHB0V2dYNTRaTmtRMHNCelZZdWdpaW1pcXI5c2xteE5M?=
 =?utf-8?B?MlRlMkx3WE5xYktsZ21LTG03QjZXZVpUUFR2L0J1RTBPdjZRTkhoSWJHYllN?=
 =?utf-8?B?bDJXMERaYWxFRDV4QkMrN0VIaDNiWU9TT3RDaW8wU2JESyszK2V3WFVqRFVy?=
 =?utf-8?B?TWRGMURlSDFiOHZ6OEtBV2c1YXVkUzlzTWdLRnhDeU1ZUDEzSGpkSG5NdXZN?=
 =?utf-8?B?UldBSTVIV2lTaDhpbDczeDN4anArTGd2Zk9STGxYQUs3SVE0MUpURkVjR0Y1?=
 =?utf-8?B?SkNIcXBucXIzMTB1cGZlOHZMVXlIRWpkRHprc1hRdUpoZGo2K2tad1FlRnNY?=
 =?utf-8?B?Z0FrTGtzWUlidUxIbG55c1ZjcjlsdWZKN3VUQy8zZjlSeVRTNVM5WDRkeXVo?=
 =?utf-8?B?UndCYmpFUU1mV04vYVlvQlIwd04yamZKT25ycG5NTGZreHdBNzNBV0U3OThK?=
 =?utf-8?B?Yis5bU5qeGowMEZrdDNuZ2g1VXE4cUo4ZkdJWnVTZ1p0VExHc2FGNEZCRkl4?=
 =?utf-8?Q?n/iqvVgDfEu6uQCA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12769.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0288132a-50e0-4a3d-eac1-08df1962d7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 11:07:23.0504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ko888lxgH9nI9QxhazSrYg3aucKOJskMe58IAxK8Zr8/wT33fmbe3sN7RMHjGNDLIVtgYm7/zgeZUknEfuaPK2rFv41bHVRxlhZ5DR04y9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10756

SGkgR2VlcnQsDQoNCj4gDQo+IEhpIE92aWRpdSwNCj4gDQo+IE9uIE1vbiwgMjEgU2VwdCAyMDI2
IGF0IDIyOjAwLCBPdmlkaXUgUGFuYWl0DQo+IDxvdmlkaXUucGFuYWl0LnJiQHJlbmVzYXMuY29t
PiB3cm90ZToNCj4gPiBPbiB0aGUgUmVuZXNhcyBSWi9HMkwgcGxhdGZvcm0sIHRoZSBSU1BJIGRy
aXZlciBmYWxscyBiYWNrIHRvIFBJTyBtb2RlDQo+ID4gaW5zdGVhZCBvZiB1c2luZyBETUEgd2hl
biB0aGUgRE1BIGNvbnRyb2xsZXIgZHJpdmVyIGlzIGJ1aWx0IGFzIGEgbW9kdWxlDQo+ID4gKENP
TkZJR19SWl9ETUFDPW0pOg0KPiA+DQo+ID4gICAgIHJlbmVzYXNfc3BpIDEwMDRiMDAwLnNwaTog
ZG1hX3JlcXVlc3Rfc2xhdmVfY2hhbm5lbF9jb21wYXQgZmFpbGVkDQo+ID4gICAgIHJlbmVzYXNf
c3BpIDEwMDRiMDAwLnNwaTogRE1BIG5vdCBhdmFpbGFibGUsIHVzaW5nIFBJTw0KPiA+DQo+ID4g
VGhlIGRyaXZlciByZXF1ZXN0cyBETUEgY2hhbm5lbHMgdGhyb3VnaA0KPiBkbWFfcmVxdWVzdF9z
bGF2ZV9jaGFubmVsX2NvbXBhdCgpDQo+ID4gd2hpY2ggcmV0dXJucyBlaXRoZXIgYSB2YWxpZCBw
b2ludGVyIG9yIE5VTEwgYW5kIGNhbm5vdCBoYW5kbGUNCj4gPiAtRVBST0JFX0RFRkVSLiBJZiB0
aGUgRE1BIGNvbnRyb2xsZXIgaGFzIG5vdCBwcm9iZWQgeWV0LCB0aGUgZHJpdmVyDQo+IGZhbGxz
DQo+ID4gYmFjayB0byBQSU8gZGlyZWN0bHkuDQo+ID4NCj4gPiBGaXggdGhpcyBieSByZXBsYWNp
bmcgdGhlIGRtYV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWxfY29tcGF0KCkgY2FsbCB3aXRoIGENCj4g
PiByZWd1bGFyIGRtYV9yZXF1ZXN0X2NoYW4oKSBjYWxsLiBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFu
bmVsX2NvbXBhdCgpIGlzDQo+ID4gYWx3YXlzIHBhc3NlZCBhIE5VTEwgZm5fcGFyYW0gaW4gYWxs
IGNvZGUgcGF0aHMsIHNvIGl0IGFjdHVhbGx5IGJlaGF2ZXMNCj4gPiBsaWtlIGEgcGxhaW4gZG1h
X3JlcXVlc3RfY2hhbigpIGNhbGwuDQo+ID4NCj4gPiBGaXhlczogZTgyNWI4ZGQyYjM2ICgic3Bp
OiByc3BpOiBBZGQgRFQgc3VwcG9ydCB0byBETUEgc2V0dXAiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6
IE92aWRpdSBQYW5haXQgPG92aWRpdS5wYW5haXQucmJAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFu
a3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1yc3BpLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktcnNwaS5jDQo+ID4gQEAgLTEzNTUsNiArMTMzOSwx
MSBAQCBzdGF0aWMgaW50IHJzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
dikNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gcnNwaV9yZXF1ZXN0X2Rt
YSgmcGRldi0+ZGV2LCBjdGxyLCByZXMpOw0KPiA+ICsgICAgICAgaWYgKHJldCA9PSAtRVBST0JF
X0RFRkVSKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwg
cmV0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmYWlsZWQgdG8gcmVxdWVz
dCBETUEgY2hhbm5lbHNcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycm9yMjsNCj4g
DQo+IERvZXNuJ3QgdGhpcyBtYWtlIHRoZSBwcm9iZSBmYWlsIGlmIHRoZSBETUEgZHJpdmVyIGlz
IG5vdCBhdmFpbGFibGUNCj4gYXQgYWxsPw0KPiANCg0KWWVzLCBpZiB0aGUgImRtYXMiIHByb3Bl
cnR5IGlzIHByZXNlbnQgYnV0IHRoZSBETUEgZHJpdmVyIGlzIG5vdCBhdmFpbGFibGUNCmF0IGFs
bCwgdGhlIHByb2JlIHdpbGwga2VlcCBkZWZlcnJpbmcuIFRoaXMgbWF0Y2hlcyBvdGhlciBkcml2
ZXJzIEkgY2hlY2tlZA0KKHNwaS1yenYyaC1yc3BpLCBzcGktcm9ja2NoaXAsIHNwaS1iY20yODM1
LCBldGMpLg0KDQo+ID4gKyAgICAgICB9DQo+ID4gICAgICAgICBpZiAocmV0IDwgMCkNCj4gPiAg
ICAgICAgICAgICAgICAgZGV2X3dhcm4oJnBkZXYtPmRldiwgIkRNQSBub3QgYXZhaWxhYmxlLCB1
c2luZyBQSU9cbiIpOw0KPiANCj4gVGhlIGRyaXZlciBzdGlsbCBmYWxscyBiYWNrIHRvIFBJTyBp
biBjYXNlIG9mIGEgbWlzc2luZyAiZG1hcyINCj4gcHJvcGVydHksIHJpZ2h0Pw0KPiANCg0KWWVz
LCB3aXRob3V0ICJkbWFzIiwgdGhlIGRyaXZlciBzdGlsbCBmYWxscyBiYWNrIHRvIFBJTy4NCg0K
VGhhbmtzLA0KT3ZpZGl1DQoNCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRo
ZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5v
cmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxl
LCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0KPiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBq
b3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZQ0KPiB0
aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRz
DQo=
