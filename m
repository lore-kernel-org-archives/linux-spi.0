Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED8175A79;
	Sat,  2 May 2026 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697218; cv=fail; b=kIlZOjY0+923pUwMf9XPWT3RnFn+LA/OtZhHFHsa8EP+c6Um6tYTXGNz5yLKeTA5StULB250glqqlARzwpusRRMSA5vQ/fC/DRWEQLw3QAbs9Z6g1K8cBwlP2FLt222DkOcPLrQEmlSFWNiHBkx5WswN4Tpn5w95H5QDMmw5Rso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697218; c=relaxed/simple;
	bh=LbixuwMtsRg5Vm0hUynBhk/0d638DxGfCb7Vrimd9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KcvEw9UOha7BCgqnXgQcGgEyB/Rd4glvDaoCPhDipVWiuF+ezf4RuZoBLTO+Y/M4+jPbqyS1inmDqqjC9m/C9rNZgPdU6v0gemW7xUjM1hriqWNWc7VKDPRp4hU0fcMpsTR5IUOoH9DSpUAv0Mx4lkKR6iZUMmmrMlF60JETtLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fx3T488u; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fx3T488u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSDdp1qlrPLk9MA85G7iX7AFspJx8R2cwwuw9xPHS7S0URDrppML4UJGP2g7jvj8IeTjUpLAwUGPfUNajCbYe/0CFwYcgLM+Yno43vZRjg/P4GvPDDALgcEA0UrZkcTH0UGY+erq8bvVXLMn0is8gjHsG+BbYMQGf0PXSU4iCMQu/LI5T9WVjRUo5jymYLkrqBms38ek13XLW+8o+YU8616ZIDK1JD9FA7xtEW7zNMCS5ADsyzPl4rt4jMpX804IVK2K7u4x2HcOUkGbg5CldAI1X0xuiNpsZqxRhvVuNOcLYDX8h7UqrI9gvSenoI+1xoKi3ndn/AzXUe4iMzZoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rPeR883wYIZdlH5B8YXFZCcDA2Ufauu7FUnRI4P8GA=;
 b=kVAgnGHK5fQ0LoZzTBJz8llIaUVCiTtwW6afsNzMXXG+2sTAOgofpnySEE89lW8DU3w64a1+fFcH4YxjWXBEBAEZS4TTzEU6SbV5JnXjj8w7qudlBU4G9gwS6Ae0Xb8S4OB03h4DzuM3mVGEFPDxp8M54tmuZ1KBp7nyo9MaDbCje5bfNsge4vl7oaycM+mnMS4v6bva/UhiKK8ckPGnCgk0TNEAfPjKwoa0uk6D4xmqtumCn1NTYdyJ54vGwz+Fgq5wvrUsvgKoCcchoCSL17GboH/gHt7hFTvknkIa7nGNLTByLvBbOzJhMCgiFRp8iQ3iLep8/jbEao/C7l3ahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rPeR883wYIZdlH5B8YXFZCcDA2Ufauu7FUnRI4P8GA=;
 b=fx3T488uuAQw1dEJIaibpAPBMghhRzRN+k7BLq3CV50trxAvssINhG+mB0pc00lbJvjJH3G1qGLCvszQGRhvrM6ch0a6Tue6+U/46ciMLsUmW5p9Luj89EPrweDv9rhZDu3z2/CZGQOlnXpkK99sg/RWHQS+M2BJs8Jm/0Z06Gz5QVvk+7V1FzQQWtq7EYd3dIlt1HJykvcRxWy9o+r8epn5goaly8h0KTsIvcEPsiHALcIy9VFS4CgBLkeFCmL+2h/aMrFuZIY7EbkigQxxwQTPFPD0oVYh2HeiH4q1IchbrsXxiep8yxIZFpwAW/BcI5+lDXGl4C0b9siYY+RBJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10792.eurprd04.prod.outlook.com (2603:10a6:10:58e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 04:46:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 04:46:53 +0000
Date: Sat, 2 May 2026 00:46:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: John Madieu <john.madieu@gmail.com>
Cc: broonie@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, carlos.song@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: imx: Fix precedence bug in
 spi_imx_dma_max_wml_find()
Message-ID: <afWBt-VJwC9XVFG1@lizhi-Precision-Tower-5810>
References: <20260501135951.2416527-1-john.madieu@gmail.com>
 <20260501135951.2416527-2-john.madieu@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501135951.2416527-2-john.madieu@gmail.com>
X-ClientProxiedBy: SA0PR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:806:d0::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10792:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9d01da-28de-4d9d-b698-08dea805d4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Clos/uoptmx94F5CK01CzKIDPC41WrZ8OW/NK2UGBy3wqqzWeBRWRNNJismqLD8lpCl47zOOrObMZ1rNUl4rfxOhoxe3WdHYWSIb8+XGDh9Hb7JZCbWgoDAHA18uMx13fAV3pfVgMMP6biMJUtg2Ao1hzvEmTQw3B/xofGom9T4Ze5c+pzGxoyYeK9Br72HV1dOA3H8II3D+qbxZzrXO1X0MeY1sgBhlUJ0ELlIpuezmnZx7Si6+IoiWdt39a2hZW1J7jmsLlvEnfKRdB3Kj8A4WjPIh9LsZlNWrQGIncy7RicVhH7oZvBeOm4KClZrnWH6hDhtP0DulbCMh8PqWOpbUMqD/B+42MZKwvIplw2fGGlC5HI9TlfkRrZt1pIQJepdcIzoWzuY/WFomHQqgLuAikrFwJgpyD4yn2l1lQevXF/pg+o9LhYyLEpJILOQtrK7M+doYt8jpUQJPI+E8NfAhlShj6H9AvvkW9cXGWkl2rqaRiPx5gCW2jHLwdNOL0wvVQOqeCSMq8NhEjJde/TCQ65zmKJLsuWRqb+qCCNqJnMASmTekQADAGrNFRuxhBlHSZg0/5SRQTMxJK74ihIlHKV9c6RoB79wCdZ4E+4SggBJyvU95oCoEV5hZmB61qIETDFyPYo17OA5oP3zvPl155yQhhawk/p4pu4XL8TZKoXu4RaS7Xv4S40Rq13aqzsO9oQXAxeznAohUomYTz92hxfJOcXPwAlYQnyfpws2C+8Jk1zuUAHQp4aoChUVw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3wPIuYO+dkFGonCAad5LZ0125oHLb1wOBlwn0ihf93KPpdLbINUamsvDsmzW?=
 =?us-ascii?Q?7RbzZIkO8cIYXdFky3iZYN/uiSobS49HHAmOCSrJ/36a2OeNseJxAEc0v2LP?=
 =?us-ascii?Q?WMtuLmSwtlT4Ehf+nR3LqponrSFgTyHHMHYRS2iRuF2nWh5wC0RNnJ197xU1?=
 =?us-ascii?Q?wVojBd7tKj6cA1X3I7Ejc5/FaXB9FB4S+K13SnPj+JfHbX20wOfo694PByKM?=
 =?us-ascii?Q?jH03C2MPsi8fE6QZlGxnZvLRbf6h9MLORAT30ieVe5yk9M+p170Ap/M1eUQn?=
 =?us-ascii?Q?FNdkGsRMT8Qv2w9yhJW7IBhXNKQ6tbSZUGQNT1e0Ynfz0B+Ulmob0WOCY5Ti?=
 =?us-ascii?Q?7iF0QOjiIkytNeSasjcPOBJhBlINVif+M+SiX6u2IC9yTd8iYX3pQgUoAWpE?=
 =?us-ascii?Q?3IisF6Y6ad3waWB4Go02dguS+KG8u2B91MCVfDEog+H+tr1ukBQQH60oqdiW?=
 =?us-ascii?Q?7wChKlAxJeuP4VakvNY6+yUT/wJTaGzG/hHoSwso90400msZAFCkNRQ4MdW+?=
 =?us-ascii?Q?XO4/FTg3l12oCOWjamVef9xlcw0xR20YRYJhiKXlHaM8XQV5Y9OhxP5+SL/B?=
 =?us-ascii?Q?51yfPgoT5i76YnblDRMVZYfyyk3J/E08SMPz8fNDqqNB9hOH99Rm8T6LE5My?=
 =?us-ascii?Q?OG1TPiPZt+6qU2QQHegMzYk0lUSKuy4PIJVNwYlrBV8RcZBAdr4u/tzAEtRw?=
 =?us-ascii?Q?EgeGG6MsJ9QYFGrCE4/MZLdeaMtoET++iGqrcpvGsVcD0BuTeZz/OM3qeRCs?=
 =?us-ascii?Q?VQobJ/DgQWjpjac/viIbwlWvsXwDzNr2YO7HGCPOn2VOQTCpCIZ1UBCFhZaf?=
 =?us-ascii?Q?hAvS63OgpZav5PnMmwuP5y+Q5bsJX8OIV2XQDEzDfsEVz/0G3E2ucOJrKLNM?=
 =?us-ascii?Q?pR3mTYACCj3KALcQwWAsNf5j+QWMhNptiZl9sPW/5XQuQdavceC5qXCnV1R7?=
 =?us-ascii?Q?9H0afHx9uYeR4u01fxXAT4HIrHrOIRH84vn/C296TzvLce7oz1/fb6wx71Ka?=
 =?us-ascii?Q?KuKHVY+6csExXGesOdzJOtH4gn0jCwJElvlhPcknVn0RGZ6HnUyrbqICrnNI?=
 =?us-ascii?Q?OGuHMBWjEegzfvl6wggBXC0wr02v8W2b0l8VsWmUghA8wMBZ8DnibwaBLHI6?=
 =?us-ascii?Q?273rby7frca3FvL9pJncSCdmeIsxRm6oY04aPDLnbUfP0ZQ02mOe19OVvc+o?=
 =?us-ascii?Q?RWwUFyLtOXNY6HbhSP4/SedZyU0ktUJO1cupffHFODVJzHxXUnjr9jGhrBnF?=
 =?us-ascii?Q?AdgB3rXbgvSdUWClIWKyVKcYh6iApkxNdWTaFT0ZV6/n0ooU+LNX4ozx7bjM?=
 =?us-ascii?Q?/6WyRpw1AXf4399ucQFqRaysnuy25a5aQH5PCM76dYrXVBdPPT8FjHlyTpte?=
 =?us-ascii?Q?o3HqV7AiWsNn0IpUNHKqMrzt8qZ+9jjtMpv3Hn2Bm4qexVgKwM3Tc9MvnwGC?=
 =?us-ascii?Q?pGDLbtZi9E6FwXORP56I7bJcCWimPnEwNlBvrhDh6/SpIsfzZ4XYv7Dd8a8O?=
 =?us-ascii?Q?iOLmJObZQsE9NNsgWRv01CLiVU2ylk6JZZJ4K3R1Rb5OLvYST5x22LlT5GVW?=
 =?us-ascii?Q?LAQOt8x4K9QRH8G6cv8VWeMPL0VzF9ncYRMXMdfbHGs98A+AG//I1xhoRPcD?=
 =?us-ascii?Q?SZRLFHoW6QckMR7ScZxJ7fDgluzV0o17Wu+DZ6U7uLU0R34csi9iWXfpOkeY?=
 =?us-ascii?Q?ljiT+lMwA+63NA/JPTq5dM66e5RKelyXODvrFaPgtmPfCmAg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9d01da-28de-4d9d-b698-08dea805d4ff
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 04:46:53.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eSJgHp3ObgAIlGgqpb0afvYebbjDZkDHM/hf23T4PwBi0sLPCqaDJY8+uBsBAxKEQ3SmoI43bNmTYJZ9zYTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10792

On Fri, May 01, 2026 at 01:59:49PM +0000, John Madieu wrote:
> The watermark search in spi_imx_dma_max_wml_find() reads:
>
> 	if (!dma_data->dma_len % (i * bytes_per_word))
> 		break;
>
> The unary ! binds tighter than %, so this parses as:
>
> 	if ((!dma_data->dma_len) % (i * bytes_per_word))
> 		break;
>
> !dma_data->dma_len is 0 or 1, and `0 % x == 0` for any x; `1 % x` is
> 0 unless x == 1. The condition is therefore false in every case
> except dma_len != 0 with i * bytes_per_word == 1, i.e. i == 1 and
> bytes_per_word == 1.
>
> The loop almost always falls through to its end, leaving i == 0,
> which the post-loop fallback rewrites to 1:
>
> 	if (i == 0)
> 		i = 1;
>
> So spi_imx->wml ends up at 1 for essentially every DMA transfer,
> defeating the entire purpose of the function. The DMA engine then
> requests service after every single FIFO word instead of using
> multi-word bursts, hurting throughput on every DMA-capable variant.
>
> Add the missing parentheses so the modulo is computed first, then
> negated:
>
> 	if (!(dma_data->dma_len % (i * bytes_per_word)))
> 		break;
>
> Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA mode")
> Signed-off-by: John Madieu <john.madieu@gmail.com>
> ---

Thank you for find this.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index e5c907c45b87..7ae8078c10ef 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1836,7 +1836,7 @@ static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
>  	unsigned int i;
>
>  	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
> -		if (!dma_data->dma_len % (i * bytes_per_word))
> +		if (!(dma_data->dma_len % (i * bytes_per_word)))
>  			break;
>  	}
>  	/* Use 1 as wml in case no available burst length got */
> --
> 2.25.1
>
