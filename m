Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1761F2B8D;
	Wed,  5 Aug 2026 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890209; cv=none; b=nP54saSTwiFpMFmuFqE3V0nvpbCb+Ppshd0Yze+no+cdtjA8FYi0PS2o677aj+v4/C74QUE5pvddYBl8lbFEIIRein1G5UtkSDaThRK6cZDhCcKzBD1S0Xa1NRXMTjDVHVLv/E/ZfEpl3Md48tXoP3+iwBSLt6I1Wn46Z/QzBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890209; c=relaxed/simple;
	bh=Wnci9jVVcW+6VJ7mqgWN3hxueduOOx5o7+FaA1eL1MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbEPUlOTKrEGFyjhUIYqCPHhdlm2T1Favp4DIiwtHjXtyJEjANNE1IhCMe65nt/wkbXzMxOxkgr7BL1pRwuTz5Iz6vq7A6M3a34SjHsth8t8mPUhT8oAbSP2HePST4buBgksJdyLG/w+0aoPRzxiqg0y+A6a4EnXGcL0agnl5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUKwzP27; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUKwzP27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785890208; x=1817426208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wnci9jVVcW+6VJ7mqgWN3hxueduOOx5o7+FaA1eL1MI=;
  b=QUKwzP27+5PYmvQvXgYs/4RMEXimqiMYWch1CVRVX63Wd78qsVFMhAre
   pnsaL8PvNFB2/adFd3eS13Mz122LebqxU1fpf4l2vb76zmniyupaw7iB5
   bSEGpT6TTUa/1X98rB9rb2sicNkYFCkGQvUPWlZj0HRxSeCM/Gn4jm6pN
   lRMunVyuQuTUihiZLhyrE/nCzsd1GBRQ9TWiSW9hV1wRdPUTzXneYi4Zf
   B3bEQ2BuEdmpmaeFSn3AkHFXf6n4WFh52sh+Hgtr9cTO9k/YKJuCz+IDR
   ip2QzL2MmyxorySHHgBPvvas0h7eSHKeffuDTCT3ZQ/5wUsR/ZCy/8Pp6
   w==;
X-CSE-ConnectionGUID: F6ePdimDQGSTT33joQuz7Q==
X-CSE-MsgGUID: R92yV0fSRhWA5DkXfBqS1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90265906"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90265906"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 17:36:47 -0700
X-CSE-ConnectionGUID: jt7OGor2RyKB5WZLQmxTpw==
X-CSE-MsgGUID: fJ/RlcYmQuKrrYO021yycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="261717211"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 04 Aug 2026 17:36:45 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrPch-000000004JC-2xXB;
	Wed, 05 Aug 2026 00:36:43 +0000
Date: Wed, 5 Aug 2026 02:35:59 +0200
From: kernel test robot <lkp@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>, Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: Re: [PATCH v4 2/2] spi: pxa2xx: restore LPSS private register state
 on S3 resume
Message-ID: <202608050250.Walny9nd-lkp@intel.com>
References: <20260717163731.6782-3-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717163731.6782-3-fourdollars@debian.org>

Hi Shih-Yuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v7.2-rc6 next-20260804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shih-Yuan-Lee/spi-pxa2xx-disable-DMA-and-fix-runtime-PM-for-Apple-MacBook8-1/20260804-222537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20260717163731.6782-3-fourdollars%40debian.org
patch subject: [PATCH v4 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
config: x86_64-rhel-9.4-bpf (https://download.01.org/0day-ci/archive/20260805/202608050250.Walny9nd-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608050250.Walny9nd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608050250.Walny9nd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_resume':
>> drivers/spi/spi-pxa2xx.c:1554:28: warning: unused variable 'ssp' [-Wunused-variable]
    1554 |         struct ssp_device *ssp = drv_data->ssp;
         |                            ^~~


vim +/ssp +1554 drivers/spi/spi-pxa2xx.c

e0c9905e87ac1b drivers/spi/pxa2xx_spi.c Stephen Street  2006-03-07  1550  
86d2593afeb94e drivers/spi/pxa2xx_spi.c Mike Rapoport   2009-07-21  1551  static int pxa2xx_spi_resume(struct device *dev)
e0c9905e87ac1b drivers/spi/pxa2xx_spi.c Stephen Street  2006-03-07  1552  {
86d2593afeb94e drivers/spi/pxa2xx_spi.c Mike Rapoport   2009-07-21  1553  	struct driver_data *drv_data = dev_get_drvdata(dev);
2f1a74e5a2de04 drivers/spi/pxa2xx_spi.c eric miao       2007-11-21 @1554  	struct ssp_device *ssp = drv_data->ssp;
bffc967e93c771 drivers/spi/spi-pxa2xx.c Jarkko Nikula   2016-09-07  1555  	int status;
e0c9905e87ac1b drivers/spi/pxa2xx_spi.c Stephen Street  2006-03-07  1556  
e0c9905e87ac1b drivers/spi/pxa2xx_spi.c Stephen Street  2006-03-07  1557  	/* Enable the SSP clock */
62bbc864d1946c drivers/spi/spi-pxa2xx.c Tobias Jordan   2018-04-30  1558  	if (!pm_runtime_suspended(dev)) {
74ff7000fd41ae drivers/spi/spi-pxa2xx.c Shih-Yuan Lee   2026-07-18  1559  		status = pxa2xx_spi_clk_enable(drv_data);
62bbc864d1946c drivers/spi/spi-pxa2xx.c Tobias Jordan   2018-04-30  1560  		if (status)
62bbc864d1946c drivers/spi/spi-pxa2xx.c Tobias Jordan   2018-04-30  1561  			return status;
62bbc864d1946c drivers/spi/spi-pxa2xx.c Tobias Jordan   2018-04-30  1562  	}
e0c9905e87ac1b drivers/spi/pxa2xx_spi.c Stephen Street  2006-03-07  1563  
74ff7000fd41ae drivers/spi/spi-pxa2xx.c Shih-Yuan Lee   2026-07-18  1564  	drv_data->suspended = false;
74ff7000fd41ae drivers/spi/spi-pxa2xx.c Shih-Yuan Lee   2026-07-18  1565  
e0c9905e87ac1b drivers/spi/pxa2xx_spi.c Stephen Street  2006-03-07  1566  	/* Start the queue running */
51eea52d26d493 drivers/spi/spi-pxa2xx.c Lubomir Rintel  2019-01-16  1567  	return spi_controller_resume(drv_data->controller);
e0c9905e87ac1b drivers/spi/pxa2xx_spi.c Stephen Street  2006-03-07  1568  }
7d94a505858841 drivers/spi/spi-pxa2xx.c Mika Westerberg 2013-01-22  1569  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
