Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572E382F33;
	Mon,  1 Jun 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300976; cv=fail; b=l6yZtcAGZQ0S7CZzpFzjfNyMTa/OMzXSLobgBh3gJUle9yy15p8FLdG29IpiZsluJQ13ANlqaUPwTDd6wx0WV0v8/YmyWlOIEujHLTkj79nIhAdmU62sH2Mn28XsLXYBQfu4k1lMcekNwNjZxif//D0TnAzrYiRAe9n14VBEW0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300976; c=relaxed/simple;
	bh=SYzCKsAvQitN/EWjYPAp3YkLgoj9lHSu39fZ/PKYkPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rQiASVTs2pcC16odUlhslIEGYjqK2QtGhdhHKjtOc/KbOSfmNKdaTUcnyioYQsmaPe6Bde12e3SiLPcF4XwrftouFZNpT0Tn44xihKQEUKWXGNFg2shnqri1pjVf7c1oGv2ES7aeJv71jp7c+7rXIQNl9Lm6JD2JJeX+N2SQLXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NaqsXh2A; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NaqsXh2A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fON+p9Xef4WbDbaExmZBinD/Qrfm+Qv0oag8BPO24v7ogBRQrPF0NDWxOz6UvKV1x2ghStNXhYmz+0U5nO+ePfO61VzZhoNbPHKwsh+m/Y//0l/Gj5t1a9YwmykFanBnQgILGVLBOt+VYpqE9tQkj80sdc2x5mlNm0LC8h9BjVojOF462r1izshWZoy3esrFaIPNNUINUinoJxIGkIrjjMEQqyGV8EA9J3Mvf9dB9/nKkocjcE+umSHQmTie5+JKPC1CGOHXHzeH8D12EkVKJs5Ylh4CdcG8+OTikrbCc154cUvaJ6DcyvraBatorkTEBYn1FfJaIrbNJiEnUBShDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWl4riFVY5LRwCvmgJjwjS7XsI+F0qOapmZ+/RnS5uA=;
 b=M5L5Y7Hj1+j99h8s+FA2mubuRQaTRpH6ZGVkUi9LcG54qeAeXDN12l9FEKaV0tVru/NbBy1BKs5nhFtScTIq5WoXTOwFgRKn68QPx1CUOb/sxUJnKlPOAyAuXhqV8jkhTm5WCHiqkpqwAKeju6ywrFN3G0KlpkHbflOxSI0yjIEWygFCdvXdMv9hvojvKaxs4WCSuc7Uintk7VmOpWo4pUsWwHZSPH2szjSP2ZjR1LmiuYGGRPRyLFzLrzQm+GZEdfXCNbJkRZK/Yh6USPz+tT7srNKzPiuuuaBZCxvaZWVIeTPfkjcoZ51izA4gY0/gz6PYXK7oTty2OLhmfvqiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWl4riFVY5LRwCvmgJjwjS7XsI+F0qOapmZ+/RnS5uA=;
 b=NaqsXh2ATUEPvxAMvyYGgTLWBOUi5S3Bv7Rh0a4BFgVh8MaPJrF5q9GjmTFpqqSRjSXigAwuX2TcY5HpIDkHTf8tEl0xwzLvJOf59nbQeqfiR+c2ArZSaQp4vMJvB0ctkH/FU2/cHNxb39w3qzrNcVMCMI4BgoQjX8IhPhfAoR4=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 08:02:52 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::47) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Mon, 1
 Jun 2026 08:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 08:02:50 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:02:44 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:02:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 03:02:44 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65182drS1118344;
	Mon, 1 Jun 2026 03:02:40 -0500
Message-ID: <11494d0d-4177-4c6e-9043-fdd0498740cf@ti.com>
Date: Mon, 1 Jun 2026 13:32:39 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] spi: cadence-quadspi: add PHY tuning support
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <8733zchr6o.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <8733zchr6o.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA2PR10MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: f944489b-ff73-4e23-4f87-08debfb42d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|3023799007|6133799003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7zOBOT1Qn5QAIoxjsSGTv9CBkDVEqBQr6y592L2RIkK+oBSTsuac9O3sxsPWD7v/E+9Rl6W26HBsgcts0p8RVrbxDonsZebzX7pzyH+YyeArk5VJaLOWt24ArbdH93BeWmQU3s+a3ZpRrkey14LG9h/vytqsA3s7/9Ej7aagX2KbnUwhWN9ibX0i3S1smD+qnBa/JS17IUfpN3mcCmvJVDvQ+bAo3d60wDfr+WYMlZtMHYkZqz6f0PSS92xyPhaiStocKaW9+AzvhnJqU48TL4+bh8k3PO855eYShSkPhuZFRn2Tg+kjwbHv5NefLodrLTV6wpnCOELO/0gluhn8guQ8k5enlXJAejBW01hBi+MvIhUoMtD0nnnu59zi+8oMohNT2Fcr7ffclfpz0OZVujkcH/G7M013SU6JZHypyfiulasGkRuzVAuXOBX6/BK7avSO9akU3fwWaGdFRfce/CCc424Cp75vkROiyQ2bXUth79NTxSuNxbYPbEutwRSBQbERCUkOgto2x8coxiXi5iDf3mwdbnm+6eQ2fyk/t0U5KlRmeB0RRyMCpKkYY0Hwqxt3BUtMR3ABCE4oiNv0tF31LlXDKLOhSEZCKRCz16IheT+WbQIlqon1cCp5KYqk5ph5NI/e+kQxGfCmxX+0fkT2MHZTX5cGIGHXHp0laNV6QxQjafwbFllsaosnoK1V9qzmF1W/vsvc2kUj/7l1ByxgeZqFyLlzIa5Bz4kbXeBKa0NqzN7JV7Bdk1PU/upB
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(3023799007)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9iJr6Z8ujqy130FUlzmjLWrtHPcQRx8BtNJ03NwxP1HZBLBCfuTBbqzVLYNuzmJpsykn0Vvy2V+Ga5Yl5CsKcrPVFRuATCJMK8LZrHDnA1wepo6Wx1TqYgZiMIy7dJWIjXJPcLBbUlQ2mlBitnD/MwwHG0gmtcvINatUCC9hqJhlrjJ69Hv7M1yoBrAFB+2zcDhkoR0XzqhtSmP+/J0wT8Br8RhzJNR6FSELA1dl/W1cQx2swtWDfseg3pqXnbgPjm0IaeVyzv5HudNFIO2ArBUClEHQ9Uy8VHEnhBEo0lisOS6/qj/9P/7BYNbJ7TntAWqRooNlEugDEqOgjQN/EbIIS0yS/x4/0kpP8/9jD3yr25sdf6Zi4Gx8NqzJ4dbK7sDsO/ArFBZLrM8rUQUMIEXqzGYVb/9fA7KyNeczAIC+9Xd9a7rkhiPfGDW/QPw3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:02:50.9447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f944489b-ff73-4e23-4f87-08debfb42d6c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457

Hello Miquel,

On 28/05/26 14:00, Miquel Raynal wrote:
> Hi Santhosh,
> 
> Very happy to see this v3! Looks pretty neat overall.
> 
> On 27/05/2026 at 23:25:14 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> This series implements PHY tuning support for the Cadence QSPI controller
>> to enable reliable high-speed operations. Without PHY tuning, controllers
>> use conservative timing that limits performance. PHY tuning calibrates
>> RX/TX delay lines to find optimal data capture timing windows, enabling
>> operation up to the controller's maximum frequency.
>>
>> Background:
>> High-speed SPI memory controllers require precise timing calibration for
>> reliable operation. At higher frequencies, board-to-board variations make
>> fixed timing parameters inadequate. The Cadence QSPI controller includes
>> a PHY interface with programmable delay lines (0-127 taps) for RX and TX
>> paths, but these require runtime calibration to find the valid timing
>> window.
>>
>> Approach:
>> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>>
>> SDR Mode Tuning (1D search):
>>   - Searches for two consecutive valid RX delay windows
>>   - Selects the larger window and uses its midpoint for maximum margin
>>   - TX delay fixed at maximum (127) as it's less critical in SDR
>>
>> DDR Mode Tuning (2D search):
>>   - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
>>   - Finds TX boundaries (txlow/txhigh) at fixed RX positions
>>   - Defines valid region corners and detects gaps via binary search
>>   - Applies temperature compensation for optimal point selection
>>   - Handles single or dual passing regions with different strategies
>>
>> Patch description:
>> Infrastructure (1-5):
>>   - Patch 1:   Extend spi-max-frequency DT binding to accept an optional
>>                second value forming a [base-freq, max-freq] pair
>>   - Patch 2:   Add cadence-specific cdns,phy-pattern-partition phandle for
>>                NOR flash PHY tuning pattern location
>>   - Patch 3:   Parse two-element spi-max-frequency in spi.c; adds
>>                spi_device.base_speed_hz (0 when a single value is used,
>>                keeping all existing DT fully compatible)
>>   - Patch 4:   Add spi_mem_apply_base_freq_cap(), called from
>>                spi_mem_exec_op() to cap non-PHY ops to base_speed_hz;
>>                tuned ops bypass the cap because execute_tuning() marks
>>                them with op->max_freq = max_speed_hz
>>   - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>>                spi_mem_execute_tuning() wrapper in SPI-MEM core
>>
>> Cadence QSPI Implementation (6-10):
>>   - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>>   - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>>   - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>>                verification (NOR via cdns,phy-pattern-partition phandle,
>>                NAND via write-to-cache), SDR 1D and DDR 2D search
>>                algorithms with temperature compensation, AM654-specific
>>                execute_tuning entry point; base_speed_hz is cleared during
>>                the tuning loop and restored unconditionally on return
>>   - Patch 9:   Reject 2-byte-address DDR operations via a new
>>                CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag to work around
>>                AM654 OSPI erratum i2383
>>   - Patch 10:  Enable PHY for direct memory-mapped reads (aligned body
>>                region only; unaligned head and tail run without PHY) and
>>                for indirect writes >= 1 KB
>>
>> MTD core (11-13):
>>   - Patch 11:  Integrate tuning in SPI-NAND probe; propagate the validated
>>                frequency to all plane dirmaps (primary and secondary op
>>                templates) and to the persistent write dirmap template
>>   - Patch 12:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>>   - Patch 13:  Integrate tuning in SPI-NOR probe; patch the dirmap op
>>                template with the validated frequency; store the result in
>>                nor->max_read_op so all subsequent reads (dirmap and direct)
>>                pick up the tuned speed automatically
>>
>> Series dependency:
>> Merge after:
>> https://lore.kernel.org/linux-spi/20260527173736.2243004-1-s-k6@ti.com/T/#u
> 
> Isn't the DQS series a prerequisite as well? I sent it as an RFC, we can
> definitely consider it for merge together with this series once
> ready.
> 
> Link: https://lore.kernel.org/linux-mtd/20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com/
> 
> Do you confirm that you have "[PATCH DO NOT MERGE RFC 4/4] spi: cadence-qspi: Retrieve
> DQS capability using the core helper" in your branch for the PHY tuning
> series to work?

The DQS configuration is now derived from the selected read_op variant
(SDR vs DDR), which in turn selects the corresponding tuning algorithm.
The SDR and DDR tuning algorithms are designed such that SDR tuning runs
with DQS disabled, while DDR tuning runs with DQS enabled.

Because of this, the DQS support series is no longer a prerequisite for
the PHY tuning series. However, it can be useful follow-up to make the
implementation more optimal. Once use_dqs is enabled, we can
additionally check has_dqs to ensure the flash advertises DQS support
before enabling it.

> 
>> Testing:
>> This series was tested on TI's
>> AM62Ax SK with OSPI NAND flash and
>> AM62Px SK with OSPI NOR flash:
>>
>> Read throughput:
>> |-------------------------------------|
>> |           | without PHY | with PHY  |
>> |-------------------------------------|
>> | OSPI NOR  | 37.5 MB/s   | 216 MB/s  |
> 
> I am impressed by the SPI NOR improvement o_O
> 
>> |-------------------------------------|
>> | OSPI NAND | 9.2 MB/s    | 35.1 MB/s |
>> |-------------------------------------|
> 
> Was this tested in 8D-8D-8D mode?

Tested in 8S-PHY mode. 8D-PHY mode is not supported with 2-byte
addressing due to Errata-i2383. [0]

[0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

Regards,
Santhosh.

> 
>> Write throughput:
>> |-------------------------------------|
>> |           | without PHY | with PHY  |
>> |-------------------------------------|
>> | OSPI NAND | 6 MB/s      | 9.2 MB/s  |
>> |-------------------------------------|
> 
> Thanks,
> Miquèl

