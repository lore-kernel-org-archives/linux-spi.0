Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023C2DCBFA;
	Thu, 11 Jun 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167912; cv=none; b=ojJ4BTMv9/qzskGXjpNXdXUkVjn371ajSk5aIVML/3y+rWu2KBVHQP9I2O1bGY8H48/iTGrRIckWyu9KjajnzdM+r2/zSZcokXPy4SGFrmpFlsADqkFRYawf2Gt18ZWeNVrHLaTeNoxvXQAikjfBbYi2nnXX5yBkmRZ8Qay4gbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167912; c=relaxed/simple;
	bh=N0EK4IBexhF2iYbsX39cPQwIn6hi364u0TKQp5J8EKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3rjgc/lf7HqaF92YEj4Y58orO75VNq3DisVLi6rNxJtqqKXtMG9TnaEBuOJ105Sdf1Dz+bPW+czlsk2flHZauFdXeezHkspCYrA09kbbRewA6cXp67Dn82eM7Kru89Ez07rCeszziIiXdS9fpHzutvgoTH/D0c1r8iZXHZxPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0PPIVX6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0PPIVX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781167912; x=1812703912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0EK4IBexhF2iYbsX39cPQwIn6hi364u0TKQp5J8EKg=;
  b=h0PPIVX6VjOAJ7qWvkaUP3ZKTi8egOXiQc4oAaEKfjCew82REGwMLjRR
   cyhjTcGhQwaUWDVSOK0l0vRFnZLKmqF4MQN5ZMif3pvi6xraVrXRes2Yq
   8/7S+DT7z8iR5kClYZNidVq+oZRd2JmbSxoI0Mp0pbAOC/vr8Tgw/CkeW
   8ooxZYmMlbQHx7tFYo1Da2EjkAD/q1XT38Hsu8nUl+T21yHQX94THYhj0
   bhUxpPL7dX5+DazKH8eKFFhjvO7G+MLvnQtUfKFfsamCbrr8gEyX8oJxl
   H9/kTI9TtOI3Lt7kPH90mEBMayauFIljxbqLTl9iYBwj2xG1XcmbY4yUa
   A==;
X-CSE-ConnectionGUID: jsRuSR/LQPa9q+OBy2RAqQ==
X-CSE-MsgGUID: VK5dcajoQw6HpNUbsgPaKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81955844"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81955844"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:51:51 -0700
X-CSE-ConnectionGUID: ql0AEbTwRJ2qbikKm4aMJA==
X-CSE-MsgGUID: X2+l879PSpOiPXbqcLMIrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="243976038"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jun 2026 01:51:49 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXb8d-000000003z3-38bv;
	Thu, 11 Jun 2026 08:51:47 +0000
Date: Thu, 11 Jun 2026 10:51:28 +0200
From: kernel test robot <lkp@intel.com>
To: Diogo Pimenta <diogo2003pimenta@gmail.com>, broonie@kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Diogo Pimenta <diogo2003.pimenta@gmail.com>
Subject: Re: [PATCH] Documentation: spi: add SPDX license identifier
Message-ID: <202606111027.TFnhhj2n-lkp@intel.com>
References: <20260611003242.44820-1-diogo2003.pimenta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611003242.44820-1-diogo2003.pimenta@gmail.com>

Hi Diogo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v7.1-rc7 next-20260610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Diogo-Pimenta/Documentation-spi-add-SPDX-license-identifier/20260611-083409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20260611003242.44820-1-diogo2003.pimenta%40gmail.com
patch subject: [PATCH] Documentation: spi: add SPDX license identifier
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260611/202606111027.TFnhhj2n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606111027.TFnhhj2n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Checksumming on output with GSO
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ [docutils]
   MAINTAINERS:40: WARNING: Inline strong start-string without end-string. [docutils]
>> Documentation/spi/spi-summary.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]
   Documentation/userspace-api/landlock:504: ./security/landlock/errata/abi-4.h:5: ERROR: Unexpected section title.


vim +2 Documentation/spi/spi-summary.rst

9cdd273e29f3b9 Documentation/spi/spi-summary.rst Mauro Carvalho Chehab 2019-07-31 @2  ====================================
8ae12a0d85987d Documentation/spi/spi-summary     David Brownell        2006-01-08  3  Overview of Linux kernel SPI support
8ae12a0d85987d Documentation/spi/spi-summary     David Brownell        2006-01-08  4  ====================================
8ae12a0d85987d Documentation/spi/spi-summary     David Brownell        2006-01-08  5  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
