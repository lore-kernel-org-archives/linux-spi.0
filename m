Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B8153E2E4;
	Thu, 15 Oct 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074584; cv=none; b=Fdt+/arz/Wt+rUWWFGUOyJexo4w6WkOpSRLQLP95ENU17UA1pYxBY6bVpCQbI3HwfpYmjDfSLQgXOyk+W1cKUlXX+qHsmfNq0iaFL3xyiZuayFqg6VZiqjJN1rbVcf5tfhhkf5HWE8guSa8CU0QpCgUNNLCxQsGV3hWFleXEb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074584; c=relaxed/simple;
	bh=Ux8bYPBf+tPZGPkVOGqIDc2hrCy5YoJwGkED1by+PtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6oTtO0YLoSwT+EMWaOEu7PfQCpBrawiQw3neS4DR6TGWfm9ZMnhbCNXVsnjqZvdigIpW94IMg0C3bNkGHabucLTdq+3bcWLxGR2NWAInyLaWVpTIhiMUPj83W6B/T7xA9TSfcEWB0i9wdQuG+VqtDesHutk/MrrqnwRiXdhfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZGaWqZ1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZGaWqZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792074582; x=1823610582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ux8bYPBf+tPZGPkVOGqIDc2hrCy5YoJwGkED1by+PtM=;
  b=NZGaWqZ1pihGoDoDqwTox99j4J/nc5d5TtIAD8Cvihu5bes+8zGAV8Pc
   oyTUcGKH2T9q1HbtZcCtZhjSrmVYb/egDD0zszUSVOVePM7dVvKmhDVh6
   A1+qyrsnandhLtYf6hs0yPVPpATQ1iKD6QP5BihOigsPfO9O2/SVu2y/v
   ZGSPpVaZ/iS4jVm/A+UvEN+fxj/+tnekBQmlyfOc/2M1JABhWbcbt+WxZ
   caq4KZYnE1Mxl0fvF6DBeuvT06jYWsbhqti0LqAGBrwInPaZYu4dZsgAj
   AwowythQO8cFo4Nx2tFEjCyegvDrReqlqZIPDZXxM2NrJUMhHkS13cKtS
   w==;
X-CSE-ConnectionGUID: Dc/QLZ91RXWSqUyT7nRFlQ==
X-CSE-MsgGUID: yw5oh1QjTWapF0WGwIHVDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="877383"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="877383"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:29:40 -0700
X-CSE-ConnectionGUID: 57vUb34KTa2iHrVIj9ofiA==
X-CSE-MsgGUID: oKxPacBOQyOt9AEtHla1/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1617076"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Oct 2026 07:29:37 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHMSc-00000000GeO-2Uqv;
	Thu, 15 Oct 2026 14:29:34 +0000
Date: Thu, 15 Oct 2026 22:29:09 +0800
From: kernel test robot <lkp@intel.com>
To: Navid Ghahremani <ghahramani.navid@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 20/24] spi: zx: Add ZTE ZX family SPI flash controller
 driver
Message-ID: <202610152215.xgWnk9aT-lkp@intel.com>
References: <20261014072109.1759502-21-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-21-ghahramani.navid@gmail.com>

Hi Navid,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next linus/master v7.3-rc7]
[cannot apply to clk/clk-next next-20261012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Navid-Ghahremani/dt-bindings-arm-Add-ZTE-ZX279128S-platform-descriptions/20261014-082042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20261014072109.1759502-21-ghahramani.navid%40gmail.com
patch subject: [PATCH v2 20/24] spi: zx: Add ZTE ZX family SPI flash controller driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20261015/202610152215.xgWnk9aT-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610152215.xgWnk9aT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610152215.xgWnk9aT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-zx.c:473:4: warning: cast to smaller integer type 'unsigned int' from 'struct zx_qspi *' [-Wpointer-to-int-cast]
     473 |                         (unsigned int)qspi);
         |                         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                              ^~~~~~~~~~~
   include/linux/dynamic_debug.h:285:19: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
>> drivers/spi/spi-zx.c:706:17: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551614 to 4294967294 [-Wconstant-conversion]
     706 |         writel_relaxed(~ZX_QSPI_EN, qspi->io_base + ZX_QSPI_EN_REG);
         |         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/io.h:88:39: note: expanded from macro 'writel_relaxed'
      88 | #define writel_relaxed(v, a) __writel(v, a)
         |                              ~~~~~~~~ ^
   2 warnings generated.


vim +706 drivers/spi/spi-zx.c

   701	
   702	static void zx_qspi_remove(struct platform_device *pdev)
   703	{
   704		struct zx_qspi *qspi = platform_get_drvdata(pdev);
   705	
 > 706		writel_relaxed(~ZX_QSPI_EN, qspi->io_base + ZX_QSPI_EN_REG);
   707	}
   708	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
