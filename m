Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDDB1DDC07
	for <linux-spi@vger.kernel.org>; Sat, 23 May 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779562126; cv=none; b=f+2IISxVCnGAie3P5+M2bw9o6YUoE9pU7DpEhdJpQSw39ULw0Efgj9MDxRP1o6fYz8IeVlj4gWJOLppCsy9NTD3xucNQ8s/jReMde/7rqk8cFgMtoSmkpJHxW2C6knFYHAqW0K8S62YFy4SAHUdznTZ1ET2ooMaMlYLx+iEfn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779562126; c=relaxed/simple;
	bh=YXcg58n6rK4mo4xLDfg5SCE4PIwRVtgnE1EYzs2M55M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=USOW8lOk3TC0Zs11RrxW1S8yJgFLpG7yXwcyMJCKJWIV0kkYYolJkR7PEX+2+py4oGu7dNtTVU9OLT3YNpR001BjkmWuGwAyzys4YddkxrFM8Y2cj5dQR8qNb5sYbWvabI445mbt61yBCcEq/uoPVtiV4p3jpL3g6KZfl6qj47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTQhuAgI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTQhuAgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779562124; x=1811098124;
  h=date:from:to:cc:subject:message-id;
  bh=YXcg58n6rK4mo4xLDfg5SCE4PIwRVtgnE1EYzs2M55M=;
  b=jTQhuAgI+9vRkHJXzuGfbxeGOk3Czyoor6NsFdIYY476hBYlbRugDf7N
   U2poqdUfyabsqRv/cvd+owXgNLuvjrzDZGtYOSD+f3DT4ZR2zfioi6cyA
   BGJfqnBVvu+nV3RMuvX2Lxb7qI9IQHxROey/clKcSO8zqZDvDeS0uKlPT
   CaK7wGvaJalfkOi3XQg4LumMyZRDwTymRSGjE3bXaUsA1ATAOJK37dFn6
   /9rZ7UY3ihm2LtJiepVjpz3neHywllk2xUIF2eaHee0LVWaKihOWLqXuC
   OGGMmyqtI6VNIfnS6uktd+z7DpIopmAntdyVl9vPfYdubCu4ECNWyk5Dh
   A==;
X-CSE-ConnectionGUID: pyKj3e6+TXqTHNBW1cGe9Q==
X-CSE-MsgGUID: L9ID7P5fSUm7nyMK0exDYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="80421104"
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="80421104"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 11:48:44 -0700
X-CSE-ConnectionGUID: 2W4mZsMBQqiTDPp/OV9qYQ==
X-CSE-MsgGUID: 9WhetWPXQjSwZNhpPLMEHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="264767367"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 23 May 2026 11:48:42 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQrOp-000000000HR-1HL7;
	Sat, 23 May 2026 18:48:39 +0000
Date: Sun, 24 May 2026 02:48:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-6.20 2/42]
 drivers/spi/spi-aspeed-smc.c:909:35: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202605240240.yLBPcZCa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.20
head:   40534d19ed2afb880ecf202dab26a8e7a5808d16
commit: 04f7516ab70f7b82aae1d2830af2ee6f17f3fe98 [2/42] spi: aspeed: Add support for non-spi-mem devices
config: mips-randconfig-r134-20260523 (https://download.01.org/0day-ci/archive/20260524/202605240240.yLBPcZCa-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260524/202605240240.yLBPcZCa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605240240.yLBPcZCa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-aspeed-smc.c:909:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *dst @@
   drivers/spi/spi-aspeed-smc.c:909:35: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-aspeed-smc.c:909:35: sparse:     got void *dst
   drivers/spi/spi-aspeed-smc.c:939:46: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-aspeed-smc.c:1469:61: sparse: sparse: undefined identifier 'cols'
   drivers/spi/spi-aspeed-smc.c:1469:61: sparse: sparse: bad constant expression type
   drivers/spi/spi-aspeed-smc.c:1469:55: sparse: sparse: undefined identifier 'rows'
   drivers/spi/spi-aspeed-smc.c:1469:55: sparse: sparse: bad constant expression type

vim +909 drivers/spi/spi-aspeed-smc.c

   890	
   891	static void aspeed_spi_user_transfer_tx(struct aspeed_spi *aspi,
   892						struct spi_device *spi,
   893						const u8 *tx_buf, u8 *rx_buf,
   894						void *dst, u32 len)
   895	{
   896		const struct aspeed_spi_data *data = aspi->data;
   897		bool full_duplex_transfer = data->full_duplex && tx_buf == rx_buf;
   898		u32 i;
   899	
   900		if (full_duplex_transfer &&
   901		    !!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD |
   902				    SPI_RX_DUAL | SPI_RX_QUAD))) {
   903			dev_err(aspi->dev,
   904				"full duplex is only supported for single IO mode\n");
   905			return;
   906		}
   907	
   908		for (i = 0; i < len; i++) {
 > 909			writeb(tx_buf[i], dst);
   910			if (full_duplex_transfer)
   911				rx_buf[i] = readb(aspi->regs + FULL_DUPLEX_RX_DATA);
   912		}
   913	}
   914	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
