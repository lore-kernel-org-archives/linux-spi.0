Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F301E3DE5;
	Tue, 17 Mar 2026 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709569; cv=fail; b=J8U4kYtFlbKFySh4FUwHJbOelmdg93tx4fjUa9pLl2rlFXzyrcuu2XK8F2RXsPRV8K9gtAycM68PDgaOkY1cMEpZ/sR/44HLumYF3id7A2z8GXidFGVgrAVLk2qVp0D7OPE+abTANvaIrAAXrcMGRYL2DgmJVWZTFKtaw+KN6F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709569; c=relaxed/simple;
	bh=Llit0Fk3MTWgxUfYcly+0WE8MRlWI4+LFwWn2gMr7Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6TvGOhLGGg1zWyrIxlaDatzAW+x1BEeuYk+Ge3ggBRTJAXmY+AWxKTBLvILuBmbnf7SuV3Tk6fswliZCCmwW9wrUl79Ya3DGxobekIhvMcYv4JwJjdFdnoOvkPC6VgqdaSDxBpXTFy1iUl/OlGKjoa0M2VWom6BOND1hCozBok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SlmEMFat; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SlmEMFat"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjXEyRABGrmEcks0HOrnHwC4k30QolTzWA5A+Ox7nor9c6YVIpwYoVxCDGcJbcLD5+i4K8UTiC0KGHqi3d6C6QbZDxtZtCkYt0yFnbOmXqlwVmqIoBEYK/e/zKGYai+Xx8hEkM0tyNyIffRlWqlZHftmas6glbFxQ6FrTBjjyBgGqmT8FrIxPdZbaUnR/EoyRKJ7Rn55yjK/Wg9lf8iZqj6uTX5xFLp+QUzXD/OAzfhUCOhRhMeyBJSmYMH02kiK9yiFueVGOYnYIXx0EIv0jDXH9xpEtg+jrnvPXKMl7aZJmC+rGuBoCugc5JCeJi8sIgfAyH4HpZo4DglEVhAD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Llit0Fk3MTWgxUfYcly+0WE8MRlWI4+LFwWn2gMr7Bs=;
 b=jGR2175Y17bKTdDPdPpUnjms3w79pTzElpNHH8jtVv8Jg+3sr9+eRsYpOLC5QloUGl8uG4Gjp8+qBpGKfVh8QycAI9mIDKTORUUVDRdL+tY12pOgrsuFcbEJivZusYb8e2XP7OKZ7Tl+UYXufcIvNok48tkb8xrdXXcnpOI9niU01Lrq7EHXsX6mSJZfk/HUI7y1ld6x+JcOgKv7sozViTa02sPHtY6Cx2yJzKYbPygFRhbM6C5iCx+Ux32wyR+IDN+CN/8Cvu0Yn+qsEdi4VPfLLnVNVAGGApysUVEPz1eAyH/I0STY73LU0XQwd9eJaowBXCFDDwmGGeguGPoPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llit0Fk3MTWgxUfYcly+0WE8MRlWI4+LFwWn2gMr7Bs=;
 b=SlmEMFattJfyZRPpjqh6tXryRm8rYiaQ+6OuLqyOWKbwR5SbUliH3B3Y/EjNpUscCUNwg7wcsSUBCxtoPv2wbnLoy2CUqlVCkAjsK5ivA9LYtJnPmECm+u2wFKWlkg3+d/ZP0C7taJzdJleX8N9XmdH5fEtilKiGn/y7rgEcjKuTyoCDs4s85U+J5pC8JNIP9ddVcYY5pg5Rk2Opj+rpDOGv03MnULJPXrEdHf3e6+tMdGzgAGvzB4xClKX6OA7JIkP51kFfo8cEHZJw5bTKyAkmCs8CKODIti8+1P/h48woy342wPfI0c0lSyyQH8W2ReUZ+2W/w/KB75KuWHSXtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 01:06:03 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9700.025; Tue, 17 Mar 2026
 01:05:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: Frank Li <frank.li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH spi-next 02/11] spi: spi-fsl-lpspi: fsl_lpspi_probe(): use FIELD_GET to decode Parameter register
Date: Mon, 16 Mar 2026 21:05:45 -0400
Message-ID: <20260317010548.3293912-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-2-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-2-1b695607702d@pengutronix.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:806:a7::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DB8PR04MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a5a574-8b49-4b05-cc0d-08de83c156da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	2vhVK/8Yb3Iq5RDDpUQhSZ4dwyvO3ebmESYuy+XLdPt95qJB1d9USaksiHmlgFRnjamAvI7i1Li6qLzGJ3Vbl1OvZyLnD8ZdpLY7mHC82tAzKBpEtZwpVqjrqZIT+jUeXtzQrfhR5JCL940Af8rry7WcwCKK8NYOhPznTQN5bywrXY5p3nG4/CG2TbAI1fg2GGeps2I0hDv6FRR0tGoBA5PUy8c8J9zG6KQKXrlG0FB2b6KFC0nBJeNDou9aS9LKu6A4HKOpkpcTCbHh77o4y7Vy/N8dk7v19HeC66ez3/UU/xuzi4PJmb+1GQ2RnmgkUiPdHB8d4TLxjSLlZt18ZZnAoIE53v852UYblY3a6otq7WcBoF+rsKMMWcO1PevK6El+3LLWROAtKK28ZllLahNSKqk87FwOq1AmFq1zK6LYKsKU6+c9PZpUUhd7E4ujnCcbHCnS73UoMLINIvYfOW1+stC21qmCf4ToO57Qv/7kGi0hVK7O3JlgJXSbb8WtL2oCu+4FjBo5GE/d1y1nqrYR0bgGnSEm+rzs/e9Ql58tTuOYFHv0HoVUgliGOU8X4duMsYYsufnY2x+DtD4qJfH/og9qKJDbiJde0oVLXvhWfWCBJujt32QP0jIPh6yoiaeF/nkDHGiSCkP/ZCBCd+nsFhJcWrBCgOt7qIceMaTeu0MEAGuOpC+HadwcNedP29NYVPI3Mv/HA2DcELRjIlWr/PSjmdBi+A6iJqLysjMgxCEWeUtEKZvoixeF1y5nScn+KCCoN02k7DD5oB9vaN1R7ZMuUOxgohhE/Tpckso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jhdu9CSJX8I2By8k7xzXZxeJXNW0aqVZ8hDACJY5s/RT64K3ku3hRVz5BPyY?=
 =?us-ascii?Q?ABnR0bSRSn6SljqHMZHz+ccrUAdJmC2tpMludlMCJFCnZSnTPt+C6IV3DsTI?=
 =?us-ascii?Q?m+wSeM3dQfvpfuv8BHmkUb3pqMZRg0s17Kr4S993X43MC+oItrRLYnmBHzj9?=
 =?us-ascii?Q?9eXuRWm4t96P21WdtZKiKqCJ07Zh+Y+Yk12bzrVwZ2AEKZ7jH3qaPr2r0sdL?=
 =?us-ascii?Q?T9gb3U3TtjDwi2P26YDw52yUTeB9IuxeYECRs+0ZAshHFyuA1/xDS40zKOhs?=
 =?us-ascii?Q?vF+oqu2MaMwdYyIvqzLU5IJ/umQpTQmk3ULDijHyX3QxzCmLTDuAXYleROqz?=
 =?us-ascii?Q?zxQKzyx0OSM8wVPe9R07BLymTKscpMQb8RzcxDhZb0JapbtOVJYFmbnMmohk?=
 =?us-ascii?Q?815beFtKKZznB/MORhcKfd5YnwKISUYCI9RQqD4oh+SJyTQoHgRXdXDcX+pZ?=
 =?us-ascii?Q?yf//4xPhDSkLMfB/eFSEhlV0A+MMwq09TqmtLtl01/sAlJxMJfGOahrvST9f?=
 =?us-ascii?Q?t3o44ZQhvosQhV+kRjuL/lbTj51qE/qaJiUYaki/nu50oQa8sQvft6LW6swP?=
 =?us-ascii?Q?cErZcr/qzZuEkvb3YtUN2HF0HJPI7OgTQY0dnEZatrc3YSIXUDb1xWyak61D?=
 =?us-ascii?Q?/+/yZnTCtx0hDrZprhbupLNnv3dZ4gdT1d7cCSIdjtOljwX8fi/Do63doy8G?=
 =?us-ascii?Q?u6Z+yQIe5mAXgdxuvTSr6uz6R+OSQDt2CfilKUjBkMM6rAYx/c7fukV6Y0W+?=
 =?us-ascii?Q?CTmj57PcmUJ3hHFUD14qFyP0YgX1lu0wF0yJdIbnhutweVcQQu4pF3j32X7r?=
 =?us-ascii?Q?QtPhMR1HuSN0voRLCD0HUvNm3TVPRPBcuHwWHL7CiO2Uky386uS/ytNar7LR?=
 =?us-ascii?Q?fv6DdltfPKDM3hreCR4X1hEMEQ+eb4Q9eRNNmgeDN1kF5jHfQrd0iGanbda1?=
 =?us-ascii?Q?/VjLfLoo2ZthoSsV/YyX4BG11qD7Ww/6ivbLI87REKrB/gRaz+2emDtiUfSy?=
 =?us-ascii?Q?AacOkAH+9qP3W1A8LyROxbrpCLTlCj3ypj9IhxgnKcbl4zBniMe8i3OTmWrm?=
 =?us-ascii?Q?q+gL8frTKy9+ovMHXnfVyqn5O4mbkVy7HVrFH6QTSpvIjZIaoSqDOwNvRs/J?=
 =?us-ascii?Q?17NO32D9R4JYc5oHiulcl+Z20KSbeDaxvLM6npKin8oJRuNsZBBHZNwcbRkl?=
 =?us-ascii?Q?FIzdw0T3Oc9YkpGLe86Houl7HdfoLeFeLysV4lOEZVF+GGzCJNak/Hghn08Y?=
 =?us-ascii?Q?3pmSTaUztLxvmoL40PLjvsgJiv4BMra8UUj5HG6EyfDkvnBNnprimPCF8yI1?=
 =?us-ascii?Q?sgBJXe3qxrZqMzor24zbWeMcud5gOybkR7XU27P2Joevv3Eg+jIvtjYrUm2Y?=
 =?us-ascii?Q?+hj4NadcQ8a2cUp4kZmmHB9DexW0hhLALx4OnYFf64yT2k6TTuSJgaWzQ2Ql?=
 =?us-ascii?Q?xUXdZJe73eEXAN6N/eFigllKZ8UGyLcmOaNclTq00mDws3JhqcWp3E5bxdeg?=
 =?us-ascii?Q?8tR7ZhhkeqzW8SiMHjIMrtwArfnrjg6RetPwtFX9UzVXsPdBqDFc+ZbsbzHE?=
 =?us-ascii?Q?h9je2LiW7jN5eTbpGO3sRgLEl2epbSdP5X97vbkVf9QKYt+Zrtp7Vtr+B+FQ?=
 =?us-ascii?Q?8nFKLpH7deua+mKz+ownjkyiU1MPuGTGExVIFAHTa3t/48SjEzZmYgiU5k7a?=
 =?us-ascii?Q?07CkZOI51+UFOs468weCIMnDaB0FACbqOa0oarqvi46v92nZFeVNfagutlPr?=
 =?us-ascii?Q?beEhv+NBug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a5a574-8b49-4b05-cc0d-08de83c156da
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:05:54.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guyoE5l8HDV6cNiZwMC2Q4uDNYNefjapjdXz0XX+m4SsybSxH31NYWgHVI7XRkpbkkzAaKkaTW/DRErISVQGtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923

From: Frank Li (AI-BOT) <frank.li@nxp.com>

Typo in commit message:

> Instead of open coding mask and shift operations and to o increase

AI: Should be "and to increase" (remove the extra "o").

Frank
