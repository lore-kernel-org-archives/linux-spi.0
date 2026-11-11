Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387442;
	b=WAPuUsgC47256noZxqPL3N+1hxenSh67yQMQtIHXBQrFEUiG8cQVVr2epszI7n0ILCSd
	 BNEn14B8/WcSp4hJyUrPOJhcXCU6FW3BmoZzlw6q3tUF1IkmQ1rLkxHtibe8LdGSxI2YA
	 RRtN1YJTELe+41kMUmvlOd4Oe0SyaH6Zcc3lcuOJeBPeymCm7zrfA8Ix3TkfN/Qld6/N7
	 izkk/3rl1gBkT8DU3K1C8HCeMFbHfQgtsXoxnY30oT2gZrjgWXnjDKig39oC4u9DXjs7g
	 FnSaS5/15RcW7Dob7reG8P/fS3CkiBaXpJVA4Gg13G9Yv7QQ4/6sqg+N/LDjz/BDnYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387442;
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
	bh=cZRjMrpcCIELl3FnwT0rBL4bZCvKHoA4z7hns+oupl0=;
	b=hyws2hC2wgpdl+NZ1sSuS9hDdKZ4rlSejoMpth+YpOjAERNErVE0VMvAmAbyF0DxMEJJ
	 dMQxhCiDKd467BN59CXotTkk4hc0wRNXX1lytf9A+drbZoFpo05IneNkIBNzdgVvwAjIq
	 fXim+0kxFDrGI4LO7Rs4V8Xj4kcp4bCjSK5U64AVtMPJq5ZirUmsZkt0dIm3GMZV2GnMW
	 jPAo+scYxMc4MwZBQteIpyn5W03DmLaZRLw9mfbJriGDGaDQCdU/TJKAwvPf580mORNB/
	 6hr21yH/Wy+AK/72HQ7nlhalkZ3qU8w7mg93gGUgqP81VwHelTh6L26NSthXuldpJ8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.114
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2114.outbound.protection.partner.outlook.cn [139.219.17.114])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74660A3806;
	Wed, 11 Nov 2026 08:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F74660A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqX3GWFqe9/ZrI/2T1O7j3f6edLDBf8O6o2txWIv09cN47L8WqmlYWq5FPCdss2JXyT4QIoTQFA6BRpHqYfJLO+8Ads6FopMjtjzd7eYfF4I+Bd1X6acmeDqcQUasnpmNU6O2RR1c+Dq3zkoVb9b7SHTf4mtt5Qk06vRNTjMSlbjiZDZE+JGuGBXdUAtAk7K2yATfMDbR/tHZ8rWWbyhCv2F0FH55K+djqkedQ8c0h/r8qsp00NKstoWQYtNzRzb/bdWHbNGfzOCPqT5aQI2pwWfrw7DCPcuQhLtREneeh8m7CSiEPgsoZrggmOEkAH1kClI1MtDvqqa+sAIhuNNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZRjMrpcCIELl3FnwT0rBL4bZCvKHoA4z7hns+oupl0=;
 b=m6dtRP+p/JJIYgZteSJcTVsYAGDQDq/XPrimfQIzWEu+1LdUYouBz85h5amHwNi5SObMo2iBrsgWNlAhCJfn4/daMia991k756eyX83dj9MVnYZ7xWdBi5DBlPpG0X8yR5ASlawVBQsjzTohK5y63dOid3RT7IrEE+Wvr9kvlkHxJ0OPuWkMYjsTVp+UTZ92ydaUxodrBitLVgL3styJE23vmdv60eiBhlFFKdo9M8h3Pd7mkUR4daoN6gOPUyWTmiMjp5Xe18biNUA+97vlMov1hjks3sAvJm4NPiRSV2QPIxeGvpDgySRqsWvv+iLQlAZlz7dGQYOGg9/P47qBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1138.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:57:09 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0615.008; Wed, 11 Nov 2026 08:57:09 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] mtd: spi-nor: macronix: Add 1-4-4 DTR read support
 for MX66L1G45G
Thread-Topic: [PATCH v2 5/5] mtd: spi-nor: macronix: Add 1-4-4 DTR read
 support for MX66L1G45G
Thread-Index: AQHdZtV0PySYFuq/qU21OO+JG040CLclTS0AgANaasA=
Date: Wed, 11 Nov 2026 08:57:09 +0000
Message-ID:
 <ZQ4PR01MB1202B6F48D3E7E5C13AED1A1F2712@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
 <20261028121100.79667-6-changhuang.liang@starfivetech.com>
 <fd16660e38f24049af5db47d726744d5@infineon.com>
In-Reply-To: <fd16660e38f24049af5db47d726744d5@infineon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1138:EE_
x-ms-office365-filtering-correlation-id: bd00ba7d-11b8-4e54-1228-08df3fd1c4d0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|10067099003|4143699003|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 nz+6pIbw693uIIES+prTfIp0uegflgu+FJZkZsptmavMi2zfm0FtiyW3DrZICfO8GdSuYh+n70X3EhQrJz1lLFXZoCeSWi+b2MWdGrN9rNqbTTimkaAmLkT49K51yjKChUEwnRo94lUvLalD6bRHEMnnQt/MN8MzueBknBpSKwPjVZJgj2Apl5Rv5CUHUQGixtYiFgkbyVA+z1Uc5JkHU+IqULOFtk0U2UbzaPCrFmFp64LMzvn4bMZfQwuRL4UDli863JuuMZqugFblueM0XjN5zuoKNgO14cffgHkcD29hzheBalXWdw+fH6Gd/muaMXdHAf0OL92UOHQzaKMea8BkPGi2eNMOc/w40tdIoDwllwG1ME9dUPhI+SF3qw0+nrX0CNOBKrIYJWJVsb2jPnHak+uo3TFuH/isNz8hJaCZPQJ71o+1YcW2YE7ghK0b1SiE+LJMC5MTrYjwqxD7DKujzfKl8KCrFhM8Ue7IQb/RNDRuvjp3uGE7F3KQUUfzKp7FJpu8ZUHdFBVyNkHNlE6A+ZT/MYWKqJEH4XNm/tpamW1MfUYJ2/SPwz+i8r6D
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003)(4143699003)(56012099006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UyqkjPGab/gvZpsVyEEwQatTcv2oyGHmj+IuufROB2P5uLNnimqNAJhj0IRx?=
 =?us-ascii?Q?8DKL2z6EBHFltHrG9jXd0amtiFzZC5mwLiodt7oywLKGO8J54LGE//KUBEXL?=
 =?us-ascii?Q?U4y+cgmoXAAe8xGwTR2BymfjxXmwSS2mBed64XijdCldxqKlAR0/vzHMBEaH?=
 =?us-ascii?Q?Z4P2Sjy4+3Mce/nlhMFhpEsMWdXEf+kZONgBkmQvqBKfzNQFEtF7hRqnpy1s?=
 =?us-ascii?Q?Hqaiz2gqaiXjqxJKUa2kMHe7XFSMUplOnbBv89vXhqQXipvEnrjhoYXWVXe1?=
 =?us-ascii?Q?V8r3FOLddfsBsRYrn0AfR4KNBLu4bfbzuyqBoUyJNoCxrgBFdu0EA77QmstR?=
 =?us-ascii?Q?b9Xc26G8NXOOO9X7W5oTFP62bb1bxP5Q0eOR27ZgZH6WbfuHjaUyoavFTe2I?=
 =?us-ascii?Q?9YnKA8Bh3IHyytKxZlTloW2h1SMa4PMrp9vV/9z29BKK74rk3sx3+e1bls17?=
 =?us-ascii?Q?Uo+fGQqwScGVFtEZ+S9QVWghVb5FggXWWjNO+HYx839ct2avoXPiLgD5ixs/?=
 =?us-ascii?Q?zj7dTfsclhtFZmxCcSL+N7KcsESgBTS8rBVsPhfs0yS50KvzYNO3ZTmy4OyB?=
 =?us-ascii?Q?/Bj8asipeXV3JsONeAhpZ+BwXgn+cjzcUSByUX+M9N4wI+knA46oXNFVIPgc?=
 =?us-ascii?Q?IdfAt4TzlYkt8Y+Mddr03Owtcc4GsfuaonarYth7xB+NTBW5l2mxLAEy4YQT?=
 =?us-ascii?Q?3Bli8t6TSPF3a9OmYKJN7iTdmn8R6Pq7HC7Ee0K7WKPPDxUneSbc2hFV3et0?=
 =?us-ascii?Q?KM/E877vh/+2gk2kfW0F6SfWqvIk6HoCGw+MGjCNw2EA9KvW+a1Kd8ilxSwJ?=
 =?us-ascii?Q?vZCh4hAgEGs5GlFHLa1Dsm/PegnSEHiQzDFuXa/qerKE2M17+xRY9Kfc0FaX?=
 =?us-ascii?Q?gdQM11uzOlu0qU84EjWPk3trNN39yfINcnnmoybRkCT72INIMOJL02QquO4q?=
 =?us-ascii?Q?svtrZQPs6WRuD5bCM9v8G4X6r/wItZ8x3Q9Z9g0ogg6/C5iPHceS5G6RaqiU?=
 =?us-ascii?Q?s+XyF6OFnx/FRwsCLxVr1LJax5ekwb5OLDRPlYC5GxhQ+6UGaZdhm3a+VF8c?=
 =?us-ascii?Q?hsbFuYXq/PLEMEJxNccNpojshCtlSjGV7TC1eAvdipZlaDUSVf2HxtPPSBI4?=
 =?us-ascii?Q?qV00wdv8dpgnw4nHcsvf4rF/hqk6sfL5aj0+F0l3ukLUcuaqT7o1DEPgTNLX?=
 =?us-ascii?Q?/tmBUGjoX5bk/nWJHQyb0wlZA6F6ngHH5ZLv8iWVJQNhdWsC+b2Za8LsSrHx?=
 =?us-ascii?Q?6zWh4Cv7GeMotH3mgKWOD0Y325A56LA4XWe4hhnMuWCVuhiTzadeV/iQkaVj?=
 =?us-ascii?Q?SIaQt7Hwv7x5W0hI/tgI+V5tIFrBSSTL4Q/Z+PHWzA/Zpxa3gl5Yr/VE4Oyh?=
 =?us-ascii?Q?e7e8tFJNAO34x++o5RjLp3U6DPCgvCQbX0DHHDdsM9Z1r4f7j0FVJAuEjQML?=
 =?us-ascii?Q?h/MY2kht3Y9y/ins5qm6mCWRFBMIb0pzZrh3uwZv6lvD9mQioqxrmvsdrzqx?=
 =?us-ascii?Q?qxokBHp6Y/uwuG/qSMSPXMn+zQHgP0oA6pCfAInU5bUN1sTtRgKdYbgK+RgB?=
 =?us-ascii?Q?J295NbOBuTnQDE5qGvEEf7jaZV2VtGa9vqlmocL+kK0iXtr5L7A9XGRSWdZg?=
 =?us-ascii?Q?H++5IRNwcaSM+cEstsUPxk7zVtF67Bf6HnaXIiiGcUygWl+yJW7yhw3qxAEj?=
 =?us-ascii?Q?nDkct7Z9xAMBghup29MGOaegmNjBHE11SW8b9PFOwF34h4wQirpsO50XB5ND?=
 =?us-ascii?Q?sIK+CCg0XBMAJpZhmWYjdHVlHeboRU8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd00ba7d-11b8-4e54-1228-08df3fd1c4d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 08:57:09.2081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jheordCJGuFEaWMNToQ1yR5rhh9CSXhaEir1UD4aKEyzvZDwhs/JOumIdDu3epjVlIPAx7QVmhPDBEuEDwCdeRMell4fxxDR4ehkzr7HAvRzOr3ayc0GJmF0bwe0Uu/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1138

Hi, Takahiro

Thanks for the review.

> Hi,
>=20
> > The MX66L1G45G supports the 1-4-4 DTR read mode. This flash uses 6
> > dummy cycles by default in 1-4-4 DTR mode.
> >
> > For 1S-4D-4D, its support bit is located in the 21st DWORD of the BFPT
> > table, while the dummy cycles are described in the 23rd DWORD.
> > Unfortunately, the BFPT of this flash model currently only supports
> > 16 DWORDs, and the kernel's SFDP parser does not derive any
> > SNOR_HWCAPS_READ_1_4_4_DTR capability from the BFPT table.
> >
> > Therefore, implement late_init to initialize support for this opcode,
> > configuring the read settings with the default 6 dummy cycles.
> >
> Since the 1S-4D-4D support and dummy cycles are expected to be in BFPT,
> this fix should be done in post_bfpt.

Okay, I will use .post_bfpt to implement this support.

> > The SFDP of this part provides a 4BAIT table, which also advertises
> > the 4-byte 1-4-4 DTR opcode (0xEE). SFDP parsing converts the read
> > opcodes to their 4-byte variants and spi_nor_set_4byte_opcodes() is
> > skipped later on, but the 1-4-4 DTR read is only added in late_init,
> > after 4BAIT has been parsed, so it is not converted there. Select the
> > 4-byte opcode directly in that case.
> >
> If 1S-4D-4D support is added in post_bfpt, conversion to 4-byte opcode is
> done during 4BAIT table parse, right?

You're right, this will further simplify the process. Thank you.

> > Also set SPI_NOR_4B_OPCODES like MX66L51235F (0xc2 0x20 0x1a). The
> > part supports the 4-byte opcode set, so if 4BAIT parsing does not
> > complete, spi_nor_set_4byte_opcodes() still picks the 4-byte variants,
> > including 0xEE for 1-4-4 DTR. With 4BAIT parsed, as on the tested
> > part, the flag has no further effect.
> >
> > Add a dedicated fixup for the part (SNOR_ID 0xc2, 0x20, 0x1b) that
> > keeps the existing QPP 4-byte post-SFDP fixup and additionally
> > advertises the 1-4-4 DTR read capability in late_init.
> >
> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >

Best Regards,
Changhuang

