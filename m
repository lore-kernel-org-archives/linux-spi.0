Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19530315D5D;
	Tue, 18 Aug 2026 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036007; cv=none; b=KOK6Qmn78EIUq0Muump5UmZjQuGPDP86QFNqtQmeIeCHDDmDiUjB0X/W+wQn0Fpd3FeN9qNS3DIh9MyZ7QmzR6r/wf+0gLxYrJQj8Jofj1SRdUx//B6Y1wtYbwuaTQiBb29Mlr4Et/t32XS9D6az7wySQFDk4cUSwHE72zCDtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036007; c=relaxed/simple;
	bh=iynbCO6TFVkHrOpLZ3+lOY96sEdrxE1E9dSFW5Lqh2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bukqEm7btlnDrggRUKzcnRRZyjAGuk7qVTdvjzMyXUMPxG9A0SVLKsmsh/IUMA/xKGiKrVJzW0czswS5XmirYW5tJN6uBDW88lrlbSg798vN6UcEU7BQlLKGsHaZI7CaG/qQzs7rFIEhgY93dTvP+iQS2R5K3N6ZlOKr2XNCCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDj8LGVh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDj8LGVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787036005; x=1818572005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iynbCO6TFVkHrOpLZ3+lOY96sEdrxE1E9dSFW5Lqh2Q=;
  b=LDj8LGVhEP6h88oxJvR0fPQ6yK7LWxPeK+46k1oBvkyozVGo4QWJyttT
   j9JJgT0kpH7LpKEfXa0ur6P7pcNgrykpGhvxLGGzN0M7sLz+z+fVSYgBe
   VI5P6hsnsk3S71ItAnFg+5mI5ii5h7goylvY6Hx+kGjds07zTE5sqV53M
   FLxFteUGX3ycYur/tQLFXwN4CDCMtUDeWusTFcfIz+/InvbjnwYQRTU5w
   Td4Akudwsso9tvsY+KwXeUsVyoiIUTegFsUCWw3N3LKI4msipdsL4A1co
   Hpt78+YG5Kz2ZwW2O5jW6xW8++lOLSgnz8Yh4sensOlL+2Sdy935Xw3B7
   g==;
X-CSE-ConnectionGUID: 1ZeSF+QbRXK7WYHgvifUDg==
X-CSE-MsgGUID: ps31bEx2Rrqwtvt9H2QQPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87282092"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87282092"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:53:24 -0700
X-CSE-ConnectionGUID: fd0v3uayQkadYwT3zT7d1Q==
X-CSE-MsgGUID: /Rb7LH6YStWyHYQGzODYqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="262510818"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:53:21 -0700
Date: Tue, 18 Aug 2026 09:53:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 4/6] spi: introduce SPI ancillary device with lanes
Message-ID: <aoQBX4__i14vm3or@ashevche-desk.local>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <d593c34ec559a674bdee30e2f11489259af295b7.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d593c34ec559a674bdee30e2f11489259af295b7.1786973376.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 08:33:12PM -0300, Jonathan Santos wrote:
> The existing spi_new_ancillary_device() creates an ancillary SPI device
> but does not consider the parent's lane map. In multi-device setups where
> each sub-device's chip-select is bound to a dedicated data lane, there is
> no way to bind an ancillary device to an arbitrary lane index.
> 
> Introduce spi_new_ancillary_device_with_lane() and
> devm_spi_new_ancillary_device_with_lane(), which accept rx_lane_idx and
> tx_lane_idx parameters to select a specific lane from the parent's
> rx_lane_map and tx_lane_map respectively. The resulting ancillary device
> is registered with a single RX and TX lane, keeping it independent from
> the other sub-devices sharing the same controller.


...

>  extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
>  extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
> +extern struct spi_device *spi_new_ancillary_device_with_lane(struct spi_device *spi,
> +							     u8 chip_select,
> +							     unsigned int rx_lane_idx,
> +							     unsigned int tx_lane_idx);
> +extern struct spi_device *devm_spi_new_ancillary_device_with_lane(struct spi_device *spi,
> +								  u8 chip_select,
> +								  unsigned int rx_lane_idx,
> +								  unsigned int tx_lane_idx);

Can we stop using legacy 'extern' for the function declarations?

-- 
With Best Regards,
Andy Shevchenko


