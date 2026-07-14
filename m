Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A123624B2;
	Tue, 14 Jul 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997775; cv=none; b=Tcrs/viIKIh5Tiw0yhy16jVdSIsXSKou1C/X7xCKITdJOccg+SCw7ErlOcpx0SAddyJ720g1YJ9JZeEXuMTDjtcdOU6OSV0UuEoFK707bcNoZT14Gfy4D6oyyvt4qJtPsvyUFd/M2N219B1VsoOcg6oJlCdebmHL1ZovxmE0Mlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997775; c=relaxed/simple;
	bh=VmfDtiliJvb4CkUfXyu5Hqexb/aSozjZEnTjzYmHKUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mr9uH8GGIzH8GfeiZifjG868wyoEMuJxAxMsplWP/Lon05g7vNZehUFLIim8PjmCf99MH0veF7JUZ2bNO3Yc56Ed1vjttI1fLg51zWAebPtlnL49Ew4GhbPTSH5GP7Q58VS/gzSdly2OsB39gvhS5qJ6t6WLCnGG1u3GsOE2B18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xbP9ez/C; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xbP9ez/C"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNmR4k622268;
	Mon, 13 Jul 2026 22:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=LJgrhquxj0/9W+z4LV82tYcp1S5
	1WnkAmHqDBNQ4QFY=; b=xbP9ez/CsaRRkg74MgtVfAyKdjemkVCAsMCgFcQkiPO
	/mFnWsoGdnxdVUGccEGA081wiIKMLpsr9JQH2COKEknNl2OXocU3fdtDxHXqfdJH
	2rsSE4CmzuRKt/ZLxTdchk5T0fEa2ykL9pgXw6kUOz7pzruMQGend0bZ0diKQUNp
	RorBf2oWMFCmv1gVTTJu6c4VsPXmotiPxDMOJI3AIn/YLHOmRY5LQ9YQOkeLR/22
	c+mglqYtQYak8mbsMYq8Bd9xTLUWx078jNwf+GzuQSzuikYG2dZgKZmICMnrOxcL
	MgbJj903fFtNf0y/29FEZRKtk8igCc/rBfZlb7EoKrg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fbjr18y8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:55:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66E2tuIY028154
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 22:55:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 22:55:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 22:55:56 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66E2tjiO021203;
	Mon, 13 Jul 2026 22:55:47 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andy@kernel.org>
Subject: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
Date: Tue, 14 Jul 2026 02:55:31 -0300
Message-ID: <cover.1783729282.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX2Sb+34R+0hNr
 tw6jEBWGhjh0LcpfK2JWv0ad+MJw/Z8lY/VngwJ3RjtIUwP1tRI3IWZvulwdwUjYhYruV0gB2/D
 psBloTpCREj+i9KZrBoqViRcgQX73GfgQjz8GeBuPvr0dP/iyUX9
X-Authority-Analysis: v=2.4 cv=Ovp/DS/t c=1 sm=1 tr=0 ts=6a55a53d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=BDPrav7PC1f0xjhbB_YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX587tfU/910NR
 xzRHOdu8z0RE4L7ovGrohmQVYljzfAfqYVwxcJ+PdaB72mkf7Nv/XJ0xR2lI6+UYR9e5jCSakx1
 nogskblPvNyG/VYawhsw0llC+toQgJdMjamnYgORbG+cMyFkL8egpAGZ5k6IQRUjfdhZUKVslhV
 d/QJkSmvo73ZvW+91HV+dZTE7LU7fzB6EdL8VoHD2AlPsIMYqYWaAWoSVg+nl5Ep7eezSPva9wZ
 +T2nZ8U+NhFNrxJ2YThbln3TOZjng6YZF6QnnWErCxn6UFbz9h6/U9Pjft8LWg42lc/Ucb1MZi1
 DJ5fvdOOLJ3WR0n81/ks0hOTBokhlOtC8L0w/OqQpejCdn5GggCjfLiZybfdcgYvxvjcuDjtj9t
 o3ayCCtZM5vvmEMmQd3UOdMJwUi2+YlDRcSZzGyE0aqJqQXQrbkK5Gzmsy/IEtn9OrEhR8g5oBt
 yZ8qjak5gNT5TevcNeA==
X-Proofpoint-ORIG-GUID: n5x4wVg3Uk7P2ksewHP0c_QdgtYr0vFY
X-Proofpoint-GUID: n5x4wVg3Uk7P2ksewHP0c_QdgtYr0vFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140028

This series introduces two SPI subsystem features: per-transfer chipselect
masks and multi-CS device support. Together they address the multi-device
setup described in [1] and the limitation noted in [2], where no SPI
controller completely handles logical chip selects beyond the first one.

The first part of the set addresses multi-CS support. Some SPI controllers
can assert multiple chip selects simultaneously, but the existing code
hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
preventing this from working.

The second part addresses dynamic lane selection for STRIPE mode. In
SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
active. Some peripherals need to select a different subset of rx/tx lanes
per transfer. New fields are added to the spi_transfer struct to allow
drivers to specify which lanes to use for each transfer. The documentation
is also updated to describe this new behavior.

[1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
[2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/

Jonathan Santos (6):
  spi: support simultaneous assertion of multiple CS
  spi: add per-transfer CS mask
  spi: spi-engine-ex: Add support for multi-CS devices
  spi: Documentation: multiple-data-lanes: describe rx and tx lane mask
  spi: add rx and tx lane mask to spi_transfer struct
  spi: axi-spi-engine: add support for dynamic multi-lane selection

 Documentation/spi/multiple-data-lanes.rst |  30 ++++++
 drivers/spi/spi-axi-spi-engine.c          | 106 +++++++++++++++++-----
 drivers/spi/spi.c                         |  97 +++++++++++++++++---
 include/linux/spi/spi.h                   |  12 +++
 4 files changed, 206 insertions(+), 39 deletions(-)


base-commit: 093239070573637ad2b4cb56abc9c4c7ee109294
-- 
2.34.1

