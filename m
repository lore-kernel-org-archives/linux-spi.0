Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2D331221;
	Wed, 18 Mar 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853523; cv=none; b=Ccd/gioFwVxbifAeKJUukzsuBpmXEH6Y5Xl5Kdys0n/5HBinMaQnJpqg+UPCqeK73KwoHC1bYwp6pc4wpI6yiH6K0DlRUGD6mRopMqIfj+f/XlcsxOC+GF0E5JeZvFO23g+MG++QVJbOIn9Wf/CNnw2mxGCcj2Ve2l/GF6B4qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853523; c=relaxed/simple;
	bh=FRwg2E9CLljwcNk6xTVAFoV/k9oE/5jF1+naOPnV9r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPuLO0y75Lz3R/M7AztOlp/Rjj2bjQ4XWhBqGvlGBe/qVkii5ia/+wfZZPHtHELi8Wee42Hwx6Ulu6eg6zoAvDtavBthKIiLOB91BNqD/dI/p8nYU15fwtE3JCrMHjcGXZ8qRgq+oY/W3wt7DExB0SgJCXrYLPxmI5kQ0dNuwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMrEa1lB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMrEa1lB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773853520; x=1805389520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FRwg2E9CLljwcNk6xTVAFoV/k9oE/5jF1+naOPnV9r4=;
  b=RMrEa1lBMPKLXJI0s0HXz/ul+E2lyhRAqeFVodeDxSpviH9yovul75xZ
   TNXP9fci4kqx6B4dBWnncNJ51/1G/xci+RhVhlTocBqLEXKO8BvXhxK/j
   c0IOaHjjq2Qv7tM0mfXUeNt2nakKZ4Zz+XXKsPKhvir8RQwXWhSAtxI/i
   I9KV3r028yfzSHrQ5H5h7ZWOpWodT/iKZf6Ut8UC6BfgAjd41hvTXB9va
   NJxG2etfMRzQp40z+s691KpIEGViaaaJGD3f1rUtAlmZ4J1GAWcf8NF/t
   4KJIkHLrCZSlfzdQ8/0k25go8KUafizpxioFoYwIPz3bfAGFB+4LXHzoU
   A==;
X-CSE-ConnectionGUID: 8Z4/jkG/Q8KAFmvWeI/DBA==
X-CSE-MsgGUID: JVF0DuLNQ9GRD3mOgBm9rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74948737"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74948737"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:05:20 -0700
X-CSE-ConnectionGUID: I4g4cbSVQxWMegfWb/0kZg==
X-CSE-MsgGUID: a8hhyyakQLmEVdfMWq0wMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222740621"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 18 Mar 2026 10:05:16 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2uKX-000000003Az-29FG;
	Wed, 18 Mar 2026 17:05:13 +0000
Date: Thu, 19 Mar 2026 01:04:38 +0800
From: kernel test robot <lkp@intel.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH v3 07/17] spi: orion: Use helper function
 devm_clk_get_enabled()
Message-ID: <202603190122.1OMLjae4-lkp@intel.com>
References: <5727aa84748872059e2a39eb67f1f08c0de6206b.1773733017.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5727aa84748872059e2a39eb67f1f08c0de6206b.1773733017.git.xiaopei01@kylinos.cn>

Hi Pei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on next-20260317]
[cannot apply to atorgue-stm32/stm32-next rockchip/for-next xilinx-xlnx/master clk/clk-next shawnguo/for-next soc/for-next linus/master v7.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pei-Xiao/spi-axiado-Use-helper-function-devm_clk_get_enabled/20260318-110300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/5727aa84748872059e2a39eb67f1f08c0de6206b.1773733017.git.xiaopei01%40kylinos.cn
patch subject: [PATCH v3 07/17] spi: orion: Use helper function devm_clk_get_enabled()
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260319/202603190122.1OMLjae4-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603190122.1OMLjae4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603190122.1OMLjae4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-orion.c: In function 'orion_spi_remove':
>> drivers/spi/spi-orion.c:798:27: warning: unused variable 'spi' [-Wunused-variable]
     798 |         struct orion_spi *spi = spi_controller_get_devdata(host);
         |                           ^~~


vim +/spi +798 drivers/spi/spi-orion.c

60cadec9da7b6c drivers/spi/orion_spi.c Shadi Ammouri    2008-08-05  793  
60cadec9da7b6c drivers/spi/orion_spi.c Shadi Ammouri    2008-08-05  794  
2e0de1efb233ab drivers/spi/spi-orion.c Uwe Kleine-König 2023-03-03  795  static void orion_spi_remove(struct platform_device *pdev)
60cadec9da7b6c drivers/spi/orion_spi.c Shadi Ammouri    2008-08-05  796  {
08e6c5038fee47 drivers/spi/spi-orion.c Yang Yingliang   2023-08-18  797  	struct spi_controller *host = platform_get_drvdata(pdev);
08e6c5038fee47 drivers/spi/spi-orion.c Yang Yingliang   2023-08-18 @798  	struct orion_spi *spi = spi_controller_get_devdata(host);
60cadec9da7b6c drivers/spi/orion_spi.c Shadi Ammouri    2008-08-05  799  
5c6786945b4e04 drivers/spi/spi-orion.c Russell King     2014-06-21  800  	pm_runtime_get_sync(&pdev->dev);
4574b886698dfa drivers/spi/spi-orion.c Andrew Lunn      2012-04-06  801  
08e6c5038fee47 drivers/spi/spi-orion.c Yang Yingliang   2023-08-18  802  	spi_unregister_controller(host);
5c6786945b4e04 drivers/spi/spi-orion.c Russell King     2014-06-21  803  	pm_runtime_disable(&pdev->dev);
60cadec9da7b6c drivers/spi/orion_spi.c Shadi Ammouri    2008-08-05  804  }
60cadec9da7b6c drivers/spi/orion_spi.c Shadi Ammouri    2008-08-05  805  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
