Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058E3ACA5D;
	Mon, 11 May 2026 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486439; cv=fail; b=BvrJfXxNg41OgT3f/QyvCe+7t7xYalyVfR2+MFU0xPwcw0jwd0BCm3Y9XhQ0qi7MPGD50UZhuzALluxrMItsXV43lBbJA7SQkf5mUC0BeVZT5AufilNtr8+i3Oe0pPuDxwnjue3v945s8Vo2a6Abwf+8a2NYMN1HEat2/Wio1Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486439; c=relaxed/simple;
	bh=hHUMCzYy/5XLNjXAkYJMgPnftcER9LdpZz8KlFw8dWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S5+tsrZb1rWU9yYtMDVDA4SYAU5Mq96KindtcPIIeZCIJSkHHFXV8HOSxpA0oZJRgLHyHOXgS1KqAwu0FRNd1cjlxh/dJdJ1k1QHeQ242maj6Zes9lVmfwuaq53zwsxMUZCPklNgs3bXL4cm74uaSLBkM9OrihdQfhCzkrRSuaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bYpS2M5Q; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bYpS2M5Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow/jVZL3GoIl+c93iPbYdSQvxzxsLubDtBwNyUwmtUnpkfi8DKzdthzm15X/eodfEJglfws+nPp2V0QxGpU/ITa1uX2/GMihppv9LYULS/04osF+SlGgWCeeBEWCJ+0MWqgUEX/SPZYUyffro37q6iEyTUwPP+IaaDcqN4kOJKrFCb2SSukgpENKVqXr/euv0pwfPUcHgp59aC9XBmCGaBj1Robv1aZQsjT1D7JQdwD7ieUHiNzaYp9SB8vrHR0Dgfh22If9azFR2d6xNUnq4TEzZW1KV0VxoVzwjwV6ws6gjf1Goah+gT+xTgQk8+3E9D7bbjyYgKWgHfgat+O40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5r9Q3EYcCO7i6tMHGCp//y/9iaflG6MqzqyAatSxt58=;
 b=bydxGoCUew0fK9DwIyRqvaLEUyVfD+tSQCa6ksva1fvaof1gee+4i7cBnAfBYNaUrQkeQAj0v1mJeQjnoyQZOwzp82XvGHqwuMabQndxuFSxS6tKGDpaYUg9LQdEE6V3Q24FhwezVi4CSjD3puw9TE6KDfln++2uKOwuzO/lhO7+vG4o+wndtE4o00myX1gMcZMIOR09L47i7NzSOyYdZEhk2bR/B9PA5Y6Ntr8EO5iinemh0mopF7TqXdMN5FwB3Iuc+Ge03JDemc8ITfK+YSu3H1B5mtlBXG8RFfZSCtfZuieylavsgYfEBpPgW2dod1aPkdxbQe79COHxATb9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=163.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r9Q3EYcCO7i6tMHGCp//y/9iaflG6MqzqyAatSxt58=;
 b=bYpS2M5QgaWdtfmN3hjk/wvKzjvlicIuxsLDfa+3H5sVJ92ShVHQLgv6dQeinHaXL4nW4lUiRjfgUo+4bEwtcjYJ3Seyehly+P2m5wMHQTLltNJdgRLZNq72ohCyWcvTkOA1KMGI0AwVtrIyLT4xkAX5c+019qNsAriKhAcMqJSG+YoOxs9rN1COGdevdKjprjO6XK/n1K67L2t28HvgROLGoSj4f/u64/DGY9exZTYAs7H3xgCo3FiDT8WrTHXFkqioyP7G+3KnYEWlemKuG5RfuyYKmZoeZaqK1E0g/USGWmfJPn45C0x9Zr6nvFuL4FfuZhL7dcSxdUtjYcLM0A==
Received: from DUZPR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::13) by AMBPR10MB9883.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:75e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:00:23 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::bf) by DUZPR01CA0059.outlook.office365.com
 (2603:10a6:10:469::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 08:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 08:00:21 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 10:03:44 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 10:00:17 +0200
Message-ID: <4e9c1ede-d42f-4894-a3d1-28e095903f6e@foss.st.com>
Date: Mon, 11 May 2026 10:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] spi: stm32-ospi: Use FIELD_MODIFY()
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
 <20260430155456.36998-8-18255117159@163.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260430155456.36998-8-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|AMBPR10MB9883:EE_
X-MS-Office365-Filtering-Correlation-Id: b5af85cb-2e09-4064-f597-08deaf3359bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uavQhdDhnLa2uO0ANj2WEDNU+AHiOHrbECtbFNtqrDeEE4LzfIDUJqY9X+gDFJ5U3EIkWXjNIQfblWV/Hk3Ur5CqoFgem/+OIqWlFRU/3YUYmZjfXggT/h9PbteljA0QigspAkj6+nZyuP84DMc9ozmfcQ6zPeQrOVV4yUT07KkzZX/918QmAb5gyqjEes9q0DG0CrifcmNshGL6F+/kxjvw/f1L4dXfXwAUw0YJpRXMChkf6YgjP2YxIgw949AtigX9gIzoyOLTnuKuqeIY9o6MaZ2tarPRf8SKf+wGraDmEJyKKuzsc6U3o1GsNpnCMMkE/HxHrRbVBvBKovfVxV8DYTIgXiWmEz3axKEs1lIDoRs1PLG+AjEcQR1zW6o1+qFGJTqeKY1eV9J4yxqD8WYqIxK8+PPAngUI8/lYAOaCuGYJEJZsy9d2lAD1JuAMfGPlzLeqObEb9njz11lz6dZsRJ7RnkUmCSuavCW78hUDBI1wltxQwscEEYSjoXtUdmmhdnp+cVN5ewNn4kEP6ygJIcuXnH7gprMISCctcqwy52C4iWfLBmhxm6AKxNH1FrbqpKeRHSOiUM+dBHe5y/ha/St2BQZ7T8j6O9Ph2TtEnaGRK2lVZRtYj9pSlycfq0Ey7owMkIJngDWsr2vZt6HNVhED+jJzsriYGZbDX7iIfckuzv9igH5veJ35nFPCQTil6m7qglS7IN4zQhKi6XcD48n0ml0RvqhAb2tSqZclmLy/zZU2KaNkffAQ0uu7TOOOURithrRKnfF6codmbA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FfYzux6GJTnoi4IRxf6iSKWv9F/oIRg1z4tIfZz8H8EumIUirKksgf3ofeiCc5QO2Zt5Tfm8m28JCwks1BXPf8Q1DDlogt9erfx2kf6USO5+IbHaWxJs3JNhG8BJYb8fXqgS4uAPJxn/aioXqyYiussiJUKGLV086NmRVltHCKuImAenzsfUl5BG2R+sAn6GyazlHPZqfYM7DQ5YcDHmMEuZAv4vZWkmc+3CSnn/AJ/FTdzgn5qp4iErYb9WLSOIaoW7N/5Q6c9anYcDtI9uSLIm7x8cPPbQWQvq4hvI7VkaINUV74jTwVcEAG9lzprKMX3ppiBLIsWAGY7S0A1DEZsk9o5Qq6GI+zj3hrj4Ne9tZJ+4sYICi9TlnnD9dt22yTEDEGR5O1XbSJr4mkHlla7QD8wTxCDDD+ntKKIkaBkM3w+Q51R8qINeRr4wtK4d
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:00:21.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5af85cb-2e09-4064-f597-08deaf3359bc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9883



On 4/30/26 17:54, Hans Zhang wrote:
> Use FIELD_MODIFY() to remove open-coded bit manipulation.
> No functional change intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/spi/spi-stm32-ospi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index 4461c6e24b9e..3757f6ba8fc6 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -470,10 +470,9 @@ static int stm32_ospi_send(struct spi_device *spi, const struct spi_mem_op *op)
>  	u8 cs = spi->chip_select[ffs(spi->cs_index_mask) - 1];
>  
>  	cr = readl_relaxed(ospi->regs_base + OSPI_CR);
> -	cr &= ~CR_CSSEL;
> -	cr |= FIELD_PREP(CR_CSSEL, cs);
> -	cr &= ~CR_FMODE_MASK;
> -	cr |= FIELD_PREP(CR_FMODE_MASK, ospi->fmode);
> +	FIELD_MODIFY(CR_CSSEL, &cr, cs);
> +
> +	FIELD_MODIFY(CR_FMODE_MASK, &cr, ospi->fmode);
>  	writel_relaxed(cr, regs_base + OSPI_CR);
>  
>  	if (op->data.nbytes)

Hi Hans

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
