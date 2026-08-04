Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE43845A7;
	Tue,  4 Aug 2026 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844490; cv=fail; b=j5Y2fqffwkWZiAC/ualXj6wTv/Z5IXB6q+x0EtXbrKwHqmE/8s1wv3oQ9EFcUeMlEKWQHtDltiKc2REtS27wdzwDn27HQnB88M5M110h4cRB3Nci0QW5LOBbu3B5TAeY8I/rFZhdH+taWdms949UElcXq1AHI8xJguWUwjcrqVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844490; c=relaxed/simple;
	bh=WD6oKBuaRl/55FmHDDfsKA3uufB6/Ud2n0SiBPktfX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAZEmTN4KbJj0Fsul9LKyKY5ksMQNrBzhiZHiB0xH3hGqx/8dn/wHHw8XIc1YHIlR74jLXy9DGSFG3COETWVxSbQnFVoHR1RGeUbD5V2Fmg2N/K4Y5VFZqnVBKjfCdr0CWEklDSfkIqhH3f6JQ0e4Vhsa+Ggm8xMLbf+K48N0OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yhEkd3rZ; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yhEkd3rZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z63Av2sRrsrTBqauhzQqY40b9+GteRNa2mDl0CXhM0E0vFKEyEuGyBRa6wh5kXJIP4tj0Dq2qwtwgkLkexkliBTadz2vcIoEcJTxiDNfk3tAuub6IQbpZuqeh5ezQlSuLRuPr7unKgwv7BGd8LzXUheTHXyvtG0yJ2JQLnftHgskPN1LATO/72cb6vwZ6pe1o/zz6/sWvGh8Xz+uMqUyy8zjG9UydbkGAVYUhtZ2X1thFApgGH8M4D2G2fFfaSVKAdeqBuKbGjHDFpkymS9VY2Ys2/blk79RpWLWC3dtJXYLv8s408NW8XN/TN0VJ677cMstUGY02nIo0lHwjKwbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQcTl/fV+iuJ9ImdmCIgjqy3ijrM5jXF3JtsMPK3hDQ=;
 b=k3rIE5mX8f85nf2fXvWVoJqZcMptQPqtITSxMphEIeeY7i1czMiDAV1wIOUyTpsn4+4vp0X+8k1tH1Ny7lQawcA9HjPxuuvz4wm7FZsxNFWhSvjpr8cF9SSqm4qQCBoK9eiy5Sb/xYa8Ht3mNqeoVpPyCJYMmZ0j2wKEBDpIUsvMj7J6lm1LbSp68wExx7xwRWNiEQAxSheSbQg+3TX1KOqf0+lBpNKNXkw+AG8JDSlZSSfAUUsz2K2goC0jxBr6OjQBRBhZffVRr0sNvQYx7uqKwvx28EdwvawCeKXywkH7ZErbmFt0Xx9qNS9vB20M0RmWu8gsmiPTM6ad9mv9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQcTl/fV+iuJ9ImdmCIgjqy3ijrM5jXF3JtsMPK3hDQ=;
 b=yhEkd3rZjY0KsgBC2SQVeFhdbt9uX7vJua880e7D9bKxiBeQ0Cmib2yHzDX9p5DJCIyt08Mpf1ZjWeC3SjPSbx/AWd18skJv+mMng5nNfds6n00oNFqWHcVLdnimKUjj1D85apknxdr/lLGsCN/R5DC1FIrK8IwqfRqopdjYzJw=
Received: from CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::26)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 11:54:42 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::44) by CH0P223CA0011.outlook.office365.com
 (2603:10b6:610:116::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 11:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:54:41 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 06:54:37 -0500
From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <akshata.mukundshetty@amd.com>,
	<bleung@chromium.org>, <groeck@chromium.org>,
	<chrome-platform@lists.linux.dev>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: [RFC PATCH 3/4] Documentation: espi: add subsystem overview and MAINTAINERS entry
Date: Tue, 4 Aug 2026 17:22:58 +0530
Message-ID: <20260804115259.4065638-4-krishnamoorthi.m@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: b04f22b4-8a36-4a0f-4f83-08def21f2b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Ytmb6yIQthAOhFEeU9sOVSgRpid+bM6BKRCCyCbxnPTqZwwCZ6dloNMPypgiTo5QwGk4JKQG6aznCF0DFM6rS7VC23Ai8/TwyrsuKZCZjgnWb/Ngie/LV5xyfJzk2+ADCPnmha3DALfxNucKWSUF28n217ixeN+grgiSvADwH5E9Az5w826G342SErLEJQ320ndB9jeqz2uqzAaQC9T13pL61wbxyIpgZMfT9aSWfJ4/9CC7eZLvzw0abfp8eo5r5nTbPgzNWX15/keQPVA5si8pFISTG10yEWFI688kH2GZwvexALLVfKOVfqL0rswxPhgA5w/1uZQZlP7rRgTylUesL8xUOJcpuWzgAIijxm+kWjANORlOjJP3eZ2+nERmwCcqCSXYZ5aU6kwLFua4JDzWW52LENY1TO6I8vbU+o5U8Bquu8oLv3j4j5QPWRHipbtb3oRJ8+tNbnLphXDNzU9CY9hDnEi1HIb5SjqT8S2g5sDI+eezixDWe1aJifhcqco0CU457ECW/DHDLjvmES7P/cO1W7LPvhGwueN4zl23TFxcOdlAl50J45teot+hwmpSMuvq1+VdZltgYiQrfN3S1rgsJKjlvOUXRgqXw2Pk0N2iP9VFVphFW3xjysPPAgRfz7tVkwN2dJH/Bu/BIsbW9to6hnMhNlwu8PQB3w+pRPeWoyXuTWvoxus3ByBeC2wZjrfe/2jsRz999980Jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WRJ38oM7I/jwqPchD0CA79/Bz1UaMeoeswyzW6p6RwCoYeQHb6s0okj3PDEOumMef8A1/764LTAkO/Dm4cEFgPoaiOlugaqO5+CIawzXA4aPEh9CeQ2Z660uWwCNRSbQo6M5T1CZ9QKt7aU1hbGJyTJzTmrVNbIiuQSoelw+5UpIOA4icikWSyA+xRvLMVvgnhcWnP8+d9w6poDymCoW4S84/mGmVsfXtUc7plfFRwnQ0vmb4yJgH33JqSVMThVGZUdwoq7CXhddNR8kcQtsOCAIdvnrubJl93YJpwCxLM2PncOWb2XcR+H8caJhvftoN31cBQEeliH6z6I0SEKEKfC1GPWiUiZKAR6lC8x1h5RzUBADw8qiB8ogrwum9lu4CcVWoJiSHr9Miz3ap/ba45ZtwZHnqEp0gNRAHLyKnt3OdW44ikg/HvVfNsxmu6PC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:54:41.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04f22b4-8a36-4a0f-4f83-08def21f2b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

Add a driver-api overview of the eSPI subsystem and a MAINTAINERS entry
covering the subsystem files.

The document describes the architecture, how to write a controller driver
and a slave driver, the per-channel APIs (Peripheral, Virtual Wire, OOB,
Flash), the alert mechanism flow, and the event notification model. An
API Reference section renders kernel-doc from the exported symbols.

Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
---
 Documentation/driver-api/espi.rst  | 213 +++++++++++++++++++++++++++++
 Documentation/driver-api/index.rst |   1 +
 MAINTAINERS                        |   8 ++
 3 files changed, 222 insertions(+)
 create mode 100644 Documentation/driver-api/espi.rst

diff --git a/Documentation/driver-api/espi.rst b/Documentation/driver-api/espi.rst
new file mode 100644
index 000000000000..60a3187edb05
--- /dev/null
+++ b/Documentation/driver-api/espi.rst
@@ -0,0 +1,213 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================================
+eSPI (Enhanced Serial Peripheral Interface)
+===========================================
+
+Introduction
+============
+
+eSPI is a bus defined by Intel that replaces the legacy LPC bus. Unlike
+SPI it is a structured, capability-negotiated, message-oriented protocol
+with four logically independent channels (Peripheral, Virtual Wire, OOB,
+Flash) over a shared physical link, and asynchronous target-to-controller
+events, so it is modelled as its own bus type rather than an extension of
+the SPI subsystem.
+
+Architecture
+============
+
+* ``struct espi_controller`` - host controller, created with
+  espi_controller_alloc() and registered with espi_controller_register().
+  It is not itself a device on espi_bus_type.
+* ``struct espi_device`` - a target on the bus, matched to a
+  ``struct espi_driver`` via its modalias.
+* ``struct espi_controller_ops`` - the optional hardware-op table; the
+  channel API returns -EOPNOTSUPP for ops a controller does not provide.
+
+Writing a controller driver
+===========================
+
+A controller driver allocates and registers a controller from its
+``probe()`` function::
+
+    ctrl = espi_controller_alloc(&pdev->dev, sizeof(*priv));
+    if (IS_ERR(ctrl))
+        return PTR_ERR(ctrl);
+
+    priv = espi_controller_get_devdata(ctrl);
+    ctrl->ops = &my_espi_ops;
+    ctrl->max_targets = 1;
+
+    /* populate ctrl->caps from hardware capability registers */
+    ctrl->caps.supported_channels = ESPI_CHANNEL_ALL;
+    ctrl->caps.max_freq_mhz       = 33;
+    ctrl->caps.io_mode            = ESPI_IO_MODE_SINGLE;
+
+    ret = espi_controller_register(ctrl);
+    if (ret)
+        goto err_put;
+
+After registration the controller calls espi_new_device() for each
+target enumerated from firmware (ACPI or device tree)::
+
+    struct espi_board_info info = {
+        .type = "my-ec",
+        .cs   = 0,
+    };
+    edev = espi_new_device(ctrl, &info);
+
+On removal::
+
+    espi_remove_device(edev);
+    espi_controller_unregister(ctrl);
+    espi_controller_put(ctrl);
+
+Writing a slave driver
+======================
+
+A slave driver declares a device ID table and a ``struct espi_driver``::
+
+    static const struct espi_device_id my_ec_ids[] = {
+        { "my-ec", 0 },
+        { }
+    };
+    MODULE_DEVICE_TABLE(espi, my_ec_ids);
+
+    static int my_ec_probe(struct espi_device *edev)
+    {
+        /* register for hardware events */
+        nb->notifier_call = my_ec_event;
+        espi_register_notifier(edev->ctrl, nb);
+        return 0;
+    }
+
+    static void my_ec_remove(struct espi_device *edev)
+    {
+        espi_unregister_notifier(edev->ctrl, nb);
+    }
+
+    static struct espi_driver my_ec_driver = {
+        .driver   = { .name = "my-ec" },
+        .id_table = my_ec_ids,
+        .probe    = my_ec_probe,
+        .remove   = my_ec_remove,
+    };
+    module_espi_driver(my_ec_driver);
+
+Channel-independent commands
+============================
+
+espi_get_configuration(), espi_set_configuration(), espi_inband_reset()
+and espi_get_status(). GET_STATUS is optional: controllers whose hardware
+does not implement the wire command leave .get_status unset.
+
+Capability negotiation and channel management
+=============================================
+
+At boot the controller driver reads the target's capability registers via
+espi_get_configuration(), negotiates link parameters (I/O mode, clock
+frequency, CRC) via espi_set_configuration(), then enables each channel
+with espi_enable_channel(). espi_channel_is_enabled() may be called at
+any time to query the current state. Channels may be disabled individually
+with espi_disable_channel(), for example before an in-band reset.
+
+Channel APIs
+============
+
+Peripheral channel
+------------------
+
+Carries I/O and memory cycles between the host and target endpoints.
+
+* espi_periph_io_read() / espi_periph_io_write() — 16-bit I/O port
+  access; ``width`` is the access size in bytes (1, 2, or 4).
+* espi_periph_mem_read() / espi_periph_mem_write() — 32-bit memory
+  mapped access.
+
+Virtual Wire channel
+--------------------
+
+Carries logical signal state (power sequencing, SMI#, SCI#, IRQs) as
+indexed wire groups. Each group carries up to four wire values with
+individual valid bits.
+
+* espi_vwire_get() — read a wire group from the target.
+* espi_vwire_put() — send a PUT_VIRTUAL_WIRE command to the target.
+  Named after the eSPI PUT_VW wire command, not a reference-count
+  release.
+
+Wire changes from the target generate an ``ESPI_EVENT_VWIRE_CHANGED``
+event delivered through the notifier chain.
+
+OOB channel
+-----------
+
+Tunnels SMBus/I2C messages between the host and target out-of-band
+processor (BMC, EC). Messages are exchanged as opaque byte buffers with
+a tag field for matching requests to responses.
+
+* espi_oob_send() / espi_oob_recv()
+
+Incoming OOB messages generate an ``ESPI_EVENT_OOB_RECEIVED`` event.
+
+Flash Access channel
+--------------------
+
+Provides access to a SPI flash device attached to the target. The target
+acts as a proxy for flash read, write, and erase operations.
+
+* espi_flash_read() / espi_flash_write() / espi_flash_erase()
+
+Alert mechanism
+===============
+
+When the target has upstream data pending it asserts ``ALERT#``. The
+controller's hard-IRQ handler acknowledges the interrupt and defers
+processing to a threaded IRQ or workqueue. From that process context the
+controller driver calls espi_handle_alert(), which acquires the
+controller lock and dispatches to ``ops->handle_alert``. The hardware
+callback reads the target's status register (GET_STATUS), identifies the
+pending channel, and calls espi_notify_event() to deliver the appropriate
+``ESPI_EVENT_*`` to all registered slave driver notifiers::
+
+    ALERT# asserted by target
+          |
+          v
+    hard-IRQ handler (controller driver)
+          |
+          v
+    threaded IRQ / workqueue
+          |
+          v
+    espi_handle_alert(ctrl)          [espi-core.c]
+          |
+          v
+    ops->handle_alert(ctrl)          [controller driver]
+          | reads GET_STATUS, decodes channel
+          v
+    espi_notify_event(ctrl, &event)  [espi-slave.c]
+          |
+          v
+    slave driver notifier callback
+
+espi_handle_alert() must always be called from process context; it must
+never be called from a hard-IRQ handler.
+
+Events and concurrency
+======================
+
+Hardware events (Virtual Wire changes, OOB messages, Peripheral channel
+completions, channel state changes) are delivered through a per-controller
+blocking notifier chain (espi_register_notifier()/espi_notify_event()).
+Callbacks run in process context; controllers deliver events from a
+threaded IRQ or workqueue, never from hardirq and never while holding the
+controller lock.
+
+API Reference
+=============
+
+.. kernel-doc:: include/linux/espi/espi.h
+
+.. kernel-doc:: drivers/espi/espi-slave.c
+   :export:
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6601a258690f..175ed0794a48 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -139,6 +139,7 @@ Subsystem-specific APIs
    sm501
    soundwire/index
    spi
+   espi
    surface_aggregator/index
    switchtec
    sync_file
diff --git a/MAINTAINERS b/MAINTAINERS
index e95fc6f2ddc6..c416326d14fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9705,6 +9705,14 @@ F:	Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
 F:	drivers/clk/eswin/
 F:	include/dt-bindings/clock/eswin,eic7700-clock.h
 
+ESPI SUBSYSTEM
+M:	Krishnamoorthi M <krishnamoorthi.m@amd.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	Documentation/driver-api/espi.rst
+F:	drivers/espi/
+F:	include/linux/espi/
+
 ET131X NETWORK DRIVER
 M:	Mark Einon <mark.einon@gmail.com>
 S:	Odd Fixes
-- 
2.34.1

