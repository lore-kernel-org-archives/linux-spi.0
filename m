Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9133BBA2;
	Wed, 18 Mar 2026 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860556; cv=none; b=Exui+ffOo9IPK4Hs2LycE8VsufBukwt2DzMhHOpM6TIMiC1eLG4fZWSQHbpXMpfo6jr96ricqSTqzpQU255sWu0k9qO1IMHDMbODcasUD1AOlTX2lEpsFNaYjD5oCmFrVhcASJcGMXhk7d8q/S3RlLjlmImCF83jyMKnJv8LG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860556; c=relaxed/simple;
	bh=XIwaunvaQN5MSz2DPfNECpeDO+PYa3DzRiYLu9KKQpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTSGoZ6/knyOehrr1Sh73Ke+Dgjb9EFEXQXsAxI596aWSQfcXVYQ854CwsDHgHCd7kwnGay5hjDmOjZm6szPMpj2yBklLlvr5fn2Sf8+Avoe5vAev80soSDcsiuPaGHMKxAwFKc/kP8Q1uD83Z2VOEol7oXmdJEOa8vv34YmlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSWnmgA6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSWnmgA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773860555; x=1805396555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XIwaunvaQN5MSz2DPfNECpeDO+PYa3DzRiYLu9KKQpA=;
  b=TSWnmgA6sJAN0q1mqSJOHNVgUqsK60fysfXmz6AxE7KIMjmIosM4NV56
   20WRbKz5sJV/smG2oiZ4k4xUW1ny16IUa0I0IRIBzfgY3aaoaQ6bHUqRv
   EtYPEmku8hvSt3sc22LqJCT9NMhwKHBhSyXa3YZDYRNp30MAyG4+u3uOD
   BnJvxJ6gfxGsLLl9l1rTanY8uR8QKbYMaiznwVw0OrEEPdEQ95Xf4ApdO
   /MW36Dkow3i91zYQKB5K9eDw7ULq8qkPKJRt2cxgUSOmjUtOdOrBmDVO2
   8XQ8OAyaTS0H9bRQdZtc2UAgfzsoGIelqIcm4C4Y33/SOeXtamxKj+KxQ
   w==;
X-CSE-ConnectionGUID: 1EhZRgEtRZqA8QQroeBuiA==
X-CSE-MsgGUID: gf54MyvRQRSDkifI7Mz1AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74839283"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74839283"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 12:02:34 -0700
X-CSE-ConnectionGUID: r+qX+cIKSd+zOG1mKDXMNQ==
X-CSE-MsgGUID: rqrMMi0WQPux3KNMprNQCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="247147805"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2026 12:02:31 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2wA0-000000003Hh-2Dvy;
	Wed, 18 Mar 2026 19:02:28 +0000
Date: Thu, 19 Mar 2026 03:02:20 +0800
From: kernel test robot <lkp@intel.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH v3 11/17] spi: st: Use helper function
 devm_clk_get_enabled()
Message-ID: <202603190255.yJJehgKm-lkp@intel.com>
References: <96c8fbf6840c71f29ebcf37d7ffc68f297601c8a.1773733017.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c8fbf6840c71f29ebcf37d7ffc68f297601c8a.1773733017.git.xiaopei01@kylinos.cn>

Hi Pei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on next-20260318]
[cannot apply to atorgue-stm32/stm32-next rockchip/for-next xilinx-xlnx/master clk/clk-next shawnguo/for-next soc/for-next linus/master v7.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pei-Xiao/spi-axiado-Use-helper-function-devm_clk_get_enabled/20260318-110300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/96c8fbf6840c71f29ebcf37d7ffc68f297601c8a.1773733017.git.xiaopei01%40kylinos.cn
patch subject: [PATCH v3 11/17] spi: st: Use helper function devm_clk_get_enabled()
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260319/202603190255.yJJehgKm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603190255.yJJehgKm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603190255.yJJehgKm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-st-ssc4.c: In function 'spi_st_remove':
>> drivers/spi/spi-st-ssc4.c:366:24: warning: unused variable 'spi_st' [-Wunused-variable]
     366 |         struct spi_st *spi_st = spi_controller_get_devdata(host);
         |                        ^~~~~~


vim +/spi_st +366 drivers/spi/spi-st-ssc4.c

9e862375c5420a Lee Jones        2014-12-09  362  
2dd42da0b479ff Uwe Kleine-König 2023-03-03  363  static void spi_st_remove(struct platform_device *pdev)
9e862375c5420a Lee Jones        2014-12-09  364  {
e6b7e64cb11966 Yang Yingliang   2023-11-28  365  	struct spi_controller *host = platform_get_drvdata(pdev);
e6b7e64cb11966 Yang Yingliang   2023-11-28 @366  	struct spi_st *spi_st = spi_controller_get_devdata(host);
9e862375c5420a Lee Jones        2014-12-09  367  
cd050abeba2a95 Chuhong Yuan     2019-11-18  368  	pm_runtime_disable(&pdev->dev);
cd050abeba2a95 Chuhong Yuan     2019-11-18  369  
9e862375c5420a Lee Jones        2014-12-09  370  	pinctrl_pm_select_sleep_state(&pdev->dev);
9e862375c5420a Lee Jones        2014-12-09  371  }
9e862375c5420a Lee Jones        2014-12-09  372  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
