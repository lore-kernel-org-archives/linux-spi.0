Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2101.outbound.protection.partner.outlook.cn [139.219.146.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC883911DC;
	Sat, 13 Jun 2026 05:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327599; cv=fail; b=h4UJMtTVas4DDVZQPSWkx7vBQ1gdNIouWIcD2DlMrUBESc3IjZENIzv1+EnNIy97i6o0cXfNjbApoV7lTlY6+dS00Fyd+lQE/ctb8NHblDrJW+ZhIhje6I/amnqL3Kjv4qqksUnbuhPLkfrFL53HymWVNdCSG08T47ciHHQKCSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327599; c=relaxed/simple;
	bh=V0UaFol/Yyp/NwaeKeuBy6JGAhGSaTGmCh6SGkpY/gU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXSBNwS7KDUY+RnnsLBqXlGUQOwThPDKjZFlx0VVokiB4dL+glKwObJaS0Zjl6ImDCAOmW02/74dNvm4gNQgfD7zoPoD1M0uMgiCJnVcjCTqcio+WkuhbXS+xzCJkn5sxlg56e/WFaYEuCzTgYOkQyenVA0nfiTnuUaoTX7ITNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4FvT92nej9y5Y1JvX3bJeR6ECZYmq2Jkx+TqGKgSMyKHrazFOjaUFA2z54i+c7/7jl077/o2YI5t97HI45uJ+sj1RHpHPzvpb/V0ldeNM/9H/e6GFevkR9HwwUjy9sx0uy4DDEqaiTeuJjgSGFwQz/GDKfCen5VpWh0NC2wwE1VT7mY5Hz5b8708HSaTZP2yIbfTVGycamMK1por4lpVOTWS9HFvBYVKwsZkovc8f+a/+8BBAicZFxgDfo0WbgDl3goRV7S2U3gC8Vmegz/6O1yYpPFFVxD8NMX4WHMTCJ/J7Apwql/9TkNqBXQGkIqHICBLjE9Dky+QTSAX6dCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnLnsVU5z4svocGt6KiN+r627Q6yGxOk2SmbiCb711k=;
 b=FfQUyHUqD1EWr0+u78zdifu+D0gyTZo7N+mneDMY8Ta4dtzqvjvNrMVCPmzoe7u2KPYhB6qIIb3wspTRbrr9COcG1hFpcbz/d+txY7yXEK9allEjyxQ37ALOGW1P1SZG+5vinWpPxy7uLNsO1qMEGr4nJ+c3rUG7jTfZ++3ZFiaNKlnBJdoNxTct6IY0/xl8k7orsgSx3iY+WeXhPfOGW6DoAtaS4dI2ZF9cDZsEBSbMzgNNJ8GqEHpgnHDlhfvF2N8L6/E8y3Y4ylpjgKe76CSQLZkW2O2mWLJ+gHX2bj/uLFxze6hBUIxTZBbjHEhcnYEfuMO2IR3pvXoPnUCeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1235.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 03:38:46 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.21.0113.014; Sat, 13 Jun 2026 03:38:46 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support for
 snps,dwc-ssi-2.00a
Thread-Topic: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support
 for snps,dwc-ssi-2.00a
Thread-Index: AQHc+mtCPJneHTK71kastHnYdP89lbY7ISyAgAC2QrA=
Date: Sat, 13 Jun 2026 03:38:46 +0000
Message-ID:
 <ZQ4PR01MB1202FA8F122134F7153D26F7F2192@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
 <20260612125856.8530-2-changhuang.liang@starfivetech.com>
 <20260612-mute-aqueduct-029ac227314e@spud>
In-Reply-To: <20260612-mute-aqueduct-029ac227314e@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1235:EE_
x-ms-office365-filtering-correlation-id: dbabc442-a17d-489d-c4ca-08dec8fd4615
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 6h5boq43kZgl2n9ijuLIUAaAn52mn3LFG50rDbn1rKbXhR06XSCNkb08wiUAABDG7NXrA9LRYSYSZFx8Ve9LfGtKTJmgKIj90zz1tg/jTVscuy8Pb7Iqvf/NwfmOSMXwyRFJOffROipRtrZjl296KblyQdRR2wdTHF90Yl5B4341BNd6XbncGYhoDENcJcYMp+56Ea26xozsNQj98ElPIcOyEQZ79OTO/nrE08DGr6cLcFTdDSdHXnNY95LZUytj+YYv/zDuNUTHFjW0m00P3dd2vhlMtyW7Yk3/8kvsE+KIdlFBvyx2lkqrRTMtZanAXCEWpmCrXSzsLwmEVmP58xme3FFEta+NAjh1anQ2OllCK7TuIZiFwzV3Av3OWP3gRLEi26nxOzQktKJZelGmAmCF1uatyXdZCLwb9asiBSHfBd0Z5u7p/BqO0DXDnE5FWR7y+z3K1NLK4o0RqKvnEFzU356GJnNCV1CFuQ+rFIWicS45CjlHcQgUtpSVEFqlLde2T443ym9gVwX2qdggFV+ioD9FEs0O383lEOGADAIdkGA40kwP4kUGs9CuFiK/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Deqe7LvV7naT/WAV2xDAjI66z8vPvAvdTKstdoovZwazQNKHA45U2no2//ce?=
 =?us-ascii?Q?FLbs/kTfKBlxxzg2CcAeI9FN80JIJNtmSw0fwOlrwEMU4f0YqP/M/D6yT3ak?=
 =?us-ascii?Q?/Ex+Yu5Eh9V30eZfrGV5UcdmZS+0Cm6oAH4IW1TJBaXyTH9Sxa+GX9POYnEq?=
 =?us-ascii?Q?lKgScho1tSLUllvajkEpYiNly0/VvrAiSt09GxdZEN+CwJM7dpXGGqB6gd4k?=
 =?us-ascii?Q?PC1WEJETsAixpEPW+skeNeAV17kTconYZmgKVJl5XyjqAPa+JQRomaNyGW8P?=
 =?us-ascii?Q?QgAZcProU+HROI1uLja6f65NaKaV2YdJ6p5BXr//EQ9WfjnCw/mIv05ff4Uk?=
 =?us-ascii?Q?kY0BjPIpMSsLutlgXkKnc6zRDM1lWtXj94FlKkfL0J60OT8DV+DuMDuz7hj2?=
 =?us-ascii?Q?Fh8l1h900klv4mgCiqy4KyyrsftsZ2SizuYxhig+SogKunb6mCp5ou34Me3U?=
 =?us-ascii?Q?rkp7zaegqdwrxxFBrL6V9PMlnKZyB6Z0dkpsPUIyuRx9iS93DAGZItlq0BTz?=
 =?us-ascii?Q?keIhfo7dBm1avGO+zxvwakK09U6Spk9ooJIzp251slJXKncZYLNrZ7/iLAiF?=
 =?us-ascii?Q?HtKGuKjS/LmdyiO6oum33DfOHyuzfysyDgHK2gk6szKEK4jzFIUkiPG3tIFu?=
 =?us-ascii?Q?l3jCit1uBdfILScbEPpLKrvoLLY7dPdPj1hc+WXE8SWz1QhHSciVVdvZjBHP?=
 =?us-ascii?Q?WsMO8wS5rNNRhRdh4w9KBgObYp5TE0tMCFHrnMQmhJrqaovNmh4h7zvHCjDQ?=
 =?us-ascii?Q?OdpFRv6d+rtSvbQRMb9b0K6sD6XMRIQ8m98W+2CmFqdVgONQ4Ttai/hUgaoY?=
 =?us-ascii?Q?INESkIjwmoa6v2rKiXFPCBA4qJ9i/bkpixMqOmuRXsLzUXyi3SQQkyjgp/gq?=
 =?us-ascii?Q?qm9Hehh+cwlK370Jd2REBMQrlW5suDHQvseVcAoRT5pAHc+XlmFJQU3W1eth?=
 =?us-ascii?Q?49GW/Agw1VpSufm0s8/kSmP7ykpvNweVDRdNrI3tDbqxFvVRATS9xuOgBuCK?=
 =?us-ascii?Q?YcLdHCQ36thQX2S63k/FEG9gPt7KUtPUJlhWUE3dsyUZXKuHTulUIxRlvgXd?=
 =?us-ascii?Q?VqJP/X2mhF02LqWJ4tNxhKyEmsLq/fJw1biwqBjGsg2LkiClTEV8sUZASB/B?=
 =?us-ascii?Q?yIzom6TVqNrUW9bxIVM8u2FuxtUTm9tkB7mDbje8Z2JDpPU/MFfrr7x1KSjl?=
 =?us-ascii?Q?FggT0C9jBrScmnWI6rfLG5KWoI0yz+nEyng+HY+VrKJt1XMEbwPbFNdoXy29?=
 =?us-ascii?Q?L9/94+xtXJIkZcQ9nKUzrF9x6l5Xxws2+W7/6Qb1B4Ai8Uqe6WDWOpnhPTjJ?=
 =?us-ascii?Q?vW8gu/PTdmq16naIJsJiy3cO06qLePegi1hgbRa0NBnvxbkU003ya3qGIQKa?=
 =?us-ascii?Q?7LRSAC0Bi0NVwUZgqUzuvJw6IveLxmYQcyD3B+G43h2ykfzxiHlRz825tRH5?=
 =?us-ascii?Q?y8UeSFJVfVrNjzXdM3swqvdgB4hEy9uEvE9+JXvzr0kcrWSRSPnzP1d92KHi?=
 =?us-ascii?Q?qYVYk8wMJN6AIl66uLajH1ZWo7kBD0svjizRn7KM9VD4stHjS9WXDTukOAuM?=
 =?us-ascii?Q?QjKU66u92aMPbclOodQiWoZfvjo6eKULahkC1fAzsle6R4AL5QemJuIdH9ew?=
 =?us-ascii?Q?QiRYgLtgbpw/W4uYJRjluU6KgaNulJlhzzLtroLMVwODzzCzzE3MXkB+V8GU?=
 =?us-ascii?Q?AVOK4lFhYIEv0l6rrT0ZR3MRA9KRvh41v87VyUKTR+nuemtoYXJVzn1crVsL?=
 =?us-ascii?Q?eqlIGS/HT73pIUp4CwAGM/INm+EnhW8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dbabc442-a17d-489d-c4ca-08dec8fd4615
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 03:38:46.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5K6iZnqIiDkEWrnYF4LxJI5k0uRfLpRoA0kHS/iSOAzmVwW1r9G0tG6EZvC85ng5BchrMiF5KpbVzJgQwgra049pIzh6umypCRCpcqiCCGM1/ti9nRVG2uLcDcW5kvEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1235

Hi, Conor

Thanks for the review.

> On Fri, Jun 12, 2026 at 05:58:55AM -0700, Changhuang Liang wrote:
> > Add a new compatible string "snps,dwc-ssi-2.00a" for the Synopsys
> > DesignWare SSI controller version 2.00a.
>=20
> Two things. Firstly, driver patch suggests a fallback to 1.01a is possibl=
e. Why
> haven't you added one?

Will support fallback.

> Secondly, I am going to expect that when your starfive user for this appe=
ars in
> my inbox that it has a device-specific compatible, so you may as well add=
 that
> now.

Our standard SPI control is completely based on the Synopsys DesignWare SSI=
 controller version 2.00a.=20
However, for the controller that accesses the flash, a set of modifications=
 has been made based on the=20
Synopsys DesignWare SSI controller version 2.00a, and the driver part also =
requires specific adaptation.

Therefore, on the JHB100 SoC, the initial device tree source I have planned=
 looks like this:

spi0: spi@17f20000 {
      compatible =3D "snps,dwc-ssi-2.00a";
      reg =3D <0x0 0x17f20000 0x0 0x10000>;
};

sfc0: spi@18000000 {
      compatible =3D "starfive,jhb100-spi";
      reg =3D <0x0 0x18000000 0x0 0x10000>;
};

Thus, I plan to add a new "starfive,jhb100-spi" compatible string for the c=
ontroller that accesses the flash.
For now, I intend to keep these as two separate series.

Best Regards
Changhuang
