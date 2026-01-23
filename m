Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB62F9984
	for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200737; cv=none; b=dVSIvsKrHA79Y4sPqrvLQhFMMapmqk/V3yCBEOyzyAsb8B66F8oBDUwqmQmY9lDUwGcf/PO8Pv1bU7u23gc6IP+LMd/2pHWNSkO5b+J5xZVBHrDXu4EKbGnXyuiinX6J3HJxiTYi+UnX4ii7ULbXDeqhOmkQxvZrEqbaiXbzcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200737; c=relaxed/simple;
	bh=2C6i3NBXyh26o+VI6Lld/UbaveXiw02diDxZ2kfzhPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXeqR+3HCT01zeLKg+PlHLW16KFXA9UVMqxHAg6U9bvWjgu6UVV8Y+Mt16nxvqxWTG9wR/a1kKY0SnjlYMoRG1nqAOwErM7epkedwVqCrkrYpA2IXVbxX4HlNNRc5udA2FqqLMIYQcvy64liQP+A78bsPrsj1XkpLe/WvVA2vLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GHR802oR; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GHR802oR"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40866616d47so2008657fac.2
        for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200732; x=1769805532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbdZS75AKMVh8QDM0w0436GKbW8GMgnOih9TIeXC38A=;
        b=GHR802oRGTmGP+m43X+o8HB2AzxUHzwkDazDTfrFrS3vTnksz/JVttuD1a4352kNyL
         f0vf0rJdN0y1qHe1xIZTqhW07hOPnI+a03eZMMTekTeaYeOUGHF8Ro5m6JJYtSBpEswP
         zIiVJd/zABTNwIoEQjEVrnuFielorme7Rj0sJmkuom7a3jRnqPRnfGRxXTWuV+X92xph
         PL/kqxBrY404t8O5vy7lnAkdP8z+UEaQ3KBFZz35Ue/VKA2KcQSevGa3RGk3Y2qBgR3Q
         iAHF/Y7007/wNHya0U/yh/Gvs/jNaLySDRVI3+V4jT5jis/qRlPdjSaE92jxZ2aMcUWA
         I0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200732; x=1769805532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CbdZS75AKMVh8QDM0w0436GKbW8GMgnOih9TIeXC38A=;
        b=SldaKYPa7cQ60PwgWH7WHLWQsIZys3J85j/L0G8ZzicpKe2YQAQ78o2IfCoQ/w/XWI
         /yjozjahEIcF2NtuG2sXmU3zefOepMQa8ijaOY1w6vTOyOMENpjeC9TXAEJVXvdhLBzw
         YhtuRC+PBdedouEuMmZCOVwQsS84Id0CUBrDGO93im2aZ24uCPGxSR5WU7kqREjfI6fV
         MV1h3WMvSrEWG5H7GzPLens5JqYYPDLVMOaH5PIJeqpAJithNbR9GQ1ki1IDYz425jyP
         kuoKLZWbFtPIdOdSpzA6iGu4ak0ViUpUFnu9Q1p6kqZ3FUhCAkYO7eSNJqlyEULB/Ksg
         qibw==
X-Forwarded-Encrypted: i=1; AJvYcCXIL1mUx71BObjXxaiZK/Zr3UwZoc9kPIDFg6q/7BOvoaI9x6CVGhKjfYsmEXzoVhRuJd/faogp6pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLMoWiVpDRJLlCQQV/W9kw5nvMp/Yd61Dncs1BkL//HajdcQZ
	CNnMQqC/B40zDMngoPqEtptr/fpiXKoWFG516Dd/otBNFPYlN2T4iyxYOO9l0grWP/M=
X-Gm-Gg: AZuq6aLB+4ANoTnGBXJ+eZTRPtXibJlIgXG5uiXqBD2RJHEbrvukJ1JC8k2QgsrNyk4
	NuPm8lDhQA6+7HwUEsFZrEokIfG+ws3rSfU6jnlW2NZTWmZPgyk4TRhovw/vDBF+nafHukT41Bk
	Y/YizS2hOcVFd1pdcczWAtCHm3t1HQ3beRk55IGHta9StXjS8H+lmdZ4ugnPVrksaOfjaayID3F
	oa6m4uJEfYxTiMsrBijxpIxirz04iP65morU7qoD6CjaFrLYBqZgV2zNONVDkMdHq1G+uZnp2ZH
	GSQKSj+Wyls8UEA03dkyTX/XpbBUTa6DigU2yBSc8xfvK9JrqW2N98OA0jZu8RvQrld87VnMmLk
	WmPLsHMq1IHpWplmm6lHhN+CdIrNC39QFlVwoWQkWksMKfZ7NB+g6u7OMyy/hevGlzp3A9VOGjc
	pGT6C8Tw5db6SgwQ==
X-Received: by 2002:a05:6870:f215:b0:3f5:5d85:80d2 with SMTP id 586e51a60fabf-408ab7e291bmr2111309fac.43.1769200732405;
        Fri, 23 Jan 2026 12:38:52 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:32 -0600
Subject: [PATCH v6 9/9] iio: adc: ad7380: add support for multiple SPI
 lanes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-9-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6262; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2C6i3NBXyh26o+VI6Lld/UbaveXiw02diDxZ2kfzhPE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9xEN+k0R7Bic+VA3HmpepXcuhZgilXf5ajsv
 oYVQbn21oeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcRAAKCRDCzCAB/wGP
 wNFoB/9VGW1yDYrM8DKEAfnpAkhTWzsoBaVaQHqlbzdkgE3UKW+5yKu2LwOHodIbKhFEot94REK
 9+PQGVW2urhNn7geTxRmFFLrHP4x8tLzvJLnspiTwGVqZthwKxQdtyUv2wt9KrEZrbCF9ISQQ13
 FxRKgWfYbAvKvwQ07qHvxrOb35V8/8LhL1B8X3PUFYZIz5pjQC6DQQI360SBMeJHavSxgJwzk9J
 AksPUKILzD6DgmBNzuDK3Y2C1e0xpUSuJ3X39RhtahkzBwPZKRJDRk7+SbvUpwQMKJAGsID1ilO
 WaglwEThPxE3LipUhfMt7MT8CS85j8SGxxHNwihy9LTExgLS
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for multiple SPI lanes to increase throughput. The AD7380
family of ADCs have multiple SDO lines on the chip that can be used to
read each channel on a separate SPI lane. If wired up to a SPI
controller that supports it, the driver will now take advantage of this
feature. This allows reaching the maximum sample rate advertised in the
datasheet when combined with SPI offloading.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes:
* Include the number of SDO lines in the error message.

v4 changes:
* Update for core SPI API changes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

v2 changes:
* Move st->seq_xfer[3].multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE;
  to probe().
---
 drivers/iio/adc/ad7380.c | 51 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bfd908deefc0..ca411371816f 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -77,8 +77,7 @@
 #define AD7380_CONFIG1_REFSEL		BIT(1)
 #define AD7380_CONFIG1_PMODE		BIT(0)
 
-#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
-#define AD7380_CONFIG2_SDO		BIT(8)
+#define AD7380_CONFIG2_SDO		GENMASK(9, 8)
 #define AD7380_CONFIG2_RESET		GENMASK(7, 0)
 
 #define AD7380_CONFIG2_RESET_SOFT	0x3C
@@ -92,11 +91,6 @@
 #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
 #define T_POWERUP_US 5000		/* Power up */
 
-/*
- * AD738x support several SDO lines to increase throughput, but driver currently
- * supports only 1 SDO line (standard SPI transaction)
- */
-#define AD7380_NUM_SDO_LINES		1
 #define AD7380_DEFAULT_GAIN_MILLI	1000
 
 /*
@@ -888,6 +882,8 @@ struct ad7380_state {
 	bool resolution_boost_enabled;
 	unsigned int ch;
 	bool seq;
+	/* How many SDO lines are wired up. */
+	u8 num_sdo_lines;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
 	unsigned int gain_milli[MAX_NUM_CHANNELS];
@@ -1084,7 +1080,7 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 	if (oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
 			T_CONVERT_X_NS * (oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->num_sdo_lines;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
 }
@@ -1113,7 +1109,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 	if (oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
 			(oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->num_sdo_lines;
 
 	if (st->seq) {
 		xfer[0].delay.value = xfer[1].delay.value = t_convert;
@@ -1198,6 +1194,8 @@ static int ad7380_init_offload_msg(struct ad7380_state *st,
 	xfer->bits_per_word = scan_type->realbits;
 	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
 	xfer->len = AD7380_SPI_BYTES(scan_type) * st->chip_info->num_simult_channels;
+	if (st->num_sdo_lines > 1)
+		xfer->multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->offload_msg, xfer, 1);
 	st->offload_msg.offload = st->offload;
@@ -1793,6 +1791,7 @@ static const struct iio_info ad7380_info = {
 
 static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 {
+	u32 sdo;
 	int ret;
 
 	/* perform hard reset */
@@ -1815,11 +1814,24 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	st->ch = 0;
 	st->seq = false;
 
-	/* SPI 1-wire mode */
+	/* SDO field has an irregular mapping. */
+	switch (st->num_sdo_lines) {
+	case 1:
+		sdo = 1;
+		break;
+	case 2:
+		sdo = 0;
+		break;
+	case 4:
+		sdo = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
 				  AD7380_CONFIG2_SDO,
-				  FIELD_PREP(AD7380_CONFIG2_SDO,
-					     AD7380_NUM_SDO_LINES));
+				  FIELD_PREP(AD7380_CONFIG2_SDO, sdo));
 }
 
 static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
@@ -1842,7 +1854,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
 				     "failed to get offload trigger\n");
 
 	sample_rate = st->chip_info->max_conversion_rate_hz *
-		      AD7380_NUM_SDO_LINES / st->chip_info->num_simult_channels;
+		      st->num_sdo_lines / st->chip_info->num_simult_channels;
 
 	st->sample_freq_range[0] = 1; /* min */
 	st->sample_freq_range[1] = 1; /* step */
@@ -1887,6 +1899,13 @@ static int ad7380_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return dev_err_probe(dev, -EINVAL, "missing match data\n");
 
+	st->num_sdo_lines = spi->num_rx_lanes;
+
+	if (st->num_sdo_lines < 1 || st->num_sdo_lines > st->chip_info->num_simult_channels)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid number of SDO lines (%d)\n",
+				     st->num_sdo_lines);
+
 	ret = devm_regulator_bulk_get_enable(dev, st->chip_info->num_supplies,
 					     st->chip_info->supplies);
 
@@ -2010,6 +2029,8 @@ static int ad7380_probe(struct spi_device *spi)
 	st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 	st->normal_xfer[1].rx_buf = st->scan_data;
+	if (st->num_sdo_lines > 1)
+		st->normal_xfer[1].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
 					ARRAY_SIZE(st->normal_xfer));
@@ -2031,6 +2052,10 @@ static int ad7380_probe(struct spi_device *spi)
 	st->seq_xfer[2].cs_change = 1;
 	st->seq_xfer[2].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->seq_xfer[2].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	if (st->num_sdo_lines > 1) {
+		st->seq_xfer[2].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
+		st->seq_xfer[3].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
+	}
 
 	spi_message_init_with_transfers(&st->seq_msg, st->seq_xfer,
 					ARRAY_SIZE(st->seq_xfer));

-- 
2.43.0

