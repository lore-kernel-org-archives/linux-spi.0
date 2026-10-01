Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB84BA9F2;
	Thu,  1 Oct 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846011; cv=fail; b=J3h7w96umct+1pZ/R/HQ1Vpa8u4eq/cNCvpg25aPlRmtWtbojWwAseb/lSdg9pTcz86VH56sjOvr2j+S3VydCDsCG/yCXLejlfzvz4dsPGO7hdGKPZ+S8knP3Tbbzsfw1ojfbErBBYuMKa4DQoXgVn2B55fTtXxs89OWFA3tMlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846011; c=relaxed/simple;
	bh=kRgMGN1Yw62r2FthGOhbpUQjMj3csljulOlOx1hAw1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pdDkjEqeceUwNrf/MyRjHMKVI4SLdZVfwPqivF8Gn8jUNnn+pZS3SX9+stUDqH81XJp844ZpSzc+9l9I/XCD6w6BD6MCGVdAjHWhitBt1rBiSbB7O8s/x+Memm+cJBjp76Y5EwQRPj0xfKgQl1rlrVeNuS1c1OYNVCp87pL4MrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QvMYmd4A; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=GtXnPV9l; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QvMYmd4A";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="GtXnPV9l"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6914qidV3043943;
	Thu, 1 Oct 2026 03:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=zDNEH2ZPXJ4zQ1ka
	d1HTLfwuPKnXI9MMO8bT+1FWvsE=; b=QvMYmd4ABqFgBaCylOhX6YFOUNjiCb+t
	xLifecgrVbIGvqcnkUoy2bi9TWlxoyY30wk+2AQ/5Py3+mHOQI/6v8/92K1iATNv
	IFSoP+HfbkGqTbJtauJKk13TaWl56U0HsYpF6iaB9NrUcG/CGxPUSkiqwiXcsduX
	PO9o+SjWql4OVgzA1Qwa3Mjavn+ff4kK5yGqeHvO8ZDPxxbsfNIx7lskxYlUUZl7
	3NcVHtsO/jPGdss9HKG8fUTNXcCYWK5aolaVdqORqrVcnfjDzp7UwZlHxAeXvyna
	w/Uoomm6D+JidhTqyUQxA+Xcg+WS/IJBEp71DRKP1sUpuSCuf/XEhA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022083.outbound.protection.outlook.com [40.93.195.83])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4h1gv7g6uv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 03:58:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXgMcr//Kds8LLfqSH91J5O5wsksPEooNFCAKssjiQNRBydHDm6SW3A3OdwVjshEG7d0Xzi7pcEjb2Eek3GWDtj9xBlQpizTbR6Mu3VS1/TUv9S0RR5iMHtUeXRY3ZPPXiayCMfLqx5tj0U8qiCifcMyRjAiBHrKEzTepbF+v/vYVPwbZW6LST42x1hkt2/hyn5E1+rSf7GpCupe6eKLk7xapZ8XYUpymzWzEYtjBboFBGXPWSJwAm+seuZ/q4K/xoGvdpn0AsS5HXDTLY8wEQLLC6yY06IuCzXFiHSWGU2kDnenLGLBwEGcjcJ7YRKGJAks6xK8wc471NNiTht9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDNEH2ZPXJ4zQ1kad1HTLfwuPKnXI9MMO8bT+1FWvsE=;
 b=Z9ScIZprdYmIRT28h0QG43+dGTeJv74aOUb/HVF7adKEdCEn9rW6OV+KwXJ0U1UgI30HTjfaYqOfP+tnNgOWTLy54Rp+Q8P6UYuuIL8XtArZtOBaQ8+fpGqjksJjhzWmMQVXwEwcIFsyEfcSdDuOZciFD80RiJlC2uzoPosKnVgOu4UWuYOTYGUiFP0SZ6K19He6utsEmTznQ8AQcdA8XgSbZpWlxj0abFonEyzAN0snCQ3uBQDWdfetwStg0bGButWVK9Rh6U2dviAK43vI32oPDYEADWCO/mvEfc1xo48Kaa8MSS9uQ24/TBlxMzF0xnZcXC7mdGS8tE+T2gl8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDNEH2ZPXJ4zQ1kad1HTLfwuPKnXI9MMO8bT+1FWvsE=;
 b=GtXnPV9lJUMf+snVw3ZfBo59J9flSApb3LApAYQfz57bmozg442ZJovIyVF5Vgpgm3TmcD1Q4w42vWQ4cPbkCFMcd95WL1adfpcItnVeJ/6VClJ/b6wGNZbUe+nVM0wMSOOVVDJic24XcRcOcoGKPF10d+C3t3wUb4MO5z/znBg=
Received: from SJ0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:a03:39f::32)
 by IA1PR19MB7278.namprd19.prod.outlook.com (2603:10b6:208:429::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 08:58:33 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::96) by SJ0PR03CA0237.outlook.office365.com
 (2603:10b6:a03:39f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 08:58:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Thu, 1 Oct 2026 08:58:32 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2BBF0406544;
	Thu,  1 Oct 2026 08:58:31 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0D0E582254B;
	Thu,  1 Oct 2026 08:58:31 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH v2] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260
Date: Thu,  1 Oct 2026 09:58:30 +0100
Message-ID: <20261001085830.4014291-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA1PR19MB7278:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 14e514e6-5f0f-442b-a32a-08df1f9a2bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|23010399003|376014|36860700016|82310400026|56012099006|11063799006|10067099003|6133799003|18002099003|13003099007|16102099003;
X-Microsoft-Antispam-Message-Info:
	rD6vP4mPTE+wH11FP7UiXxli1PYamxmbHkfDBblvhVBFmwTLH5wvzjGFAWn9qIjpAVbdkLIugQ+1IW77fsOJV7vVVFiOykzvuzNFh3kFdgODL9ur/A5milUbHtUeVs02Ju0cCfEzUxfN5pfiZ7Y0hrjOYki/mxwIj+IptukYfHF/k4iTI9o4+fVtiW1PW8S8KuQxoUtGSrJqiG1iqBX2DcOSkL3XqayqHqQ8Inyf5F4f/iAvOFKDlYgvJc7QlR2K5rsolifLfnFy7wVE3r0bYXGmLxsSYkXB9ibzyN0VVfEYvzLFcI86M5hV7YDDN0g4/GZSEFvN9cMlW9c80v2MSGoofVLYxVjZ/1Vhvk8PndVLAo4jI8XzmwYVZIuaPtlEhVg47CshN9JUUT3f/BTCWCdcpegAz4eZ+7UEIfgkDkctqWyLKlpl5lU0IYpABqF4PiFRYm+R1f9IlCXPngCu3ZrblmEZDUwU5i5Md9brHskiRHsBAn/C/68lQpIO0xL+FWUw2h8rwVSSDaeuvMiYL1DiFF/inqxpruHi6P7c3Qs4pLORXF0cQ0akFcabDAkL7r/50RAJM20IOPHRiuUBuUjFBVWceuuDlR9YT9YtiGZV2jU4ulvifCJNBSRTS+B5SguvmamQkKSA3R445uIxVVD7jGWO+JZnHUDBI+rgJl8=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(13003099007)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5gnPYGTH+OFErDF+Elfe+5DX1bpOAD3mMW5RLPWy9iG4klHIPeUw5DN4XmdswHWaRXZaH5QkYY2RofITPUevhhUtSgvp5XP+b/ngr596SbKupawaTWsMM7kcQzvTPgvA4hj+gPOtCfT4TpBFtsz5B0aWsBoelU+RSC9g69fyLAOXDp6wQ7EhbJRCsjmfaZVhrCS6dzcbZPBdkfDq2ZeAhP0lJ2bhSCNg/yEp60Z+Z79jHl+z62o7d+Y4+DJdqmoxA7zpB4FUVe0T3ZWCEIlPU2hRFFy0yFR9BHFEy558hYqlCaa4V1zkNrRlKzDO9bqxgrri0QWILjeBNql3iZ1CaS+NZGPLGwg1VzzuI+wgR64wEQKJ/0qkJFPnfzzEgKVZ95otv7RikZFjDZH2LsrHZx8tZ6xKNWyHFBwQ2WNIy6UZz7FDHTfqLFHuCW+9tMZG
X-Exchange-RoutingPolicyChecked:
	VyP7fzbQhp72ucnbpD3VON1wIhIXEJPbDTs/MN+RWHMoUkJFuqNonGvNXXuqoJhwGr6d7B6VRmeBbF82Dzo3o/gPlcF9V+zRI5pm1GZ/seDWt/7m73iVAP6af2GWfsz2jkxhRKjlafc2pN/rjNAyyaqs5Xv81R1UX4CXuEkknPNKg4udwbDRvJdfjq56rdgAX+j2oI4Sb7GbFL3Ghx3uqAeTFAukV0oYCnOfFeoadH86YlGCVvGPQm8BKOzO6e42gyGxkLqFo8yEGczrIc0gHdL2f0T9dU0/fcQXizrBLtEwi4FBbiSv4czSOKuvc++9ESe45GXmuZ//92aEFgOEgw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:58:32.9713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e514e6-5f0f-442b-a32a-08df1f9a2bf6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7278
X-Authority-Analysis: v=2.4 cv=JtBkP84C c=1 sm=1 tr=0 ts=6abe20c4 cx=c_pps
 a=qXrkyhrtrlo5bn8cMY6OCA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=781EvAJ9ysGJopcBSz8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNSBTYWx0ZWRfX8Bju2/XBKgC+
 VE5vkIKfZcxKL1w+iWz92WVeV9j8pj7m93e73cJrWyOndjXsj6/QgiVwBhBMpS3GNFNlRgz20g9
 EGRjr0sopU8uUX6MAVuhsJ2Dy3TRkQFOGaITX79EauK9irv8EmvZkLem0NUZ2Iu+SOcM5yuKKuP
 FGeI98SxHr74MSuLEmGrea4yMTDe0BHActIA4pKs55SFOGT4MTf+BbK0QzuGuZIVzNjeYr44ppx
 8DaPURsGJo7xhJp/SpIbDTcV82pqbH/UKGV7VsOXAjZXrV5Bmp1bGMHXQOxMfgdb3du8JwJWFo+
 60MxYGg4XIA2QhpReal6TBEX3rlBywoaeVJMqZKSTtw0LX1GL1B50kUycmcpMgf8ikVZov6Vqfp
 b4DCgss9GYlaARfkY6WZp30gKt+reLVq6wuzIzqP1uv3VND8y1NwniKRcwJ5mRGfIlXGIxiu/QK
 EIS9/fH1rIzqHPBD6LQ==
X-Proofpoint-ORIG-GUID: SegMoQvuJKw-ut2O5RJDx8fUF4U47z3t
X-Proofpoint-GUID: SegMoQvuJKw-ut2O5RJDx8fUF4U47z3t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNSBTYWx0ZWRfX4ZtTdHVaZmG0
 G0TYouGlb3yb1um4WrQh7H/Ry1onNAhv0fvwkaxNNWSLkF2DwNspLjZZXAocnGjfuPGsaPVW4j3
 jeduesB3mqpvIHhYDk1/G879Tmrv+0o=
X-Proofpoint-Spam-Reason: safe

On Dell XPS 13 DX13260 create an acpi_gpio_mapping with exactly two
GPIO entries to point at the two pins in the GpioIo(). Use this to
read the speaker ID GPIOs.

This fixes problems on Dell XPS 13 DX13260:

- No speaker audio
- The wrong firmware was loaded so the speaker protection did not match
  the speaker characteristics.

The Dell XPS 13 DX13260 has two speaker ID GPIOs, to form a 2-bit ID. The
ACPI GpioIo() has both pins but the Linux-specific spk-id-gpios property
only has a mapping to the first pin. This meant that the speaker ID was
wrong in most cases, and that would lead to the codec driver loading the
wrong amp firmware, or not finding a firmware (as 0 is not a valid ID on
this laptop).

Assisted-by: Codex:gpt-6-sol
Reported-by: Wiza Jalakasi <wjalakasi@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221956
Tested-by: Wiza Jalakasi <wjalakasi@gmail.com>
Fixes: f3c605147741e ("spi: cs42l43: Add GPIO speaker id support to the bridge configuration")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes in V2:
- Rewritten to be a DMI-specific quirk. We need to leave the original
  GPIO code in place to support a proposed ACPI change for future
  products.
- As it's now a quirk for the specific model it is hardcoded to be
  two GPIOs.

 drivers/spi/spi-cs42l43.c | 97 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 7106a8a4f2805..6772abb483dd3 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
@@ -215,12 +216,108 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
 	return CS42L43_SPI_MAX_LENGTH;
 }
 
+/*
+ * Workaround needed for two speaker ID pins in one ACPI GpioIo() but
+ * the Linux-specific _DSD property only contains one pin.
+ * Create a temporary acpi_gpio_mapping pointing at both pins.
+ */
+static const struct acpi_gpio_params cs42l43_2bit_speaker_id_from_one_gpioio_params[] = {
+	[0] = {
+		.crs_entry_index = 0,
+		.line_index = 0,
+	},
+	[1] = {
+		.crs_entry_index = 0,
+		.line_index = 1,
+	},
+};
+
+static const struct acpi_gpio_mapping cs42l43_2bit_speaker_id_from_one_gpioio_mapping[] = {
+	{
+		.name = "spk-id-quirk-gpios",
+		.data = cs42l43_2bit_speaker_id_from_one_gpioio_params,
+		.size = ARRAY_SIZE(cs42l43_2bit_speaker_id_from_one_gpioio_params),
+	},
+	{ }
+};
+
+static int cs42l43_get_2bit_speaker_id_from_one_gpioio(struct cs42l43_spi *priv, int *result)
+{
+	struct fwnode_reference_args args;
+	struct acpi_device *adev;
+	struct gpio_desc *desc;
+	u32 spkid = 0;
+	int i, ret;
+
+	/* Use the _DSD property to get the node containing the GpioIo() */
+	ret = fwnode_property_get_reference_args(dev_fwnode(priv->dev), "spk-id-gpios",
+						 NULL, 3, 0, &args);
+	if (ret)
+		return ret;
+
+	struct fwnode_handle *fwnode __free(fwnode_handle) = args.fwnode;
+
+	/* An acpi_gpio_mapping must be added to the node that contains the GpioIo() */
+	adev = to_acpi_device_node(fwnode);
+	if (!adev)
+		return -EINVAL;
+
+	ret = acpi_dev_add_driver_gpios(adev, cs42l43_2bit_speaker_id_from_one_gpioio_mapping);
+	if (ret)
+		return ret;
+
+	/* gpiod_get_array() can't read from a mapping in a child node */
+	for (i = 0; i < ARRAY_SIZE(cs42l43_2bit_speaker_id_from_one_gpioio_params); i++) {
+		desc = fwnode_gpiod_get_index(fwnode, "spk-id-quirk", i, GPIOD_IN,
+					      dev_name(priv->dev));
+		if (IS_ERR(desc)) {
+			ret = PTR_ERR(desc);
+			goto out;
+		}
+
+		ret = gpiod_get_value_cansleep(desc);
+		gpiod_put(desc);
+		if (ret < 0)
+			goto out;
+
+		spkid |= (u32)ret << i;
+	}
+
+	dev_dbg(priv->dev, "spk-id-gpios = %u\n", spkid);
+	*result = spkid;
+	ret = 0;
+out:
+	acpi_dev_remove_driver_gpios(adev);
+
+	return ret;
+}
+
+static const struct dmi_system_id cs42l43_spk_id_quirks[] = {
+	{
+		.ident = "Dell XPS 13 DX13260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0E53"),
+		},
+		.driver_data = cs42l43_get_2bit_speaker_id_from_one_gpioio,
+	},
+	{ }
+};
+
 static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
 {
+	const struct dmi_system_id *dmi_id;
 	struct gpio_descs *descs;
 	u32 spkid;
 	int i, ret;
 
+	dmi_id = dmi_first_match(cs42l43_spk_id_quirks);
+	if (dmi_id) {
+		int (*get_speaker_id)(struct cs42l43_spi *priv, int *result) = dmi_id->driver_data;
+
+		return get_speaker_id(priv, result);
+	}
+
 	descs = gpiod_get_array_optional(priv->dev, "spk-id", GPIOD_IN);
 	if (!descs)
 		return 0;
-- 
2.47.3

