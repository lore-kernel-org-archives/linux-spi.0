Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9A23395F;
	Mon,  3 Aug 2026 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726187; cv=none; b=q8nOgLd3GVrPz62cKXWVqKVSz9e7g7/mxetIg+tBLehwmpgls/n9qr5UQMk2dHrdNckUUpM8Ci2f0c9oAFdAO/4rUqBYjzUk/5ZfxOhIiwy3dl4ij/ay6irdME54eoPquHgkNteCPn2m49moMEwqp0s6wRuCuBhNIaPXBJJ+VDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726187; c=relaxed/simple;
	bh=nJv7+AkFjKNIcwfXiWQGpXwADhVXT495ngR5KybrQ2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXbiucvMOvpK9kCyWdyjh7trvujssF/gS44WIMaZPVgdCH7Dd5hCZL/52xzpJeyNP7R1yqamabXdBTqCkfuI+Kjwv/dzCsGwzTCeBC+k4LPkeTYm0YC9BO6m8n9QSmgfDh96cPGoukwrfudJvL+/RW7MShGYzPCq9xQjvk1kZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vw3B9JgI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vw3B9JgI"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LW6Ya1573529;
	Sun, 2 Aug 2026 23:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Z3oXx
	7CWvEjmHcIVsWvv/k58AfXxDL1A512S9+oxV/8=; b=vw3B9JgIJmXWMaCD6+m4g
	lb0dL7PKUliq1/akpxB+2A2uz4WBa0gmaNTDu2jiEC8c6sHvZ4YtrXH7jmQGqSmb
	e9lgf1BbjmBRdLRCzOP36eGTZ2520qqSrAqYyRXUxAeFokHyHr+DWyuJhPCQrzSC
	9wOcmf5PBUjcKWAQo751bG+EQemCkhwY0AqHd++jrgDzaLwM59Zome7GfDO1A+DM
	MtTSrqCDElDsPJ+k9E6kPANbHdENiSsWSiYGZFMVSxTySYN/Lc29YIdnS/U+zm7f
	fak3bhZ57hJ3osovsa429PIY0Mv6jx0ODctNG294k02+dF/3cbJoHY0AOv7Gw4rc
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ft24e20ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 23:03:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 673331K8035467
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Aug 2026 23:03:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sun, 2 Aug
 2026 23:03:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sun, 2 Aug 2026 23:03:01 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67332nHx011653;
	Sun, 2 Aug 2026 23:02:53 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 5/5] iio: adc: ad7768-1: add support for multiple chip aggregation
Date: Mon, 3 Aug 2026 00:02:43 -0300
Message-ID: <6a951fd7064d5c4a64c74e3afbe991a1a2ec82dc.1785725359.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfX51BR3893wOGT
 O7XweoZTheIoPlBWZZ36ffdYeu4hnwg0M3rLOb7cUqc3OJ62uoT+Gr/d6mfK/X2fPZiL3PjIic6
 jSf6VG+mx4j3stpOD93G9kp2RWRbp8dmXQCRqeLL9tgFEzj7U+8ZfPAcxTp+p1mB/lyludabu3G
 gaKWmWYPtVxW64FVOdE54qgL3athKAKUk7MVYlOswhfcws4RnDCMCrtDImW16SyJPxEmpVzmFpM
 rrOICstDy+GVNwny/mtcSVogEJMDPBkmiQ3lP5q9HD2Ng4peQfvqgZI+VIMucHtLvs14XgyLeZ8
 qY3F0LcwLPigOT69CygMKlCbQpYscZ1qca6oUcw8zko3cC/ABhbRK4hmdFQFQrpnJLxJINbmXyt
 7zwFTdXVA9LBTnomGj1/P3GXGuvikrtsikekJGzFeXLG2rYxFMrE+uNMryzAyO8ax30S+Yk+OVg
 X67Zt3GmuGvZaVGdckw==
X-Proofpoint-GUID: tgmVWpJfVBfrFS10rRqoswPvnRMi3w1y
X-Authority-Analysis: v=2.4 cv=YeCNIQRf c=1 sm=1 tr=0 ts=6a7004e6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=eSt0327NhoWBdm8inWMA:9
X-Proofpoint-ORIG-GUID: tgmVWpJfVBfrFS10rRqoswPvnRMi3w1y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfX4ob5Z6dv0cR/
 QZ0ao0Al1QjG77fQLf11OueWPEgooMEc3p4hRmJoY0RM+72SP6mdh8HDLl6+0hqO69B2nkB4PNH
 yJA44dBq3TZtWYAkwNRUoxGdgyQsRMg0N5Pe5aQEm+594uhObbYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030023

The AD7768-1 family is a single-channel ADC, but it is designed to allow
connecting multiple devices to the same SPI controller, each on a
dedicated CS and data lane, clocked synchronously, and sharing SDO and
SCLK. The number of aggregated devices are derived from
spi->num_rx_lanes, assuming all parts are single lane.

The DRDY pins are combined to trigger the data interrupt when all
devices are ready, and since the synchronization pins are tied, they
stay in synchrony.

To reflect the multidevice setup, IIO channels are dynamically set
based on the number of devices. Restrict buffered capture to the
all-channels scan mask, since all devices sample in lockstep. Register
an ancillary SPI device per lane for individual direct reads, and enable
SPI_MULTI_LANE_MODE_STRIPE in offload mode to interleave samples from all
lanes into the DMA stream.

Since all devices must be in sync, all configurations that affects the
sampling rate are unified, so they always have the same sampling
frequency.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* New patch.
---
 drivers/iio/adc/ad7768-1.c | 99 +++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index e9060c1bbe6f..0a34d408c188 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -120,7 +120,8 @@
 
 #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
 
-#define AD7768_MAX_CHANNELS 1
+#define AD7768_MAX_CHANNELS	1
+#define AD7768_MAX_AGGR_DEVICES	4
 
 #define ADAQ7768_PGA_PINS 3
 
@@ -300,10 +301,12 @@ struct ad7768_chip_info {
 
 struct ad7768_state {
 	struct spi_device *spi;
+	struct spi_device *spi_anc[AD7768_MAX_AGGR_DEVICES];
 	struct spi_offload *offload;
 	struct spi_offload_trigger *offload_trigger;
 	struct regmap *regmap;
 	struct regmap *regmap24;
+	struct regmap *regmap24_anc[AD7768_MAX_AGGR_DEVICES];
 	int vref_uv;
 	struct regulator_dev *vcm_rdev;
 	unsigned int vcm_output_sel;
@@ -322,11 +325,12 @@ struct ad7768_state {
 	struct gpio_descs *pga_gpios;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
-	const char *labels[AD7768_MAX_CHANNELS];
+	const char *labels[AD7768_MAX_CHANNELS * AD7768_MAX_AGGR_DEVICES];
 	struct gpio_chip gpiochip;
 	struct spi_transfer offload_xfer;
 	struct spi_message offload_msg;
 	const struct ad7768_chip_info *chip;
+	u8 num_devices;
 	bool en_spi_sync;
 	struct mutex pga_lock; /* protect device internal state (PGA) */
 	/*
@@ -335,7 +339,7 @@ struct ad7768_state {
 	 */
 	union {
 		struct {
-			__be32 chan;
+			__be32 chan[AD7768_MAX_AGGR_DEVICES];
 			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
@@ -478,7 +482,7 @@ static int ad7768_set_mode(struct ad7768_state *st,
 				 AD7768_CONV_MODE_MSK, AD7768_CONV_MODE(mode));
 }
 
-static int ad7768_scan_direct(struct iio_dev *indio_dev)
+static int ad7768_scan_direct(struct iio_dev *indio_dev, unsigned int chan)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
@@ -492,9 +496,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (!ret)
 		return -ETIMEDOUT;
 
-	ret = regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &readval);
-	if (ret)
-		return ret;
+	if (st->num_devices > 1) {
+		ret = regmap_read(st->regmap24_anc[chan], AD7768_REG24_ADC_DATA, &readval);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &readval);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * When the decimation rate is set to x8, the ADC data precision is
@@ -989,7 +999,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		ret = ad7768_scan_direct(indio_dev);
+		ret = ad7768_scan_direct(indio_dev, chan->channel);
 
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
@@ -1391,6 +1401,8 @@ static int ad7768_offload_buffer_postenable(struct iio_dev *indio_dev)
 	st->offload_xfer.len = spi_bpw_to_bytes(scan_type->realbits);
 	st->offload_xfer.bits_per_word = scan_type->realbits;
 	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	if (st->num_devices > 1)
+		st->offload_xfer.multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
 	st->offload_msg.offload = st->offload;
@@ -1694,6 +1706,55 @@ static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
 	return 0;
 }
 
+static int ad7768_probe_multidevices(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *channels;
+	unsigned long *masks;
+	u8 cs;
+	int i;
+
+	indio_dev->num_channels = st->num_devices * st->chip->num_channels;
+	channels = devm_kcalloc(dev, indio_dev->num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	for (i = 0; i < st->num_devices; i++) {
+		struct iio_chan_spec *chan = &channels[i];
+
+		*chan = *st->chip->channel_spec;
+		chan->channel = i;
+		chan->scan_index = i;
+	}
+
+	indio_dev->channels = channels;
+
+	masks = devm_kcalloc(dev, st->chip->num_channels + 1, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		return -ENOMEM;
+
+	masks[0] = GENMASK(st->num_devices - 1, 0);
+	indio_dev->available_scan_masks = masks;
+
+	/* Setup ancillary SPI devices for single device access  */
+	for (i = 0; i < st->num_devices; i++) {
+		cs = spi_get_chipselect(st->spi, i);
+		st->spi_anc[i] = devm_spi_new_ancillary_device_with_lane(st->spi,
+									 cs, i, 0);
+		if (IS_ERR(st->spi_anc[i]))
+			return dev_err_probe(dev, PTR_ERR(st->spi_anc[i]),
+					     "failed to register ancillary device\n");
+
+		st->regmap24_anc[i] = devm_regmap_init_spi(st->spi_anc[i],
+							   &ad7768_regmap24_config);
+		if (IS_ERR(st->regmap24_anc[i]))
+			return PTR_ERR(st->regmap24_anc[i]);
+	}
+
+	return 0;
+}
+
 static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
 					 enum spi_offload_trigger_type type,
 					 u64 *args, u32 nargs)
@@ -1830,6 +1891,15 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->chip = spi_get_device_match_data(spi);
 	st->spi = spi;
+	/*
+	 * This family is composed of 1-lane devices, so we assume that each
+	 * lane is bound to a different device.
+	 */
+	st->num_devices = spi->num_rx_lanes;
+	if (st->num_devices > AD7768_MAX_AGGR_DEVICES)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Too many devices (%u), max %d supported\n",
+				     st->num_devices, AD7768_MAX_AGGR_DEVICES);
 
 	st->regmap = devm_regmap_init_spi(spi, &ad7768_regmap_config);
 	if (IS_ERR(st->regmap))
@@ -1853,11 +1923,18 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->mclk_freq = clk_get_rate(st->mclk);
 
-	indio_dev->channels = st->chip->channel_spec;
-	indio_dev->num_channels = st->chip->num_channels;
 	indio_dev->name = st->chip->name;
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (st->num_devices > 1) {
+		ret = ad7768_probe_multidevices(indio_dev);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to configure multidevice\n");
+	} else {
+		indio_dev->channels = st->chip->channel_spec;
+		indio_dev->num_channels = st->chip->num_channels;
+	}
 
 	/* Register VCM output regulator */
 	if (st->chip->has_vcm_regulator) {
@@ -1889,7 +1966,7 @@ static int ad7768_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
+	ret = ad7768_set_channel_label(indio_dev, st->num_devices);
 	if (ret)
 		return ret;
 
-- 
2.34.1

