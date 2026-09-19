Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D6FC0A;
	Sat, 19 Sep 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825662; cv=fail; b=gAMbSzlfV7F9fbl/a+WXjCYZ0hltEWCwWCTJVyXxaplGecS2kyxLO+n0yA+UNG5bs8WJryopke/ES+OMTSA64XuVAyj1d13ddCbiJKUqjAK7NhYohq5HMt41Szwrv6zNrmAGVvv8Hx67BYc0BqlbjmpY2WwjWO9pK82g0coExx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825662; c=relaxed/simple;
	bh=5L8cUQt16sYANAQosW16Qh14/wzLehSlMcwKrGQGUb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eoq0gmVPvGnPPIrw/7yPYXg6RSE6u/uX4ReEpMSekaPZt70QGUGwIIinOtf78AH3sztLZKL6JVFtuV6xm8e33It4tKLVkm1gfu+2zogZ+sfWjhnajxDO/KtDEy1K8CDAsSdyNeKgUSdmWpmTNSGV02pUMGwHpkdxLMtpmDrRNi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NMWI1hQp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=gYk0Ee/i; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NMWI1hQp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="gYk0Ee/i"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68JDSeWb923208;
	Sat, 19 Sep 2026 08:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Yuz7KD5PDM1De8zQ
	4iYkZJuNrmPxHKwh/0JFgRo/M3c=; b=NMWI1hQp79nBQHYzsxziOWl12DELPLUa
	OS2zb+YO9wvfvdQ3a4Ae4GBabI50EA9oMeTV/2qnwGlXaNkuytgTwbbUyRYJoVaX
	NfPzbH98JGyFOiY8nbRoYcj4yz1zRgnObai0wBVt+ykzl5ZZ2+ALGsFDvDMyvbIe
	gbxHfcvTgcfnnS//0P9OsuK01iomdVxjvZkNAoPajODGWjmANF9Ky5dJ9eNSXwJb
	RRWW5tkMPjIo/b7ChHVK36ZgS6d7IEJFucr5WrY8n5036IhLfgjXDyvRAkUobiI/
	GxmSlgcOvFr7hd2qnRiHIkCtrswjy1AYdltpsgY0kR0pgj9cWhnaTA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022118.outbound.protection.outlook.com [52.101.48.118])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gsqt084jk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 08:47:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPgnSuZUqq4oOQoSq2Mh548+8l2Dj3PuMklMTZTtjr9WpSvCK1Ahs/U/YdTryJYDdJjnI5FecB8Z/SmcEpDukSUk3s2ZNwYQJRqD3iljf2i4QlLidqgDOaH1Dz/8MI6qJ65JOO1lTe4hpfEx5RNoagYpU7EtJBV2aVflqAKX/v1in0ndXIZsJ/p1j7XzYx/mKizeiiSafXSl8oU6HPS+k53/HGThF4nD2jJfCwIgRX83+rU+4L/6wEGCnpl9Dss5AxN5pFazYnpPziSx6QbPd3CeS9Vdl37ocJGkmggSF4aLgT48XPQV7FXO8tC1vrxh+jSSxUxzDrSumFsMBeCCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yuz7KD5PDM1De8zQ4iYkZJuNrmPxHKwh/0JFgRo/M3c=;
 b=RhHzHXSXXyEIgshHPOvJjFxo0V/mwtB+CbvKnwn8ygKmTDPYQZf9G4UUbhYYYphEh5AjR7FRJR7zkZepr3d2XwqwNNHc38deWFy89hvJA8N9Hnnn424s39S6lFdacQpAexqBP6uEnmzxZYMkT7bzo2rsj+hp2gu4uFEu/brmilba3xBr00b7kQ1WUyQyIpmDOmIek97MXJ9e7GSiId7FcwnOZWGmqOcXXVYqfCcqGYwHJhVbVM3BbfWoLT4hZHPRuW1dFrhAckKwIre9zyKILJhAdqAhUAJ2DxmJgBr3j2XVyt+CX4r7FmXar90BONNUe4whe+IQKsDapsrLGXjv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yuz7KD5PDM1De8zQ4iYkZJuNrmPxHKwh/0JFgRo/M3c=;
 b=gYk0Ee/iXYK+F3W7Clm15hrNrtr3ho2PBKyhAnK5PAX9iJ1/8VeQcrzBSOLixzSqaqdR8k2Sp+xh9cU9qVdKIVCoJugWZHD/NA9BCnF2YGcDbjFaX7Hj4qhNtQO0QVjEUgpdjKyC2GzgOriEfJRemKHPkxMQRirZf3iXE6eRX3c=
Received: from SJ0PR13CA0232.namprd13.prod.outlook.com (2603:10b6:a03:2c1::27)
 by SA1PR19MB8997.namprd19.prod.outlook.com (2603:10b6:806:45b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 13:47:33 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::69) by SJ0PR13CA0232.outlook.office365.com
 (2603:10b6:a03:2c1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.10 via Frontend Transport; Sat,
 19 Sep 2026 13:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Sat, 19 Sep 2026 13:47:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2FC28406542;
	Sat, 19 Sep 2026 13:47:31 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0AED1820247;
	Sat, 19 Sep 2026 13:47:31 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260
Date: Sat, 19 Sep 2026 14:47:30 +0100
Message-ID: <20260919134730.895381-1-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|SA1PR19MB8997:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 02fd68b3-b8e5-48c2-a1bf-08df16548e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|23010399003|36860700016|13003099007|16102099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3YzaQMddssxz32EW++gcJw+4kGDaQanjFhweppRd3kgJPMpVEC3Q3gAmo2tmwq6MdUVkSbFJ95RoY64ErZL3BZPm1AUG/DzUdZO3NsCmq+UtyZI+QuoK6QvYNQcFSDJu84UOwdGqP23b0LtMAfzwt2VeQfeWEBOUkxQ1k9MVR8F9SxrZgieB0UK+XB5WxwSUObG1DddvubvRIRKKGoxuvr/btsGptzUIxJQ8Zw/rvlVglU5l0LBdTjcL4Z5lQiH8vZyYiwJ9ieKui2CcYuFlfSencAL0TtghaDBfPt0IibLEjes3v2745MYairjKo+TPwRLeGYKxQK+W+Ocx/1SlgI0zOmIZSnwQ2T3kywB4PTXFuSrMe5FKby2e/TGpB1PsjP4/YvaX20NzX0hNdxjvv9/5tz6oXou4LlKzcz32YxwgMKQ3xQshO+63zr7iiOm+ZaUwrIKZCAarm3B4C60UVmgXS6yuWkYLiqmtTX7hQ/lQygvmwnwK6Qk6zGcy0xbtk1XuPcrS4u/X3H/SUOTcF0BjwGs5BmYxvWsUCW4giXES1uyCCK/SRPvE4aPRHr2fjv579hk2sjAChg519IXUZRgWZkNIjuXMlGGBFHuKHAChwVnUt7XOlny1E4ZpWtGiGGqmpGfHjETsaNMT9B2GAOz7mEfqSn9+9ICIH7zpqKZ6xiBOJ1MFqG6RVB2MUkhNcpxWJbh/DLjMe5N4Rw72Tw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(23010399003)(36860700016)(13003099007)(16102099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A6ui1sQOHKcfWN/jw1NhH4hnYEr4QfHsXjznS+S9PoNOJLCRKp+2utBoy4HezAjD2SaWe/6ikIpbnaY7bg4iwVje8CRif85CwyIU8+N4qXwMO8sUyFrJBjFHXV62g49A4ptNzbxNaeZobDvXi65+hEWcMfx34aF89MvsDkinl5KKFjDfwiDOYYr4k+WUWN7WSnrOcGIxVVnYjqXZ0ch9h2TnXJEQBXGX9sSL8Iqk94i20u+eoM8W0tLvOTzAhfqCwtsr0o6+QlsnC35MupUcHKCFCXTv8+BSW4Bjfxxg3JHnDPs3letKZSpoh0njfzYNzPbJKk68Rl5WYZH/AAWMO8jBw45E69arU9t5r2WoNDuSjnaqx24YERp44tZNeuS2KLxhouWdATmN7/0aWXO9Cm9d+Byujd9TwYg8XKTC1mOKpCW8bFop4TOTVtcT7ztZ
X-Exchange-RoutingPolicyChecked:
	Z1uTvW1ypHpx8k2rJUZYc2ejJ/UdLCyxDjXq7izaW8MMS9oW08WXpFBj8a5KRfX/NfVtNuFqG0fiv1zJ89iFb5gTjYFszw7PnRmE3mr+YIH62+21VsxGapD2CNqPGNJ2zO72UgFvjqugM3MkqXVf9Dv6zM7Swxlpn8ZXkuuMC3tOdR9ro8/XrJe8uYOk+VxnnrP76ddklmvKcJgyKC9eaKoCu0jr49HjVKd5q/2SAYZDkRy9jxhJcQYqdVik+EV/xZ5flMszytA+5/3BMRsusMKJ5EsRVG75/wHc6jNWcQL5popAKPZtZ82yOrJ9F7oRyZIF2t4XlMxOe8PwMtxOuw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 13:47:33.0712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fd68b3-b8e5-48c2-a1bf-08df16548e83
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8997
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDE5OCBTYWx0ZWRfX+KcxFVH83oI/
 z1FlVJmoGS8mZHCju3JX72F5hpJwDUS/FFSITqQNQOpQcH20lH7pjbAR5U5O6IXWnhlP2HKBv6z
 McINpx/HMmTdwL7+lQXknLm7+hvPV/t3EI3jLaYVWxwSyyPurdoDTOv5m+A+WmgWBKYA7mf46aE
 E6gbMaZrC7QRpjxqzJGAWuERpsRo8ih6d1+PgCKCkDBVBDL4mTBOWHbEJygTSUo3dyD/YB+cZVR
 +ym0A3bpA3IzeicwZIuhI0KOGBdvnuCSbp6KJkgLZFD1jhPQHzLhTj7svCel6XgWLYs9HSZ0b4W
 bASi+KQpV/FXBUqgZwaSskS48OtUOwmL3p/NHcPqClN15HjOdezezaPTYYWu1AVPXx/M510r1LQ
 dNcGZK0zdeRSwnqkVVjirmg4DGP81yl7RmB3hX9R0Ncz2LYiGE2UmgvdzhGuQ8Y/oACS1/mNae8
 R8pNVIVEZAdthoMZj7g==
X-Authority-Analysis: v=2.4 cv=TPTQ2Fla c=1 sm=1 tr=0 ts=6aae927a cx=c_pps
 a=Jb17x8V3W++mjBIvuY/Z3g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=agGuP1jirnaObcj7zIIA:9
X-Proofpoint-ORIG-GUID: i4Tks2zn4DoVY2NMnmX0x7IPm-9zUapu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDE5OCBTYWx0ZWRfX09Ew0EuGXIFf
 w9BoDsxiM6x4D5T5k6rvtj2GUPRVc/q8CTglDsv57uHVZrwdvT0yTSfbO/1S2m50f4/cth5oMjt
 PTAHxZNTnV9YWnrA4LqMVOLP0N8jqaI=
X-Proofpoint-GUID: i4Tks2zn4DoVY2NMnmX0x7IPm-9zUapu
X-Proofpoint-Spam-Reason: safe

Create an acpi_gpio_mapping so that speaker ID GPIOs can be read directly
from the ACPI GpioIo() instead of relying on the spk-id-gpios property to
have the correct number of pins. Change the reading loop to read each pin
one at a time until it reaches a pin index that doesn't exist.

This fixes problems on Dell XPS 13 DX13260:

- No speaker audio
- The wrong firmware was loaded so the speaker protection did not match
  the speaker characteristics.

The Dell XPS 13 DX13260 has two speaker ID GPIOs, to form a 2-bit ID. The
ACPI GpioIo() has both pins but the Linux-specific spk-id-gpios property
only has a mapping to the first pin. This meant that the speaker ID was
wrong in most cases, and that would lead to the codec driver loading the
wrong amp firmware, or not finding a firmware (as 0 is not valid on this
laptop).

Instead of quirking this specific system, the code can be rewritten so
that it will always use the direct GpioIo() mapping. This works on all
ACPI systems, so avoids having to keep adding quirks for other systems
that have the same ACPI error.

Assisted-by: Codex:gpt-5.6-sol
Reported-by: Wiza Jalakasi <wjalakasi@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221956
Tested-by: Wiza Jalakasi <wjalakasi@gmail.com>
Fixes: f3c605147741e ("spi: cs42l43: Add GPIO speaker id support to the bridge configuration")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 131 ++++++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 7106a8a4f2805..ee227205010f7 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/cs42l43-regs.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -29,6 +30,7 @@
 #define CS42L43_FIFO_SIZE		16
 #define CS42L43_SPI_ROOT_HZ		49152000
 #define CS42L43_SPI_MAX_LENGTH		65532
+#define CS42L43_MAX_SPK_ID_GPIOS	8
 
 enum cs42l43_spi_cmd {
 	CS42L43_WRITE,
@@ -41,6 +43,12 @@ struct cs42l43_spi {
 	struct spi_controller *ctlr;
 };
 
+struct cs42l43_spk_id_gpio_mapping {
+	struct fwnode_handle *fwnode;
+	struct acpi_gpio_params params[CS42L43_MAX_SPK_ID_GPIOS];
+	struct acpi_gpio_mapping mappings[2];
+};
+
 static const unsigned int cs42l43_clock_divs[] = {
 	2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
 };
@@ -215,31 +223,118 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
 	return CS42L43_SPI_MAX_LENGTH;
 }
 
-static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
+static struct cs42l43_spk_id_gpio_mapping *
+cs42l43_add_speaker_id_gpio_mapping(struct cs42l43_spi *priv)
 {
-	struct gpio_descs *descs;
-	u32 spkid;
+	struct fwnode_reference_args args;
+	struct acpi_device *adev;
 	int i, ret;
 
-	descs = gpiod_get_array_optional(priv->dev, "spk-id", GPIOD_IN);
-	if (!descs)
-		return 0;
-	else if (IS_ERR(descs))
-		return PTR_ERR(descs);
-
-	spkid = 0;
-	for (i = 0; i < descs->ndescs; i++) {
-		ret = gpiod_get_value_cansleep(descs->desc[i]);
+	struct cs42l43_spk_id_gpio_mapping *mapping __free(kfree) = kzalloc_obj(*mapping,
+										GFP_KERNEL);
+
+	if (!mapping)
+		return ERR_PTR(-ENOMEM);
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(priv->dev), "spk-id-gpios",
+						 NULL, 3, 0, &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	struct fwnode_handle *fwnode __free(fwnode_handle) = args.fwnode;
+
+	if (args.nargs < 3)
+		return ERR_PTR(-EINVAL);
+
+	if (overflows_type(args.args[0], mapping->params[0].crs_entry_index))
+		return ERR_PTR(-EOVERFLOW);
+
+	adev = to_acpi_device_node(fwnode);
+	if (!adev)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < ARRAY_SIZE(mapping->params); i++) {
+		mapping->params[i].crs_entry_index = args.args[0];
+		mapping->params[i].line_index = i;
+		mapping->params[i].active_low = !!args.args[2];
+	}
+
+	mapping->mappings[0] = (struct acpi_gpio_mapping) {
+		.name = "spk-id-gpios",
+		.data = mapping->params,
+		.size = ARRAY_SIZE(mapping->params),
+	};
+
+	ret = acpi_dev_add_driver_gpios(adev, mapping->mappings);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mapping->fwnode = no_free_ptr(fwnode);
+
+	return no_free_ptr(mapping);
+}
+
+static void cs42l43_remove_speaker_id_gpio_mapping(struct cs42l43_spk_id_gpio_mapping *mapping)
+{
+	if (!mapping)
+		return;
+
+	if (mapping->fwnode) {
+		acpi_dev_remove_driver_gpios(to_acpi_device_node(mapping->fwnode));
+		fwnode_handle_put(mapping->fwnode);
+	}
+
+	kfree(mapping);
+}
+
+static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
+{
+	struct fwnode_handle *gpio_fwnode = dev_fwnode(priv->dev);
+	struct cs42l43_spk_id_gpio_mapping *mapping = NULL;
+	struct gpio_desc *desc;
+	u32 spkid = 0;
+	int i, ret = 0;
+
+	if (is_acpi_node(gpio_fwnode)) {
+		mapping = cs42l43_add_speaker_id_gpio_mapping(priv);
+		if (IS_ERR(mapping)) {
+			ret = PTR_ERR(mapping);
+			if (ret == -ENOENT)
+				return 0;
+
+			return ret;
+		}
+
+		gpio_fwnode = mapping->fwnode;
+	}
+
+	for (i = 0; i < CS42L43_MAX_SPK_ID_GPIOS; i++) {
+		desc = fwnode_gpiod_get_index(gpio_fwnode, "spk-id", i, GPIOD_IN,
+					      dev_name(priv->dev));
+		if (IS_ERR(desc)) {
+			ret = PTR_ERR(desc);
+			if (ret == -ENOENT)
+				break;
+
+			goto out;
+		}
+
+		ret = gpiod_get_value_cansleep(desc);
+		gpiod_put(desc);
 		if (ret < 0)
-			goto err;
+			goto out;
 
-		spkid |= (ret << i);
+		spkid |= (u32)ret << i;
 	}
 
-	dev_dbg(priv->dev, "spk-id-gpios = %d\n", spkid);
-	*result = spkid;
-err:
-	gpiod_put_array(descs);
+	if (i) {
+		dev_dbg(priv->dev, "spk-id-gpios = %u from %d GPIOs\n", spkid, i);
+		*result = spkid;
+	}
+
+	ret = 0;
+out:
+	cs42l43_remove_speaker_id_gpio_mapping(mapping);
 
 	return ret;
 }
-- 
2.47.3

