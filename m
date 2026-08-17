Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC62C15BE;
	Mon, 17 Aug 2026 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009653; cv=none; b=mMGn8dyBikeJYV61S2qV//sVrr84egESwbKzqGm7LxS5AdTDv4B+wH8OKS4NsLILlRO8oS6Rn6OUUmOi7Au1Mp7PbPO4K60Ser7c5W2ahJo31HDQnDmseggrLEYtxWBpTRzgq1Uto7njBz6x3rmAyFyeo4G3VTIq71WpvxN0uk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009653; c=relaxed/simple;
	bh=hCBUelN8GdKsJ0xx5d+8GuDzIQjzipMe81DEKQvf2Ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toPvR86VRCjGXbZxs2BY1Ifn3/FwRVg6B3bwgMl2e2Y+HbxBHPJb3kcpEexPk0B15U/YbnbbopNT3fYf7G5+oD48ndrboqwgB8EZWwNaWmyDj+nkOxtLduWkcH1JHtqZ6F1fyuZsbl6Ug2hqbJpzVCUyxnfRKlGZ5UEuHnAYTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=S3FKAtWY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="S3FKAtWY"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLrUJ01480483;
	Mon, 17 Aug 2026 19:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dnY7U
	/ZctpyC+eXlgF8MkR74Cpx9hNM9Qe5r2GQvFzs=; b=S3FKAtWYgDLp2IIIOqdyZ
	8oSzgQneEBd3jqDGIfSe3hG55bJ+Z8MbELtwNWx9dTPn/vVk7N+riK1P/8S8YLev
	xawrp8Lh9Ni+25G9u7iBbIatvs8pqpAdnYb0/2fu15vII33ZAeApjWzNz32nVe5b
	hI0RAXfPeZCGrHJipW1mFj3H2G2lcZwW46FjMWg3Xm8B3q5LTow73k6dVgHBgMWr
	Mxu61dRVxO9my80F3LNzsZziSC4L6D/VhQahl9+nDP2BG8+sfS9LaOrmFcakKzSA
	BAxgu8wH6ku2C1iztvlClsfnJzQHtrmCB+PmTrMdu2+X1i9NyYXSFjQ9fZWkggIy
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g39efpyb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 19:34:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67HNY6to025427
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:34:06 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:34:06 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 19:34:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 19:34:05 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67HNXqfa020620;
	Mon, 17 Aug 2026 19:33:55 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 6/6] iio: adc: ad7768-1: add support for multiple chip aggregation
Date: Mon, 17 Aug 2026 20:33:41 -0300
Message-ID: <098f11b4ceca37037e770363bf4aa7e8dfa6bdaa.1786973376.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786973376.git.Jonathan.Santos@analog.com>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: TqI6xQRJ-cAbY83sp3wbzccCS5oAfder
X-Proofpoint-ORIG-GUID: TqI6xQRJ-cAbY83sp3wbzccCS5oAfder
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MSBTYWx0ZWRfX5it79YZ3s/mx
 TbL2D6PzMTKd+SpZcoxY3r8XVeO7nA26mcNu89UTMUeSHdtMfLbMYHHB8rtIzLw+CR6iCJRzCjh
 e7i4mYT3Y7Snu/UPlF/wwIT+AU3aiGuUl2EX5lxf8D8nDykJNYsP
X-Authority-Analysis: v=2.4 cv=VM/tWdPX c=1 sm=1 tr=0 ts=6a839a6f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=eSt0327NhoWBdm8inWMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MSBTYWx0ZWRfX7R7WokaAIy5N
 HGbr1QopOMxKbKZXexW6h+rANGB+VNIyJGzOXU5BmL7ieDW4FBe7MKngXIYD5ltrGV+zvXeKkQH
 QYfA07eSwF3UZuDTtSNkHRZ33sGdGwp7N+cuh8cJRuaULsMfFvHUTnFUb992qCEWNYH5wpvXP9g
 Afxv17meNcEv8cz/eAfJkNBOzMwb/K1EHpFnbeo9pUcatEbA/DMANHf0RsUHGBvlMeXISWVdI6m
 gblrEE/5XrJxudpXc9HleAikdgis98upbt/vIto9Z71CmWvTvRBBPYhnkH5sHYtejIDE/vR8g0B
 OZD+3P+O6BJHgjeNm9J5vr3zNtsSSIAR492mKaAqpkXpnriDMe20ad63dDDwsgTgPfTeDg7WZo6
 opJodOVXyhLMoPwFSrHFTXHFSrPefAKHpFbKSwLqODcVI3wrhops+73dG0vAn/unyTJwVDRZEoB
 oPkUdLcy2qWaw1BnwDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170181

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
Changes in v3:
* Modified channel mask allocation on ad7768_parse_aaf_gain() to get 
  a static value, Since we assume the family is single channel. Added a 
  comment explaining.

Changes in v2:
* New patch.
---
 drivers/iio/adc/ad7768-1.c | 100 +++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index e9060c1bbe6f..deff36165ed1 100644
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
@@ -1694,6 +1706,56 @@ static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
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
+	/* One mask entry, considering single channel ADCs, plus a zero terminator */
+	masks = devm_kcalloc(dev, 2, sizeof(*masks), GFP_KERNEL);
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
@@ -1830,6 +1892,15 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->chip = spi_get_device_match_data(spi);
 	st->spi = spi;
+	/*
+	 * This family is composed of single-lane devices, so we assume that
+	 * each lane is bound to a different device.
+	 */
+	st->num_devices = spi->num_rx_lanes;
+	if (st->num_devices > AD7768_MAX_AGGR_DEVICES)
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Too many devices (%u), max %d supported\n",
+				     st->num_devices, AD7768_MAX_AGGR_DEVICES);
 
 	st->regmap = devm_regmap_init_spi(spi, &ad7768_regmap_config);
 	if (IS_ERR(st->regmap))
@@ -1853,11 +1924,18 @@ static int ad7768_probe(struct spi_device *spi)
 
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
@@ -1889,7 +1967,7 @@ static int ad7768_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
+	ret = ad7768_set_channel_label(indio_dev, st->num_devices);
 	if (ret)
 		return ret;
 
-- 
2.34.1

