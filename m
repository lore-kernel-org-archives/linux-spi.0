Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D733B4EB7;
	Mon, 15 Jun 2026 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552712; cv=fail; b=p9jC6tlcCIXCJiD8Tld/56u71KUbQhRMYU2uHd+a0chcuMAhWnpqU+C3SnIzM62fdpzeUghOjkCEIV3w4WzFFfwt1NxiFKG1uDJNWdhETXupbP5qtVOEGRLVMHqv/OOKZS9XKxebs1+fPuy+l4zUm6DlM11WWQHzMl6GJHMUZuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552712; c=relaxed/simple;
	bh=jhNT3YIEdEPKkzll7hSx2TmHbyc+wziR1GdKOuYzIJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vCcU/80P4vtZKP+556U8vEXRNSLzfPCYM8RNEXaqB1QHL9PdQhyzS1yN83Fkhl1ol5thMEl0O5XGajRbUxyJo+Vjv6O1sJbvC1ik0ZbhMfOZtN3RPZw+kA5nCyRJSejjKLjHfjCHzTdu5bkln4ZT4U52oG20Idtxmdo/6aG177Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgnrRNIgHrwQ0GtkorqT+5DvyHQMwQugAysZCzTlbXRvL5zaeMM+Ylwtmsd4jnhJSOYBp0ap+DR+iWXjlT3ME1iOGyjpkqtOiXE/e2lZizYM2IKP2ATihdctLVkPkQ2wgQt0KHwyXoOhi7FwZijBkSubzc65CCwt5rWq3DAHEh3U4x+2X8z67r/MHy9rAKkHujuWuqVca9xiGONU02wJIDe/1Q+UrSmk4+MQRPmYrmqlWcHUm8XrxA+kjUm/145x4O+1eWHZ1UDIJQrMS7S5oRFlDwP2gc7Jy8hNlF+E92GSkg6QjlXFp3gXHQ6O6RpqckAnUb2xinNDFbNoXXS3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABc+CWf4weXiGFgeMmgMPqvqg9aPFUfFRjJEfn9Mwes=;
 b=QAA0PKQsVX/tihtDlWeH6Uv60g3UQNL/Bxzw0klVWTRe0yJT1tImVo6fVAwE8GW7zWPWKvAqiBfMFDjLBFb3OkWGLZZvOlqHibSzQrg/S7v4AKv9OJ3inIBNtuLDZR1vQ2IKF5T6ZtCfAGDjDfGCfzTg9xiu31vhuLWsMeSsy6JQ7oGqMcbR086GieP3UpfZtRkTZFnXhBSOPyioTPbZ4vyt+sZIdFJt5K8cthj00Ato3OsdnnwuYT9s0j+IoaoL4LpuFZd1vUatl90+ekFEaZsp8QJzGS9K0XxJ0q3yE3/hBn0Yb+ybHQUDe9bdCNJvHc9zdBzlUNO0rHJ+ez3VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1137.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 11:15:42 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.21.0113.015; Mon, 15 Jun 2026 11:15:42 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mark
 Brown <broonie@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support for
 snps,dwc-ssi-2.00a
Thread-Topic: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support
 for snps,dwc-ssi-2.00a
Thread-Index:
 AQHc+mtCPJneHTK71kastHnYdP89lbY7ISyAgAC2QrCAA5WxgIAABzewgAACbgCAAAT/MA==
Date: Mon, 15 Jun 2026 11:15:42 +0000
Message-ID:
 <ZQ4PR01MB1202C160C5ECA0E9CB8CCFB2F2E62@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
 <20260612125856.8530-2-changhuang.liang@starfivetech.com>
 <20260612-mute-aqueduct-029ac227314e@spud>
 <ZQ4PR01MB1202FA8F122134F7153D26F7F2192@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
 <20260615-disallow-dosage-333752ccddc1@wendy>
 <ZQ4PR01MB12028430668DE1F9AE8645A9F2E62@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
 <20260615-regretful-unviable-3a6a65f48d9b@wendy>
In-Reply-To: <20260615-regretful-unviable-3a6a65f48d9b@wendy>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1137:EE_
x-ms-office365-filtering-correlation-id: 0b761a3f-6fec-4e8a-e3b9-08decacf7057
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 J72L7Gvab6bujQXTo2kQ+C1XhxG2Ny0zNeml9keL0mNIHigw9dSjFnEU4xkGGgWzKvHfxM2mDdzk2VuKVELqlWnt0hvzkchpfWNsWCumFB6X3FCA/WhvRenxFIjafF3429soOQtg6DOBumNzu2HYFoe7pOx+GHmg9NzgbH4RAAusiwt9CFWMR+V0JTkXW29gyPvmCmFRIfSF5wsYpeMkrN+9iG1A3GosDJ8r1NCG4TIU8rDpTMtfH4UJCv5NnuqoxiONxxNnTdCreTb16FkveB5fczhMaY59htNL3s9UwparcyKW+Y9JD6gOW6avhb6cySrHeZ++gzVS+Xfpk0I3jpKmLEWTAMvZqKi8JpUHECYBvj2kGbv8D+NYJstmePCkY9UQKsxiG/JAs82g0g4HMy38fiqwcGCgyPLdjC3Ukbp9jh/W7YTBhbh7Q+rOqRYJg+/MYk7WlLQlNkltemhHL8uJ6pvhBlJ1f4Zp2OT4S/gMi8pRIYWjCEegTBhfrLq2FmE2z2uMWuhS3qEFvFJMfreU2p+3CLWDG0IafnaXmZUA1OTD+t0PixvWaOpvL+R6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/8+abV6yFgZNxN87TXhGZ3GxFY4KG3b5He3JY4gZ6qRGCV+VAUnFUXxnYlzU?=
 =?us-ascii?Q?Sjd/Ea5I/B7R4JJcAHmp/7ZcjdIIuVSUtZeQ5Y+lFnMBoX2aN9h1NgeazKtG?=
 =?us-ascii?Q?APs+klwCwqNl96tJ2de8gd2BU1+pVDbuhKDU3BxVMoQQXIX/G9P643gjIT7q?=
 =?us-ascii?Q?5bsxUo9IZKKWK4k1OLq08cdEaoSBWY1Wabc6aEn0eobogJM0jiqKOqswWI48?=
 =?us-ascii?Q?S5qse58AlEMPik62a7vKMMTSpSXS1Czli87F4JxbscZX/oSRz5U7xfGL6wBu?=
 =?us-ascii?Q?M2xiWJoMmTJBGTkpBGir736cNl2eQGaFJ1j7Xrkibx3O0TDHQRsDQEYgEssI?=
 =?us-ascii?Q?Tx54P+rC093LN+EuhNH4zsyayHUWsR2q1SyukmTi9gFReoOgCi2SgX7i82d8?=
 =?us-ascii?Q?aoq4GP0g5e3OQ++iN3XjqpGk1o8e1kA5puWzm4bSW8duu0J/kQLFxLZlefs1?=
 =?us-ascii?Q?Qfw4wzrTLtF099h9yycpA/Y9qh0Wx2AMKhNOvKMVJYtSMc1YUA3W5Het66M1?=
 =?us-ascii?Q?xhJBMTmb+nqPSyE+y3DTj5QRgNbD9G/CB2enlXlxZqXeDGoQ5BpQEMomt6HT?=
 =?us-ascii?Q?dkfibHLb68Xw9Tgi6DGxbczSP6TJT03A5isN3oAizz/bPd00AJFSG6h6mzWd?=
 =?us-ascii?Q?rbuZKk69uSXzB+S1jqEV2DKZ7KLm7utJ+a87SqpscMjVsMMZlJ+mHrvMEzOe?=
 =?us-ascii?Q?P6jTrVisIJxIcB9O979G51gbhGNNULm9cy1gAAnvshckAQ4kis3VSsCl/sNV?=
 =?us-ascii?Q?78Bwvu6Cjaq7NUrf2DEyXmmRp597lpmVHQzMfnu/OHeGkJfFbK4DozEj1i0D?=
 =?us-ascii?Q?meyqazGCNk7iS0zgrPhY0J4D3oNbuEfo878eiw1AEJSk6yoOskUyPxwSXtoZ?=
 =?us-ascii?Q?iYX7h/hqjgqVn7staez40o4D6n/ajgEeKkqXRJ+laQlU2YyyGLYWMZpmAybJ?=
 =?us-ascii?Q?ninm3TP859wYsAE7lNQI7eVYcJB/FC1ESLVdb1F+rGB+eSOtF/SO7T0HvnGI?=
 =?us-ascii?Q?JHW4yHPUuimrfKA5NmUvCb/kjgVowXLbaL05bbn6vxs2reCzL/VsVMNK/7Ri?=
 =?us-ascii?Q?iyKC0Bb8VZi3a8AAVLvCV+p69gmfukJF3dpHPoXv2HoD8IaiBMcE083A0Frg?=
 =?us-ascii?Q?N84YvzQ9jJap11DJttlk459aMnkYyClhu6c0pN7vRxE5s/WlgnXhlqbxhz16?=
 =?us-ascii?Q?/M7jzlwWE3QqQfsbwZfah7uTqZYTSMc19+F2K2qBoufp/0nXYTZCLPnv9MmD?=
 =?us-ascii?Q?hDRXxcm6O+MxZPqGbZsclk/7OyFb+1f0g4M32if+SPKz+Dxx9cgPDS5OWC9v?=
 =?us-ascii?Q?IIpw4LS6sTr7nRuhgkDTQLhfeLVh+4CBVQO+OfO2XcW5i9q+61QLt7/YIdPh?=
 =?us-ascii?Q?GFPwwwIvhB/jUKQCgLB/904+ReuVUZZ0cKTlDT1CgCA5i+vxgdTQo1LTgvJV?=
 =?us-ascii?Q?pZpC9lqoaTfd8jer/PfRqc0OOdc8yfXhxTs8kaD8jmkajZy23vPTfQx5KtBj?=
 =?us-ascii?Q?nzWKS6DPCKk8iZhJUdi6du31oT32tRMw8ohCT3zjIeiVAmIzFejkr5Y29T3D?=
 =?us-ascii?Q?RM/ibg+feN04CgsPjjlLPx4f/HD/egZ2Lq0M/1c9grBaGBoTmCT24XEfpalH?=
 =?us-ascii?Q?KpCnDSbFc17pRuvgwHj7+hhzgwI97pJPaDOgzNCJNw5IYT9GOQYyKzlG+nIP?=
 =?us-ascii?Q?m5RdHakGq+lvtlMCEUyuZc1i7iOsTKvTMojmJMyUP9hBTQfRWF+3yauK4FJx?=
 =?us-ascii?Q?e2HM0sNdN5scFgfIWLQZTTApYOHNaEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b761a3f-6fec-4e8a-e3b9-08decacf7057
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 11:15:42.4483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7coB6DO55UwvlJjXpIlBzCTutFGOPD3y/8Nf7kyTCmNmRFbHKTvgGXpd9AwWZp0lLSlw0OFRzx48x2ElBqwDvNeQDRcymGKRUTcoJIde1aTy7J+Vg5z5O3A5eVB2JvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1137

Hi, Conor

> On Mon, Jun 15, 2026 at 10:49:07AM +0000, Changhuang Liang wrote:
> > Hi, Conor
> >
> > > On Sat, Jun 13, 2026 at 03:38:46AM +0000, Changhuang Liang wrote:
> > > > Hi, Conor
> > > >
> > > > Thanks for the review.
> > > >
> > > > > On Fri, Jun 12, 2026 at 05:58:55AM -0700, Changhuang Liang wrote:
> > > > > > Add a new compatible string "snps,dwc-ssi-2.00a" for the
> > > > > > Synopsys DesignWare SSI controller version 2.00a.
> > > > >
> > > > > Two things. Firstly, driver patch suggests a fallback to 1.01a
> > > > > is possible. Why haven't you added one?
> > > >
> > > > Will support fallback.
> > > >
> > > > > Secondly, I am going to expect that when your starfive user for
> > > > > this appears in my inbox that it has a device-specific
> > > > > compatible, so you may as well add that now.
> > > >
> > > > Our standard SPI control is completely based on the Synopsys
> > > > DesignWare
> > > SSI controller version 2.00a.
> > > > However, for the controller that accesses the flash, a set of
> > > > modifications has been made based on the Synopsys DesignWare SSI
> > > controller version 2.00a, and the driver part also requires specific
> adaptation.
> > > >
> > > > Therefore, on the JHB100 SoC, the initial device tree source I
> > > > have planned
> > > looks like this:
> > > >
> > > > spi0: spi@17f20000 {
> > > >       compatible =3D "snps,dwc-ssi-2.00a";
> > > >       reg =3D <0x0 0x17f20000 0x0 0x10000>; };
> > > >
> > > > sfc0: spi@18000000 {
> > > >       compatible =3D "starfive,jhb100-spi";
> > > >       reg =3D <0x0 0x18000000 0x0 0x10000>; };
> > > >
> > > > Thus, I plan to add a new "starfive,jhb100-spi" compatible string
> > > > for the
> > > controller that accesses the flash.
> > > > For now, I intend to keep these as two separate series.
> > >
> > > No, if you have two integrations of the designware IP with different
> > > programming models on the jhb100 I expect to see two different
> > > soc-specific compatibles used. I don't want to see bare synopsys
> > > compatibles on the platforms I am looking after.
> >
> > Okay, I will change it to the following:
> >
> > spi0: spi@17f20000 {
> >       compatible =3D " starfive,jhb100-spi";
>=20
> This one is compatible with "snps,dwc-ssi-2.00a" and "snps,dwc-ssi-1.00a"=
, so
> it should probably have those as fallbacks. The latter for sure, the form=
er if
> you know there's some non-discoverable differences between 2.00a and
> 1.00a hardware.
>=20

'm not sure about the hardware differences between 2.00a and 1.00a at the m=
oment either.
I'll use the following method first:

compatible =3D "starfive,jhb100-spi", "snps,dwc-ssi-2.00a", "snps,dwc-ssi-1=
.01a"

> Cheers,
> Conor.
>=20
> >       reg =3D <0x0 0x17f20000 0x0 0x10000>; };
> >
> > sfc0: spi@18000000 {
> >       compatible =3D "starfive,jhb100-sfc";
> >       reg =3D <0x0 0x18000000 0x0 0x10000>; };
> >
> > Best Regards,
> > Changhuang
> >

Best Regards,
Changhuang
