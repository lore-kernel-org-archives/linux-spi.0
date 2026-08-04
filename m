Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312C38422D;
	Tue,  4 Aug 2026 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844456; cv=fail; b=mf7D5qy4g74nPmC2Mkc6qglBp2c4jcz7JZWJW3yY5ms2aW6cBavzIRVf4ixY19+UGdu53MmFxm1GDuhdIcds4/SVBCEKZfEiS8K+VJxcZBuAVDygjTDccHIQ7WinJQscin5bmjgH9v8AbwwfGUA93u1jMV8ChlIvchQeTkfDyKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844456; c=relaxed/simple;
	bh=MP6bqvjb68ldQSLy86Fol22CqIU5GIPHMBFUFDW4MMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GCdXGHgWjt8CdtvgzwJOi+wv2Jh2vFFQyx81U9c2sSmB9H6PHX4jTePT7J3SVHFRpT3vnQvhdLFHGnVqO78tCg8E1QaDda/62urbie+Cl3cmSNa2BNIS1APon7dYvPFE0v7Btq6v48V+uW/YfShLLx2kqRjms3BL68kdLtd81v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EwLwCmRz; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EwLwCmRz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FboHvIx+jiMknu+KApT8mfcnhHKkEL0Dev9jn+DEvx7Y5hKu+kFe69sJ/Cs40OI67YYatQcdUfoP+6f7XbXRYerW8oGEpHfIV7N1QNV8NSfJ0iNyiHbCRElcwLEbYlp4hrlJZVolCzKhEI1x9CIBa4leipk+dJ3SbaTcFvPm/nQjW32k1UEBvzlysuW/lw4joVRyoNe38QkUOQXaqoHHVBolyWK1HYDi4tpwWipVzWCQarPPN8zCWTyyqkq2AtuoJknBz3c7fmaJYvloQct9KWwvEtsE0t//lUwIuipl/S4cr3nHqM/5DNGdl5qdN5PQ/9HfS/fKB3tcXFGjgmufgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6bhbTYx6dfn3Kv1u7wKpF3NOeOnG7RiVaM57KwCAjs=;
 b=Et0W9yj1bnX6UZ1JeVJF47ZoxJaqxOtT2tjy5xmJD7c5wgA3o8QRaJ6kqC8djHu4TcHKNr2Y6bE7bNPQxFT6m6HhywW+6+NpeOsJ+XV697YcAE/7BjsPRuGtTLNq0uHBD4S5gH0EfFgSBB/wwLohvMysdfiyzD32q2S8EG7sYQQIcIlkuFoXpG/5nxgr62KX9pBaCTFWjqbSr5NoK+7bSzI/706LEFS5IZw5I8dT4/EKcpFRjBZktMvL5PpOylJMMLLh/iRxLHc8jPoTBQmo3XgISaMYMpTK5d2RgoN8J2lMMwtqh2UceK7Jp93ei0892S6N9vAaq3vlkyMTlzHE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6bhbTYx6dfn3Kv1u7wKpF3NOeOnG7RiVaM57KwCAjs=;
 b=EwLwCmRzVseE86Bnhawi7LZ482o5X3GvA+NrN8jeEbfxA6wVqqbF6uoE5h0M9xf9oAFDNpCvCDw2jD9mh/mdb1k+T9W7pfjuJQSf6WJNzRnrS2dAb+PZbSPZKoXjVziNEF8b9iquiSKOko7i4nt4Fxp1+8nhDgZMxbVojkVHoVQ=
Received: from CH0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:610:e5::29)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 11:54:08 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::99) by CH0PR03CA0264.outlook.office365.com
 (2603:10b6:610:e5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 11:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:54:07 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 06:54:03 -0500
From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <akshata.mukundshetty@amd.com>,
	<bleung@chromium.org>, <groeck@chromium.org>,
	<chrome-platform@lists.linux.dev>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: [RFC PATCH 0/4] espi: introduce eSPI bus framework
Date: Tue, 4 Aug 2026 17:22:55 +0530
Message-ID: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: ad025195-5fb7-4fb4-5a4b-08def21f1724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|36860700016|82310400026|10067099003|11063799006|6133799003|56012099006|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	K9UHhpdcgc5yaIPEWceXIwyn7m07RX86N/wvEIjXGmPLgJxtg33rcjVLMqqpRyNdlnhHhaiXEHlVS/8EMy5fFY8yImCUE/9mXHt2UmmOe/Fxkyn4zRDCENHJl05bCDdasNzkcVH5vrge5ix+TNJ5jUAlFhKp+SYZWv6Z5p8b3Yr2wbTKOVdfoaFRDnH+zxJ4NgQHgHgItu13XK1ZvUrPJPqe3eJMiSAkUgJ2Gfsqg8/BWvb9m3RFnRKK+kQ1+eH9UkE6CfRp/J/wsz0ITKb+nECA0fwkGavcTR1Mbs8eVYGU/BLse//3obfqgl1SzagElxWfDnbECn7XTg+gEwmj0iT3xZgC5yJ43jPzM0M0TZQmyfKY9UC2tD8iQv0oSJdtdM+W+S8XKDUHoLYzbegls56WpqsH1RduyOtCVCi0guTuErbfclcDZNuzMXvQjrORk4QYxG7aLa7Oc+AEY+RXGrt0sXQswBeWqluiaY3eyamhwK4p6klespU58TFBAcNXhWk/g6CqKJiihtwnBEInzm5SB9UhsOdTky4Nr0JyHVf7ytcor55UkZfzVKSVAKUcHbF/o5Nwj289lLjb+hQyHr/lPK+UhYM6GUTkLlmgoJJT3C2gYYuCol788mPywLUQHn86vZHuFQ7asrWaTPTgwJsAO5467DaaktMUy1W6pwvSDZrF+N+TQvABqkz9jvEVbPSqHECeVjXnHISMMbcxMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CRN7OeBVEFEDK5gtbtvYpcTM17sMXlfI0NKVUn1BzGEetb/a+MDQnp1UM3X2V5MJc8DQl9zGnC88pWMxCLW5P5E9OA73Z5RgH/bVbV5gUMNfp0bMyqGGY5HKhe9hk2ecol/L/2eMjO4KFT8JQ4/zGPkwph9IjZjNwINPnYucmXulOFgEm20i6yZ3yhsrusPd+KS0GJa1+vKhQvuO47nlUhGfj1Wa+WmPnLIznP2jmvXM09guuunzNpzA6gxixKBls3Eb7pgAsbRRwEOfxjD/BYCWUVSoy67HfJC2EhSSyHYuiP94I4TKzaxuVcjmEqp89WTRkqTglujlgARvqwIOBddOWhDG2BTmOs45KPR2NzHO07AdntfOHe8YiWqkRSVopDEKkJVu/4UxwlK+3Vodj8T7faEAYJOWT0Bu3jWoODZSaqdSMufGl4jNo2SbDtI3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:54:07.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad025195-5fb7-4fb4-5a4b-08def21f1724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

This RFC proposes a new eSPI (Enhanced Serial Peripheral Interface) bus
subsystem for Linux.

Background
==========

I previously posted to the list asking whether extending the existing SPI
subsystem or introducing a new bus type was the preferred direction for eSPI
support [1]. This series represents the new-bus-type approach, implemented
and validated on AMD hardware.

eSPI is an Intel-defined protocol replacing the legacy LPC bus. Unlike SPI,
eSPI is capability-negotiated: the controller and target exchange capability
registers at link bring-up to agree on I/O mode, clock frequency and CRC.
Traffic is carried over four logically independent channels on a single
shared physical link, and the target signals upstream data availability
asynchronously via an ALERT# pin rather than chip-select assertion.
These characteristics do not fit the synchronous, single-channel, transfer-
oriented SPI model, so a dedicated bus type is proposed.

Channel Model
=============

The four eSPI channels each serve a distinct purpose:

  - Peripheral channel: carries host I/O and memory cycles to/from the
    target, replacing the LPC I/O and memory cycles used by devices such
    as EC and BMC firmware.

  - Virtual Wire channel: transfers logical signal state (power sequencing
    signals, SMI#, SCI#, IRQs) as indexed wire groups, replacing the
    physical LPC sideband signals.

  - OOB channel: tunnels SMBus/I2C messages between the host and an
    out-of-band processor on the target, enabling management traffic
    independent of the host OS.

  - Flash Access channel: provides access to a SPI flash device attached
    to the target, allowing the host to share a single flash with the
    target firmware.

Design Overview
===============

The framework follows the established Linux bus/device/driver model:

  - struct espi_controller: the host controller, registered with
    espi_controller_register(). Capabilities are negotiated at runtime
    and stored in struct espi_capabilities. Each controller is assigned
    a bus number from an XArray allocator. Read-only sysfs attributes
    (supported_channels, channel_enabled, io_mode, max_freq_mhz) expose
    the negotiated link state to userspace.

  - struct espi_device: a target on the bus, identified by its Chip
    Select# index (cs field). The eSPI spec allows one controller to
    drive multiple targets via separate CS# pins; ctrl->max_targets
    advertises the hardware limit and cs is range-checked at device
    creation. Devices are matched to drivers by modalias.

  - struct espi_controller_ops: an all-optional hardware callback table.
    The core returns -EOPNOTSUPP for unimplemented ops, allowing
    incremental controller driver development across patch series.

  - A per-controller blocking notifier chain delivers hardware events
    (Virtual Wire changes, OOB messages, channel state transitions,
    In-Band Reset) to slave drivers from process context. A blocking
    notifier is used rather than a raw notifier because slave driver
    callbacks may sleep, for example to issue follow-up configuration
    commands over the bus.

  - A single per-controller mutex serialises all channel operations.
    This is intentional: eSPI has one shared physical link and only one
    downstream transaction can be in flight at a time regardless of the
    logical channel, consistent with how struct spi_controller is modelled.
    Because the mutex is a sleeping lock, all ops must be called from
    process context; the alert handler is therefore registered with
    IRQF_ONESHOT and dispatches from a threaded IRQ.

Alert Mechanism
===============

When the target has upstream data pending it asserts ALERT# (dedicated
pin or in-band on I/O[1]). The controller's hard-IRQ handler acknowledges
the interrupt and defers processing to a threaded IRQ, which calls
espi_handle_alert(). This dispatches to ops->handle_alert WITHOUT holding
ctrl->lock, so that the driver callback can call espi_notify_event() to
deliver the appropriate ESPI_EVENT_* to registered slave driver notifiers
without deadlocking: notifier callbacks may in turn call channel APIs
that also acquire ctrl->lock. The driver is responsible for acquiring
ctrl->lock around any register accesses that require serialisation with
the channel API. The alert path implementation is deferred to follow-on
patches; the hook points are in place in this series.

Scope of this RFC
=================

This series covers the framework foundation and the AMD FCH controller
driver (ACPI HID: AMDI0070). It intentionally limits scope to the
channel-independent layer: capability discovery, GET/SET_CONFIGURATION
and In-Band Reset. Channel-specific operations (Peripheral I/O and
memory, Virtual Wire, OOB, Flash Access) and the alert/interrupt path
are declared in the API but their implementations are deferred to
follow-on patches, to be posted once the framework design is reviewed.

Testing
=======

The series has been validated on AMD hardware (AMD FCH, AMDI0070) using
an internal test slave driver that binds as an eSPI slave device and
exposes a sysfs command interface. The following scenarios were
exercised:

  - GET_CONFIGURATION on the General Capabilities register (0x08):
    verified correct decoding of I/O mode, operating frequency, CRC,
    Alert mode, Max WAIT STATE, and supported channels.

  - SET_CONFIGURATION on the General Capabilities register: verified
    successful negotiation of I/O mode (single/dual/quad) and operating
    frequency (16/33/66 MHz), and confirmed the host-side register is
    updated to match the negotiated parameters.

  - In-Band Reset: verified the reset completes successfully and the
    host controller registers are restored to match the target's
    post-reset state (16 MHz / single I/O).

Known Limitations / Future Work
================================

  - No Device Tree bindings in this series. The AMD controller uses
    ACPI enumeration. DT support will follow.

  - Slave device enumeration is manual (espi_new_device). ACPI/DT-based
    enumeration will be added in a subsequent patch.

  - Channel ops (Peripheral, VWire, OOB, Flash) and alert/interrupt
    handling are deferred to follow-on patches.

Feedback Requested
==================

  1. We chose a dedicated bus_type for the reasons described above
     (capability negotiation, four independent channels, asynchronous
     ALERT#). Does the community agree this is the right direction, or
     is there a strong preference to extend the SPI subsystem instead?
  2. Is the blocking notifier chain the right mechanism for event
     delivery to slave drivers?
  3. Any concerns with the ops table design or the -EOPNOTSUPP fallback?
  4. Naming and structure of the public API in include/linux/espi/espi.h.

References
==========

[1] https://lore.kernel.org/lkml/9548669c-7d3c-4053-b28b-c82490c0c2b8@amd.com/T/#u
[2] Intel Enhanced Serial Peripheral Interface (eSPI) Interface Base
    Specification

Krishnamoorthi M (4):
  espi: add core bus framework
  espi: add slave device model and event notification
  Documentation: espi: add subsystem overview and MAINTAINERS entry
  espi: amd: add AMD eSPI controller driver

 Documentation/driver-api/espi.rst  | 213 +++++++++++++
 Documentation/driver-api/index.rst |   1 +
 MAINTAINERS                        |   8 +
 drivers/Kconfig                    |   2 +
 drivers/Makefile                   |   1 +
 drivers/espi/Kconfig               |  41 +++
 drivers/espi/Makefile              |   3 +
 drivers/espi/espi-amd.c            | 453 ++++++++++++++++++++++++++
 drivers/espi/espi-amd.h            | 126 ++++++++
 drivers/espi/espi-core.c           | 493 +++++++++++++++++++++++++++++
 drivers/espi/espi-slave.c          | 177 +++++++++++
 include/linux/espi/espi.h          | 345 ++++++++++++++++++++
 12 files changed, 1863 insertions(+)
 create mode 100644 Documentation/driver-api/espi.rst
 create mode 100644 drivers/espi/Kconfig
 create mode 100644 drivers/espi/Makefile
 create mode 100644 drivers/espi/espi-amd.c
 create mode 100644 drivers/espi/espi-amd.h
 create mode 100644 drivers/espi/espi-core.c
 create mode 100644 drivers/espi/espi-slave.c
 create mode 100644 include/linux/espi/espi.h

-- 
2.34.1

