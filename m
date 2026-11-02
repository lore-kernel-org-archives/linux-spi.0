Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793641217;
	b=KISE3wJqMZE7wXZwV6Q+AgOmeKUvR4koQPHjvV5PkXonHUGcYuO9+BVkB2YWQulAR9H5
	 503Vt1srompwCTLCl1gH8JIbBjdPNSk/srsQADuMkHzt0pZZ1sttaHAujPmo4UG18Pskp
	 VhZ5pFLxWXT9F1SlonWQEAHqWKJJm765Nl92T4zkKRnR/VF6f93RC9F+gcg5tut+m2mna
	 giEWmL7TrK/wEVLvH4v3rvtCh60WKffFQtoeHwGCe/I9tGc34brmIaa+P2U9VrGeWTnNj
	 2GUIZgQrIupBOT6zIUgHqIAvQPzveNdWuB93YKj5FfCJnl61AwA9xq5YJ0gtevEPVSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641217;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=CG0lzyh+DOjzXrhte5N4cMzh1eHqHRl8IfKbrISXh8U=;
	b=IhUWFDjyOhvzzrafKkshvjr3J+lBTWvb6eNck4pynXroaC/Vu6pjHulkqgRjEXCBbAyx
	 iu+6eNk+FJD22qbduakhU20chlRpt6Rfu74kqO5l/k+tWTSXb8qo7tM/7SB+nzHFXvNxT
	 tP+ViyHjoko4AArOsZUfA7jr1Vm6KH0MV8jngf8+kgWh1+R60nvbfoR9fdBRVljcVCpZW
	 uoXDVLqa392ZwWjP0zn+bT+FzrffJakaBMjwKxGcPY0aqkpXaJ2FL+pddz9V8HDdxEWcD
	 k79BuTyIgTRkX9jY6m8wTNSXKkN/slEJcxqwGo0Gy/KGCViVwkXfAznsywihymkvlYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rG0WfAHe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.29
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBF606A926;
	Mon,  2 Nov 2026 17:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DBF606A926
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rG0WfAHe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj5x1QkrV2X/krDtrabTh2BoMH0oe0gkEJ0tVdmDm72Goi9nBXysuJk8P31BG9jO6+/s2F6/pEUBbr4iHcQIOIkHgz0Rdd54W7389z8sfxeoSpaKDbSHz0DTlcbWG/BvUCFP8Zd6RYjA6e3stQ4g8sumVdHZHI7cbPDv76tfT6bfetKazAB+YtV/ROOODJGhFQD4b/VMW+HotDtQjNlyHg3G/dOrTzcP6JizOD7bYGnZudj4R90Rc9IWCpsFaIAhaHGbi2FftNtXL/JSHKwt6HVammqlTcNjf5FoBJp0bqTtqDIQm3TN/V4Bi9EnlqT7PBzSEraOD5KM2+Mmy4unLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG0lzyh+DOjzXrhte5N4cMzh1eHqHRl8IfKbrISXh8U=;
 b=lsOTkOVL8lVr1NZrep0V65LP2qjNOI12fxn6t+o0rqDMOquFUaBfwlPdGh2bMQs9QEq+573NJ9B4Xsdm0svZfzMz3uqCzyk84nbDAs1zZajU5GHDrWOEJVUoueo+lYx38XusKZOQSoGdHAqsuv0zSkIQCoVcyuR9ncs8rYK4fu5M10pwuF/bZ1N0lh10FJDiIpfUEMMn8R8OQN1cU+qlXWMI5CATDqbZMaSaueVp9HKTQr1JkfZvtDRnDBk85uvmK4p45QY03QZO4CjDj5A2fa93luinbH0MQou+z0+q2LqyOoYW8ujpjKJrJJITMhTVMEHDmKX89+WWZV7rPWg8Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG0lzyh+DOjzXrhte5N4cMzh1eHqHRl8IfKbrISXh8U=;
 b=rG0WfAHe4dyfV3qgz9EKMBjL26+nHJgE7rCownCrYeM3TSNOdAEeurLyK1lcSMcYUsQWEFFOR0bzvPue5tcIazuri9F4ghGXJIKBbYFFMgGGzXwpCZOj72H6h6y0OjvqdzZtBGijkjFHyDzGQ7rIq1MTwwrEIyOtOedUL5ye5vAfcx//2h6roY3S9oicKpptx8LEIx4v6ztx1v53VgQNYHerPYD3D1kCHWxzDpINkRi3nkMMXj44izBBQ30A+PxJxFIXyy4lJlMYOP4nTetjkt/MD0OP+nR9AGPHpoz4ktkFB1vmycjL6u8wAxihswBouhCFG4Nsk6udc0PST6Zssg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS5PR04MB9873.eurprd04.prod.outlook.com (2603:10a6:20b:672::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:40:12 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:40:12 +0000
From: Frank.Li@oss.nxp.com
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	CL Wang <cl634@andestech.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Heiko Stuebner <heiko@sntech.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	imx@lists.linux.dev (open list:FREESCALE DSPI DRIVER),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS RZ/V2H(P) RSPI DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SPI DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 12:39:58 -0500
Message-ID: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:510:4::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS5PR04MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: b185a470-42d3-4cf8-10a0-08df390858ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261102123227099003|261021123027099003|261021135927099003|56012099006|11063799006|261009223327099003|261009220027099003|261009223027099003|261009221727099003|261009221227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|6133799003|41080700001;
X-Microsoft-Antispam-Message-Info:
	doo9axYr5qlkU4911KKvnuRh3I+cKMLtewZW/toHUucRMyljTpoJ2xz6wbg9i9nb200bgHIWwK9iIPltjTjCle3vO76AQDvOQqstYzfdE668BvBNspU3t8zvhY6oefRc/zeVe4+e8wSRMadUQmZD5536gKh4PszjpVPSf+wxfhdosJRVmpb3+gX629pBgGIPs1V6sK8mM4iJXtLfY08ODtCbx/Z3YnZXf/WQn1O06TkRXWUb5KsjhXdTDUXdY+ap1EAuGnsPmWpxbcC1nwOv3Gmr+TqCpNm4s7AcVRSLJs1Z2535m8v96S/J29X5cU1iF00hPjVNwaRGcBO7yHdcvksSjlavreQVLyYbxT9s5RJ/BDQcD2jaPY3MvLPNs7eDJ45ajxX3WoVDhUygxxIYmOYSgrhxtuUr6Y3GQw9IHf3YM2xN8kDVOQBR7qK22Yh2S/zJ3gTDE2QEvXB0jz+cIReGztLMyqvV74wLJBzS9uWk6CYqX4zmREzFMHtnWRNxIOiGiDzNAoQFMaeaNBa8hN8eGjPgPr1c2lprGSphlE7aDo0qSP4F29Pds+xOdhQKdzpvaMkPEwA9glq7CRFP2T1FRwlKWVxoWhP319yILhMhyu4YPK0rj9pUhntBQY2XLuhBSb20+GpUwP7AlHOV5zGlRPEZMoTdLLISCSlCCR+pnWqJJt8X0o9w0y7RaM/lQ+v8brc4R6IskHRnsWclCwlXXVLym02d3odE5CNPcCul9P8ScKo5NIDSUqguDSnf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261102123227099003)(261021123027099003)(261021135927099003)(56012099006)(11063799006)(261009223327099003)(261009220027099003)(261009223027099003)(261009221727099003)(261009221227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(6133799003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWEPMdu1H8zXZPc4NzE0LaJNl4tD8J7BoGKqFZXKP66CJeNxYX687rI2+/aX?=
 =?us-ascii?Q?w4RTlv3XhjVxttM5CebTJR/RS2/uJWmkICkd6zL9MhUioOJQBK6bTMTODyHZ?=
 =?us-ascii?Q?dn+CBLuLdItOd2NQXCOTdek+/mvKTuzfdJGLT0mXFuQRB8D4er/t98fNBnQy?=
 =?us-ascii?Q?fd7tCYKpZeWqKVcUoHpCshioCLtaMkwXdd055qOtV/0YvVCVHUpugbVDpYkN?=
 =?us-ascii?Q?nU05r6B+Sjfw8QeKkgOnZVCQDFuojJ1W6eLIPgWw+xJPlczSm1w5vpUhdJZT?=
 =?us-ascii?Q?CjHtu1G7e5cjnlRl3QK/hwRjPE8H3VgCY760psit1PEBn/CAa9HnOwMtO+og?=
 =?us-ascii?Q?Oi/+i+CLR+0rNXgG04YtPRmA36Fsf25CjghuAOwiX/xz3YssxexzIK9KIadp?=
 =?us-ascii?Q?lYV7zc6Bnrmzaq8WDMKgTmoOqFSzR5K1cJMfOw3eLyriUvwDBTee0OmeOyAR?=
 =?us-ascii?Q?utTIYueB36XFa0+gA2D8ZReHjiHNzFTHqRuupSBf6QWNa2ijrSRFdeVCKkfT?=
 =?us-ascii?Q?APkIMBjFZFkjwdpyILLy36aGWJFK/tcq6DZv6VVyLX4yQpdGL2jfWIwKGM0T?=
 =?us-ascii?Q?cEmQnS1H8YJB/TGXzlRuM3LeAaQtu2nJM7p2dSRDK1seK1/Phpx+EJ5IOysJ?=
 =?us-ascii?Q?drRjFpMexbHOI40Knl9/LzRjUegXR4BReepBt5aPnAEy7KAr2MO9Llfkjn61?=
 =?us-ascii?Q?YfH4PhIz8vcm+sa1ZgVR19s42XyIZPIJ0rmn9CSwcXD3D687n1mumGMCbBus?=
 =?us-ascii?Q?XAkvYRMa0h1LHlv/+0ttSrBM/hpZD72pxU7Vnub3O7477oPCoaVf/VJ5o1nP?=
 =?us-ascii?Q?gjH92bEPNkWsWcDcwKk0ICbrBX7WekzHdrxw1+25L7qFeU9fzdCVJZRYtN4S?=
 =?us-ascii?Q?bbmFKXMHS5HHmUc5Uuvg2+fQOPxhPitGdhL44Ee2EVvO2Mfiyyv8EiK3WS72?=
 =?us-ascii?Q?ANK0q+SPxxBqN7vnWdhhi1tVE+arvhN6JPnW7v/RDXITMKlRx1AzzmSOqFNq?=
 =?us-ascii?Q?rd6Io7FLmSW9c9Pye2zOMHQBoWP9qImoiYvmBdRBO5/s0cqYF0Bfjfc6A3Ku?=
 =?us-ascii?Q?o61X+MCXgOcIco7Wp/mt43kqj/AzH+XX90K7E3oEoDOR562P0ctM5dvPw95T?=
 =?us-ascii?Q?TIO9p9uUhMNxr5JOvwhuz+P6juu4aBJMO6cPPcdByDExi+HVhjdmyzo9W835?=
 =?us-ascii?Q?jko9uM5Tra2XFDj8E97c2yADMERAttd8SD9/DQ5BSMFOrSKaK1Gn9OWKFcQF?=
 =?us-ascii?Q?69m+Mdx3cWdim0TDOpRpjrHVSr3gllDJqO0nsQ6G4V3oyy5sFnv6MMM5+nGa?=
 =?us-ascii?Q?yCWYsRgsvuPtR+RSJqgRgFUhmcNlh1pXi+G3z5WXMiMaYBYLwU5X8zJu1AGT?=
 =?us-ascii?Q?2lf3YfXEfgpbr+ti6pEmGtxU7Vb7qzYNWx9aABVd9pfoBAeWUMj9qfksNjel?=
 =?us-ascii?Q?pih+kzlDh4km7oXfRgjzsNsiOSdM7Unv639YUJOZyNYe25QntNOBn5KvnyUI?=
 =?us-ascii?Q?i/0+U40iK7w8IdAr3UkozrVmAk/vctHjg0Y5T61Z2L30xpz6KI7V2fqfZgM8?=
 =?us-ascii?Q?s2/LnspXjflnW3xpms4dPWDy8woxj9BuHc3MvrSH0PTDwqRTlGPFb5YpIyuN?=
 =?us-ascii?Q?dfRzRiIqXx+kFzK5TO/Q7o73LEIAyg7AMKQK8M5zRkAWQq9BXBK5oIK2HAg8?=
 =?us-ascii?Q?qBXuN2pwfk7WEwnTBrWzD5ThQTNXQANTj+U029Wmq4pbn4S3CvUdlefRtrIj?=
 =?us-ascii?Q?gBTleDpyTYI1X7vKrALfMGncdjCEB2iAwC2DUl3IwmGvPKyzpx4S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b185a470-42d3-4cf8-10a0-08df390858ee
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:40:12.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAN/tolKT8w6SKIVElMNg65sfeXvwTmhM2veHoLFmPLPNvnp52tGSGMDUtQTBHJom7yDyayVVXGFL49vqkuJ3NWNCQ4b59/ugyTWgC5bDDE1nDLjI1qsapz1ampN1wL2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9873

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across SPI bus drivers.

No functional change intended. Prepare make to struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/atmel-quadspi.c       | 3 +--
 drivers/spi/spi-at91-usart.c      | 3 +--
 drivers/spi/spi-atcspi200.c       | 3 +--
 drivers/spi/spi-atmel.c           | 3 +--
 drivers/spi/spi-bcm2835.c         | 6 ++----
 drivers/spi/spi-cadence-quadspi.c | 3 +--
 drivers/spi/spi-davinci.c         | 6 ++----
 drivers/spi/spi-dw-dma.c          | 6 ++----
 drivers/spi/spi-ep93xx.c          | 3 +--
 drivers/spi/spi-fsl-dspi.c        | 6 ++----
 drivers/spi/spi-fsl-lpspi.c       | 6 ++----
 drivers/spi/spi-geni-qcom.c       | 3 +--
 drivers/spi/spi-img-spfi.c        | 6 ++----
 drivers/spi/spi-imx.c             | 6 ++----
 drivers/spi/spi-ingenic.c         | 3 +--
 drivers/spi/spi-mxs.c             | 3 +--
 drivers/spi/spi-nxp-xspi.c        | 3 +--
 drivers/spi/spi-omap2-mcspi.c     | 6 ++----
 drivers/spi/spi-pic32.c           | 3 +--
 drivers/spi/spi-pl022.c           | 3 +--
 drivers/spi/spi-pxa2xx-dma.c      | 3 +--
 drivers/spi/spi-qup.c             | 3 +--
 drivers/spi/spi-rockchip.c        | 6 ++----
 drivers/spi/spi-rspi.c            | 6 ++----
 drivers/spi/spi-rzv2h-rspi.c      | 3 +--
 drivers/spi/spi-s3c64xx.c         | 3 +--
 drivers/spi/spi-sh-msiof.c        | 6 ++----
 drivers/spi/spi-spacemit-k1.c     | 3 +--
 drivers/spi/spi-stm32-ospi.c      | 3 +--
 drivers/spi/spi-stm32-qspi.c      | 3 +--
 drivers/spi/spi-stm32.c           | 9 +++------
 drivers/spi/spi-sun6i.c           | 3 +--
 drivers/spi/spi-tegra114.c        | 6 ++----
 drivers/spi/spi-tegra20-slink.c   | 6 ++----
 drivers/spi/spi-tegra210-quad.c   | 6 ++----
 drivers/spi/spi-ti-qspi.c         | 3 +--
 drivers/spi/spi-topcliff-pch.c    | 6 ++----
 drivers/spi/spi-uniphier.c        | 6 ++----
 38 files changed, 56 insertions(+), 112 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 762a3fb0fca81..de205e04a8600 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -790,8 +790,7 @@ static int atmel_qspi_dma_xfer(struct atmel_qspi *aq, struct dma_chan *chan,
 	}
 
 	reinit_completion(&aq->dma_completion);
-	tx->callback = atmel_qspi_dma_callback;
-	tx->callback_param = aq;
+	dmaengine_desc_set_callback(tx, atmel_qspi_dma_callback, NULL, aq);
 	cookie = dmaengine_submit(tx);
 	ret = dma_submit_error(cookie);
 	if (ret) {
diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index aadcdf734fb03..8b56ac1dcad8e 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -228,8 +228,7 @@ static int at91_usart_spi_dma_transfer(struct spi_controller *ctlr,
 	if (!txdesc)
 		goto at91_usart_spi_err_dma;
 
-	rxdesc->callback = dma_callback;
-	rxdesc->callback_param = ctlr;
+	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, ctlr);
 
 	cookie = dmaengine_submit(rxdesc);
 	if (dma_submit_error(cookie))
diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index b532c58c0ab91..c807e730ca94c 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -340,8 +340,7 @@ static int atcspi_dma_trans(struct atcspi_dev *spi,
 	}
 
 	reinit_completion(&spi->dma_completion);
-	desc->callback = atcspi_dma_callback;
-	desc->callback_param = &spi->dma_completion;
+	dmaengine_desc_set_callback(desc, atcspi_dma_callback, NULL, &spi->dma_completion);
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
 	if (ret)
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc896e4621ac..ffc1292b08c10 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -867,8 +867,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_controller *host,
 	spi_writel(as, IER, SPI_BIT(OVRES));
 
 	/* Put the callback on the RX transfer only, that should finish last */
-	rxdesc->callback = dma_callback;
-	rxdesc->callback_param = host;
+	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, host);
 
 	/* Submit and fire RX and TX with TX last so we're ready to read! */
 	cookie = dmaengine_submit(rxdesc);
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cc57489732816..a71048a88c58a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -706,11 +706,9 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 	 * RX-only transfers; else by the TX channel for TX-only transfers.
 	 */
 	if (!is_tx) {
-		desc->callback = bcm2835_spi_dma_rx_done;
-		desc->callback_param = ctlr;
+		dmaengine_desc_set_callback(desc, bcm2835_spi_dma_rx_done, NULL, ctlr);
 	} else if (!tfr->rx_buf) {
-		desc->callback = bcm2835_spi_dma_tx_done;
-		desc->callback_param = ctlr;
+		dmaengine_desc_set_callback(desc, bcm2835_spi_dma_tx_done, NULL, ctlr);
 		bs->target = target;
 	}
 
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 73ea51c41f955..6e7c8b54e0377 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1395,8 +1395,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		goto err_unmap;
 	}
 
-	tx->callback = cqspi_rx_dma_callback;
-	tx->callback_param = cqspi;
+	dmaengine_desc_set_callback(tx, cqspi_rx_dma_callback, NULL, cqspi);
 	cookie = dmaengine_submit(tx);
 	reinit_completion(&cqspi->rx_dma_complete);
 
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 087735ed9c80c..b115daf2c76f3 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -703,10 +703,8 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		if (!txdesc)
 			goto err_desc;
 
-		rxdesc->callback = davinci_spi_dma_rx_callback;
-		rxdesc->callback_param = (void *)dspi;
-		txdesc->callback = davinci_spi_dma_tx_callback;
-		txdesc->callback_param = (void *)dspi;
+		dmaengine_desc_set_callback(rxdesc, davinci_spi_dma_rx_callback, NULL, (void *)dspi);
+		dmaengine_desc_set_callback(txdesc, davinci_spi_dma_tx_callback, NULL, (void *)dspi);
 
 		if (pdata->cshold_bug)
 			iowrite16(spidat1 >> 16, dspi->base + SPIDAT1 + 2);
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index b706770334a61..94810f9dd5c5d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -397,8 +397,7 @@ static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct scatterlist *sgl,
 	if (!txdesc)
 		return -ENOMEM;
 
-	txdesc->callback = dw_spi_dma_tx_done;
-	txdesc->callback_param = dws;
+	dmaengine_desc_set_callback(txdesc, dw_spi_dma_tx_done, NULL, dws);
 
 	cookie = dmaengine_submit(txdesc);
 	ret = dma_submit_error(cookie);
@@ -498,8 +497,7 @@ static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct scatterlist *sgl,
 	if (!rxdesc)
 		return -ENOMEM;
 
-	rxdesc->callback = dw_spi_dma_rx_done;
-	rxdesc->callback_param = dws;
+	dmaengine_desc_set_callback(rxdesc, dw_spi_dma_rx_done, NULL, dws);
 
 	cookie = dmaengine_submit(rxdesc);
 	ret = dma_submit_error(cookie);
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index d8f4aa38685f5..6832869bc73bf 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -418,8 +418,7 @@ static int ep93xx_spi_dma_transfer(struct spi_controller *host)
 	}
 
 	/* We are ready when RX is done */
-	rxd->callback = ep93xx_spi_dma_callback;
-	rxd->callback_param = host;
+	dmaengine_desc_set_callback(rxd, ep93xx_spi_dma_callback, NULL, host);
 
 	/* Now submit both descriptors and start DMA */
 	dmaengine_submit(rxd);
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f03488870d024..aee0393f9a832 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -581,8 +581,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 		return -EIO;
 	}
 
-	dma->tx_desc->callback = dspi_tx_dma_callback;
-	dma->tx_desc->callback_param = dspi;
+	dmaengine_desc_set_callback(dma->tx_desc, dspi_tx_dma_callback, NULL, dspi);
 	if (dma_submit_error(dmaengine_submit(dma->tx_desc))) {
 		dev_err(dev, "DMA submit failed\n");
 		return -EINVAL;
@@ -600,8 +599,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 		return -EIO;
 	}
 
-	dma->rx_desc->callback = dspi_rx_dma_callback;
-	dma->rx_desc->callback_param = dspi;
+	dmaengine_desc_set_callback(dma->rx_desc, dspi_rx_dma_callback, NULL, dspi);
 	if (dma_submit_error(dmaengine_submit(dma->rx_desc))) {
 		dev_err(dev, "DMA submit failed\n");
 		return -EINVAL;
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b25f94b2ef738..7798197d5b350 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -634,8 +634,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 	if (!desc_rx)
 		return -EINVAL;
 
-	desc_rx->callback = fsl_lpspi_dma_rx_callback;
-	desc_rx->callback_param = (void *)fsl_lpspi;
+	dmaengine_desc_set_callback(desc_rx, fsl_lpspi_dma_rx_callback, NULL, (void *)fsl_lpspi);
 	dmaengine_submit(desc_rx);
 	reinit_completion(&fsl_lpspi->dma_rx_completion);
 	dma_async_issue_pending(controller->dma_rx);
@@ -648,8 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 		return -EINVAL;
 	}
 
-	desc_tx->callback = fsl_lpspi_dma_tx_callback;
-	desc_tx->callback_param = (void *)fsl_lpspi;
+	dmaengine_desc_set_callback(desc_tx, fsl_lpspi_dma_tx_callback, NULL, (void *)fsl_lpspi);
 	dmaengine_submit(desc_tx);
 	reinit_completion(&fsl_lpspi->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 91e75e213f929..e239c4333055b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -506,8 +506,7 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		return -EIO;
 	}
 
-	tx_desc->callback_result = spi_gsi_callback_result;
-	tx_desc->callback_param = spi;
+	dmaengine_desc_set_callback(tx_desc, NULL, spi_gsi_callback_result, spi);
 
 	if (peripheral.cmd & SPI_RX)
 		dmaengine_submit(rx_desc);
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 76dcb283d1225..53370cff7e2cd 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -334,8 +334,7 @@ static int img_spfi_start_dma(struct spi_controller *host,
 		if (!rxdesc)
 			goto stop_dma;
 
-		rxdesc->callback = img_spfi_dma_rx_cb;
-		rxdesc->callback_param = spfi;
+		dmaengine_desc_set_callback(rxdesc, img_spfi_dma_rx_cb, NULL, spfi);
 	}
 
 	if (xfer->tx_buf) {
@@ -358,8 +357,7 @@ static int img_spfi_start_dma(struct spi_controller *host,
 		if (!txdesc)
 			goto stop_dma;
 
-		txdesc->callback = img_spfi_dma_tx_cb;
-		txdesc->callback_param = spfi;
+		dmaengine_desc_set_callback(txdesc, img_spfi_dma_tx_cb, NULL, spfi);
 	}
 
 	if (xfer->rx_buf) {
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cadf0b93f4403..f8a3ac11f49d0 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1738,8 +1738,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 		return -EINVAL;
 	}
 
-	desc_rx->callback = spi_imx_dma_rx_callback;
-	desc_rx->callback_param = (void *)spi_imx;
+	dmaengine_desc_set_callback(desc_rx, spi_imx_dma_rx_callback, NULL, (void *)spi_imx);
 	cookie = dmaengine_submit(desc_rx);
 	if (dma_submit_error(cookie)) {
 		dev_err(spi_imx->dev, "submitting DMA RX failed\n");
@@ -1756,8 +1755,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	if (!desc_tx)
 		goto dmaengine_terminate_rx;
 
-	desc_tx->callback = spi_imx_dma_tx_callback;
-	desc_tx->callback_param = (void *)spi_imx;
+	dmaengine_desc_set_callback(desc_tx, spi_imx_dma_tx_callback, NULL, (void *)spi_imx);
 	cookie = dmaengine_submit(desc_tx);
 	if (dma_submit_error(cookie)) {
 		dev_err(spi_imx->dev, "submitting DMA TX failed\n");
diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index a0a047510611e..9567ddde06ef0 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -157,8 +157,7 @@ spi_ingenic_prepare_dma(struct spi_controller *ctlr, struct dma_chan *chan,
 		return ERR_PTR(-ENOMEM);
 
 	if (dir == DMA_DEV_TO_MEM) {
-		desc->callback = spi_ingenic_finalize_transfer;
-		desc->callback_param = ctlr;
+		dmaengine_desc_set_callback(desc, spi_ingenic_finalize_transfer, NULL, ctlr);
 	}
 
 	cookie = dmaengine_submit(desc);
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index fda1d260b2966..eabea73a19fc7 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -267,8 +267,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 	 * The last descriptor must have this callback,
 	 * to finish the DMA transaction.
 	 */
-	desc->callback = mxs_ssp_dma_irq_callback;
-	desc->callback_param = spi;
+	dmaengine_desc_set_callback(desc, mxs_ssp_dma_irq_callback, NULL, spi);
 
 	/* Start the transfer. */
 	dmaengine_submit(desc);
diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 38c8d6269aadd..e532b2da54835 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -872,8 +872,7 @@ static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
 		goto err_unmap_src;
 	}
 
-	desc->callback = nxp_xspi_dma_rx_callback;
-	desc->callback_param = xspi;
+	dmaengine_desc_set_callback(desc, nxp_xspi_dma_rx_callback, NULL, xspi);
 	reinit_completion(&xspi->dma_rx_c);
 	dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e46b1d9c8cd08..56fc8211a752f 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -436,8 +436,7 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
 	if (!tx)
 		return -EIO;
 
-	tx->callback = omap2_mcspi_tx_callback;
-	tx->callback_param = spi;
+	dmaengine_desc_set_callback(tx, omap2_mcspi_tx_callback, NULL, spi);
 
 	return dma_submit_error(dmaengine_submit(tx));
 }
@@ -525,8 +524,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 		goto out_free_sg;
 	}
 
-	tx->callback = omap2_mcspi_rx_callback;
-	tx->callback_param = spi;
+	dmaengine_desc_set_callback(tx, omap2_mcspi_rx_callback, NULL, spi);
 	ret = dma_submit_error(dmaengine_submit(tx));
 	if (ret)
 		goto out_free_sg;
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 8363bc873b03a..b6a6929cbb0c2 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -330,8 +330,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	}
 
 	/* Put callback on the RX transfer, that should finish last */
-	desc_rx->callback = pic32_spi_dma_rx_notify;
-	desc_rx->callback_param = pic32s;
+	dmaengine_desc_set_callback(desc_rx, pic32_spi_dma_rx_notify, NULL, pic32s);
 
 	cookie = dmaengine_submit(desc_rx);
 	ret = dma_submit_error(cookie);
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 3ff30486b2892..9f98f95bb534c 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -956,8 +956,7 @@ static int configure_dma(struct pl022 *pl022)
 		goto err_txdesc;
 
 	/* Put the callback on the RX transfer only, that should finish last */
-	rxdesc->callback = dma_callback;
-	rxdesc->callback_param = pl022;
+	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, pl022);
 
 	/* Submit and fire RX and TX with TX last so we're ready to read! */
 	dmaengine_submit(rxdesc);
diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index c94d1d192e743..0e7ad7fb48eb2 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -154,8 +154,7 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data,
 	}
 
 	/* We are ready when RX completes */
-	rx_desc->callback = pxa2xx_spi_dma_callback;
-	rx_desc->callback_param = drv_data;
+	dmaengine_desc_set_callback(rx_desc, pxa2xx_spi_dma_callback, NULL, drv_data);
 
 	dmaengine_submit(rx_desc);
 	dmaengine_submit(tx_desc);
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index e8b076b1622d3..6be0b942d7c4e 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -429,8 +429,7 @@ static int spi_qup_prep_sg(struct spi_controller *host, struct scatterlist *sgl,
 	if (IS_ERR_OR_NULL(desc))
 		return desc ? PTR_ERR(desc) : -EINVAL;
 
-	desc->callback = callback;
-	desc->callback_param = qup;
+	dmaengine_desc_set_callback(desc, callback, NULL, qup);
 
 	cookie = dmaengine_submit(desc);
 
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1a81fd94b4396..f8d6cea2f3dad 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -475,8 +475,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 		if (!rxdesc)
 			return -EINVAL;
 
-		rxdesc->callback = rockchip_spi_dma_rxcb;
-		rxdesc->callback_param = ctlr;
+		dmaengine_desc_set_callback(rxdesc, rockchip_spi_dma_rxcb, NULL, ctlr);
 	}
 
 	txdesc = NULL;
@@ -500,8 +499,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			return -EINVAL;
 		}
 
-		txdesc->callback = rockchip_spi_dma_txcb;
-		txdesc->callback_param = ctlr;
+		dmaengine_desc_set_callback(txdesc, rockchip_spi_dma_txcb, NULL, ctlr);
 	}
 
 	/* rx must be started before tx due to spi instinct */
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c61edd1c1353b..5e03a186e9e79 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -553,8 +553,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 			goto no_dma_rx;
 		}
 
-		desc_rx->callback = rspi_dma_complete;
-		desc_rx->callback_param = rspi;
+		dmaengine_desc_set_callback(desc_rx, rspi_dma_complete, NULL, rspi);
 		cookie = dmaengine_submit(desc_rx);
 		if (dma_submit_error(cookie)) {
 			ret = cookie;
@@ -577,8 +576,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 			/* No callback */
 			desc_tx->callback = NULL;
 		} else {
-			desc_tx->callback = rspi_dma_complete;
-			desc_tx->callback_param = rspi;
+			dmaengine_desc_set_callback(desc_tx, rspi_dma_complete, NULL, rspi);
 		}
 		cookie = dmaengine_submit(desc_tx);
 		if (dma_submit_error(cookie)) {
diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index daa4239b0fe04..f17b6d3da5de7 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -295,8 +295,7 @@ rzv2h_rspi_setup_dma_channel(struct rzv2h_rspi_priv *rspi,
 		return ERR_PTR(-EAGAIN);
 
 	if (direction == DMA_DEV_TO_MEM) {
-		desc->callback = rzv2h_rspi_dma_complete;
-		desc->callback_param = rspi;
+		dmaengine_desc_set_callback(desc, rzv2h_rspi_dma_complete, NULL, rspi);
 	}
 
 	return desc;
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 58e306cc730fc..d24b95212ecd8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -338,8 +338,7 @@ static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		return -ENOMEM;
 	}
 
-	desc->callback = s3c64xx_spi_dmacb;
-	desc->callback_param = dma;
+	dmaengine_desc_set_callback(desc, s3c64xx_spi_dmacb, NULL, dma);
 
 	dma->cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(dma->cookie);
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 89fbdde46cfe9..557c645fcebc6 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -665,8 +665,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 		if (!desc_rx)
 			return -EAGAIN;
 
-		desc_rx->callback = sh_msiof_dma_complete;
-		desc_rx->callback_param = &p->done;
+		dmaengine_desc_set_callback(desc_rx, sh_msiof_dma_complete, NULL, &p->done);
 		cookie = dmaengine_submit(desc_rx);
 		if (dma_submit_error(cookie))
 			return cookie;
@@ -684,8 +683,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 			goto no_dma_tx;
 		}
 
-		desc_tx->callback = sh_msiof_dma_complete;
-		desc_tx->callback_param = &p->done_txdma;
+		dmaengine_desc_set_callback(desc_tx, sh_msiof_dma_complete, NULL, &p->done_txdma);
 		cookie = dmaengine_submit(desc_tx);
 		if (dma_submit_error(cookie)) {
 			ret = cookie;
diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index d03a93d149ecc..c9bf925ee3521 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -294,8 +294,7 @@ static int k1_spi_dma_one(struct spi_controller *host, struct spi_device *spi,
 	}
 
 	/* When RX is complete we also know TX has completed */
-	rxdesc->callback = k1_spi_dma_callback;
-	rxdesc->callback_param = drv_data;
+	dmaengine_desc_set_callback(rxdesc, k1_spi_dma_callback, NULL, drv_data);
 
 	dmaengine_submit(txdesc);
 	dmaengine_submit(rxdesc);
diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index fa0e8e83cb1be..4e202d74c9926 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -374,8 +374,7 @@ static int stm32_ospi_tx_dma(struct stm32_ospi *ospi,
 	cr = readl_relaxed(regs_base + OSPI_CR);
 
 	reinit_completion(&ospi->dma_completion);
-	desc->callback = stm32_ospi_dma_callback;
-	desc->callback_param = &ospi->dma_completion;
+	dmaengine_desc_set_callback(desc, stm32_ospi_dma_callback, NULL, &ospi->dma_completion);
 	cookie = dmaengine_submit(desc);
 	err = dma_submit_error(cookie);
 	if (err)
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index b77daba6db83a..f9865720c6dd3 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -265,8 +265,7 @@ static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 
 	reinit_completion(&qspi->dma_completion);
-	desc->callback = stm32_qspi_dma_callback;
-	desc->callback_param = &qspi->dma_completion;
+	dmaengine_desc_set_callback(desc, stm32_qspi_dma_callback, NULL, &qspi->dma_completion);
 	cookie = dmaengine_submit(desc);
 	err = dma_submit_error(cookie);
 	if (err)
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4c3ae546afc05..66932400cf570 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1690,11 +1690,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 
 	if (rx_dma_desc) {
 		if (rx_mdma_desc) {
-			rx_mdma_desc->callback = spi->cfg->dma_rx_cb;
-			rx_mdma_desc->callback_param = spi;
+			dmaengine_desc_set_callback(rx_mdma_desc, spi->cfg->dma_rx_cb, NULL, spi);
 		} else {
-			rx_dma_desc->callback = spi->cfg->dma_rx_cb;
-			rx_dma_desc->callback_param = spi;
+			dmaengine_desc_set_callback(rx_dma_desc, spi->cfg->dma_rx_cb, NULL, spi);
 		}
 
 		/* Enable Rx DMA request */
@@ -1719,8 +1717,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	if (tx_dma_desc) {
 		if (spi->cur_comm == SPI_SIMPLEX_TX ||
 		    spi->cur_comm == SPI_3WIRE_TX) {
-			tx_dma_desc->callback = spi->cfg->dma_tx_cb;
-			tx_dma_desc->callback_param = spi;
+			dmaengine_desc_set_callback(tx_dma_desc, spi->cfg->dma_tx_cb, NULL, spi);
 		}
 
 		if (dma_submit_error(dmaengine_submit(tx_dma_desc))) {
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 6b7a05dd0de8a..e9fce8618299a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -232,8 +232,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 						 DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
-		rxdesc->callback_param = sspi;
-		rxdesc->callback = sun6i_spi_dma_rx_cb;
+		dmaengine_desc_set_callback(rxdesc, sun6i_spi_dma_rx_cb, NULL, sspi);
 	}
 
 	txdesc = NULL;
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f43f2df478b45..ffe547d1e3af3 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -480,8 +480,7 @@ static int tegra_spi_start_tx_dma(struct tegra_spi_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->tx_dma_desc->callback = tegra_spi_dma_complete;
-	tspi->tx_dma_desc->callback_param = &tspi->tx_dma_complete;
+	dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_spi_dma_complete, NULL, &tspi->tx_dma_complete);
 
 	dmaengine_submit(tspi->tx_dma_desc);
 	dma_async_issue_pending(tspi->tx_dma_chan);
@@ -499,8 +498,7 @@ static int tegra_spi_start_rx_dma(struct tegra_spi_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->rx_dma_desc->callback = tegra_spi_dma_complete;
-	tspi->rx_dma_desc->callback_param = &tspi->rx_dma_complete;
+	dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_spi_dma_complete, NULL, &tspi->rx_dma_complete);
 
 	dmaengine_submit(tspi->rx_dma_desc);
 	dma_async_issue_pending(tspi->rx_dma_chan);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ed1fcf57dd30d..5aca26549e730 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -440,8 +440,7 @@ static int tegra_slink_start_tx_dma(struct tegra_slink_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->tx_dma_desc->callback = tegra_slink_dma_complete;
-	tspi->tx_dma_desc->callback_param = &tspi->tx_dma_complete;
+	dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_slink_dma_complete, NULL, &tspi->tx_dma_complete);
 
 	dmaengine_submit(tspi->tx_dma_desc);
 	dma_async_issue_pending(tspi->tx_dma_chan);
@@ -459,8 +458,7 @@ static int tegra_slink_start_rx_dma(struct tegra_slink_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->rx_dma_desc->callback = tegra_slink_dma_complete;
-	tspi->rx_dma_desc->callback_param = &tspi->rx_dma_complete;
+	dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_slink_dma_complete, NULL, &tspi->rx_dma_complete);
 
 	dmaengine_submit(tspi->rx_dma_desc);
 	dma_async_issue_pending(tspi->rx_dma_chan);
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index d8cca3aa276b2..95132d8be9dd6 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -522,8 +522,7 @@ static int tegra_qspi_start_tx_dma(struct tegra_qspi *tqspi, struct spi_transfer
 		return -EIO;
 	}
 
-	tqspi->tx_dma_desc->callback = tegra_qspi_dma_complete;
-	tqspi->tx_dma_desc->callback_param = &tqspi->tx_dma_complete;
+	dmaengine_desc_set_callback(tqspi->tx_dma_desc, tegra_qspi_dma_complete, NULL, &tqspi->tx_dma_complete);
 	dmaengine_submit(tqspi->tx_dma_desc);
 	dma_async_issue_pending(tqspi->tx_dma_chan);
 
@@ -550,8 +549,7 @@ static int tegra_qspi_start_rx_dma(struct tegra_qspi *tqspi, struct spi_transfer
 		return -EIO;
 	}
 
-	tqspi->rx_dma_desc->callback = tegra_qspi_dma_complete;
-	tqspi->rx_dma_desc->callback_param = &tqspi->rx_dma_complete;
+	dmaengine_desc_set_callback(tqspi->rx_dma_desc, tegra_qspi_dma_complete, NULL, &tqspi->rx_dma_complete);
 	dmaengine_submit(tqspi->rx_dma_desc);
 	dma_async_issue_pending(tqspi->rx_dma_chan);
 
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 091a8b8842f58..0083160c15fea 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -452,8 +452,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 		return -EIO;
 	}
 
-	tx->callback = ti_qspi_dma_callback;
-	tx->callback_param = qspi;
+	dmaengine_desc_set_callback(tx, ti_qspi_dma_callback, NULL, qspi);
 	cookie = dmaengine_submit(tx);
 	reinit_completion(&qspi->transfer_complete);
 
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index eb3485149e75a..fdda26eb311fb 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1021,8 +1021,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 		return;
 	}
 	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_FROM_DEVICE);
-	desc_rx->callback = pch_dma_rx_complete;
-	desc_rx->callback_param = data;
+	dmaengine_desc_set_callback(desc_rx, pch_dma_rx_complete, NULL, data);
 	dma->nent = num;
 	dma->desc_rx = desc_rx;
 
@@ -1083,8 +1082,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 		return;
 	}
 	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_TO_DEVICE);
-	desc_tx->callback = NULL;
-	desc_tx->callback_param = data;
+	dmaengine_desc_set_callback(desc_tx, NULL, NULL, data);
 	dma->nent = num;
 	dma->desc_tx = desc_tx;
 
diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 86fce9a571dab..e8344a66e4361 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -418,8 +418,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_controller *host,
 		if (!rxdesc)
 			goto out_err_prep;
 
-		rxdesc->callback = uniphier_spi_dma_rxcb;
-		rxdesc->callback_param = host;
+		dmaengine_desc_set_callback(rxdesc, uniphier_spi_dma_rxcb, NULL, host);
 
 		uniphier_spi_irq_enable(priv, SSI_IE_RXRE);
 		atomic_or(SSI_DMA_RX_BUSY, &priv->dma_busy);
@@ -445,8 +444,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_controller *host,
 		if (!txdesc)
 			goto out_err_prep;
 
-		txdesc->callback = uniphier_spi_dma_txcb;
-		txdesc->callback_param = host;
+		dmaengine_desc_set_callback(txdesc, uniphier_spi_dma_txcb, NULL, host);
 
 		uniphier_spi_irq_enable(priv, SSI_IE_TXRE);
 		atomic_or(SSI_DMA_TX_BUSY, &priv->dma_busy);
-- 
2.43.0

