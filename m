Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912D4266BA;
	Wed, 27 May 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904548; cv=fail; b=NyYV5gkfZHQ2b1WSq9feKeeO0pwSiGtT0ZQbsZnbP/DjqeKGy4jarSXOTp5c0GgxEkb4C3kYQEvn751jY/cPJDFNRFeo0y9ud34eHlZWZpP1blJxtoeKjAX7D1sww6mwxrkn+G90z0NTm/WPk0bHJSVGILYX2y7yl9dx3ptYmn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904548; c=relaxed/simple;
	bh=7+EVOTUN/5Oijk6IIdFuQyPUmlkSRFCIZeUhLteivLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NzgO+6gV7e8PdnSO5o6ADctKpWowsvpdYDclBZ0jwfh5vzTq5nzLYmJKiS4IWfxXIYs5H1TRBsiqO0GuQKfD6NbFIY/RZyGnj1HdByGb21TKj+/Qx0HMfZ9RGDLudif1PGNB+qSkzrrSrcvBoklzqQ9w2hmbzx/kIuR/31gFg24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cZGnLIqL; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cZGnLIqL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCqu9N0C1+7YQUt/Gyu2T5+4yoXn67Qlv0ZqolrFKD1flihmgLOZ5oqkSryZcRKCv31CFqxL3O1TFzvdRWcg/BYv0JcZWcphB2JG0QYuDFgoMyWMtmosYNIxvBNds5VGsH4GQ7VwrovsfWLNdXeUsFXfxhFXHZwZMtYnXAmDdC4l0JhPFifZUQOx4DrxO0aURFjN++rYiy1gN1ZWAR7YxsLMyX+fOWRApFqNIFQ2HafNPdtUKTOKTBKmu5T4JdluYWQ2Fatb7IhQfe08qkDcSJtFlcEkgc71r5zRCcEx02BunJBMR1omtpZRIS0P+qkB+KBmJ12rJ11F8+yLkYYiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ty9hVFxWecAL6NGZT+1PlS5sRvlEoMxg+zodtodw+4=;
 b=CvJUvjXKo8kkHvbLXm56QYY0zKoYzt7bWDGDyzhOFq3S/c+Vlcnd2FGBbhwcQsLhYhfQHJqQnEqmjZDnF54BCW8b7qreRuiOOGuj2MpTqFjA/AuF2V9nbxq1QuoAM1XhLjDuk+14fMOHCcrPXVMe4fKmujba4UqS850523kGB14rIxPS0wzflH1nKNo4d0YeYt9ldTGN3bBKLPDl3zB81dLg9PiKYBvkS5Sghh7E3XM23MV4lj1MILoQB4xz8BbgU+OUTCrD3Ibit2A4RhTjac7S0W+/dFAeZfrCWCeoB76jz3S3k4JLVzbIx0A54ivI58ydvNg7xN2i/aj/d1lAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ty9hVFxWecAL6NGZT+1PlS5sRvlEoMxg+zodtodw+4=;
 b=cZGnLIqLDsy0AHI7miiXSR7WHLvHT5+eMhwBtwmaByOyRLIcLLq88SP6nGBXHFzOGuEmNedS+rU3GgahZSfa9XcCoVkHzxU8hgGCGrmNtkC357YTd7gh9LeOdRb/Y5vcEiOFNueBYOIM8C6L6YKRUdGWEfy5lsS3OvMboGTuZFc=
Received: from CH3P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::13)
 by SA1PR10MB997580.namprd10.prod.outlook.com (2603:10b6:806:4b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:55:44 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::92) by CH3P220CA0002.outlook.office365.com
 (2603:10b6:610:1e8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:55:42 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:39 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:55:39 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpc4052476;
	Wed, 27 May 2026 12:55:34 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 00/13] spi: cadence-quadspi: add PHY tuning support
Date: Wed, 27 May 2026 23:25:14 +0530
Message-ID: <20260527175527.2247679-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|SA1PR10MB997580:EE_
X-MS-Office365-Filtering-Correlation-Id: b3eabe6a-25af-459e-b610-08debc192b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099006|6133799003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	bQy6JPEjmMmyHxqKwrzU/yeD455c5MbNH7pMZy2m0x/vU0USlwFA7YvwTdpmi799C644huPYdwWIuZyLE0F2/EfbCWUaulrv3aktsvaYw33Y585FzvxjOg7owUgzzfjNSRbYSjPMdcP4Yr9VpNBOefm6e50b9+FAWpuCxlyO62J0o9kWuvr7u5HTWA8J6LohsgbIaJcyo0YgUzPRigjpQ8H5OmUKEkMz5dOMsDY1ZwS9KrhrTktV61KShRxeETwmtR6cDuazUjFfBWRAfhcvXn+KffvDIGU21UjkrdBt0qh4GsyIqLBTFHMprk+26yD/DIpxNcAj2KV9vqVWe5P8Bt+f8k49O79Au6RkyMiTVAX2rP7ibFIe7X/0RUKOQKgR1KSUn8iY3EG2ROXcY8+1FtdrjDwi4V4g0OMdSh0KtHe+AX1AidmkpqVtfrqMZDD7ngdE9U7G4Qh//CCFtgLSyjPnWhIXM1AEDpTWfSNMGVMfrDjD8+C0VI+Kk9a46/ueGgnX1frQBfo97r8tWrn2tsjoApHiTRvzXmjlN/Y1NZd7DhIYVdqmscGjS55KCrnKhPM4Crno0WWqvdNqsj6T6eQEKTIAdJ53X0uke/1l8K7XKCjK24jvNQzkbpOrp2z+WmbBv45EsOj3YO4Cier+13yyUMjFKCmeJqzw7cfLvZUYeMhkonnuViCzICIdRnIjrQSj4x2SeDzui1l1vzibzV6YelZeEWcNoMBJcMxEyBo=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099006)(6133799003)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TSPGekrwuwrj3fBlGqgADuiA0OlsofRSE3Dgjo9ZzXTYAqRRIznN0jWjy3x4CNB9W+Zmov5ZbUfy6am78y8ci4+zVP+KWYfsx2zU4OS+R+sJpgKjMjqL1qR6qBeiP/mUEZJpOYefylXNtEFO5/S2OTZETO5FMaD4LtGjFXJ5Euu7Pmc7AYwAdEzZCgCrO5b1ULyczlSwcc8OMaDo45NdMM7hixkM95MVxr0csTyjvHDeUikGIUokHIQymA8UDbNLm+qVlV9qO4SlwBJOBxVM7sD4LvzFn8xGTWUHd5UayyasJc532R9ReTrPj33M+021PLtzGefYoJ5f7l36I8B6MOl24uJSDPNg+OW2cz/jiMDzBa7uvyvnMebgRQRQHbUh8H5HDqmBdwbYx88viMipkvcWD7Aln3MCbXI2BQecS76s2et0qw3uWeVzyfeUAoG2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:55:42.1448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eabe6a-25af-459e-b610-08debc192b73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997580

This series implements PHY tuning support for the Cadence QSPI controller
to enable reliable high-speed operations. Without PHY tuning, controllers
use conservative timing that limits performance. PHY tuning calibrates
RX/TX delay lines to find optimal data capture timing windows, enabling
operation up to the controller's maximum frequency.

Background:
High-speed SPI memory controllers require precise timing calibration for
reliable operation. At higher frequencies, board-to-board variations make
fixed timing parameters inadequate. The Cadence QSPI controller includes
a PHY interface with programmable delay lines (0-127 taps) for RX and TX
paths, but these require runtime calibration to find the valid timing
window.

Approach:
Add SDR/DDR PHY tuning algorithms for the Cadence controller:

SDR Mode Tuning (1D search):
 - Searches for two consecutive valid RX delay windows
 - Selects the larger window and uses its midpoint for maximum margin
 - TX delay fixed at maximum (127) as it's less critical in SDR

DDR Mode Tuning (2D search):
 - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
 - Finds TX boundaries (txlow/txhigh) at fixed RX positions
 - Defines valid region corners and detects gaps via binary search
 - Applies temperature compensation for optimal point selection
 - Handles single or dual passing regions with different strategies

Patch description:
Infrastructure (1-5):
 - Patch 1:   Extend spi-max-frequency DT binding to accept an optional
              second value forming a [base-freq, max-freq] pair
 - Patch 2:   Add cadence-specific cdns,phy-pattern-partition phandle for
              NOR flash PHY tuning pattern location
 - Patch 3:   Parse two-element spi-max-frequency in spi.c; adds
              spi_device.base_speed_hz (0 when a single value is used,
              keeping all existing DT fully compatible)
 - Patch 4:   Add spi_mem_apply_base_freq_cap(), called from
              spi_mem_exec_op() to cap non-PHY ops to base_speed_hz;
              tuned ops bypass the cap because execute_tuning() marks
              them with op->max_freq = max_speed_hz
 - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
              spi_mem_execute_tuning() wrapper in SPI-MEM core

Cadence QSPI Implementation (6-10):
 - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
 - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
 - Patch 8:   Add complete PHY tuning support: DLL management, pattern
              verification (NOR via cdns,phy-pattern-partition phandle,
              NAND via write-to-cache), SDR 1D and DDR 2D search
              algorithms with temperature compensation, AM654-specific
              execute_tuning entry point; base_speed_hz is cleared during
              the tuning loop and restored unconditionally on return
 - Patch 9:   Reject 2-byte-address DDR operations via a new
              CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag to work around
              AM654 OSPI erratum i2383
 - Patch 10:  Enable PHY for direct memory-mapped reads (aligned body
              region only; unaligned head and tail run without PHY) and
              for indirect writes >= 1 KB

MTD core (11-13):
 - Patch 11:  Integrate tuning in SPI-NAND probe; propagate the validated
              frequency to all plane dirmaps (primary and secondary op
              templates) and to the persistent write dirmap template
 - Patch 12:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
 - Patch 13:  Integrate tuning in SPI-NOR probe; patch the dirmap op
              template with the validated frequency; store the result in
              nor->max_read_op so all subsequent reads (dirmap and direct)
              pick up the tuned speed automatically

Series dependency:
Merge after: https://lore.kernel.org/linux-spi/20260527173736.2243004-1-s-k6@ti.com/T/#u

Testing:
This series was tested on TI's
AM62Ax SK with OSPI NAND flash and
AM62Px SK with OSPI NOR flash:

Read throughput:
|-------------------------------------|
|           | without PHY | with PHY  |
|-------------------------------------|
| OSPI NOR  | 37.5 MB/s   | 216 MB/s  |
|-------------------------------------|
| OSPI NAND | 9.2 MB/s    | 35.1 MB/s |
|-------------------------------------|

Write throughput:
|-------------------------------------|
|           | without PHY | with PHY  |
|-------------------------------------|
| OSPI NAND | 6 MB/s      | 9.2 MB/s  |
|-------------------------------------|

Test log: https://gist.github.com/santhosh21/3434d062f31622c5877a375218cd49c7
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v3/

Changes in v3:
 - Drop spi-has-dqs DT property; DQS is now enabled automatically when
   the selected read operation uses DDR signalling (dtr flags in the op)
 - Extend spi-max-frequency to accept an optional second value forming a
   [base-freq, max-freq] pair; the presence of two values signals PHY
   tuning intent and encodes both the conservative base speed and the
   calibration target in one property
 - Add base_speed_hz to struct spi_device (spi.c/spi.h) and parse the
   two-element array there; single-value DT is fully backward-compatible
 - Move frequency enforcement from the cadence driver to core: new
   spi_mem_apply_base_freq_cap() called from spi_mem_exec_op() replaces
   the per-driver cqspi_op_matches_tuned() and non_phy_clk_rate field
 - Propagate the tuned max_freq to dirmap op templates after
   execute_tuning() succeeds; store persistent op templates in
   spi_nor.max_read_op and spinand.{max_read,max_write}_op so the
   frequency writeback survives across the probe call
 - Replace NOR pattern partition lookup by name with a
   cdns,phy-pattern-partition DT phandle pointing directly to the
   partition node
 - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address DDR
   ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
 - Remove RFC tag
 - Rebase on v7.1-rc5
 - Collect tags from Miquel
 - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1-s-k6@ti.com/

Changes in v2:
 - Restructure the .execute_tuning() call from spi-mem clients instead
   of mtdcore with best read_op and write_op (optional) passed
 - Add compatible-specific .execute_tuning() call which can be called by
   spi_mem_execute_tuning() if exists
 - Handle tuning requirement check by controller instead of spi-mem
   clients
 - Add support to write the phy_pattern to cache if relevant write_op
   is passed or get the partition offset which contains the phy_pattern
 - Add tuning algorithm for DDR mode
 - Add support for DQS
 - Restrict PHY frequency to tuned operations
 - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-s-k6@ti.com/

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Pratyush Yadav (1):
  mtd: spi-nor: extract read op template construction into helper

Santhosh Kumar K (12):
  spi: dt-bindings: allow spi-max-frequency to specify a frequency pair
  spi: dt-bindings: cdns,qspi-nor: add PHY tuning pattern partition
    property
  spi: parse two-element spi-max-frequency property
  spi: spi-mem: add spi_mem_apply_base_freq_cap()
  spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
  spi: cadence-quadspi: move cqspi_readdata_capture earlier
  spi: cadence-quadspi: add DQS support to read data capture
  spi: cadence-quadspi: add PHY tuning support
  spi: cadence-quadspi: reject 2-byte-address DDR ops on PHY-tunable
    hardware
  spi: cadence-quadspi: enable PHY for direct reads and indirect writes
  mtd: spinand: run PHY tuning after init and update dirmap frequencies
  mtd: spi-nor: run PHY tuning after init and update dirmap frequency

 .../spi/cdns,qspi-nor-peripheral-props.yaml   |    8 +
 .../bindings/spi/spi-peripheral-props.yaml    |   10 +-
 drivers/mtd/nand/spi/core.c                   |   35 +
 drivers/mtd/spi-nor/core.c                    |   85 +-
 drivers/spi/spi-cadence-quadspi.c             | 2267 +++++++++++++++--
 drivers/spi/spi-mem.c                         |   57 +-
 drivers/spi/spi.c                             |   17 +-
 include/linux/mtd/spi-nor.h                   |    3 +
 include/linux/mtd/spinand.h                   |    4 +
 include/linux/spi/spi-mem.h                   |   10 +
 include/linux/spi/spi.h                       |    2 +
 11 files changed, 2308 insertions(+), 190 deletions(-)

-- 
2.34.1
