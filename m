Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F53E3D98;
	Wed, 18 Mar 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846376; cv=none; b=KizJHs2VQ+fdl5ZPUfvSQ/f2nI6sccvNg5eHssYYtMA0QQozaHEuoFQnQKFKWxcnbWVJPsMTLvkzeDZsYzeXv2iQVK501IzxKlexF07Blg7trqnH/sjNf4G78BnF6m0mKd6W5XpnBCFWQkYRX1GA2GdXCwvT2YXWAGaFuwkdXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846376; c=relaxed/simple;
	bh=4mKNZGsMnx96h+U53BOOHWYmauvrjAENdqFmFNmU85o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDQlnfQRnno7Xkd1Mn2e5GuRwZcCVTrp4bLqgkQwZWHeeC/Uq5GpMFfi1iP1FhZYpvuJ3ztnZnGN/3VNFIfIGuZRl6Ba8aeOOzwlgh4dFljWgLeZPSP4jNOt9cRQ9FXI9LikyLBs7WcDwQjwkVBDw1JSE9YcRZofAk/8idYFh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LebXoTOk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LebXoTOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773846373; x=1805382373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4mKNZGsMnx96h+U53BOOHWYmauvrjAENdqFmFNmU85o=;
  b=LebXoTOkU3k5eaXxR02elrSmRO8ZalyxL65st5SEKle86Csm8qwf0HEv
   rqJljE96LGu3pwFcwyR7PpbK4/DEJe9MAkljyzVSR/HxCcADdJzn2ziMX
   lKlUMDHE7B2RYZPb/DDrWUQ1VoTLpfZVLfn5g5ml6ncKZgmAHOrbeJvOl
   acNylwC9zBIqsgIuUlS//XYnWkZY8k1CTyI6UKu7Sl4c+02N4ANBNMnoK
   JhDu5PgZ3B55iC+ywEas2IYzaKzFiBUacaYwD7Z8bw1951NB2M66q8Lqq
   Aq+78EKiOkniRziZsj0Oqi97NzPRCRV42aLM12efvtHhpTtiOd+BiTEmk
   w==;
X-CSE-ConnectionGUID: C9FI+263TSGQTAGyFVyQFg==
X-CSE-MsgGUID: 5WZZ4Z6XRbugoe0vpYwbjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74601745"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74601745"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:06:08 -0700
X-CSE-ConnectionGUID: 45FZNnEETzigI3hiwWOn+w==
X-CSE-MsgGUID: 9Lplwp4OTDGMa1328tMtMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227341270"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Mar 2026 08:06:04 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2sTC-0000000031t-0fMK;
	Wed, 18 Mar 2026 15:06:02 +0000
Date: Wed, 18 Mar 2026 23:05:24 +0800
From: kernel test robot <lkp@intel.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH v3 01/17] spi: axiado: Use helper function
 devm_clk_get_enabled()
Message-ID: <202603182309.Rj2JxGYZ-lkp@intel.com>
References: <a78f25f1b15b90121e9723ecb5bd606bbb1868d4.1773733017.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78f25f1b15b90121e9723ecb5bd606bbb1868d4.1773733017.git.xiaopei01@kylinos.cn>

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
patch link:    https://lore.kernel.org/r/a78f25f1b15b90121e9723ecb5bd606bbb1868d4.1773733017.git.xiaopei01%40kylinos.cn
patch subject: [PATCH v3 01/17] spi: axiado: Use helper function devm_clk_get_enabled()
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260318/202603182309.Rj2JxGYZ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260318/202603182309.Rj2JxGYZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603182309.Rj2JxGYZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-axiado.c: In function 'ax_spi_remove':
>> drivers/spi/spi-axiado.c:865:24: warning: unused variable 'xspi' [-Wunused-variable]
     865 |         struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
         |                        ^~~~


vim +/xspi +865 drivers/spi/spi-axiado.c

e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  853  
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  854  /**
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  855   * ax_spi_remove - Remove method for the SPI driver
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  856   * @pdev:	Pointer to the platform_device structure
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  857   *
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  858   * This function is called if a device is physically removed from the system or
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  859   * if the driver module is being unloaded. It frees all resources allocated to
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  860   * the device.
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  861   */
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  862  static void ax_spi_remove(struct platform_device *pdev)
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  863  {
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  864  	struct spi_controller *ctlr = platform_get_drvdata(pdev);
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07 @865  	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  866  
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  867  	spi_unregister_controller(ctlr);
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  868  
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  869  	pm_runtime_set_suspended(&pdev->dev);
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  870  	pm_runtime_disable(&pdev->dev);
e75a6b00ad7962a Vladimir Moravcevic 2026-01-07  871  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
