Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887C30F52A;
	Wed, 10 Jun 2026 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071457; cv=fail; b=HmNhdM5LCnd8kQv71Q42GROIZ51oEcodv3GlZUdKuFhTQzy76P35jTQ9noX1llZONMtRb9qDh6w9mR4kI6qK3S8cUaQ73W5nBpNU6SEe73jDCPDIwLQTN0ZFSSYyG+EWszDIGmDnsMCQ9BCj/11Qh+hHkPCBz1J9Jd548RRNpag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071457; c=relaxed/simple;
	bh=CUnH5Y3GpS4D2t7v7QFBDZav4kM32xswk2Ih/9IvqOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5PWpZHSs+fIOnoTnYEmv4AQatMxHm7gBcqAAxFhx9aHsqASpL6VLurgl8D8nlCXHVmzGRUgamLsEAPahTJQ5eyk6zkb/dL6xuX9zCZGEzBaMj1o/0ryXNttmf78cfBYasfeQn6BvOjOHezVdIXx0plITOUNPM9ZY+hF5KbmfK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CZN5DPwQ; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CZN5DPwQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji4J8s0kgBiNigsKsmO1DQCzY9Tdjah4I6Plv6H1n8o28WlTpUljMrfcz54b86C+0cLDVoSTZZcudBHzqP4VUqwuLjnUV7GgMCvn8fnpm928sVxtBgHimTfZmVvHICp0gfhSsIxOM9eorvBTTTw4D8bAXDbCz01nE6JytsmeQbcbiUjZsrvHcMUSLUCE1ikK8A2qAMM3QcUguigrFJ8gLTAPqQEiX4+4/3RjOp9GsEbvfPiIcfNXTVGGqOP1wO1/YCpJK8Ahiz0Ya2vH0oDHcD8UCQRCbYOydN3RnUQOpmdch9RKsTmD2Srl3C0oRGXPLS6ph9klc/Ip10NV6XoX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2wYctGhvHUYpx/e55D1f8fLtTx8UqFjX1vOWQogrEQ=;
 b=KDbk4hKgFsJiM0SI+F7wB1ZTHO2KxweRD+nMnXplHYiR2uBPRmYhtk7v4GPC2TIpa/5eK4wzOUmDDUOAA3WVaTUhOpYP2jHFKtChFY8fNy1UwBIGvQUyXienrzq6doJXdQUBLGd+C2adB2bCyGyKNxTW6ErVuwFJe1jMk/p1kG1PvjuXEe2GxLyfnDQGI5xLONTKJ7ZfTveX2YEO7ki1DZEM+ye1UNI9QfmTY332tWf1nQu2igiyfBm+k14ZL84yAnqmJWf7GHcRAYCkb7ST8vZ57MUer0McMgMZ3HozZjeORlX9iDrClP62C5gWG27ZIIK8lMm8Ytseh0olEsSN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=winbond.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2wYctGhvHUYpx/e55D1f8fLtTx8UqFjX1vOWQogrEQ=;
 b=CZN5DPwQ5bLg2Ms1QpunNIpzhJQecRCkqodtMryDCONOTKJeyKSHiK8bNyqNYhbyPEh7mfmzY0QLY1lFgfvTwdb+I9JtAb2cUuerqN+lMym3Suo8ooKimZBdyaSpN/OouFg4lKH1gKGGS4zofxO6/bHCU1vyCYfd/J4dV38rJvg=
Received: from CY5PR17CA0049.namprd17.prod.outlook.com (2603:10b6:930:12::33)
 by MW5PR10MB5851.namprd10.prod.outlook.com (2603:10b6:303:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 06:04:13 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:930:12:cafe::69) by CY5PR17CA0049.outlook.office365.com
 (2603:10b6:930:12::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:10 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 01:03:47 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 01:03:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 01:03:47 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65A63hWs3229025;
	Wed, 10 Jun 2026 01:03:44 -0500
Message-ID: <d60a2a0b-a548-4cf2-8e0a-5f8be066a34c@ti.com>
Date: Wed, 10 Jun 2026 11:33:43 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] spi: cadence-qspi: Prevent SPI NAND continuous reads
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
	<broonie@kernel.org>, Richard Weinberger <richard@nod.at>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, Michael Walle <mwalle@kernel.org>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Pratyush Yadav <pratyush@kernel.org>,
	Steam Lin <STLin2@winbond.com>, <s-k6@ti.com>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
 <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-4-0d626e1dfb2b@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-4-0d626e1dfb2b@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MW5PR10MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: cde0eae1-7848-4c22-dbc8-08dec6b61726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	665be0CY5HXcG0JraWYr113MTDAqdpbd8pOotLaDCK0TuxPMu4ouJn+uG1D4N/MzrhGzlz0E6qJgjERTFFAuME5oBhvQXB9qTS/AX19YV0EOk6gD9S76TbCE/B+fe4q0fTHaZudigDcCg+aDqdSLtDxaabNBkY98mDlJYqz/ubExPUYlavbcuLhb/DPWdNDS9MSwE4jrloN+0ZmDuQY01F3A2RTkzOio00qaDzwY7lr+Atzx0NBavqT5brb930gPS3L+67SPrDzibabsY/Fna5uH4dlWloS4calWd7/ePM4p+ox6E+r9AxOJOxCfUfpGVdvuitfHtjn1DyegFJef0jhnOfm+Prs1lC+krJCXAav6omEnMA5yoGj0pqcCMvIt40i4tGa4LAwdZb19zU1YPa57yCRIkbUsYkSDCmvzH501UukXSAFMXpD3PDMv1IZf7Io/+iWxFpkg3iPlr7Z0qP0Cny+6pQ1hHlIYoyeKH/ohWxU8+1BvMwrea7IX7SVHd1j0tuTcY8tTzwuQsElEwN1S4QHF1Mn+nyf7IvQtUwGtaWfcbUEgo0oLzS/GGW1FZeFyGGypQlCYUyJKiop8Tl3MPqVP9I0mrtn7ralOijllI44iB+FDcDAz5NPG2WhSb3Xu2+diAlkEFt7stvQvTAu7sd/1k07l4OBACodDe6Qx6+1XTMRxHFkxFD4UIGyHJxcgXkz9IP/7XaPf5tiYD9tVQsAJ0TV1gl3IQk8xdEY=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4i6Xp4YsmOUsGpK5UukG23CkR24DnZalo3G0KDmu76tmzpxrcz2C3wXxn4FyVFve/ogtKYSfpKDlbmQHm2e8QGHo47WfOqyY6/3XLRe0EIjz1ki8YKb2s4+3t7XHrCglxggXH118rxKJ7wqX5i6Dq6y9Y1CCqHkrE/udG1PCt8qxHemhDZ265rku0K6RygdIAzefPSx7W8t/ZQ9Y6dVZUw0BNHyhYoaEFuVtJgzkaiiM0ZuyzjzaOZBzh41jz3VcyTGGhNmVXVcjA359Uj74/3Gq2rhn64ANs9nraJuBbFQix/8XIPzR3NvrC4afMTy3d0yBNrisFifdn8Quuu22FAmcNs46IWT+dfZrNt8V2XoY0a5IQHCoRMcF1HVmsft+YZmhB4Ywq/6IsTQSbmRJb89a6AbLtR/DSW08dMkNFhf7izLSXyP6/MjY2Ay/nk+9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:10.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde0eae1-7848-4c22-dbc8-08dec6b61726
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5851

Hello Mark and Miquel,

On 26/03/26 22:17, Miquel Raynal wrote:
> TI AM62Ax errata i2351, entitled "OSPI: Direct Access Controller (DAC)
> does not support Continuous Read mode with NAND Flash", explains that
> the CS can be deasserted almost at any time during a transfer (basically
> there is an interconnect arbitration every 1023 byte). This is an
> expected internal behaviour of the controller, but this leads to
> spurious CS deasserts. These are totally forbidden during SPI NAND
> continuous read transfers, because they indicate an end of transfer and
> the continuous read is then stopped on the flash side.
> 
> I initially tried to query the flash type and geometry to decide whether
> to apply a spi message size limit (there is a spi helper for that) but
> we cannot reliably get up to the MTD structure to discriminate if it is
> a NOR or a NAND we are playing with (it is not relevant to limit SPI NOR
> transfers, they are not affected). If we actually take this path, what
> limitation shall we enforce? The errata mentions 1023B, this is super
> low, less than a typical page size (about 2k or 4k, for most of them),
> so this is not usable. On my side, I only observed this problem on a
> 2-page read in octal DTR mode with more than 12 dummy cycles. The
> writesize summed with the oobsize could be a relevant boundary, but it
> is still quite arbitrary. Hence, I opted for implementing a controller
> capability flag, which then is used to decide whether the SPI NAND
> continuous read feature can be enabled.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Just to confirm, has this patch not been picked up yet?

Regards,
Santhosh.

> ---
> I do not know if all flavours of this controller have the same
> limitation, or whether it is integration specific. As I only found
> mention of this errata for the AM62 processor, I opted for limiting the
> flag to a single compatible.
> ---
>   drivers/spi/spi-cadence-quadspi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 649ff55333f0..9f9b3013aa5d 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1740,6 +1740,12 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
>   	.per_op_freq = true,
>   };
>   
> +static const struct spi_controller_mem_caps cqspi_am654_mem_caps = {
> +	.dtr = true,
> +	.per_op_freq = true,
> +	.no_cs_assertion = true,
> +};
> +
>   static int cqspi_setup_flash(struct cqspi_st *cqspi)
>   {
>   	struct platform_device *pdev = cqspi->pdev;
> @@ -1797,6 +1803,8 @@ static int cqspi_probe(struct platform_device *pdev)
>   	host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
>   	host->mem_ops = &cqspi_mem_ops;
>   	host->mem_caps = &cqspi_mem_caps;
> +	if (of_device_is_compatible(pdev->dev.of_node, "ti,am654-ospi"))
> +		host->mem_caps = &cqspi_am654_mem_caps;
>   
>   	cqspi = spi_controller_get_devdata(host);
>   	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi"))
> 

