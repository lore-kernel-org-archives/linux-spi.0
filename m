Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B93515C2;
	Fri, 25 Sep 2026 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317827; cv=fail; b=cLY8TG23aKts5C/VDvlga3mcdiCrVa1px1z/XBxtLcDZ2+H6yrUlorKZipdnqhuMoqaVpEJUYYixzCN0K3lZ0nkMxzolMNCUIEe/c2oiSzO7UeuPenysPF3ucVycgY3hwqWkzyo8/7umkV66tnA0N5H+5c9XF8n4pZdDtHgdDgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317827; c=relaxed/simple;
	bh=R8MBgqwFLny6raBEjwHOttBmvYUA8yATg+p9SSUDM4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qJw7De6PP8BeC4p3veeUTZNdC/2ZTuxo5+1qgbjtB+fMETI+LGwWgXqJYABmcE5k01NFLR4ivO67ZoMnIyTILlm5zMiBMkuMkoqv4ELnYXX3FJdtGD1k38bpfvl9zmTj6qmGLDM0YRNLqQcMXGnSiMIT7L67Yk1uN5R4qUMsC3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BazmKBB5tA3Kqku9Tx1plcaJYsXRrvtoF7QiMjdRZ5T/H8/mRabv4UIfUrB4aXTsqkZjT13hTBd5m8TQ3XjuL0tv2YH/JVjelXEg2OdxqDAtPIgTNDJZl1ZmZytPXrVDRSJ5GNWEFID7qDieOVpKAlpU6BEosj0woicD3df63aaFe49KZVTxSd2XvyNfWPHOnW7T6l1Yl9RpQ5C/DEXCQIWosA7BSFsKhb9cFsd2lLQx7b2yNo0spEDD/sbjduux/Ryhf6sCYJskumU6jMwHD5EAtYF3gF5JfMfc1kr6G6OP8AP3nGvJK/bYZS6w0wqDZIwKEG5FdYTfDcvnF+c+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dbE2UPOOCp5RXzDsdJ9923uXCGDvSvgOJXPkHZ34/c=;
 b=jSochopN/yqthSvVfQP4J5CZcgxygPuV1N0YyhRBLZvHX01XnUEay2rYxCKUa0kgHEA4sLm/OaeMZ8WjhF6Wlqjv6k///JCqasO5w/AoL8T4I/+CYwoCoWl12dV2gfe9pC1wJo/PfmK0T60yxs36VimQNxFC534csRo+fF2/PHn9zba8nP3urNKNhy8FIU9Rw0SvnsY+wAbJb07HBnFrUfCKbjdZL4lm5kHsXCi9uRHbzrAz0m/kbmMmqaLnwOwMQBRAx3NclDe1njDczG7N3L82M022vaTAMulCz8rtgcBF/29aUSgBw6bm7d8jlOSUnopLmkI4vVDLwNNwVOTMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1332.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:30:14 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Fri, 25 Sep 2026 06:30:14 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
CC: Serge Semin <fancer.lancer@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] spi: dw: Request DMA channels at runtime instead
 of probe
Thread-Topic: [PATCH v1 1/2] spi: dw: Request DMA channels at runtime instead
 of probe
Thread-Index: AQHdS0HoNlKEArO3nEamu3mxZh2zNbbeBy+AgADQ8SA=
Date: Fri, 25 Sep 2026 06:30:14 +0000
Message-ID:
 <ZQ4PR01MB1202847DC79D630EE98A8FD8F2802@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260923095705.233297-1-changhuang.liang@starfivetech.com>
 <20260923095705.233297-2-changhuang.liang@starfivetech.com>
 <4688e732-0fab-4e23-9d3c-e0326b3bd65e@sirena.org.uk>
In-Reply-To: <4688e732-0fab-4e23-9d3c-e0326b3bd65e@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1332:EE_
x-ms-office365-filtering-correlation-id: 0b0e657b-0baa-4157-0707-08df1ace755a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 BTQUkdZGXZe6DK+NeJViFebbGqgxwoQ7ho3CiWHhC2FJ0qppnKJafaVxmueWtKxmEyX8bI9o5TJrUwP6ehpXlaNcdwyP1a5vUYqSByWI5Vl881jgwRzLXdNO7j0bqAQY1D7Akbxx0Dz7GwoZgQJe2V/6kiQ4WlPxEnXVa22/I3epSIas7kSwlDS+UXeGMKmYHR/9J703+strB95azOuo631LM3rRppb2dLAOfEw5bfImUykynzxNkiasCry6JcrdL74+ML/QmNOirSWWE2hosQmGETHESj0A+gdDWfpLEUFRy1REOvqqYIQH2jT1r3g+WJAFBoFRL/oCViGgQmXuxEEzhCHvc0hVhfECvH8iM9kSZzJII1lI/W5/YN0CzM/MsAzcMDI8bdQiUzAz4GyzaMQJJmcJziWJaQ9s28Y9yUB80ecxbbmcQLi18OrsgxpEdC705RrnEazpjn2vtULH1EIOoCk5keknT/iYWRfVlqQSDsKa+rRDmLKGuG54WcSPctoA1tTOu6v1ZVjdUJwF8bQ+0qs+xdnkei30RdwJDGZ94zP6nMUFnh61Dsuxrh+i
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z8I+hFVdYjk34iFHQQRs8D4YlLZNVJYRCSfWhEizGCjykmZdnYCdQNvGgbKd?=
 =?us-ascii?Q?/oODVriAbrgwAg4KvFd71hQTIQao3i6MF+sIf1i1yVypE5d10Z+h9tbsZfNY?=
 =?us-ascii?Q?cxqPOcZeYnRF3RjlFivRkMU0LFyvQDofXSbf2Za6wbo5sZd//TJqc9J1+YAU?=
 =?us-ascii?Q?N68RhUPpBWeEYDhPeyGW07AYEPYDYdISyRNYBkx27bMoOwy/+J5TO6Hq+X91?=
 =?us-ascii?Q?lCdeuLmUbDN4CrG/qWZjTjVEhqU6gj8Bd6hQu8Yc9cq2MJXu9whJQt3dayUx?=
 =?us-ascii?Q?tbP1AEDyktjkmUBqPrEg8mf7tgcItR6rBNa4Iw3C9UxcObA6eBq5mZdUMfw8?=
 =?us-ascii?Q?zV6kSozMxr4Gsa3gH61aYzPVnP4U9oLFva95UG+soDXBhvZ78dxAofTF67vM?=
 =?us-ascii?Q?yxsMOdkajc2ChnJD6sMMm7NBnRbxLNf03MmGFPRd+B3lGlZVE7wf1alW7TSZ?=
 =?us-ascii?Q?+TKE4dpTjCChyVEL4Su1XX8yBFKA8rN3cSUoLcdaByiXTNoA4Ac8GxlNAycz?=
 =?us-ascii?Q?r0xXiQzk3z7BA2JWTQXsaQCLkty4mYOD905/Xs5FCnv3LNlQzlSCLaXcgdbc?=
 =?us-ascii?Q?aabuluiHvEVvqNvzw9wN1Dt5bZR9sjGDpBrEMw2pAiOy16uBL8fmvfGGySnP?=
 =?us-ascii?Q?otBUQKPOuNGKJqwXf9y6Mr0dbM8Z3RUTgpFIWbnO3b3V7zEBw1zLovM+bHh8?=
 =?us-ascii?Q?rOb7R1d0xRxayXNdEni4vCOOENIS9A1m2NS4M/n/iItFxlRKXr+hg4OX/cTO?=
 =?us-ascii?Q?f06KPUIsu/i9qoqujV7BzQO5lMcGcNM2fGD8WhDhbI/zIzfCOxInewASeeEr?=
 =?us-ascii?Q?HMgNgzToh6mVp3vRTvup/geiCm0YZ0YEyzkW0992uwJnRIKn9/91u+Sh2der?=
 =?us-ascii?Q?jnRe9Ak9O1Aj3NhBRbTrMmaiIkMgboUSco1K4/W4MentV1rfVEnb2k//S3DV?=
 =?us-ascii?Q?adM63cIvIN/55mL//8JCl0xFXVJAV6pV4UGA7dsfmELsamLKZbyo7X5tDO3v?=
 =?us-ascii?Q?wc9mpDiz611K2Dmw/eeEIck2Q3bOfs/sr/WkwRQ9mBk3F73OgwXuHWSg0GZF?=
 =?us-ascii?Q?nPtlKhV/ahm+TT8hAaLG8TuByvVDNvxk9R2tY+FGG0xOJ+4DNmjT3nrgMyIJ?=
 =?us-ascii?Q?ScaQiLrmg4K3+d+rm5O9Xqyzv29lKkmTzveSJ9G8ZiFgezulAc0d85IRF8vK?=
 =?us-ascii?Q?79kdIuGRucMRU+s2FVaT/Jn9VKPs/L+ee64MlqsT6yC6QsbwPYkzHVxWi2Fv?=
 =?us-ascii?Q?8SUXk/cGOFopT0GKYa9i+UJBNt/FZ7uzemToiVVVeypwSN6V7Farw2xhU/nt?=
 =?us-ascii?Q?XPw6hdTZiXgZXc4kv1TeFIuarFbK+94YsoxNK0SMJoUpX3d4OioRJQ3yw2Q0?=
 =?us-ascii?Q?0Zsnl1m/iAqyFR6SgLBmKxBEvOdI01+yNfzZm/5L6dFpASljuCNSDxVf5xVo?=
 =?us-ascii?Q?erTsGlYBJ45iJmVaDEOiinvB36/7wysTYBZpbH87I6rXIuTyaazhoGHA/qdZ?=
 =?us-ascii?Q?uchTb+D9bD56WbXviq+lT1bPDRJ8c86tHxxew6+FoZ62nv30YUtqQKfqHoXV?=
 =?us-ascii?Q?ODwRrwOjK1BarrRWhjc/F4ZLBcaJkeR9L/3HOmGeHDlSYrtN4HSas0j9pIz4?=
 =?us-ascii?Q?81m5PgVFula4ISVFNwJn0FIvKt94SCtW8GmNoSTA2/farAEE3bh/fc3fXTpa?=
 =?us-ascii?Q?QcLSp8dkw4ymjYXLxEJu1xRVnogE3rN/XcTUA3yP4NQjHBbKXfQrvHzQH3cK?=
 =?us-ascii?Q?YhbKcXdueiMby4IEeB+sPFPoBMK9nuc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0e657b-0baa-4157-0707-08df1ace755a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 06:30:14.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ma1O40zw80Kb7M1nEZw03iRp2ulRqPL3VkaqIoQ6UyLZfBnKfZZEL8cdr4TZgL6qePA8FtcM1xSRxBFE4KMf2R296X5cFi/mpqrZSaRwodJZBEGc0mCNsP6R0NH39XFZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1332

Hi, Mark

Thanks for the review.

> On Wed, Sep 23, 2026 at 02:57:04AM -0700, Changhuang Liang wrote:
> > The DW SPI controller requests its DMA channels in
> > dw_spi_add_controller(), which ties them up for the entire lifetime of
> > the controller. Even a controller that is only ever used for standard
> > SPI transfers and never for enhanced SPI transfers holds the channels
> > exclusively from probe onwards, preventing them from being shared with
> > other users.
>=20
> > +static int dw_spi_prepare_hardware(struct spi_controller *ctlr) {
> > +	struct dw_spi *dws =3D spi_controller_get_devdata(ctlr);
> > +	int ret;
> > +
> > +	if (!ctlr->can_dma)
> > +		return 0;
> > +
> > +	ret =3D dws->dma_ops->dma_init(ctlr->dev.parent, dws);
> > +	if (ret) {
> > +		/*
> > +		 * DMA is optional: fall back to the PIO/IRQ path instead of
> > +		 * failing the message. Use dev_dbg() since this may happen
> > +		 * on every prepare.
> > +		 */
> > +		dev_dbg(&ctlr->dev, "DMA init failed (%d), using PIO\n", ret);
> > +
> > +		return 0;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> This seems like a lot of overhead for every existing controller with DMA,=
 we'll
> have to go through the request/release cycle whenever DMA gets used which
> feels like a bunch of overhead for a hot path - especially in the fast pa=
th in
> spi_sync().  If some platforms need it they should be able to opt into it=
 rather
> than forcing it on every single platform.
>=20

I will reorganize this series, trying to avoid affecting the current flow.

> > +static int dw_spi_unprepare_hardware(struct spi_controller *ctlr) {
>=20
> Adding this also causes overhead since we do the unprepare in the thread.

Best Regards,
Changhuang
