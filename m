Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781969;
	b=Yik99PYMkEoub17kAS7ChXtZzLfPD1BYyXEtbnX4O1EtiFcMBNGCvSdxC/1JZ4zRhJWp
	 UMoUGDO16IVXi3UqOsHmIeyEk/meTvb3YW4/R+2Vc3p/QXQt1maZFN6qmlBC67NoF2Gur
	 Iks+HmX3CY4+v0bjAsL9ygxwFWoAJAGeqWnShAIdVMs5TxL6LkZEvUSk/3FW10/+ww090
	 Agss9a67ZBmYmkGcW5I90jt5mO3Q/XT2f6MdyhUunA6o0NhUXl7YmS+4r1hKEGGvYcExh
	 aNAFu5Bhd7QVWYS5Ht8Ro7kOjhRfaFLQQWojILEKwGzHBXeoXSE9NcYb5qD37cdj7nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781969;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=rPktWRiI/JgjZXOK0VV9UihgCUHb9+RZLQKrRxQgIkQ=;
	b=m15pkzCsB09CfQEQ8w14KSg8j+PZls5jz/KtmEvGZoWD3M9NZzei0ekkKuBzBhS6QmCp
	 LAIKWkCg4+Eo8F0HA5P/nibf0pZN5ps71yRiS8nxaQeknDqGb8g4rNV8x0xJCivL6TZkf
	 fm9QYJ6Z22goga/bAKJb/9bT4HBjT4pm+4ZphGfisNs0j2BOe3IS9dm6H7NCTF2dxiGlN
	 CFMbsg5S6SmPXgZhX00fKyBCTLDidGfa9qxyGCPtUXR5B4PdNaT2ZCZ2rPI5agrsn77Zo
	 PqBCQkTz+ivaZML3PAgnHRsPetcpOQi/2md8EzuTUlvHyjKgNsqb2glq7rD29oCb7PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iWWgRzl+;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C727606A332;
	Wed,  4 Nov 2026 08:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C727606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iWWgRzl+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793781968; x=1825317968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyw4gM5AV8XJVm/D6q+MVFyu67HewixU8i9L8I15X1c=;
  b=iWWgRzl+G9UGeLaaOSMKwUkTg0tPIFathBLyox5WuC67tvWB9dNBLxpj
   /gb+oeiLV300/eeoiT/9u4jsjoAbme2qzeCFw33Pa71aDXVtAqglZxZqM
   p1yHNgYCRe3eIJzBAKml6LQbe0OVBa/B+HbsW5NKVLfwN3tFzU961whgp
   eZtLBinlkQCN25xlHz7D0B3WmK4ZqOXriNDgJdcvO9q8rgpOCUBjxiVej
   k8SvJLa5GCbApCgIy1T3NXo1zDyCGI+9MLOTq8iQCWxRe3ADMfEtBjWs5
   exd7+80viJXd+9picluUNdgWY3Ju2X0oTzWETCfURR626wr3BM4o0z1ba
   w==;
X-CSE-ConnectionGUID: Xry16HfISnaoFYx3QuBkLg==
X-CSE-MsgGUID: N5kkojMZR7OlZGMY4e04wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2623322"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2623322"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:46:08 -0800
X-CSE-ConnectionGUID: DY0+xHzSQB+42gN643B25Q==
X-CSE-MsgGUID: /SZ9wx83SOqE5CZm7dzfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="7219588"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:46:05 -0800
Date: Wed, 4 Nov 2026 10:46:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:PXA2xx/PXA3xx SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] spi: replace chan->device->dev with
 dmaengine_get_provider_device()
Message-ID: <aurwylnNpkKi_Bx-@ashevche-desk.local>
References: <20261103215824.1823272-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103215824.1823272-1-Frank.Li@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 04:58:23PM -0500, Frank.Li@oss.nxp.com wrote:

> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.

...

>  	struct dw_dma_slave *s = param;
>  
> -	if (s->dma_dev != chan->device->dev)
> +	if (s->dma_dev != dmaengine_get_provider_device(chan))
>  		return false;

It's obvious that we need another helper to match.

// void * and EXPORT to be able to use as filter function
bool dmaengine_match_provider_device(struct dma_chan *chan, void *dma_dev)
{
	return dmaengine_get_provider_device(chan) == dma_dev;
}
EXPORT_SYMBOL_GPL(dmaengine_match_provider_device);

...

>  static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
>  {
> -	return param == chan->device->dev;
> +	return param == dmaengine_get_provider_device(chan);
>  }

With that being done this function is gone.

-- 
With Best Regards,
Andy Shevchenko


