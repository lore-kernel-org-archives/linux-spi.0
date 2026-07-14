Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B1363087;
	Tue, 14 Jul 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023817; cv=fail; b=ajtwRTq5jNTwpEp1cnaRVSPYJFXKIkgQ1ua//8k+y18Zl+MGcslPZnE7dU5tvoac5IMC3KPBlzN6ld2XPhOLT+f1Tpv9MWmgy9S+hJE5dmzqiQ1hP3oOqV3f9nSr7q1VierV3ncX/NYvYMRf3DwhjHpXT4V38MeqEXVnja2PZCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023817; c=relaxed/simple;
	bh=35IpOUY/wZ3fF6TtmOpivdVuXS/DdVYDezlplFgCJzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj4npRFePMw+rY7TKw4rwfw2jGci+fY65BIb8XDJxGnOeuAnHcZwTzSyOgGTyNdcvVa0HOHaZyceuQFILiwIrxu7EVo72b56OSpz/EV9w+bbMMO/aXXugtcdQIHIRiISulrr/OyXGBvzSEi3/p8YeOCUBw3JL3GL1bLW4Is6lEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XzINQm9X; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XzINQm9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrCuKR9JP2gjRuOU0csDzKlbyy6xbaj6J+eo0c0nDgQ61246gSbiugsc5PeTRXFYRzSyqjwilS+ehkorw4W/hB9Vhv8X9eAbrsQ/orm0c832ez1KtFN4vBzPuU9E7flbU5UlrNg51GgApcVYUVW/CCLMd1pJcO8A+SqQNZq/UPoQkVZDdO7CfdkivQ+3g4cerlkhlphCRd30BjpH5gsHx7oX8eX8Mb+n/CrHVXcAJo1G7czWHEP2Wk3IPb/fOakt1ne3ANMCd/Qsdx1Mc/ILf/20E4uVl0AK5sNBJYphhPzP7cA4NNOGC2eHYBEBjh3jAGw5PpDG9pBgPwk4CknfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTZ0502YUB2d01affOGgaMK8HpNIPqruEipeKpRfwXM=;
 b=NBVz6jXNlah+84CYgkqITJxjuA0TIx09hZTFZJCfELYUUuEOrpmaSufGvrl+dHWNwxIxiMOe9pfhzh/hGa9gzwtFPjuQeeGq4MP17DsZKNI1GuW8IQLMVJanhTqeHHsge2yPC0HZYl+1pw+qzd2kayVQHatLG8u965ty+oZe39tcGLceAWq4ADwzNNOhE+oVcnBQWnykLKo1aJZDNYdR9Mv9y5LWoeUjbhoMhkr3pdVWpQgdyOiGarOzEcPiojQzjJ7N0S8PILMPGZ+dukII22egf3faaPMoxXZ+AELZhNpLkSEBoRm8DpoWjQ872Bh5ZKwsHHjpqj0QT/VsYKXiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTZ0502YUB2d01affOGgaMK8HpNIPqruEipeKpRfwXM=;
 b=XzINQm9XQTcZdrPcJtSjd0TYfkJ1Yf+Kx3VGnM0TcIzs/embN0b3STrCyY8P5mFejSow6nvXPFSQuLBngFJvrgFOvDq8Vd+Pu1poG0ExS6P/C+bJAdxKlxR8Cd2XStmph8jlZQH7Ac6650UcMEoGmg4DE/ml0Dw/dIvI4M4fPpuvGOQ4pBPFtj95KpwEkvOaV87sAHMWNRwEIsAk2BoUat6OUuwJES9boUV8YEPGdDsEdhhRivKJS03hPTHv9PKT8si0eFWu4ZQMLEpL3GpjIog1kleakRqvpOHVVjJJTBKQgfFu4OWICRP5oaNLBwHk7yCrPTGDB3gJiis6cs0IUw==
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 10:10:06 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::9f) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 10:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 10:10:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 03:09:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 03:09:49 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 14 Jul 2026 03:09:48 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<linux-tegra@vger.kernel.org>, Vishwaroop A <va@nvidia.com>
Subject: [PATCH v6 1/2] spi: add new_device/delete_device sysfs interface
Date: Tue, 14 Jul 2026 10:09:43 +0000
Message-ID: <20260714100947.1871359-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1784000000.git.va@nvidia.com>
References: <cover.1784000000.git.va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: baeec245-4078-47c0-bc0a-08dee1901406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|30052699003|82310400026|376014|22082099003|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	5JjJbDVetFJZ8cAqEhtufxmSs0cYsKebMRmerMi6u5y4Y2Hmm+56UzuS1mbwvSnTqVUOcoGocFI7pnFwVKRPIDOUdc4BKWCJVscPM9ubhp9TAtMIPJD5urUm3nTGl/WZvaVMsvFjM3a3V9BCagaSN5e7GVwNSGGy1lXBRBOmhU+71atmoRyHir+RieOb2r/soucfXXgzd1fxNjtxh6hfrmDcfjTSxyyFjj1oTn23qazx1K+4x+JGtIcJt/9CLehxmLufi0sc2UMPzMe/quL3/85aOIrHg+naQP6bRMSH4X+pODPFhhsDl24bk3WiBpU8PvA4364/csMj+SfThJ0oQsqyWJc7B908g2+GfleTMyThdfrF74TU+lM8GdEUizr5Q8s+U+ObbcN1zQbsytC571EgAdFd8dytR1jcsz51m8L70zbAfFn5FYyFSBPQRit6yPXRD3PqXZK13ZESaQoQjuaElZyFdD3BSN0AS8jvHcCY4L3TW83dd7p2P/F1tjvwWgM4hA1afJEMFNq81s9nZnXaV6+V8tx0IZDSTrlLRIb6OuSIAM4yhoi67tc+MMVljNXdLfv0R1Y5koFrdXA2qq58GyuXjJCBENVgJl1Kzd+XZL8AUnewqEjKm5SQIlQk5WwMd+cfuH/uV26qgKVjqAYu3cWuVsGctt0fmbexyXJ7GP1BMvbhudJM5eZx6sNsEH2GoCJPy8LSfPTZSzafCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(30052699003)(82310400026)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BeE3ab96d6S9Gwgn9WTsopm0qYUutTh56uxZ9lktAyGSZxjvo0OT1Cn6SEto/kpSo9PC6Xh5v7LWFElSPEsCG0b5JxBOa/ia/OmyNPBmxXlr4OyaNwMm1NsALuV555D4EJd0OkD+2VbXyA1yaNWalHJ4GEguOB3MH9GvzHBi1xTFDKGaX5GlsR1r0vJ6MYN0iEW+TKGfwRv8QmsN+QbmphOk3sxA1Q8wWctZj9m0LZExUWsrTDxsvV/r487C5Zmr9FQ6Y8TM1RQePyhAu6Bp8Pjb11wUs0deIpEkisn1K58JJzKZhSDrFBhDAvTUNWqYoZlCz7HV1gJiWrIwc4AZcPcHOrtsntFGP+K+rs+Jll/LyEkvu1Xz6TjgyqZMPNdM4eNbnA5uuYzezbZcIeAMKuzTntZudfAqmpBfsGKv5PQDIkzSGrTWNz09GY0DURcq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:10:06.0437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baeec245-4078-47c0-bc0a-08dee1901406
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390

Development boards such as the Jetson AGX Orin expose SPI buses
on expansion headers (e.g. the 40-pin header) so that users can
connect and interact with SPI peripherals from userspace. The
standard way to get /dev/spidevB.C character device nodes for
this purpose is to register spi_device instances backed by the
spidev driver.

Today there is no viable way to do this on upstream kernels:

  - The spidev driver rejects the bare "spidev" compatible
    string in DT, since spidev is a Linux software interface
    and not a description of real hardware.
  - Vendor-specific compatible strings (e.g. "nvidia,tegra-spidev")
    have been rejected by DT maintainers for the same reason.

The I2C subsystem solved an analogous problem by exposing
new_device/delete_device sysfs attributes on each adapter. Add
the same interface to SPI host controllers, so that userspace
(e.g. a systemd unit at boot) can instantiate SPI devices at
runtime without needing anything in device-tree.

The new_device file accepts:

  <modalias> <chip_select> [<max_speed_hz> [<mode>]]

where chip_select is required, while max_speed_hz and mode are
optional and default to 0 if omitted. max_speed_hz == 0 is
clamped to the controller's maximum by spi_setup(); mode == 0
selects SPI mode 0 (CPOL=0, CPHA=0).

The modalias is used both as the device identifier and as a
driver_override, so that the device binds to the named driver
directly. This is necessary because some drivers like spidev
deliberately exclude generic names from their id_table.

Devices created this way are limited compared to those declared
via DT or board files:

  - No IRQ is assigned (the device gets IRQ 0 / no interrupt).
  - No platform_data or device properties are attached.
  - No OF node is associated with the device.

These limitations are acceptable for spidev, which only needs a
registered spi_device to expose a character device to userspace.

Only devices created via new_device can be removed through
delete_device; DT and platform devices are unaffected.

The sysfs attributes are gated behind CONFIG_SPI_DYNAMIC since
this feature adds a new way of dynamically instantiating and
removing SPI devices, and the add_lock locking in
spi_unregister_controller() is already conditional on
CONFIG_SPI_DYNAMIC.

A 'dead' flag on spi_controller prevents new device registration
and list insertion after spi_unregister_controller() begins
tearing down the controller. This avoids:

  1. An ABBA deadlock between add_lock and the kernfs active
     reference held by sysfs store callbacks. add_lock is
     released before device_del() so that in-flight sysfs
     operations can drain.

  2. Orphaned devices that could slip through after the
     userspace_clients cleanup but before device_del().

  3. Use-after-free if __unregister frees a device that
     new_device_store() still references. An extra get_device()
     before spi_add_device() holds the device alive.

Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi.c       | 238 +++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  21 ++++
 2 files changed, 253 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87c89..6bd4fbbd272b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -297,11 +297,209 @@ static const struct attribute_group spi_controller_statistics_group = {
 	.attrs  = spi_controller_statistics_attrs,
 };
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+
+/*
+ * new_device_store - instantiate a new SPI device from userspace
+ *
+ * Takes parameters: <modalias> <chip_select> [<max_speed_hz> [<mode>]]
+ *
+ * Examples:
+ *   echo spidev 0 > new_device
+ *   echo spidev 0 10000000 > new_device
+ *   echo spidev 0 10000000 3 > new_device
+ */
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi;
+	char modalias[SPI_NAME_SIZE];
+	unsigned int chip_select;
+	u32 max_speed_hz = 0;
+	u32 mode = 0;
+	char *blank;
+	int res, status;
+
+	blank = strchr(buf, ' ');
+	if (!blank) {
+		dev_err(dev, "%s: Missing parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (blank - buf > SPI_NAME_SIZE - 1) {
+		dev_err(dev, "%s: Invalid device name\n", "new_device");
+		return -EINVAL;
+	}
+
+	memset(modalias, 0, sizeof(modalias));
+	memcpy(modalias, buf, blank - buf);
+
+	/*
+	 * sscanf fills only the fields it matches; unmatched optional
+	 * fields (max_speed_hz, mode) stay zero from initialisation above.
+	 * max_speed_hz == 0 is clamped to the controller max by spi_setup().
+	 * mode == 0 selects SPI mode 0 (CPOL=0, CPHA=0).
+	 */
+	res = sscanf(++blank, "%u %u %u",
+		     &chip_select, &max_speed_hz, &mode);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse chip select\n", "new_device");
+		return -EINVAL;
+	}
+
+	/*
+	 * spi_device.chip_select[] is u8, so cap at U8_MAX independently of
+	 * ctlr->num_chipselect (which is u16 and may exceed 255).  Without
+	 * this, values in (U8_MAX, num_chipselect) would silently truncate
+	 * inside spi_set_chipselect() and select the wrong CS.
+	 */
+	if (chip_select > U8_MAX || chip_select >= ctlr->num_chipselect) {
+		dev_err(dev, "%s: Chip select %u out of range (num_chipselect=%u)\n",
+			"new_device", chip_select, ctlr->num_chipselect);
+		return -EINVAL;
+	}
+
+	/*
+	 * Reject kernel-internal mode bits (SPI_NO_TX, SPI_NO_RX,
+	 * SPI_TPM_HW_FLOW, ...).  These are set only by in-kernel drivers
+	 * that know they are safe on their controller/device pair and must
+	 * not be settable through a userspace-writable sysfs.  Matches
+	 * spidev's SPI_IOC_WR_MODE32 handling (drivers/spi/spidev.c).
+	 */
+	if (mode & ~(u32)SPI_MODE_USER_MASK) {
+		dev_err(dev, "%s: Invalid mode bits 0x%x\n", "new_device",
+			mode & ~(u32)SPI_MODE_USER_MASK);
+		return -EINVAL;
+	}
+
+	spi = spi_alloc_device(ctlr);
+	if (!spi)
+		return -ENOMEM;
+
+	spi_set_chipselect(spi, 0, chip_select);
+	spi->max_speed_hz = max_speed_hz;
+	spi->mode = mode;
+	spi->cs_index_mask = BIT(0);
+	strscpy(spi->modalias, modalias, sizeof(spi->modalias));
+
+	/*
+	 * Set driver_override so that the device binds to the driver
+	 * named by modalias regardless of whether that driver's
+	 * id_table contains a matching entry.  This is needed because
+	 * some drivers (e.g. spidev) deliberately omit generic names
+	 * from their id_table.
+	 */
+	status = device_set_driver_override(&spi->dev, modalias);
+	if (status) {
+		spi_dev_put(spi);
+		return status;
+	}
+
+	/* Extra ref so concurrent __unregister cannot free the device */
+	get_device(&spi->dev);
+
+	status = spi_add_device(spi);
+	if (status) {
+		put_device(&spi->dev);
+		spi_dev_put(spi);
+		return status;
+	}
+
+	mutex_lock(&ctlr->userspace_clients_lock);
+	if (!ctlr->dead) {
+		list_add_tail(&spi->userspace_node, &ctlr->userspace_clients);
+		mutex_unlock(&ctlr->userspace_clients_lock);
+		put_device(&spi->dev);
+		dev_info(dev, "%s: Instantiated device %s at CS%u\n",
+			 "new_device", modalias, chip_select);
+		return count;
+	}
+	mutex_unlock(&ctlr->userspace_clients_lock);
+
+	/*
+	 * Controller is dying; device_for_each_child(__unregister) in
+	 * spi_unregister_controller() handles the cleanup (it may already
+	 * have processed this device by the time we get here, since both
+	 * paths serialise on ctlr->add_lock).  Drop our extra ref and bail.
+	 */
+	put_device(&spi->dev);
+	return -ENODEV;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi, *next;
+	unsigned short cs;
+	char end;
+	int res;
+
+	res = sscanf(buf, "%hu%c", &cs, &end);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse chip select\n", "delete_device");
+		return -EINVAL;
+	}
+	if (res > 1 && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "delete_device");
+		return -EINVAL;
+	}
+
+	res = -ENOENT;
+	mutex_lock(&ctlr->userspace_clients_lock);
+	list_for_each_entry_safe(spi, next, &ctlr->userspace_clients,
+				 userspace_node) {
+		if (spi_get_chipselect(spi, 0) == cs) {
+			dev_info(dev, "%s: Deleting device %s at CS%u\n",
+				 "delete_device", spi->modalias, cs);
+
+			list_del(&spi->userspace_node);
+			spi_unregister_device(spi);
+			res = count;
+			break;
+		}
+	}
+	mutex_unlock(&ctlr->userspace_clients_lock);
+
+	if (res < 0)
+		dev_err(dev, "%s: Can't find device in list\n",
+			"delete_device");
+	return res;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
+				   delete_device_store);
+
+static struct attribute *spi_controller_userspace_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_controller_userspace_group = {
+	.attrs = spi_controller_userspace_attrs,
+};
+
 static const struct attribute_group *spi_controller_groups[] = {
 	&spi_controller_statistics_group,
+	&spi_controller_userspace_group,
 	NULL,
 };
 
+#else /* !CONFIG_SPI_DYNAMIC */
+
+static const struct attribute_group *spi_controller_groups[] = {
+	&spi_controller_statistics_group,
+	NULL,
+};
+
+#endif /* CONFIG_SPI_DYNAMIC */
+
 static void spi_statistics_add_transfer_stats(struct spi_statistics __percpu *pcpu_stats,
 					      struct spi_transfer *xfer,
 					      struct spi_message *msg)
@@ -729,10 +927,10 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 		return status;
 
 	/* Controller may unregister concurrently */
-	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
-	    !device_is_registered(&ctlr->dev)) {
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	if (ctlr->dead)
 		return -ENODEV;
-	}
+#endif
 
 	if (ctlr->cs_gpiods) {
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
@@ -3259,6 +3457,10 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
 	mutex_init(&ctlr->add_lock);
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	mutex_init(&ctlr->userspace_clients_lock);
+	INIT_LIST_HEAD(&ctlr->userspace_clients);
+#endif
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->num_data_lanes = 1;
@@ -3620,8 +3822,35 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
 		mutex_lock(&ctlr->add_lock);
 
+	/*
+	 * Mark dead and drain userspace_clients before __unregister,
+	 * since spi_unregister_device() doesn't do list_del() itself.
+	 */
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	mutex_lock(&ctlr->userspace_clients_lock);
+	ctlr->dead = true;
+	while (!list_empty(&ctlr->userspace_clients)) {
+		struct spi_device *spi;
+
+		spi = list_first_entry(&ctlr->userspace_clients,
+				       struct spi_device,
+				       userspace_node);
+		list_del(&spi->userspace_node);
+		spi_unregister_device(spi);
+	}
+	mutex_unlock(&ctlr->userspace_clients_lock);
+#endif
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
+	/*
+	 * Release add_lock before device_del(): holding it would
+	 * deadlock against kernfs_drain waiting for in-flight sysfs
+	 * stores.  ctlr->dead prevents new device registration.
+	 */
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_unlock(&ctlr->add_lock);
+
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_controller_idr, id);
@@ -3641,9 +3870,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (found == ctlr)
 		idr_remove(&spi_controller_idr, id);
 	mutex_unlock(&board_lock);
-
-	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&ctlr->add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c285d3ede1d..817fba2cb12b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -179,6 +179,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @num_tx_lanes: Number of transmit lanes wired up.
  * @rx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
  * @num_rx_lanes: Number of receive lanes wired up.
+ * @userspace_node: entry on the parent controller's userspace_clients list
+ *	when this device was instantiated via the sysfs new_device interface
  *
  * A @spi_device is used to interchange data between an SPI target device
  * (usually a discrete chip) and CPU memory.
@@ -252,6 +254,10 @@ struct spi_device {
 	u8			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
 	u8			num_rx_lanes;
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	struct list_head	userspace_node;
+#endif
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -555,6 +561,12 @@ extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
  * @defer_optimize_message: set to true if controller cannot pre-optimize messages
  *	and needs to defer the optimization step until the message is actually
  *	being transferred
+ * @userspace_clients: list of SPI devices instantiated from userspace via
+ *	the sysfs new_device interface
+ * @userspace_clients_lock: mutex protecting @userspace_clients and @dead
+ * @dead: set to true when spi_unregister_controller() begins teardown;
+ *	prevents __spi_add_device() and new_device_store() from racing new
+ *	device registrations against controller shutdown
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -807,6 +819,15 @@ struct spi_controller {
 	bool			queue_empty;
 	bool			must_async;
 	bool			defer_optimize_message;
+
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	/* List of userspace-instantiated devices; protected by @userspace_clients_lock */
+	struct list_head	userspace_clients;
+	/* Protects @userspace_clients and @dead against concurrent sysfs stores */
+	struct mutex		userspace_clients_lock;
+	/* Set true once spi_unregister_controller() has begun teardown */
+	bool			dead;
+#endif
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
-- 
2.17.1

