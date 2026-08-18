Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFB342CB0;
	Tue, 18 Aug 2026 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037023; cv=none; b=gviHTiekrHdW2CH3v0f/3wNXylaE1avW3XzyCnKQQXvmEzH6ilQuRjXB37pEuKacxSfEMgrweS9vleVe6KlQwmaaH0aahRdFDqejHweMrf1wzxYOQqLtL6XisG5tq+oqrdJ7mCJTe2CityD8KhzA21oBVeFliYpumQXOheTt6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037023; c=relaxed/simple;
	bh=cvZUiVd+e+QpMQPhPx6kN1XleRXTu3ictrW5LyD+JEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPckGEYgVokrVwOy/aH8CYjj/DmOHGFLUoR+txhSGz4OZspKiKFWZMINxKI2a0Pd1CgnydI2IASG9QCpq6Kz7j4qCCY+e+sa3+9kYptIGKw1NbjTh8kWlxhO9Cm/gVp4rLJeDucTmCz31cRnhiaZhhFZGl4mXhV5GwBNLzWorJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElrddDld; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElrddDld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787037023; x=1818573023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cvZUiVd+e+QpMQPhPx6kN1XleRXTu3ictrW5LyD+JEg=;
  b=ElrddDld64HelkPdzTdc89J+lERgrt9eQCrTuhPxNstIupjD7GMYD2lr
   8pQoHCAN/Pid8arQqn96XtqGSEH0xcE+CYtFuoSKYzwO5TWeppgsMOhhY
   y3plHBzwM9cD8TcOgWEnVgYjw+GU/kKRVduNH2Dq3Yyk009RRH0dhhP3x
   HCGdpp5Ua2Jz/AqjGWxq9j7gY2Ex9qE6gf8dqLAf7Z5H5X50dRmu87lvR
   tJX4NDG5LkzZgPiyz6AH9OzMSN1uKUeynwGGwzRNW676bM4tM7SPPWy58
   mIqS73EtYcKBMEK2qDDZ1EDmTaZrTh3fQ8DoebNHrn3sGXHsIq6QOlc9g
   w==;
X-CSE-ConnectionGUID: cXkVSR6PRc6bvX15TV1BuQ==
X-CSE-MsgGUID: NPsKh8n9SH29ZqKpjGU04Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91202190"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91202190"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:10:22 -0700
X-CSE-ConnectionGUID: EwMOLO3tRsykh7ERpalogg==
X-CSE-MsgGUID: fNGMXvMHS7irXxkPqNj3ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="303370232"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:10:19 -0700
Date: Tue, 18 Aug 2026 10:10:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 6/6] iio: adc: ad7768-1: add support for multiple chip
 aggregation
Message-ID: <aoQFWfH54kq6EK7w@ashevche-desk.local>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <098f11b4ceca37037e770363bf4aa7e8dfa6bdaa.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098f11b4ceca37037e770363bf4aa7e8dfa6bdaa.1786973376.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 08:33:41PM -0300, Jonathan Santos wrote:
> The AD7768-1 family is a single-channel ADC, but it is designed to allow
> connecting multiple devices to the same SPI controller, each on a
> dedicated CS and data lane, clocked synchronously, and sharing SDO and
> SCLK. The number of aggregated devices are derived from
> spi->num_rx_lanes, assuming all parts are single lane.
> 
> The DRDY pins are combined to trigger the data interrupt when all
> devices are ready, and since the synchronization pins are tied, they
> stay in synchrony.
> 
> To reflect the multidevice setup, IIO channels are dynamically set
> based on the number of devices. Restrict buffered capture to the
> all-channels scan mask, since all devices sample in lockstep. Register
> an ancillary SPI device per lane for individual direct reads, and enable
> SPI_MULTI_LANE_MODE_STRIPE in offload mode to interleave samples from all
> lanes into the DMA stream.
> 
> Since all devices must be in sync, all configurations that affects the
> sampling rate are unified, so they always have the same sampling
> frequency.

...

> +	struct spi_device *spi_anc[AD7768_MAX_AGGR_DEVICES];

> +	struct regmap *regmap24_anc[AD7768_MAX_AGGR_DEVICES];

Yeah, this will be enormous memory consumption...

...

> +static int ad7768_probe_multidevices(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *channels;
> +	unsigned long *masks;
> +	u8 cs;
> +	int i;

Why is 'i' signed?

> +	indio_dev->num_channels = st->num_devices * st->chip->num_channels;

This wants to have size_mul() from overflow.h to follow what allocator is using
beneath.

> +	channels = devm_kcalloc(dev, indio_dev->num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < st->num_devices; i++) {
> +		struct iio_chan_spec *chan = &channels[i];
> +
> +		*chan = *st->chip->channel_spec;
> +		chan->channel = i;
> +		chan->scan_index = i;
> +	}
> +
> +	indio_dev->channels = channels;
> +
> +	/* One mask entry, considering single channel ADCs, plus a zero terminator */
> +	masks = devm_kcalloc(dev, 2, sizeof(*masks), GFP_KERNEL);
> +	if (!masks)
> +		return -ENOMEM;

Isn't this devm_bitmap_zalloc()? Yes, it might require to reconsider the design
of the masks.

> +	masks[0] = GENMASK(st->num_devices - 1, 0);

bitmap_set() (needs bitmap.h)

> +	indio_dev->available_scan_masks = masks;
> +
> +	/* Setup ancillary SPI devices for single device access  */
> +	for (i = 0; i < st->num_devices; i++) {
> +		cs = spi_get_chipselect(st->spi, i);
> +		st->spi_anc[i] = devm_spi_new_ancillary_device_with_lane(st->spi,
> +									 cs, i, 0);
> +		if (IS_ERR(st->spi_anc[i]))
> +			return dev_err_probe(dev, PTR_ERR(st->spi_anc[i]),
> +					     "failed to register ancillary device\n");
> +
> +		st->regmap24_anc[i] = devm_regmap_init_spi(st->spi_anc[i],
> +							   &ad7768_regmap24_config);
> +		if (IS_ERR(st->regmap24_anc[i]))
> +			return PTR_ERR(st->regmap24_anc[i]);
> +	}
> +
> +	return 0;
> +}

...

> +	if (st->num_devices > 1) {
> +		ret = ad7768_probe_multidevices(indio_dev);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,

Having

	struct device *dev = &spi->dev;

may help here and elsewhere to make code neater.

> +					     "Failed to configure multidevice\n");
> +	} else {
> +		indio_dev->channels = st->chip->channel_spec;
> +		indio_dev->num_channels = st->chip->num_channels;
> +	}

-- 
With Best Regards,
Andy Shevchenko


