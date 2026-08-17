Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650502DE6E3;
	Mon, 17 Aug 2026 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009565; cv=none; b=A5Uuqx0yNVF7ZH24CKkXs/2AK/0SBqwgAcqsWUYp5fQD/YXPlCg70G8rw9IMcjWhHf9w41pLLh6VEKd1Dts0N2FKbqWEAdJA2uAiUnwojs6WmU+AzZDUA7tRTGDFNeF14iy0XWlhqA+M0NvuG4W3I2TZKPcSRPYSKr1GKHPojOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009565; c=relaxed/simple;
	bh=JFgCLfete8Erp1g/CNwvZj+1BUvTV6XxXVF9YQPcZbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnZl0VHGhGzVz/glJheFU1IxzXUeoDpkyj922gvm2IL37ApQt4k+S8kbnn7QggtNwOAuL4X928iWLDVmEBfJlI6J1Q2Ky4c6AIlwMUmerEQ3CQGCxl0hGQQ2ROYg5SnjsnjV9BvcTiZMIcHq+PrZonNNZ9WAYoVQcCRmE42GSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dmaDjENG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dmaDjENG"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLrcGP1197725;
	Mon, 17 Aug 2026 19:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Vzbp2ed4MVWLN3CkgWpnv3y3f1A
	ptOobwGiBwVzqpzI=; b=dmaDjENGK6DI/vXaAlhtWE3YsikfA166AU6AePoIdlB
	iqImMpqyTgOOyehc1A5FwPq7JxmeNDD5y6r+qZFFRChlntcDg24XzsLVpJrLsbS/
	LzSGsy0036oh2wwd+jkj9uHgh8HtMuwBLFyAA1vGcxoxYDK180AbdCyNFCp0uIY7
	W+77BZW3l0ZUqbgGRGuF4vKltVvRiXpOUpfr8UbKB6l5FP8bVTnHSjANkLBw++BF
	O/bS99kI15IM0/NZ9HOVYy4P3udTbgLyjg/AoSE5rmHX/K7jlvOuOV8V6ULhLOao
	wIQS6UCS0XTMuRFliK7LadTF0BtF+bVa6SCXQxbaeuw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g2n0xj6xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:32:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67HNWZVs025167
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:32:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 17 Aug
 2026 19:32:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 19:32:35 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67HNWM7f020585;
	Mon, 17 Aug 2026 19:32:24 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 0/6] spi: add multi-CS and multi-chip aggregation support
Date: Mon, 17 Aug 2026 20:32:10 -0300
Message-ID: <cover.1786973376.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: nIa11OsuT3xR_ApCfA-_MX4bazMTLdQ7
X-Authority-Analysis: v=2.4 cv=BaToFLt2 c=1 sm=1 tr=0 ts=6a839a14 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=CNMhNfdJe6ZRdnXQdikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nIa11OsuT3xR_ApCfA-_MX4bazMTLdQ7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX3kasSvY2rbzg
 eSpqqegnFKNvJIsNvzI/HEaneDiG4XHohvL8pCDu+mw6SKlUw+4ORw8qE4IBUBGuWxAkltvZ6St
 pkp0J2PeU8E3H9c20JGwqZ57gpLNqJDxQOycT9/uf/WGWqZONsQl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfXwamv1xY9GQPt
 6Hm//k93vxcsz4AxatUUqNCM1GI5/MtWeuwJK3b7DTA99uhLDpt0LbtCgFEJOY87+JO23kQPBU1
 siCuRi5DfE1LEfUePiMlRDlyly/1g5ch6GfvU5A55BPyRDsr9lpGVVaawOYh2vyOqQmNPmFA0ru
 bkVK2DLO5nvUhkOZC6oR489KwMzkMRFhS8smhLhKCOB8MfKXx2lFD57zfEO462o2gXwK28hq7kD
 h0kTsh/eYPOuW2fJvjFBc657b4HESPlUgpxdhvNsOO/QH51nmifZLumkU8UsIV5WQnxzqYyODte
 TWxPAyaIScQ09+Mn4u509LYvQyptK/oa0MsNTSBoxuGBa8pZ+zEh0+aGPzwC1IvxfSIMSewRfmX
 WKemmPQ3ywdtpnwq5s9+A1g82ZgFY9Xc1mdfsWLEwSvndSLSgJPOb8x2m+ZJmXQX3bRJodavfEN
 E5gnl9pXO/qoM23PN/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170180

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
v3 summary:
* Added new patch to document the properties for multidevice support on 
  ad7768-1 bindings.
* Refactored "spi: introduce SPI ancillary device with lanes" patch
  to reduce duplicated code using helper functions.
* Modified channel mask allocation on ad7768_parse_aaf_gain() to get 
  a static value, Since we assume the family is single channel. Added a 
  comment explaining.
* Link to v2: https://lore.kernel.org/linux-spi/cover.1785725359.git.Jonathan.Santos@analog.com/T/#t

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

Jonathan Santos (6):
  dt-bindings: iio: adc: ad7768-1: Document multidevice support
  spi: support simultaneous assertion of multiple CS
  spi: expand device name to include all CS lines for multi-CS devices
  spi: introduce SPI ancillary device with lanes
  spi: spi-engine-ex: Add support for multi-CS devices
  iio: adc: ad7768-1: add support for multiple chip aggregation

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  78 +++++++++-
 drivers/iio/adc/ad7768-1.c                    | 100 +++++++++++--
 drivers/spi/spi-axi-spi-engine.c              |  22 ++-
 drivers/spi/spi.c                             | 135 +++++++++++++++---
 include/linux/spi/spi.h                       |   8 ++
 5 files changed, 305 insertions(+), 38 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.34.1

