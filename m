Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893076;
	b=Udsf6m3fwEhTqPIiAMmrUVdz/XnKuIDude4RDHzL9Rr3gn/S39YECszO1UxmXxeLG+AB
	 75/y/6Zeqs35Z/+RPlVpaF0uC98x+DRnuj/XsrdRWkqI/1/I4AAOA+0hmc98iMqAbg/eZ
	 Ojd8mSIcAeYYm35W2CtGPdh5a/cva3So4waK547fTzLrYUlMwaJ08grxd3qGBFV0gNbzl
	 eB8gHYz8QgrILq0Q+Jyi+5/BLF10fvJcoud8y3AWMi1VzpOndLIc6xDvKl8cnswnaElrv
	 p0AHvgcfe28vMvDT5vPmjBSJ3YsQUcL3TwPLqTREiG8OcomjltwNwoKHHCkr43GUNKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893076;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=a8fOfTWHFzr2pCOGSJbbffcbXW9qhAZ/XrlO3SqW07Y=;
	b=3Zb/d9K4VmJ+W+QPEZCVfiHwpC+XqulJK2ne59EsB/snWnmsnvM9Z/iZUhWxon2OER4Y
	 vJ8aaQ/uYfXlvYDyUji4BhUsS9ew0JNmN2qOisGN3kPBAi5CwUI5bf8xpBL44es3BK9Sq
	 E50FIHQ9mrzairM/J49xJRvGb+EKw9HeaCdb3qEXwu7meQ2ckCya8hgLm+NKP//+4CIbI
	 3uNalzMBwvOaxPlKCImqJhBuvmGDlJK0fvcQTd9QPxKksFnOTahiGTAeHFzD4yR29zgcf
	 uFFKV0D3heORWrhf35ZnCUlIrP5oiJezCukLS2vrXRGonIXia/uy32NfGKK6OKKPJcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nF2gGAPe;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C73606A323
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 05:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C73606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nF2gGAPe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794893076; x=1826429076;
  h=date:from:to:cc:subject:message-id;
  bh=ddbsLmPpbhsXU0oGii5UBIGk7CwMM5ajiAb+K7aa1JA=;
  b=nF2gGAPeLSRtmK3qgjkDWQOFo8enFrDgQaVGXgIvxWl/Ue1YEvVg9HBh
   QKOVkNtWQ8b1yYTXkCBDh4RIApjKS4MGQr2r8oOYipUSNnMZb5gzt/49r
   hqYwQa2lOw9ALNiwGruGeb925AQFVv8oFlFSih+l06v5xweiGXaYELIoC
   WiEbIwNGj9GP7rwcokTZjvwLcjL48PVQr39+kRfp+MM2MJ7YBPIt4aSIc
   GgSygVDwobCxRQ6TIEcxHlbFjl0mqxWVoJTmDEbseXmfa2XzzfYsRDlMW
   JFu0wX8aSq5brfWMrT+WCIfWtBkW4OtX5MBiP8k7TRqPi8rjF5UJ0CRzG
   A==;
X-CSE-ConnectionGUID: /6dPlDEISAyBdAV5Ag7vLw==
X-CSE-MsgGUID: KyGtZIzlQ+2tAkWPYU4nIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3689330"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3689330"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 21:24:35 -0800
X-CSE-ConnectionGUID: uZ6zDkeYSvOxh0/CyrBLBg==
X-CSE-MsgGUID: mKTfeP5sRrWebZ//BHKaJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11665676"
Received: from igk-lkp-server01.igk.intel.com (HELO 1073a420ae3a) ([10.211.93.152])
  by fmviesa013.fm.intel.com with ESMTP; 16 Nov 2026 21:24:33 -0800
Received: from kbuild by 1073a420ae3a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTBgF-000000002yv-0APJ;
	Tue, 17 Nov 2026 05:24:31 +0000
Date: Tue, 17 Nov 2026 06:23:56 +0100
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-7.5 2/6]
 drivers/spi/spi-cadence-xspi.c:438:43: sparse: sparse: unsigned value that
 used to be signed checked against zero?
Message-ID: <202611170617.CCFgmq6H-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5
head:   9b2d7c8736a6fd27ceda93bd67529758c139e24f
commit: b7d724ff0f4ab6b5d3392938076f5914ecec12fd [2/6] spi: cadence-xspi: Support dmaengine for sdma io copy
config: m68k-randconfig-r2308-20261117 (https://download.01.org/0day-ci/archive/20261117/202611170617.CCFgmq6H-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 10.5.0
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170617.CCFgmq6H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611170617.CCFgmq6H-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-cadence-xspi.c:438:43: sparse: sparse: unsigned value that used to be signed checked against zero?
   drivers/spi/spi-cadence-xspi.c:430:59: sparse: signed value source

vim +438 drivers/spi/spi-cadence-xspi.c

   422	
   423	/* -EAGAIN means no DMA was issued, so the caller can use the CPU path. */
   424	static int cdns_xspi_dma_transfer(struct cdns_xspi_dev *cdns_xspi,
   425					  size_t len, bool read)
   426	{
   427		struct dma_chan *chan = cdns_xspi->dma_chan;
   428		dma_addr_t port_addr = cdns_xspi->dma_addr;
   429		enum dma_data_direction dir = read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
   430		void *buf = read ? cdns_xspi->in_buffer : (void *)cdns_xspi->out_buffer;
   431		struct dma_async_tx_descriptor *desc;
   432		struct device *dma_dev;
   433		dma_addr_t buf_addr;
   434		dma_cookie_t cookie;
   435		int ret = -EAGAIN;
   436	
   437		if (!chan || len < cdns_xspi->dma_data_width ||
 > 438		    len > cdns_xspi->sdmasize || !virt_addr_valid(buf))
   439			return -EAGAIN;
   440	
   441		dma_dev = dmaengine_get_dma_device(chan);
   442		buf_addr = dma_map_single(dma_dev, buf, len, dir);
   443		if (dma_mapping_error(dma_dev, buf_addr))
   444			return -EAGAIN;
   445		if (!is_dma_copy_aligned(chan->device, port_addr, buf_addr, len))
   446			goto unmap;
   447	
   448		desc = dmaengine_prep_dma_memcpy(chan, read ? buf_addr : port_addr,
   449						 read ? port_addr : buf_addr, len,
   450						 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
   451		if (!desc)
   452			goto unmap;
   453	
   454		reinit_completion(&cdns_xspi->dma_complete);
   455		cdns_xspi->dma_error = false;
   456		desc->callback_result = cdns_xspi_dma_callback;
   457		desc->callback_param = cdns_xspi;
   458		cookie = dmaengine_submit(desc);
   459		if (dma_submit_error(cookie)) {
   460			dmaengine_terminate_sync(chan);
   461			goto unmap;
   462		}
   463		dma_async_issue_pending(chan);
   464	
   465		if (!wait_for_completion_timeout(&cdns_xspi->dma_complete,
   466						msecs_to_jiffies(CDNS_XSPI_DMA_TIMEOUT_MS))) {
   467			dmaengine_terminate_sync(chan);
   468			dev_err(cdns_xspi->dev, "SDMA %s DMA timeout\n", read ? "read" : "write");
   469			ret = -ETIMEDOUT;
   470		} else if (cdns_xspi->dma_error) {
   471			dmaengine_terminate_sync(chan);
   472			ret = -EIO;
   473		} else {
   474			ret = 0;
   475		}
   476	
   477	unmap:
   478		dma_unmap_single(dma_dev, buf_addr, len, dir);
   479		return ret;
   480	}
   481	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
