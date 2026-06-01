Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D8349B02;
	Mon,  1 Jun 2026 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303464; cv=fail; b=a9dNgEfaa3th6HhWtMrrJr1EhGsxa4tKwFvYxOo1Y/ZG6gFRpKNn9PnUL5vZxECMXgvd/b6ocA/EZE+YmOo/1HRmdUbb9j6CKiROiemPLMRZXvCxAsXTMtyenlJuRyZQigi47tzR85hkXV2hhRlb8cFOaqUZAPD32/q/pYfBezo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303464; c=relaxed/simple;
	bh=ZTgF1p5MaES8qGpMxXsqIe5u+9wl9hLoPBCF5XG1A/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o1krhX6uGZmY+ZZiXOUkSKNdP+NV2CBYcmTV/cG/JLRwubT4LgsFxbgzn0JjKmv7kgrtAwgJWmT4gc3xHa9+cqErsRckMffe2tQVZA9yzoAALoqM+cnnpHuEIVu81UmILfRQtQazC404TCwcJUKOcbMrJ2Wrwi5+Fvk0y8LIWLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yw3aEwEQ; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yw3aEwEQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ccli4Arq6rJwt9rKoAg0C9RvfSaITotn7+GmxU8HaQMuh5SELMsUBriE98CbnHtiYAgf+zYLWT7FTGnZ7QghNNSjzw1CLOE99GXHWceiSj0q+RG7woIh0ah+rDsy3FYDb4domiIkwAlIH50iRjdzxXOjoEjCCV/DNNIEhc/H8j2XEgWnTOAz2DcC1nkxjCxoq5VCZi6+/4nNmfnk4kT7dOUF0nwdowixXovFZUDGe8d1uQyMbj+xz4q1gJh8qwk6iflGkEVMQyEr3kzIKRttxXC0BAMF+5vzeqf25Lzwes3dqt0GQ3kBaE37bk4UmcGoWBd4HBrKvTm1qFopN+q7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FjE5DLCg4pDH0WIJ+5n9VOR8CzHH3iLvvRyAFUOgkY=;
 b=VMBi2hA5ggo/7+dMheoGEL9daYoSG/h1++Yt7556FHIlW4t862XzBp6Kpik9EsAMjlcc2GyeyfYGtVWXVxTxS/iSlLqTIcpaxAmJKSV5x52iQeyPrvvDoR2Z25sNNVAWvi7kgmcLNFwlspCcwJ0cG5Y6Vyr0UaqMNURb4p6b1xYMK799397qSVsZn7KHP8bw/XfCGc/VSzni3T0rVL45Fji1k4uwEEh82MCrjPW8YzkEEO/AXY132bbRvdT9LKVsSJE/gziWtVe9sVooUVxUlNVCXt8lrBfTHB/KJflnuGaDzedW2Vjdnp7cMYL7K5akHpZCjFk43vFlruT4SFxHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FjE5DLCg4pDH0WIJ+5n9VOR8CzHH3iLvvRyAFUOgkY=;
 b=Yw3aEwEQSgfBH0XKSbCkmzr/7gEeNvIiPoLABigwdJWTqcezbOjvXwo7GpoXQg2CaUdp6Vv8412D5OMdviDwLbFmeH/d6cN5llYoQN1u0lylahNtLG4az08yRw1DegK9zmuGbWsrPQ+MHnZm+cDxHXSleOKVH62vRgY9OWyrjUI=
Received: from BY3PR10CA0019.namprd10.prod.outlook.com (2603:10b6:a03:255::24)
 by IA4PR10MB8544.namprd10.prod.outlook.com (2603:10b6:208:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 08:44:08 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::8e) by BY3PR10CA0019.outlook.office365.com
 (2603:10b6:a03:255::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 08:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 08:44:07 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:44:07 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:44:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 03:44:06 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6518i1Jk647846;
	Mon, 1 Jun 2026 03:44:02 -0500
Message-ID: <d2d6509b-1831-47c3-91b7-f0c4a7397507@ti.com>
Date: Mon, 1 Jun 2026 14:14:01 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] spi: cadence-quadspi: add PHY tuning support
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-9-s-k6@ti.com> <874ijrhq1p.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <874ijrhq1p.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|IA4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd1cd5a-9840-413f-d79f-08debfb9f1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|22082099003|18002099003|6133799003|4143699003|56012099006|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info:
	sYm3/UO9a6fzsX4vpECCKZRbBm1ZPUS28GUG7NheuQZbT0SpM3Ffy3K8h4qLBOjYmQRHIy+T4g4zI31Nq1DSV1HUsm7UzLovGrA7Nk5G3/yC/C/RUQ9KTWpzykCu8oiJc48hPAws8deExkXv8k67MXKo39fWaYCTIEOVGDqJQBHQ7T6amfWUN8ixF+UgTbC/duHSJArBH4PEkOIKhUIKyVsc3AT6+UsKq+BvOayLARIz/mT7OhEaW8FX6iYW8hp1TbsGvfLNKzsX/oyivjgc1TdZsg5J84SdNibspEZEqfoADsZas6TtAuMB4MSgGdFJg5eGJ7hjNbgdKhinW4xD9zsHWpPj/qDwEfeWPiwXEPPDLsVG4NZPFsEAK9sIuwHjafdKSxw59NzglhvInXWop94oY++bR/Exu9ctoYAghywU5rXwR5NNXU4hBC1BH9nhWGaKRfDJMTIl004b4RHopLvS4qBdx8v315k4HWuGtWA/afawr57DswFCec7yulXQ+USb7c7WGgyJlaVV4N3bZBdeDFVBhcUG8SNsrmlz8itkRslDvn4nMIp6O883HW2NukF2cQyYGKJK3mAxGyQvp7vkSJFPMiYhU8mOmvoAzmkT+JOzruYVxkbO49gippb/c4EYojCYcgIubTy92BLYabb3loNW+xPR/d6itrdmPvViettvKjg8Ac2QpmjLbrQNKkxp3QIGiSCiyYF25l9xQ7JII66s9wCaQIcmDt/ZMfM=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(3023799007)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NqCSbkAa0l5CwiQZCSpGiiZw7tx0OhstPWr4hcuN+wB4etzuEHTj5/4pso2dW2auXTHu0e4ZbqCbLRoetdpNbnDcYLIJO+2w+5JkFT/MCKuCnM3xBs10M9lJPrxfoI8grlOAgVNIoT+ZN/LIctqUZuO5pNKdSRNGEDRq4PMx1fcmoKv1BXsZDfSyXM0n6R/oJYVnRjbeSMB5QmT5ZrGTzcFvGcMBg6D31Q5LnerwYeHDI221FHaIlcZvr60tY2nAWEx99fvVe7XZHf7LHpxGCUbGJmEDrt0qjau83ePs4ILb2i/QKuXuRke7pDk5KJBLcGJRZHFGySe/9h7uL7XtKi4oZdcYV1yuTNo7lcOEtptCMbuA5YzXsx1YFEoUrixC5a5iRzOB0x1AhWjroNPyjlLqwuy/AXNhVwQVH+Xj4/Dv/inuHPRDEhOwlyMofsI6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:44:07.6198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd1cd5a-9840-413f-d79f-08debfb9f1aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8544



On 28/05/26 14:24, Miquel Raynal wrote:
> On 27/05/2026 at 23:25:22 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> The Cadence QSPI controller supports a delay-line PHY for high-speed
>> operation. Without calibration the PHY is unused and read capture relies
>> on a fixed delay, limiting throughput at frequencies above the base
>> operating speed.
>>
>> Add an execute_tuning callback that performs delay-line calibration using
>> a known data pattern written to a dedicated flash region. The pattern is
>> either read from a NOR partition identified by the DT property
>> cdns,phy-pattern-partition, or written to the NAND page cache before
>> each calibration read.
>>
>> For DDR protocols (8D-8D-8D) a 2D sweep of (rx_delay, tx_delay) pairs
>> is performed to find the widest passing region in the combined RX/TX
>> space. Binary search locates the gap boundary between passing regions
>> when two separate windows exist; the final operating point is placed at
>> the centre of the larger region with a small temperature-dependent
>> offset.
>>
>> For SDR protocols a 1D sweep of the RX delay is sufficient. Two windows
>> at adjacent read_delay values are measured; the wider one's midpoint is
>> selected.
>>
>> The tuning infrastructure is platform-specific: only am654-based OSPI
>> controllers populate the execute_tuning hook. All other platform data
>> entries return -EOPNOTSUPP and are unaffected.
>>
>> spi-max-frequency may carry two values in DT; the second (higher) value
>> is the tuned target rate stored in max_clk_rate. When only one value is
>> present max_clk_rate is zero and tuning is skipped.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
> 
> There are more than 1800 new lines for the PHY tuning procedure. I left
> that decision to Mark of course, by maybe we should move that into
> another .c file.
> 
>> +static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
>> +					   struct spi_mem_op *read_op,
>> +					   struct spi_mem_op *write_op)
>> +{
>> +	struct cqspi_st *cqspi =
>> +		spi_controller_get_devdata(mem->spi->controller);
>> +	struct cqspi_flash_pdata *f_pdata;
>> +	struct device *dev = &cqspi->pdev->dev;
>> +	u32 base_speed;
>> +	u32 phy_offset = 0;
>> +	int ret;
>> +
>> +	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
>> +
>> +	/*
>> +	 * A second spi-max-frequency value (the higher clock rate) must be
>> +	 * present for tiered speed support.  Without it there is nothing to
>> +	 * calibrate towards, so skip tuning gracefully.
>> +	 */
>> +	if (!f_pdata->max_clk_rate) {
>> +		dev_dbg(dev, "No higher clock rate configured, skipping tuning\n");
>> +		return 0;
>> +	}
>> +
>> +	base_speed = mem->spi->base_speed_hz;
>> +
>> +	if (write_op) {
>> +		/*
>> +		 * For NAND: write the calibration pattern to the page cache.
>> +		 * This uses write_op at the safe base speed (base_speed_hz is
>> +		 * still active) so the write itself is reliable.
>> +		 */
>> +		ret = cqspi_write_pattern_to_cache(f_pdata, mem, write_op);
>> +		if (ret) {
>> +			dev_warn(dev,
>> +				 "failed to write pattern to cache: %d, skipping tuning\n",
>> +				 ret);
>> +			goto out;
>> +		}
>> +
>> +		f_pdata->phy_write_op = *write_op;
>> +	} else {
>> +		ret = cqspi_get_phy_pattern_offset(dev, &phy_offset);
>> +		if (ret) {
>> +			dev_warn(dev,
>> +				 "pattern partition not found: %d, skipping tuning\n",
>> +				 ret);
>> +			goto out;
>> +		}
>> +
>> +		read_op->addr.val = phy_offset;
>> +	}
>> +
>> +	/*
>> +	 * Verify the calibration pattern exists using the conservative base
>> +	 * speed.  At high clock rates the DLL is not yet trained, so DTR
>> +	 * data capture is unreliable and the read would return garbage.
>> +	 * Setting max_freq to 0 here causes apply_base_freq_cap() to cap the
>> +	 * read to base_speed_hz, which is well within reliable DTR margins.
>> +	 * max_freq is restored to max_speed_hz for the tuning-loop reads
>> +	 * after base_speed_hz is cleared below.
>> +	 */
>> +	f_pdata->phy_read_op = *read_op;
>> +	f_pdata->phy_read_op.max_freq = 0;
>> +
>> +	ret = cqspi_phy_check_pattern(f_pdata, mem);
>> +	if (ret) {
>> +		dev_err(dev, "pattern not found: %d, skipping tuning\n", ret);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Pattern confirmed.  Now clear base_speed_hz so that tuning-loop
>> +	 * exec_op calls run at max_speed_hz, and restore phy_read_op.max_freq
>> +	 * so those reads also use the full speed.
>> +	 */
>> +	mem->spi->base_speed_hz = 0;
> 
> If there is a way to avoid touching the core parameters, I would be for
> using it, but maybe it is simpler to do it this way.
> 
>> +	f_pdata->phy_read_op.max_freq = mem->spi->max_speed_hz;
>> +
>> +	if (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
>> +	    read_op->data.dtr) {
>> +		f_pdata->use_dqs = true;
>> +		cqspi_phy_pre_config(cqspi, f_pdata, false);
>> +		ret = cqspi_phy_tuning_ddr(f_pdata, mem);
>> +	} else {
>> +		f_pdata->use_dqs = false;
>> +		cqspi_phy_pre_config(cqspi, f_pdata, true);
>> +		ret = cqspi_phy_tuning_sdr(f_pdata, mem);
>> +	}
>> +
>> +	if (ret)
>> +		dev_warn(dev, "tuning failed: %d\n", ret);
>> +
>> +	cqspi_phy_post_config(cqspi, f_pdata->read_delay);
>> +
>> +out:
>> +	/*
>> +	 * Always restore the conservative base speed cap.  On success, write
>> +	 * back the validated maximum speed into the caller's op templates so
>> +	 * that those specific ops bypass the cap in subsequent exec_op calls.
>> +	 */
>> +	mem->spi->base_speed_hz = base_speed;
>> +	if (!ret) {
>> +		read_op->max_freq = mem->spi->max_speed_hz;
>> +		if (write_op)
>> +			write_op->max_freq = mem->spi->max_speed_hz;
>> +	}
> 
> Neat.
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int cqspi_mem_op_execute_tuning(struct spi_mem *mem,
>> +				       struct spi_mem_op *read_op,
>> +				       struct spi_mem_op *write_op)
>> +{
>> +	struct cqspi_st *cqspi =
>> +		spi_controller_get_devdata(mem->spi->controller);
>> +
>> +	if (!cqspi->ddata->execute_tuning)
>> +		return -EOPNOTSUPP;
>> +
>> +	return cqspi->ddata->execute_tuning(mem, read_op, write_op);
>> +}
>> +
>>   static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
>>   				    struct cqspi_flash_pdata *f_pdata,
>>   				    struct device_node *np)
>>   {
>> +	int nfreq, ret;
>> +
>>   	if (of_property_read_u32(np, "cdns,read-delay", &f_pdata->read_delay)) {
>>   		dev_err(&pdev->dev, "couldn't determine read-delay\n");
>>   		return -ENXIO;
>> @@ -1584,7 +3343,26 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
>>   		return -ENXIO;
>>   	}
>>   
>> -	if (of_property_read_u32(np, "spi-max-frequency", &f_pdata->clk_rate)) {
>> +	/*
>> +	 * spi-max-frequency accepts one or two values:
>> +	 *   <max-freq>             - single rate; no tiered speed support
>> +	 *   <base-freq max-freq>   - conservative default and higher maximum
>> +	 *
>> +	 * With two values the SPI core sets spi->base_speed_hz = base-freq and
>> +	 * spi->max_speed_hz = max-freq.  Store the second value here as the
>> +	 * controller's higher rate target for calibration.
>> +	 */
>> +	nfreq = of_property_count_u32_elems(np, "spi-max-frequency");
>> +	if (nfreq == 2) {
>> +		ret = of_property_read_u32_index(np, "spi-max-frequency", 1,
>> +						 &f_pdata->max_clk_rate);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "couldn't read spi-max-frequency[1]\n");
>> +			return ret;
>> +		}
>> +	} else if (nfreq == 1) {
>> +		f_pdata->max_clk_rate = 0;
>> +	} else {
>>   		dev_err(&pdev->dev, "couldn't determine spi-max-frequency\n");
>>   		return -ENXIO;
>>   	}
> 
> Why do we repeat that operation in the driver? Can't we just use what
> the core has already done for us? Seems like we are parsing the same
> data twice (even before this patchset).

Yeah, you're correct, they're redundant - will remove them in v4.

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl

