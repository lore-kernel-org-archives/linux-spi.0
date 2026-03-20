Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76D373BF1;
	Fri, 20 Mar 2026 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996049; cv=none; b=gFaCMEO68fr21GlhxrbLwj9JjjzdLswHUzrU9oGNactpGcF1rBN+mBW2NXpTel4D8L9e3aBWBpPcrZDnPu1/kEgOYugV1zX9Gj1rj/61V/dtnuFs+e02og0mCe0lKtOb5fXhYK/m+vWAHVOQCdfOrDotPIMj9LSar+hJL8PZY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996049; c=relaxed/simple;
	bh=pRoVm1uSlvFJ1DUaEsZAHIMkqpeZSr5DbQgK9V4VP1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLN3snmcWIOqbLevt+Y6niMrHJqdklNp3vF/gd3S5N5ZuPaQGWzQrUbmENsahRZDUIHpFxFh1M4hxlnUfynrT0+QyU2q6dICewNUpLd3hu0yjtY8ctwOuQlQ6ahyiFJcNabTf6YAomoqLKOmmvO4PcNQf390VJXUjIml61u4PaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzQtpvTj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzQtpvTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773996046; x=1805532046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pRoVm1uSlvFJ1DUaEsZAHIMkqpeZSr5DbQgK9V4VP1I=;
  b=MzQtpvTjEa9O1z1g9Mj+QbRPBf1OedNo6s4xP5tFxQL2x+37i3RJ5qOu
   bC5jIcVIekdar88i7n2BID98FjORI6+Y9pslJJvVUUJlSyGRqwSeL4QmG
   pOEz8FDNCIPLP7u3cu6dok5LzxzQPizs5Kf86Z3QRLQXT5BOeFo8ZJS7J
   t4yif1o5BmGH4dRkEnwIwVBAZAAuLsX/djBKN9VQY2JCJfgjIMKPhD34R
   bWPKcVemumcndUhMEgzHhpan9S0ObspcKEBVeq9KtsdhBVnDrsG7z6kxt
   p1Mx0YX4cOcgE95TcxxptsHaF5vRN+67yWQGds6S6BR/NvktiQ//44XcB
   A==;
X-CSE-ConnectionGUID: xfy0PGlLRm+7JEbdEvm+DA==
X-CSE-MsgGUID: pNZyY6C1TImlLkw3b3rdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75043698"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75043698"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:40:45 -0700
X-CSE-ConnectionGUID: UMl4ekA+SP2qinyxdLsYdQ==
X-CSE-MsgGUID: oy8/u9TvR3Kup4Vvs0GRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223210435"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2026 01:40:41 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3VOw-0000000029V-0Dxy;
	Fri, 20 Mar 2026 08:40:19 +0000
Date: Fri, 20 Mar 2026 16:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org,
	Frank.Li@nxp.com, amelie.delaunay@foss.st.com
Cc: oe-kbuild-all@lists.linux.dev, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH v5 11/17] spi: st: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <202603201638.tsz5xX5N-lkp@intel.com>
References: <383814750ad46181fd4199b3c6cec4767d480075.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <383814750ad46181fd4199b3c6cec4767d480075.1773885292.git.xiaopei01@kylinos.cn>

Hi Pei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on next-20260319]
[cannot apply to atorgue-stm32/stm32-next rockchip/for-next xilinx-xlnx/master clk/clk-next shawnguo/for-next soc/for-next linus/master v7.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pei-Xiao/spi-axiado-Simplify-clock-management-with-devm_clk_get_enabled/20260320-025630
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/383814750ad46181fd4199b3c6cec4767d480075.1773885292.git.xiaopei01%40kylinos.cn
patch subject: [PATCH v5 11/17] spi: st: Simplify clock handling with devm_clk_get_enabled()
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260320/202603201638.tsz5xX5N-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603201638.tsz5xX5N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603201638.tsz5xX5N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-st-ssc4.c: In function 'spi_st_remove':
>> drivers/spi/spi-st-ssc4.c:365:32: warning: unused variable 'host' [-Wunused-variable]
     365 |         struct spi_controller *host = platform_get_drvdata(pdev);
         |                                ^~~~


vim +/host +365 drivers/spi/spi-st-ssc4.c

9e862375c5420a Lee Jones        2014-12-09  362  
2dd42da0b479ff Uwe Kleine-König 2023-03-03  363  static void spi_st_remove(struct platform_device *pdev)
9e862375c5420a Lee Jones        2014-12-09  364  {
e6b7e64cb11966 Yang Yingliang   2023-11-28 @365  	struct spi_controller *host = platform_get_drvdata(pdev);
9e862375c5420a Lee Jones        2014-12-09  366  
cd050abeba2a95 Chuhong Yuan     2019-11-18  367  	pm_runtime_disable(&pdev->dev);
cd050abeba2a95 Chuhong Yuan     2019-11-18  368  
9e862375c5420a Lee Jones        2014-12-09  369  	pinctrl_pm_select_sleep_state(&pdev->dev);
9e862375c5420a Lee Jones        2014-12-09  370  }
9e862375c5420a Lee Jones        2014-12-09  371  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
