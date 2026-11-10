Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794271567;
	b=BxoNdBJbHpQSiQ/5ahXB3SgjpUg6xd8eSPopUxhSsS4+f4iJcKFEEjXqsp3jcTM9PrMI
	 /UlnlUgFHA5bVBpaNy8qPWquoZXjHJ0czLAatpUz8E6K2mgQwpSk0A9+xdLAyM/PpMCbi
	 IfDVUv3N9NlMIY6uHKrazDWReAKgZmSbeWoXabbf7iskhnhK62C+k4tuAjtTItDOFRWEK
	 tLZR6aVuN0e9us2NF2r22mNgdVSduoQmvZG7P/Vndl1G9Tl8HRD+KN5OUMmEP1VtTT1Bj
	 XtvZ485zPWLw95fm+gVRtSprfEYK8ADUt/CzW0zWVVA5ZLgQ3rkKYwtRO8cbPBbNBsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271567;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+ks9l1QzZdIjsZ/kG1eSx/g3dYpRiAL0ZwWUfv8a9ZI=;
	b=llRReoNiFOlHg5VmE6O7EyRYszpndv+ittotRSowNYUf06HQW0KHkYpZZwz0MYMUWCTs
	 ZX7L2nMEQoBptnfX4R7nJyyA7Gw8GUK0JD2C+SFL/5O4j8I0FKu0iJQVD6BH7ZKKdp6EP
	 285u5+hu5ReBWsJKHRhI27wBYPCsw6M/FLv0u7xBA5RZ3HtpHH3f5sg4dWf3kf1UZuFWf
	 bkAUHUHwrVLvTljxTrHFzHE0hoVpD7OEnGlYxgnufqe9OHiP2MiAldjI53a0I/ygt6on+
	 J/ck3I3OpP0UaQg2nO7O8EIsSu80p4OpeDY+kOnQ2xFAoROvwpScR/rrzNSuZkPht2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="GSdK/CKu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.35
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D8606A321;
	Tue, 10 Nov 2026 00:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GSdK/CKu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMY65jxHZv9L/+wnnYbHyouRIzdk04e1VEOKNzWCoV302HRE+eS8h3eU/vAlDHQUk1m9j8pLPIcLtUbfh0/6O35E20siRrJATx+U6m78j2WDbAH/Pb5HTrCXNJemuKoAfFlc/GWAdimdl9cRCEYtzO5pNYdeE6EoXZuk3b+HCNbc078DkVaDvaQ8o7wE/8UapsPHu62hyK7ntH1HGUUBfJeHSvAAbN9bgHP3mEkAfWe1naZWtIkZrqruZgtrj6FqjjqJk8PmlSRUyT2xD+ctAYP0awxRU4YoVFo8PM4PbCIyUj4Nd0OaTju1dT9F9AIE4SGs2JA68q97U5/+EeQFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ks9l1QzZdIjsZ/kG1eSx/g3dYpRiAL0ZwWUfv8a9ZI=;
 b=jCw3Ofj+lm0zrw/YFUbKLcm9c8Yc6MeEx3PQUZTT5hanUJEnUCuTc06GwFLlGSno0N5xe3dwAwvF5mmYgaBMLd+drNKB4K2hwsXBZptXwBn76lRidx3HqJeNx12MU52wYf8AByo0m4DI6LARuDmC9Jw2AI/EipItXScnORNUfL+wmizPO3fjo7Ol7Hd591D+yNjN2trOY8qkc/N6d9eQcGxlmcOMQDpln9S/mfzAtZ2/2HOJTpfoSPvUMVCuyLyFuIdku6tFK5BiQ0ImL5Cn9c911tm2AOMACOiyOv0ZEcltHdVlrVy/uZeiWHj1Ou6EtXORQgp1P8uyxVrOw9QU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ks9l1QzZdIjsZ/kG1eSx/g3dYpRiAL0ZwWUfv8a9ZI=;
 b=GSdK/CKu+3B8wUu/iscC3ANre1XUbZv8sQUDRl2eze9w2ykDLaARh4yuVAoPK2PJxCXLCT+OrjMsU/KSJ7ZPa320Oq75FzSowC+kK9s5aIKJSLdKMvp1ap5vaXBlsyJ3dnrSD/daTYFqvysQKISPAsHIqbOARB020Vi1C2OuXOG4yX9eG8PDevjvAUWbS7bD3ek6dciBW0Oxz4ryNKJy3cTHsUfz+K55vbJcMGqNiTn02hhPBlc5IeQpwKXCklHFQJ6XJINSJqmqK7vo6i3pTKTM8IlVy7XJxcFMzdLZO57AmKgZn2XcQidAB8MTqVVwRgtfr2XuTIa1YwwGmqrdBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com (2603:10a6:10:1e9::23)
 by VI2PR04MB10190.eurprd04.prod.outlook.com (2603:10a6:800:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 00:46:02 +0000
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb]) by DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb%7]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 00:46:01 +0000
Date: Tue, 10 Nov 2026 08:50:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] spi: convert to subsys_platform_driver()
Message-ID: <avJqb9FtviLeCmle@shlinux89>
References: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
 <e86963ef-6080-4aa2-ac80-e06d16d9b092@sirena.org.uk>
 <avI2rf-04L3FOfSv@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avI2rf-04L3FOfSv@redhat.com>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To DBBPR04MB7883.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::23)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7883:EE_|VI2PR04MB10190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d23ee5c-f539-4261-70a0-08df3ec3fdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|18002099003|22082099003|11063799006|5023799004|56012099006|4143699003|10067099003|261026121527099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261102123227099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	3qrse2TMzY5JIan02kQV1dn5Dgy1H+N4k6baADraYLU4qxSIaPF35odkXVfXrDEiBryiA8KT6RvXiGwWex7VuQmIaIZ8W1MRCXJRlcgBrVXNGVgcJzrXyLOOsVRfau1vYnRj3tn5F6d6tV4OuZ5o4KxMQCpVuJXD+UQ3qTJXwlsy5zIahS/TiBjxCuXLAYyphp/nzpo+tYiJvubzuDqXh9paHQNziozTV3Vo/GFh4xnvds5EOyxwoGIqdOFRh08JL5lKPoomxkQiwZ25SE6HCzpP1j6v3LQ/ssqXS+0uPBb+71CbmIz9vJ804UaVZ8SYKQl6wqEqN74N6rLPylVurV3YB4/E+Hn4auQ669AnWC+Xdf4hyIRd0OjfpAdodIzK44nusAot++ITIXjZPq7oEnkC1+qvS9lRkNdOmC7IbQbw+8ymGqBSoSjODQXJY/AtO8j4OSUsWt6xh1Mf7d0C1Zd3VXRVGKoAOLwAjHwTDCAt3pGCV0pBlDjPRNvLIxXFVgT2uldQjPBE+pxGWW7wgCUOQScpbHyu7tSK8hYyy0du/HOiZcwvT4eIatc2j9uKZz7Wd6UdW358mFCSljitf9s0jcWZ3r7DiRc8Qj2/IwOmWCY2jp8I/zJDnTTf/1weEdOye/LpB5rNwuOGS7NqVteM5rr7ZRNbCT2/KhmvIe9RFJ+NW3dgxo6aXMQIHBwoCpzXCFO251XTETgfmwNCEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7883.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261102123227099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CjPGYZUjmEJUCR+Rs1mlZc+Lm6kQ+1YGElEcBlCI/SixEBZuIkB95OgTCBfn?=
 =?us-ascii?Q?kaOTqXKYxfPI1RB+sUC74uIbDNohBKKava4f5Cnw/g3fFQ/IGt0mg43A4A6K?=
 =?us-ascii?Q?Vj8I05ySmFpNh9Ft+s62mjjHuLoyxeKCgX9wZRpRp7fyWJ0h6P0qWC9L+nyp?=
 =?us-ascii?Q?ZqYYGenfjrUEm4R2hmFzoH9QHaHN1nA/TrsShCNKAobNSyB9ojnU2OveE02/?=
 =?us-ascii?Q?/OieswdCQh5+2L4nrrYXdX9nRxHp9cjv+qS/eDTba9z/VxuWNjOILhhpQlfO?=
 =?us-ascii?Q?GdrsuJFpBItgbqo9+k8Fjr2UtQh1OX0d0AOb1LTTueHhstrRBlsiao8CJmpk?=
 =?us-ascii?Q?Ao+M5NdJJH6oO0Dq6KieBqR4habXlb+U2jUItt+EHVcDzezQXWlq8UwVDWC9?=
 =?us-ascii?Q?7q/nzkjHpocscCwPKJmNLw6KtNMnd4HMzX6UDk3ZJVxdzeivm55WGKdx8qmm?=
 =?us-ascii?Q?0hpVIIn0nzTf2r8ApJu6qD5Ecv/bfMoHIB7kaLEQqdJtRd2UOWmyBIgh3byy?=
 =?us-ascii?Q?fRqZTzfKFFefcacnAJyD+/uAR/ob25Ox0tJH0TcoFAtNSgkNss8VBI8DCz0a?=
 =?us-ascii?Q?n0a9HXwr7bp9oIIbohTTP/GecuUv6j1DpqlCTKVEXAhqjJe/9+aDwhV8zUwT?=
 =?us-ascii?Q?rR0/FhWH793L11gbw4VcNACcvDbCeIhTboGMDt2OeMVn8/7FzEgGj7nPzkOl?=
 =?us-ascii?Q?d4w8CwpRUBXRbFdP936eBNJzMKu1MKESsc6vB5C0E7AnPnYjXkXwnvNLcwvA?=
 =?us-ascii?Q?YfIFx5km0tY5MbD78/i2g2WfLgPKEzjEIJWXBsptDrRGTxE2eUgPMKaNgzn0?=
 =?us-ascii?Q?MyWESAS0dSILe+wvIZuZcF/DClyAEAA2pktoZFOMgx4o6Gyd887CHBoSrXE3?=
 =?us-ascii?Q?mkeyv4vxWgEps4VCwZisW2dZRdPOiWYpqvzbFz8DmWoZhEOgAv1/r8P5id7C?=
 =?us-ascii?Q?MJk9ADCuZnUGFQRTBPmHFRaIhI0cS1Gm2byAUzDjlqLXKMEPCwuKjuuMhzgK?=
 =?us-ascii?Q?ByJ6Rm8aHqxdmilDfbnWbnwLfCUnvob+5B/FyRckBKP4Ogv6zEwimR4uZNnr?=
 =?us-ascii?Q?IVCkAz4V3zQ55QbPcAIuh7g3OoAExTs6u20/iC2CEAhEByJicK8usoqO8dEM?=
 =?us-ascii?Q?wqnMXpqlOfxVXPQZn4lGJdN+xB7f7UaVrdtEbXACxRfW6cZqfVWCGBq2+7vQ?=
 =?us-ascii?Q?NaPYsOnr04ElEhLXm9SYn3ehcw5sU7wBv4mLf2Fu743pChA+zq+aNXDqwW7C?=
 =?us-ascii?Q?HtplWJhPeAqm3w6ydspjm270tRdEqeRyZhTmgzZSfjIZQi92IMNAJSCtVgbD?=
 =?us-ascii?Q?qx72rt+jyeUVFGVM83mn/TeWVIiYQKLcRdG2e6Iy/ET2PqurYOPmvd2z/EUv?=
 =?us-ascii?Q?co6kCAFIr4mUtzRGe1zrXEpzALbppEy3G83YkMVi/+LT7XgrN/1fM8ABf2gB?=
 =?us-ascii?Q?qVfrz+z0WZNOzbkwS0dFN0UbvGRvR8yPfh1kF/Q/bexvzNEn8Y6fi/PWP7wQ?=
 =?us-ascii?Q?eIjRooQBcD6lSqF/RZgnZMU6IJ9P02uM7wu1l0yCVn4PyXIOmC5rmvOD9i5r?=
 =?us-ascii?Q?KiQBVFXK6+KzjkvroD7xb9MXAySysiM6q1YcVvZc1Aqy+Ov19cK63DzJs4xd?=
 =?us-ascii?Q?D2Yrul2N0RNQQlAMz1wKeuPY6/uVXDQddshPEns+fa5pVPS19b5Kk0GVTJlJ?=
 =?us-ascii?Q?5dBrtpPX7qpySvtwPme9EwlyG6iE3lGx8MjR83FuVGAb/TF3AdRXOHEaNQWF?=
 =?us-ascii?Q?vIdChUlyfYPjfd633aczC79kiQZ4q0zXsdIqVomX7JiQy5xQ2UZq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d23ee5c-f539-4261-70a0-08df3ec3fdf1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7883.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 00:46:01.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HPpKCz6HHEJNc7ChF8r01fCfiJoQmccPS3ky/SqLpRZRBtlm7kUycyAptSrglRPI9sTThWhuVSOzQyUoWbzJXVeeXT0hLWSD/Uj+gM3BUZ79am2aCJhGwvei+Z34uwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10190

Hi Brian,

On Mon, Nov 09, 2026 at 04:10:05PM -0500, Brian Masney wrote:
>Hi Mark,
>
>On Mon, Nov 09, 2026 at 07:14:33PM +0000, Mark Brown wrote:
>> On Fri, Nov 06, 2026 at 07:33:07PM -0500, Brian Masney wrote:
>> > Reduce boilerplate code in these drivers and convert them over to use
>> > the macro subsys_platform_driver().
>> 
>> This doesn't apply against current code, please check and resend.
>
>I see that Peng Fan already beat me to this! There's nothing else to add
>from my series, so there will be no follow up from me.
>
>Peng: Just a heads up that I posted patches across the tree Friday for
>this migrated. I think I changed everything that can be easily migrated.
>I suspect we may have collided in other subsystems.

Thanks for the heads up.

I wasn't aware of your earlier treewide conversion series. Sorry for the
duplicated effort.

I generated these conversions using a Coccinelle rule and it appears to
have covered most of the straightforward subsys_platform_driver()
conversions across the tree. If there are any overlaps in other subsystems,
I can the corresponding parts from my series.

Thanks
Peng

>
>Brian
>
>
>
