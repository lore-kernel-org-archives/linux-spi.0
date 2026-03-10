Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72763E5EF6;
	Tue, 10 Mar 2026 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175465; cv=none; b=ql9Rm12eX04eZBNZRqwWIyIgf9WXEgAOrnb3i0HIWYr+cLdk1uxs2mF4VJJSsBLZvkZtd6sWInfIedTxllQGNam3kpNFpmm9XBeGb/GYGelY33ypqvDJ92FyL3qS4Ed8xhjcCo2KmXWvKmL7f6s5EcYMAZ0aYicGia1nqOpC1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175465; c=relaxed/simple;
	bh=6qMrLtx1HkCxpdBNJCz60aOmbbnnraZYUi4qvVGQTWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8mtGkueaD5/o1wn/x9dEW2KZZ+8iMoirfay68M8pk7ch6gADU60A7po9UhXazYmFjFyp8/0hxzxwo+bF3W5qoq5EVKv3t6ZpI94WO8cQxr05JeWXVDZVrYmhsmedyjySWAuSB/Xr610TU+FT1Kh2TRPNp1ZEayLL25C2fXOZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCEemFlO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCEemFlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773175464; x=1804711464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qMrLtx1HkCxpdBNJCz60aOmbbnnraZYUi4qvVGQTWw=;
  b=hCEemFlOnSde/Mu6YUhSP6TWTnlnWeazAVH102cWn+KHDvHo0t21/1J6
   0O1vF/S92gO765hSkOClstlThRViReJsayCW5vzB6DcKcCSlI3yIwRZ43
   WyJtfZOACoIXK6oa1uv2ARa/2XC7Gn+UYqQEWcQdbae+ecemZVY4t+KE2
   6gfdw10X7C4tDlNaYmNB5G+Xum1yl76QBBdxdD5EXYyNMoDrDXosAwFBo
   TRTYAZpxXpZ6XO3OBd7FuUqZEo0rRQrTINYNZnKzuiqFXksUSwpNo1ZPe
   4RmB5YhfvU30cL+iWzvg04GDQFA1jpY9kGpVHQftEY1wleF3an5dOT5fX
   w==;
X-CSE-ConnectionGUID: gxlUZ0ibT9ivpMcERrBHWw==
X-CSE-MsgGUID: wBWO8nCfQyifW6Jez/2hAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78092627"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="78092627"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:44:23 -0700
X-CSE-ConnectionGUID: jSBQVH6jQSmmOZidMf3YVg==
X-CSE-MsgGUID: IJHzyH/GSNu3AwFkeRl8FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="217753107"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2026 13:44:21 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w03wA-000000000H8-2xtx;
	Tue, 10 Mar 2026 20:44:18 +0000
Date: Wed, 11 Mar 2026 04:43:46 +0800
From: kernel test robot <lkp@intel.com>
To: Pei Xiao <xiaopei01@kylinos.cn>, cl634@andestech.com,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] spi: atcspi200: Use helper function
 devm_clk_get_enabled()
Message-ID: <202603110449.mxLAYdGU-lkp@intel.com>
References: <9f6e31608a24f3cdbd6e1429c1e006ccf9f7d9c1.1773132237.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6e31608a24f3cdbd6e1429c1e006ccf9f7d9c1.1773132237.git.xiaopei01@kylinos.cn>

Hi Pei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v7.0-rc3 next-20260309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pei-Xiao/spi-atcspi200-Use-helper-function-devm_clk_get_enabled/20260310-165916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/9f6e31608a24f3cdbd6e1429c1e006ccf9f7d9c1.1773132237.git.xiaopei01%40kylinos.cn
patch subject: [PATCH] spi: atcspi200: Use helper function devm_clk_get_enabled()
config: riscv-randconfig-001-20260310 (https://download.01.org/0day-ci/archive/20260311/202603110449.mxLAYdGU-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603110449.mxLAYdGU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603110449.mxLAYdGU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-atcspi200.c:510:6: warning: unused variable 'ret' [-Wunused-variable]
     510 |         int ret;
         |             ^~~
   1 warning generated.


vim +/ret +510 drivers/spi/spi-atcspi200.c

34e3815ea459713 CL Wang  2025-12-15  507  
34e3815ea459713 CL Wang  2025-12-15  508  static int atcspi_enable_clk(struct atcspi_dev *spi)
34e3815ea459713 CL Wang  2025-12-15  509  {
34e3815ea459713 CL Wang  2025-12-15 @510  	int ret;
34e3815ea459713 CL Wang  2025-12-15  511  
7dd262df6a0fc29 Pei Xiao 2026-03-10  512  	spi->clk = devm_clk_get_enabled(spi->dev, NULL);
7dd262df6a0fc29 Pei Xiao 2026-03-10  513  	if (IS_ERR(spi->clk))
7dd262df6a0fc29 Pei Xiao 2026-03-10  514  		return dev_err_probe(spi->dev, PTR_ERR(spi->clk),
7dd262df6a0fc29 Pei Xiao 2026-03-10  515  				     "Failed to get SPI clock\n");
34e3815ea459713 CL Wang  2025-12-15  516  	spi->clk_rate = clk_get_rate(spi->clk);
34e3815ea459713 CL Wang  2025-12-15  517  	if (!spi->clk_rate)
34e3815ea459713 CL Wang  2025-12-15  518  		return dev_err_probe(spi->dev, -EINVAL,
34e3815ea459713 CL Wang  2025-12-15  519  				     "Failed to get SPI clock rate\n");
34e3815ea459713 CL Wang  2025-12-15  520  
34e3815ea459713 CL Wang  2025-12-15  521  	return 0;
34e3815ea459713 CL Wang  2025-12-15  522  }
34e3815ea459713 CL Wang  2025-12-15  523  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
