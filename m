Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9713CE485;
	Wed,  4 Mar 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636165; cv=fail; b=RqujwyzTCK4r9Jvi8Rx0LQbv7INV6pdN4TEQ17fUk4XIMNwNdM8I0l2wyLBHrxF1N7Gem0WYOqljwlfkXND8iowD66VqvFMYLmbvP3g0oE98Ws55hC/pF9KagqPYHMTF0rxATlNxjMO/6gJRApnOJpHRQJzQ2TDb6PTOt4B6odQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636165; c=relaxed/simple;
	bh=psvgXdEAcKsbHUei/RBCbvhY8mcDaRcIRCiafyLaUqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BArwoD6D0U5bclO26qGc3LsQb/TjY/f9kdRBtdUxkHO5W01NHFLu39OGmawX9+Xly5f5bA4xLUyEIXwOlC3SQx0PccAShMboqwX/EYIgLqYBMvgwYdQqDP2k0SybFr+YjVmZ1fpTzgVv5nh0QhE8vTNyIluk4bpBbLZdEy1TIz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SF35g+JZ; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SF35g+JZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez79LvAyjrAwxDmPHE33f+7/xRL6LLD19+HoVjlt1JR5Y7AJt+FznJyVg8/EkV6mY2UePNw1sJ7AX+IAQxQfGIfjBk1L2Wpmsjt0Sfq316hrPZSriJ2zZ56qnN5aQPOV8kiEdJ8GLeTnsE+XjG+G6W+DeE08FI7wZ6G6+pDTmUHZiOg7beFrmcSTQZGBOMliZdSR2TZmKLPWoX/TbrnM983ipk0payjV+PcOcFO3raGnmdoQGXue7ufkY84CGuFe9Me5Qw7r9Zcd3JrAOlpTezZ3jVt+VbSzZYGqV5d/TB/bmCaCbAg8LvA5x3LLpenzBuT4A9GQlhdHq9AOQpaEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psvgXdEAcKsbHUei/RBCbvhY8mcDaRcIRCiafyLaUqI=;
 b=ODEBfPEDg2RLwPqFQjH/mMSsKm8B4o4SUljPOcRjKLpmzCeveJTXOm+SPH8thaG9oBrgOTiFU/A9wZbUgjx7tJn01hqUr57ZS0G9Owj50aNiN9Sb7NgoQDFglQHPQOgesTzGCWOHl/l+1yiGifJM1u2gihmNc+/lSpbbcGOGSY9YRwf9RQbb726TnHzJ6w1KQTsPyD3TphC1SdHMy5uhsYvxwWO1p+jiPvSoSF9zgBH7UGJoXvxsS6xGJjZCRTk/52GU3qfP6KsxOw5QrQnz23IfgRyAbPvKIkUYUcpMKXs3lE+Xul/nXSmJSn5xm6h/oplbX3Z2bBxeiAQA400xSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psvgXdEAcKsbHUei/RBCbvhY8mcDaRcIRCiafyLaUqI=;
 b=SF35g+JZW4peeiHCsIXKdx9hdRi9A7OkEKkTH7GXh9H+enDqTbbmL1iEgTsWqcDLaBPZ/SdKMzytn7tRvqpTSbAqstC8vW4cxZ/9LBEExOsNVKHz1y93BYvH4tZfr6zd96lGV3DRUtmj9j1pHHfXwEJCrcx52p2EYzO/1iKRdSFE0THg3CosGWzLFO/FrS6FzNQDfVpcW99YJiYhCANzGuNJN0xFo9YbKuMgmqNnMcR/oFLKrbyCrAKdvcWcUSH5zrqtw5hqKq2Nxz9Uot+0dlBNP+f38AW2raXFIGz99sO4pJfM8uTJ4AdgoLqqvILvy/xADUE1zWd+XEdJW+JVQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7009.eurprd04.prod.outlook.com (2603:10a6:208:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 14:56:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 14:55:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frank Li <frank.li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v2 1/3] spi: nxp-xspi: Use reinit_completion() for repeated operations
Date: Wed,  4 Mar 2026 09:55:35 -0500
Message-ID: <20260304145540.3331304-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304-spi-nxp-v2-1-cd7d7726a27e@gmail.com>
References: <20260304-spi-nxp-v2-1-cd7d7726a27e@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:806:27::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ec4581-7c27-48b0-eab8-08de79fe25b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	KAigGcx5TUDzSbExPZixFnSASagGOiDQ451MevwomIvl2b6HoszoEAMxv6ZKO+CJQYKoVP3QkAjeKi5AWacrf9aeedoAKhbdfAMVk5Zxyxsr98mnY1/+xSl/yiosuTe8tOlDw86sgzIn2pwvJ2rI9qhsAT6Rh9n6N64nTEkk6WIGmyolT1jcwCtLRqJ0JlKLdX5D8dO0aqrfI1V+3mAmVWS64uk2oqjtg4pUIIJGTVfKtnYmVbftJzUwUIEoMQyBXugI/D94ixlip0IQFSdRTumDYw/30FDkJ2M1llL3iqztCWUzHzcbz8gaLuy+Q3bFwHbOWBgT2MyARUuVw7mzPVoytR/4r7dIxRgYuf7Ng/Wr/UyqOwmmMeh4Ts5Cn97RpPhWkI6nAkZ7ippKKYONseao2LobSnO74qqenQ88j2iYrxUVBkXs8HkIFKo+ci8v72dNL6SxiWoN51+VSvh4FEH27XTJ8+57XTMrE1N5ZChG+Or4mae57wbzTJUSAT+FTL4KBlun1iCvQ8tH+XGAdGXPQiXeBnoBwYwOOVM4Q7IAfHgF6H61MIso5HPeXIGRUFKDXxdbK/sSc2sAALFzRI2C89SLibBSEB9AkhN8nAXaHtpI0ffZh4Itafbdfh1GVBdAh9LYQ+Y6pYM7WFGPa1y+aCs54Ex6d7rHjWoaEaehWvcC7+ZL6gpb3bCs/qEv4k3DsmYRJPuKI5qKf8SewTeu2niAV/AtvsWqlK/ij6Wd8caAVZOEmdLB32yAMENkzNA8h1ZPg0GxZ2qP+nI055AAoYlds/yVOypgWK8Yu74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RByCZn3SulMGzthdNf4cWS8zpMlsRaYkhI6Kwg6Z1wfQvHUNbv3+9eUJR+b2?=
 =?us-ascii?Q?HFXZ2/XpeFLuB4OZ2K7XuHSV32FsveDmf+nc5lNfyZmy6kUaX4SRmOZXSbJ1?=
 =?us-ascii?Q?YE4Cs3gdTB64+JVJKRKjj8pHCit8H7HCHJzUDrhtuD3BF9yu/nXAdiQxM/4K?=
 =?us-ascii?Q?4htgCv2YrQeR8ZQby7t1A5/U0p+gP8RQEuny5XlaF0ErMMimC0A/OMaCnU8M?=
 =?us-ascii?Q?2M9G/rrNzWoBfqLzupwl7ySuU3z9YijG4F3ERmPBl3gOG3z4xgHzy/vAfSjf?=
 =?us-ascii?Q?h1NGjpFCdaNzlfYlgQH6Gi4Zb4a0G1RByptPdyPZiUoom4gSGB3q4sbZt9gB?=
 =?us-ascii?Q?ekoyi1LWh6q9YTP5Mv0NX9PXrsYnnT02cJ4vjUBkTEGgzWJBtxm14MtpjUMd?=
 =?us-ascii?Q?ea5tJv09fjhM+r3XSy8vNOzIg7jAVP1VCzC9beP5bqulyxTSeZWvWhFRmRlj?=
 =?us-ascii?Q?XoiVLZLiDhy8tJ4DeuBQrT5znJ+h1Qu4jIu8cxr7K8eAdanFfbf4BHjNgF7J?=
 =?us-ascii?Q?4GQ4jQvZtqnt5l2siVjmsIDEprOESpp2CN9Ihneb8CsZV1S+6n82x0aZFJqe?=
 =?us-ascii?Q?1IS0E07jDlv5Q7u6wAx67x80Z4/8tj0t7iZZxOwsoke7vGgjfasacyJ9XFjF?=
 =?us-ascii?Q?PZcSZ/ZKRXcYf3MLseWB/QcBQbY2blhgfCZTq5PVBfdi2ugbXHF2U5VOK8f5?=
 =?us-ascii?Q?1Z8o+cIs2j9n+Im8OhuSSquIM6SOTNpSJ+kkVsmYuBEzEKCf51cMTVUkKgoc?=
 =?us-ascii?Q?I/1tzVlylie7sVFsKtDZK1/hqNGqOin+y0wEgYDn9xPar0a659FwBe/ZY+cl?=
 =?us-ascii?Q?T1NmWA89jFg40/wQjDp8A6V5Bo3aaY+KjcamsQ2zjK4JGPMe/ai99HCLyB7T?=
 =?us-ascii?Q?5+JwVRsXX/jbgKJp80OFLa5hTCuj1qTLYWq1sLUTk6R0OA99Jh68OmVLROwq?=
 =?us-ascii?Q?uvvzeaqEyhBNvIB5bJ9KL47EzoyBhhc1qtCrb0+nwrRK4yeM6PdqpUWq/y9L?=
 =?us-ascii?Q?4f5S6Q8+emNUOHNhb5dMPAwmF+DDLa2yKTyAUhhhu98pV11RqTIYixS9+QMg?=
 =?us-ascii?Q?WgGpIUksAbUhbjT0aax1kk3CyQOCP/9VkFkvE2xL9KxuDsi7qYyBoAj8ZH4J?=
 =?us-ascii?Q?svKTWAL/CiIPSRCH0sqNQQWZ6FJ4BQ+OBcsowWO8b0Ko6ZF14z/bnVSFCFdi?=
 =?us-ascii?Q?zMEZWfA2b+9LQKITENzRJ4oGY9bv/mfkKyzZDyk1yWfAjeSM+an+4K+5LQs6?=
 =?us-ascii?Q?sWzqhdu+wU77sDoqp1RsPPmPBZKpFwhwrZyEJFSqhF7uRChTCVrERNvADed8?=
 =?us-ascii?Q?UQLOcW+2+rxJn4dGtEiy/IZL2RbiiHW9y+UN25uby++G3Ci3HA3Rgs3Stb0X?=
 =?us-ascii?Q?qMjHjd67dKuDiK07UPKJMK5WDvDEGLqXG8Vq2eLaGdVQxhaI/yQ243lGdNWG?=
 =?us-ascii?Q?MMPtz2bcJrra0MgHB7oxxIFoRj4D/GR1Pia8DKcxoSyR3JHsZSKO+X5bqzBr?=
 =?us-ascii?Q?4hDvqsRikJHJ+znMiYWSOLdeAevrKMb9u0iMckJ7JWwoU9ZanVRImh/FRaiF?=
 =?us-ascii?Q?o1RR4d/3cpDxsmyZ1eisGr9D+hNWjm7MT4a3mBcamxTtGWBaFeP7MOB010cH?=
 =?us-ascii?Q?s3raafYjpBzanM2Wv3in+QmQQT20M09GOxFP5oQ68Kb8ATchgup74l7FKaF9?=
 =?us-ascii?Q?DSJcwL7eGfW702l2j/2JJRzxu46tRjjawG1WaaNBnipbFuyG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ec4581-7c27-48b0-eab8-08de79fe25b4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 14:55:59.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tBMoM+eaFLWIsU08PMIie+2ABEqZUBaNDMHAO1PJZVlDWJ+tXERHBcL2BWKQ39ixxB+QY6epPwP5vUQgQkoew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7009

From: Frank Li (AI-BOT) <frank.li@nxp.com>

Typo in commit message:

> Tchnically it may work, but it's not the recommended pattern.

Should be "Technically" (missing 'e').

---

> So moves the initial initialization to probe function and uses

Should be "So move the initial initialization..." or "This moves the initial
initialization..." (subject-verb agreement).

---

AI bot review and may be useless.
