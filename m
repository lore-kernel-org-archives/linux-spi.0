Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFA1F1932;
	Sun, 31 May 2026 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780188377; cv=none; b=Cn7a+Aat9er1MhByqAeRFVfBLVNji/yQymMzchUEbOCTFuZuwhNdT6fyW41Q0xBsKIBrasR+W/mLGvwyqrMLwMTy3FyT1266jPELmmDnf4kfjb+OqNEFFI+fr1CzbrsccIgeqMaPUtxBmJdmVuAVm/gQ/YlNvsFVUPl8Ecb9Llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780188377; c=relaxed/simple;
	bh=jpTfjX9mNM8h3K7oR8BVKXhyNjueunIRRNInpWrKVgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Arf8Jz+ArpryuCBdVvP58PsIKJWHsaxThjqqViIb4nGExAiTe5dYGJ2YoIUDNyTcQwXG5G60zsEEQSJ4wwLbdMwGENUjelRdKbvyDA7V68KwHmndQycJxy8rxE35bnqRGOlBzTGjgAmykToGCLPyhfcTWFODuQSYljRWPWQiAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG5xz+QT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG5xz+QT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780188375; x=1811724375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpTfjX9mNM8h3K7oR8BVKXhyNjueunIRRNInpWrKVgc=;
  b=SG5xz+QTBQKTKwKZj5nxENNSY9CYRbTjZ9DGBeBnXHP8cA2iYIlScfgh
   fSrmKWeuqmm/MKHD52VV9zEQQuUlD5fguTa5Xk1tQNv0nBejALjLSlp+s
   cKdoXLD1/jyiLe9gOEjpm8S/Z1MyVzVadvtzZ49FAbzsY1z8I4dNZuIsg
   qZFpDP+/v451wL+GfIZ0rJ5QTQ0sQnZ8UyjU7+EMLJUPd6XouGXSHLwmS
   rpz5NcnBwMfVxEFpUMfQoIdaLQVAgpxT1KHXwZWHgVAmf8CcvZfSjIiKe
   F1sTYCffMSPsTqjpBFtwWnsWSD1VHpUUw0VHNnEF4kgA75OoLebw/bJbA
   A==;
X-CSE-ConnectionGUID: rTXQQrY7Txqz9SLeDDq8Mg==
X-CSE-MsgGUID: NTTPV3jxQ5ihh/p1XcPxhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="103663891"
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="103663891"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 17:46:15 -0700
X-CSE-ConnectionGUID: a0Gzb8LGSMGqaNkQ+/F6Eg==
X-CSE-MsgGUID: q9/Br8YXSLKQR/ImCPK0QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="240193517"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 May 2026 17:46:13 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTUJe-0000000093K-3kW3;
	Sun, 31 May 2026 00:46:10 +0000
Date: Sun, 31 May 2026 08:45:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-xspi: Support 32bit and 64bit slave dma
 interface
Message-ID: <202605310818.A7laSi0h-lkp@intel.com>
References: <20260530123715.25899-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530123715.25899-1-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v7.1-rc5 next-20260529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/spi-cadence-xspi-Support-32bit-and-64bit-slave-dma-interface/20260530-205805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20260530123715.25899-1-jszhang%40kernel.org
patch subject: [PATCH v2] spi: cadence-xspi: Support 32bit and 64bit slave dma interface
config: x86_64-randconfig-005-20260531 (https://download.01.org/0day-ci/archive/20260531/202605310818.A7laSi0h-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605310818.A7laSi0h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605310818.A7laSi0h-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-cadence-xspi.c:601:4: error: call to undeclared function 'ioread64_rep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     601 |                         ioread64_rep(src, buf, len >> 3);
         |                         ^
>> drivers/spi/spi-cadence-xspi.c:623:4: error: call to undeclared function 'iowrite64_rep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     623 |                         iowrite64_rep(dst, buf, len >> 3);
         |                         ^
   2 errors generated.


vim +/ioread64_rep +601 drivers/spi/spi-cadence-xspi.c

   586	
   587	static inline void cdns_xspi_sdma_read(struct cdns_xspi_dev *cdns_xspi, size_t len)
   588	{
   589		void __iomem *src = cdns_xspi->sdmabase;
   590		void *buf = cdns_xspi->in_buffer;
   591		size_t offset = 0;
   592	
   593		if (cdns_xspi->dma_data_width == 4) {
   594			if (IS_ALIGNED((uintptr_t)src, 4) && IS_ALIGNED((uintptr_t)buf, 4)) {
   595				ioread32_rep(src, buf, len >> 2);
   596				offset = len & ~0x3;
   597				len -= offset;
   598			}
   599		} else {
   600			if (IS_ALIGNED((uintptr_t)src, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
 > 601				ioread64_rep(src, buf, len >> 3);
   602				offset = len & ~0x7;
   603				len -= offset;
   604			}
   605		}
   606		ioread8_rep(src, (u8 *)buf + offset, len);
   607	}
   608	
   609	static inline void cdns_xspi_sdma_write(struct cdns_xspi_dev *cdns_xspi, size_t len)
   610	{
   611		void __iomem *dst = cdns_xspi->sdmabase;
   612		const void *buf = cdns_xspi->out_buffer;
   613		size_t offset = 0;
   614	
   615		if (cdns_xspi->dma_data_width == 4) {
   616			if (IS_ALIGNED((uintptr_t)dst, 4) && IS_ALIGNED((uintptr_t)buf, 4)) {
   617				iowrite32_rep(dst, buf, len >> 2);
   618				offset = len & ~0x3;
   619				len -= offset;
   620			}
   621		} else {
   622			if (IS_ALIGNED((uintptr_t)dst, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
 > 623				iowrite64_rep(dst, buf, len >> 3);
   624				offset = len & ~0x7;
   625				len -= offset;
   626			}
   627		}
   628		iowrite8_rep(dst, (const u8 *)buf + offset, len);
   629	}
   630	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
