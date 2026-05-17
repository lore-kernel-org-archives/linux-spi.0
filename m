Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B33128A3
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051898; cv=none; b=VBVp9xM65gkKGB4IO6dk/Qyh9ri1puiiv8697ITIOgy26BtLKpFGkXCzXsGyluvgP43rX0J44ctpUD5N7cvdKNdAEs0LDlw/DJ/v07AFJTcX1nfKisk0kaf3PzyrGlYTIvQsiAkekRRn6NudRDUQD+r8DoH4AEm0i1NNI7+eIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051898; c=relaxed/simple;
	bh=7J/Q8z0p6z/ZaMeFT9hzqiMVl4XH6nAoe47w5IyX6FE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZoMbbz2S5hvyOtwMZFqPjBuXqTrD6LUr/TEts9Im0sDU6uVeDo695TS5J4a0qX9Q0nfD7mJNv//SuOWMsqEEfrfHf0GRuhJLc0fRm5oz9vKJUEXX2W5lIg40W1jTUFZri8Rxy1KBwW4g5AtE/j8Sfb5zYWFR1i7C6Ww/Ho9iiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQyt9j/7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQyt9j/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779051896; x=1810587896;
  h=date:from:to:cc:subject:message-id;
  bh=7J/Q8z0p6z/ZaMeFT9hzqiMVl4XH6nAoe47w5IyX6FE=;
  b=OQyt9j/7QZpe/Ct1dQaONBXKQYEXVwJHQcxvj3HLEXd6fC1wyHM+ts4d
   7hT9Gb6vwAaHat7pWacP39R2Uw7U/oCNIdPkhfkL6zhUFtX/qkgQOlP83
   Ta6BbgM2JW7dmTVrOYmbWPjO4MiEhqAExiorLd4t9xNqITPtBDx+ZKO+Y
   2xC1jjps0yv64auPspKpuSzA6v7GgcbgF6uhe7nAI8jr7j9LQ/zgCMgHt
   Hf+Kt6MFPpK3eqlwdZvnCCeQqA6NZeII7SizGyHDK4EEagnEFAGVxghX9
   M4KB63rI4dJZ4ueBATDVTkknnovcjEGVtjkcuq0cSh/xrhKUhku9AyOy6
   A==;
X-CSE-ConnectionGUID: oQfIWwEyTfi9f2Qvfthk3g==
X-CSE-MsgGUID: n9yRNkkFSK6X1HMY6MP+ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="97341848"
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="97341848"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 14:04:56 -0700
X-CSE-ConnectionGUID: HLGeySCuTKeGSqdZtvJsaQ==
X-CSE-MsgGUID: wLNt4rwPQVeCu850RGFgRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="238365836"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 May 2026 14:04:52 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOifJ-000000001wo-2dns;
	Sun, 17 May 2026 21:04:49 +0000
Date: Mon, 18 May 2026 05:04:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-6.20 2/42]
 drivers/spi/spi-aspeed-smc.c:909:17: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202605180441.uD3toFRJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.20
head:   40534d19ed2afb880ecf202dab26a8e7a5808d16
commit: 04f7516ab70f7b82aae1d2830af2ee6f17f3fe98 [2/42] spi: aspeed: Add support for non-spi-mem devices
config: sh-randconfig-r132-20260518 (https://download.01.org/0day-ci/archive/20260518/202605180441.uD3toFRJ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260518/202605180441.uD3toFRJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-aspeed-smc.c:909:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *dst @@
   drivers/spi/spi-aspeed-smc.c:909:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-aspeed-smc.c:909:17: sparse:     got void *dst
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
