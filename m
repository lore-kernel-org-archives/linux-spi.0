Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE223A6B6B;
	Mon, 11 May 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486371; cv=fail; b=GK+wWM5lnNu1oGy1WR+iKVwVHGyldyl/yhywfjlfjD3fNxvZLohSTm6hsSzVodSrSMQZ/1T3xDnceaV7/mw5D+J/COV8BV5CfCgxH6ul2G7ex7s6XUZRKCEvlyye4zWHTSAKROKzV/mB3/LARDQVbLkXE15G7GobjEEG1O5qxsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486371; c=relaxed/simple;
	bh=7to2BBq6ZiTCdDV4ci8QCYPqZdwVgSc2dZ0oaI1RRrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E2lKf2HwU/GBABLsFAOPvk1zddKh0TEgi/hFfFBjE8xAV32vHxWIJyfLQxggrBhJVRKMPl2QdtsScpvkvoIwc14nRT4GqZwX43InhfjvIG6Ctz0lGDaRKJYwDgaHzbGdSAVxHyNMjgd13ZQXvZ7hRN9nt1sEC2YmQ2ryHtstHl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f5WiGPBz; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f5WiGPBz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VN0e09G4B7xOoK9PmIUnQAekjY6fmNDk/8dmOmBkkVFYF4Iovrju2zDd/QGYWrpazhYI+X8OC9i5z4IAHTzbo4stv0vCJpQbnvp2W+8hsSjRLJKKPTXXw6UAOdMngOzLtaHwSBUgeu7cXlov0jG5g+ozU8wOKe+SNoMc7gfhFRSYyoPkn+exGJIERSkZFZMpXili1bKuEsyT3Md74I7KO05UBEJz0ozZXvic2eLC+TFybcQXaQt7bwbtkvhByddazGL3NqcLLLcbJ/2C0eeMKC3QntIgSmBoX1siDOA7XnBkWU74ON9lN8X6XJNO3eHXt6tpH6Hm9Ubt4OUxFi0UzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhf7Va2qE03OdWSTRymUrEKa4aA07ZjN+UxCUbh/ouo=;
 b=eJw7HbWNVe0Rqhh6KvxDXntDX0om0N5rnVg2pE0PkunlORbIz8C+HfDs1/iGyctbo46oAk2mUVrNwv4zYDMttabTcd6MzVkeNqJtsN2+kAAfrLCTeOkQSGLb8JJdcTor4SgdY8it2+To22iMMD6ZK9gUp32nHUw3pX10CVLp3gBpmyuaMrJAjNgtIOO5d0DeWYWTw5lr4iXaVtfiMWPV/2VIn+afKXgnpi+NbHFjoBLkX57BE0aKVFdFrY6BEL0+sq4/Rmt4yC80pP4VQfqsyepJ7GWuRJIlzK9XJW+a/BP2SfmEDQySuKzCZEfJH26zhELX1a8CDdt8mLrVEGCqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=163.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhf7Va2qE03OdWSTRymUrEKa4aA07ZjN+UxCUbh/ouo=;
 b=f5WiGPBzfxG7HhljsWhHTDdWLaQdjDl9BLNqmowtU3+NMA5t7TwORnfuB9pDWO+plY9ERZKDI+s+K6+eDfIuvd6Hcdu7MUwKbYljbalY0nkwrZrGu+zp0RdUvLUDwLQXxyLsI3gojI+fuPXwVuaKqO7oTog4HegKmj5AJWCevZ8SFSc6LjYioTYPBEIYXEerNbY2H7vxqjBGAmZT3yT99Xxw56sMxPMAaEAJ8DwMfFVWvVQN16Tu5XM7G06lBWBlxSvh8N5NWZDZlD50IVcqNP1ztuNdt55vf0PNLnv8tjlgqVH36JELH6weFGeUCCYjur6+oax99g2M45Td1YTRNg==
Received: from AS4P195CA0054.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::14)
 by PAXPR10MB5759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Mon, 11 May
 2026 07:59:14 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::5c) by AS4P195CA0054.outlook.office365.com
 (2603:10a6:20b:65a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 07:59:13 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 10:02:55 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 09:59:06 +0200
Message-ID: <283c1eb1-670f-45f3-bd33-dc8f9b0776ed@foss.st.com>
Date: Mon, 11 May 2026 09:59:06 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] spi: stm32-qspi: Use FIELD_MODIFY()
To: Hans Zhang <18255117159@163.com>, <broonie@kernel.org>,
	<sunny.luo@amlogic.com>, <xianwei.zhao@amlogic.com>,
	<neil.armstrong@linaro.org>, <khilman@baylibre.com>, <han.xu@nxp.com>,
	<haibo.chen@nxp.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <lhjeff911@gmail.com>,
	<hayashi.kunihiko@socionext.com>, <mhiramat@kernel.org>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<imx@lists.linux.dev>, <linux-stm32@st-md-mailman.stormreply.com>
References: <20260430155456.36998-1-18255117159@163.com>
 <20260430155456.36998-9-18255117159@163.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260430155456.36998-9-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|PAXPR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: d4230464-567f-4e52-4786-08deaf333156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	QHePOoj2iWA/aL0ExawxzWdh/fbJ15lFYwGI9d4DTWAvLfhf64BGGg0AoW9Py5tKdZeMg6ayykY8NA/ZJxQDTjhzvR4Ci2bvxNzgKUBRalNhi2yxgUbAYr5G9kXL2ohzQqzJYTSw3e0rt/3L+Nsplm+oBYvhO81G0Rc5L2cUcXT2DXEv5a4SoC6FDCvZ99YiHtvlJ3CnykHQ52GQOZif0EooQijjjoxXRnHSJ9tBGegFwga3w4Ulggm5AJBz8EcX5qKFi6415HkKv7STlDqEFPwzDUkG05QOoT09SMNHWcXhBo63ZvPJtWD6IWskhk5w9aKtULUgCJ6y1T6G6ZDKk3jk/WOFWtquXEPVUl5BQUfDaSfVt13XuqR9u2JfwOl3Ki/SudF0gtJ8wp3GFJ14B7KngWE34lgwWa+TtZ/Ix774wZg5ZvWFMbUCEGfmM+qgfp7goC6DbWQ9MNjdV1HPQ9uhpjBFi/MC4cloApoZg/oexEY9sndxIFJtMAN35TUD9vWN+8X6tkub0WJX+tRSRzZu5L03UEp7cniIAe9TvWWU1LJ/6O/udMVlqMfxZzNGtmWhutR5iZRg4jyjDlQihK0lLHEbaJ5/iXtyDZsskMnGzSRIPx/gQlbjGOMDtj3/xjdjcJik5AQy34mQW8OVUilypEqx4daSgF9FfjK+EVDXPVimVjOuQ55OrS5vdxcBMr29+cdf1EvXC4nFC7OgKIcKY1L6yZqV3frMuHm/xeaSpyKc70BLiEwRWKIr6mTbVchI06pOujBrsn58glN1LQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H8dHFFV1T5EiTXwr2V3NJuxotUURbZpgQqzjf4ph0BGBy5Wcy/Yt6Mlu4n+QpnSwgjDD72LW65WIr54eV0SaLkZUvejWcZzsdKUc/rcxUJTroWqUiFjBN2jy2XIMq6xU92zkCvUzt10BZ0Ky+Mt5Qfe8fCfifRf/m1VOgSs5c6vJdZROZvsp/Gm6FaHLhezvCbLOp2Y2HBnsOROrreARUmfKu49s0zBWdmMCwVcWrhRSoTz6huC54urtaQ/hxxcdU1sdwkka1d1qKhZjevzULXq6ixGqHEZE4lmaCc3uCwQLlFfU2/VbHBPnPjlANLMpn/Tv3AI2idlAaYs08k6XcUBfT0d3RTMDXqH65mG63XOoILsc3yaykYIO8EbtW8HZOWf7UTkNM8PzXKDZf/q861bJJXBNT44nltom7NCnf0uNfZddLLxHKHcjDMI0+bSf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:59:13.8191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4230464-567f-4e52-4786-08deaf333156
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5759



On 4/30/26 17:54, Hans Zhang wrote:
> Use FIELD_MODIFY() to remove open-coded bit manipulation.
> No functional change intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/spi/spi-stm32-qspi.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index df1bbacec90a..ea69fe25686f 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -374,9 +374,8 @@ static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
>  	int timeout, err = 0, err_poll_status = 0;
>  
>  	cr = readl_relaxed(qspi->io_base + QSPI_CR);
> -	cr &= ~CR_PRESC_MASK & ~CR_FSEL;
> -	cr |= FIELD_PREP(CR_PRESC_MASK, flash->presc);
> -	cr |= FIELD_PREP(CR_FSEL, flash->cs);
> +	FIELD_MODIFY(CR_PRESC_MASK, &cr, flash->presc);
> +	FIELD_MODIFY(CR_FSEL, &cr, flash->cs);
>  	writel_relaxed(cr, qspi->io_base + QSPI_CR);
>  
>  	if (op->data.nbytes)

Hi Hans

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
