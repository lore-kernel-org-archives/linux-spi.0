Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02F194C98;
	Mon,  3 Aug 2026 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726123; cv=none; b=tN9g8EPlnGgujfQDxuS+tcMigvRY7cP4Gk+LvapJoP7+2gw/BB3shSAYTSnhSLVtYcfw7tdwpfN6qyKC1zaIrG0fH4vJeTS4gsFSdmaUyGNp+GD7Lu6fhCAvaihN3kflp9jy4myfQPyYjEUfxrJ460bwvv6wA3Xj+p3LrMWCeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726123; c=relaxed/simple;
	bh=yDPoI+k7lNQgy3iS0vwWQsY6EuNulBE+y4Az1MpM5vY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nQPqVg32Yy1NM68GwEKPobzdH80zBENDMa+8dF0HTW4L/RjzHDgvDx1EhrLgn6GDwVWXPsQlPhYCoBBvOyAN5emE2eo20VjivVhbOB6RdNakzv5WAWN7bNgCtW4WSXnVLzgwS/4S0OX1Seflbk2LBdbi+WoPttuAbQLo7h+px9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AMk6aj/z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AMk6aj/z"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LVn7w1718278;
	Sun, 2 Aug 2026 23:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=nd7zdFyR8yGS6gKX5ZgUQeRyubT
	7h/v0lAXrAQ2zL3s=; b=AMk6aj/zfbvgxjAUQ2L1ivmMicY0HusSYwl6FWvFhPK
	kdYSXCxm6r0TMjjdHMAmrDxMWWcXuxfffwKBlmd9dGE5VjTc3vBqRdJxmXSddWbZ
	IMpH1hwLiYF95jcrM4P3jlNXPSsm6YpPW7LgpWeYyJyJlBP4Jaz9MfXt42Gcgtzc
	/JwSIC5Y9RD6Q8arn+zTeSHN0e/PdrEE0LVPg478NiIAVCyw7n2+t2Ugy1pAzMnx
	5zFiSa7SrLMXJqTIp7D8l+QxaICnwK9wUNNcKjKcDK04xjRbZ6MLV2I5sx9KsVQg
	wqMkfE/spK1l/BU/uzIiwPpWvUzqpKYfaQPe982KHNA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fsamxmvtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 23:01:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67331oDF035222
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Aug 2026 23:01:50 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:01:50 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:01:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sun, 2 Aug 2026 23:01:50 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67331dfa011624;
	Sun, 2 Aug 2026 23:01:41 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/5] spi: add multi-CS and multi-chip aggregation support
Date: Mon, 3 Aug 2026 00:01:33 -0300
Message-ID: <cover.1785725359.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfXz1jOgsRr0KIX
 G9gSKcFTepHT3+GgX74VwfGUYOPlYFdfe7EbM3vUYDJ7AX14Rq10iaxnh7K1YW1mczjKKmb+fmY
 IIPWXMbRv+KEEY5aU3CYFwgHA6EtuLSkqtjhe3OdKw5nN5RoKa6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfXxxFFLf59jjod
 S9mCCyh0R70sRiRVhkJwO+6Sp78YIC6tEsv4EsBrXReptcOU7xsjW7aY82p4+ZZiN917ySRZTWd
 Gnc7rk7RnKL0STwVeZlBOYJ0z6DIHlNp6N5eMgI8bcZeHTzrs1fJkPIvRriiW9sjuttVma+7P72
 aANcNrePyJR6Qr8YNDkazFmNaWuEzhtillPD1fFxplKym1yxd9C+M1EnIdoTrfWbOOQa+mYdo2p
 prnW4fLS6LaKI6JwKRqJ1Nt9J7yZnuyj1UimRcTtLB3etlSRk9jZsg9qay12pxmsNncCVlKGYzz
 rFsI4oQ4eUR2PyUAmVUPmA9/wfbPZncA0HibGQOklM4EMaNJV5j7nR6CrJk5gA2EnxaxB3fFRVc
 kPg+WatIIIAP9Tz3Z4Wt9xrfOZdHBhnvzTW+diV5iPH1yICTTvZFw04BzsttG5Wj5gzEpTUR5tE
 XSlD0ANYl8c5HjndmxA==
X-Authority-Analysis: v=2.4 cv=daWwG3Xe c=1 sm=1 tr=0 ts=6a70049f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=ctrc8raZ2tMGTsnIRwsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: w-p_Vvo_gvymHoisF2i2XYTWYuh-7sLU
X-Proofpoint-GUID: w-p_Vvo_gvymHoisF2i2XYTWYuh-7sLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030023

This series adds support to multi-CS devices and ancillary device with
lanes, to enable the multi-device setup described in [1],  where multiple
AD7768-1 ADCs are wired to the same controller in a synchronized sampling
configuration, and the limitation noted in [2], where no SPI controller 
completely handles logical chip selects beyond the first one.

The first part of the set addresses multi-CS support. Some SPI controllers
can assert multiple chip selects simultaneously, but the existing code
hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
preventing this from working. The spi device name pattern is modified to
include all active CS lines, so multi-CS devices are distinguishable in
sysfs.

The second part introduces spi_new_ancillary_device_with_lane() and its
devm variant, used here to create subdevices that binds the CS with a 
correspondent rx and tx lane from the parent device. With that we can 
handle each device individually when there are separate data lanes.

The last part uses the above infrastructure in the AD7768-1 driver to
support aggregating multiple chips as a single IIO device. The number of
sub-devices is derived from spi->num_rx_lanes. IIO channels are
allocated dynamically, buffered capture is restricted to the full-device
scan mask, and SPI offload mode enables SPI_MULTI_LANE_MODE_STRIPE to
interleave samples from all lanes into the DMA stream.

---
v2 summary:
* Removed the per-transfer CS mask patches, the devices will be 
  individually handled by the ancillary device feature.
* Removed dynamic multilane selection patches. The lane is bound to the 
  CS using the new spi_new_ancillary_device_with_lane() feature.
* Included a use case patch modifying the AD7768-1 driver to support 
  multidevice aggregation.
* Link to v1: https://lore.kernel.org/linux-spi/cover.1783729282.git.Jonathan.Santos@analog.com/T/#t

OBS: The ancillary device approach was chosen over per-transfer CS masks
because it has better integrattion with regmap. Both approaches require
multiple regmap instances, but the CS mask approach would additionally
require custom read/write functions to route transfers to the correct CS,
while ancillary devices handle this more transparently.

David suggested adding an ancillary device field to spi_message, I guess to
enable dynamic CS-lane selection. For now, using one ancillary device per 
chip for individual access and the main SPI device for simultaneous access
seems to be sufficient. The dynamic approach can be implemented in the future
if needed.

---

[1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
[2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/

Jonathan Santos (5):
  spi: support simultaneous assertion of multiple CS
  spi: expand device name to include all CS lines for multi-CS devices
  spi: introduce SPI ancillary device with lanes
  spi: spi-engine-ex: Add support for multi-CS devices
  iio: adc: ad7768-1: add support for multiple chip aggregation

 drivers/iio/adc/ad7768-1.c       |  99 ++++++++++++++++++++++---
 drivers/spi/spi-axi-spi-engine.c |  22 ++++--
 drivers/spi/spi.c                | 121 +++++++++++++++++++++++++++++--
 include/linux/spi/spi.h          |   8 ++
 4 files changed, 227 insertions(+), 23 deletions(-)


base-commit: e0484d62e8e1cff75b210938be835ea6221bda59
-- 
2.34.1

