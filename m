Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484975;
	b=dau3ICzSLdxmwqOyc9StJ8TxIal/AeI87Knnumw4Y6K8UT7xIgRFKXTKsL3gbtUttVjp
	 2fDZSozxk+uqk+FZ0VY8C+plvre9dNR9FwImjCoHXyn4WFTmNq7xxTEhV+6dVkJQwufie
	 yl6UBiXnaFO4ihPGyngQtSkgJpIjGH/a+FnPuR5MqKqlqlvPez+15xZOqgN7QJxb2TB4V
	 dW7W5n0AoB0cpfzNY7z2zPFcrHUDVgd/LIKJd8NqZ4vjnHmELH8uxojTL7/ift6bkyPK3
	 33qXOoXy671ihoj38ijntyF9h8VrL2DVcj+By2NnlYVofGUz03535NQu79DCK5QgTjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484975;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ll+ifZsj7f0p421Y+dZ6l5aN1p+c086yHqt0vsBJ3Nk=;
	b=oeY5+JWzqCKImpuUO9VlhoiFzCAATop9nxpuSbQ5hIXziT+adSTVbIbP7/q+5AOYNZSw
	 7keFzT4g6q2SvniXFfRKfsYnsa4R4Fhtve5xBvBJQnUHbL7yy135bFFCQpl+jypCfqqbi
	 nkI3/CIMnLrv6V8YMZWzjtOtY+up6fmLnKyQEKvtLoHTYK6Jc/nkOeCYY5+bVY6s5fXGX
	 LS1VNDukey2HK8lTbA0wTYQQATcV5moF29vnC+Ke6FXl8U+wH6CmOvAkcIfBIiPjThfaf
	 Ig46kRUvVcsmU1hCNle1u4PMLC/DkIgOG4VNX7+RIo1GT+i80yjP5yZhoQzXbtA84ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E1DfSO9F;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C426606A339;
	Thu, 12 Nov 2026 12:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C426606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E1DfSO9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794484976; x=1826020976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=maRw+kmF3iMpLkKwwCjUqPLxEt+usu6mxGfGFV05qOk=;
  b=E1DfSO9FWFkfesLlIW7jruxTxPKPnxcPbXFUB7gS7JP+4lzIP+b52TH6
   ZBo2/2jS+IFpHKit2Tzwkq92at36CA/iYwvJIiACRPg0OurTMCBYDkEJ0
   UCvfnP/NHCZowkJVJu5zLySB9cRPeYsg+5AO+p2KPygGJChgpymcRr0yN
   eTU0TspVtkMDNbyK6Tk2KvZdy0CiOxjGUdqOvuK36U1EdnrT7RSbAyNSK
   yBEltULeXeq83eatdpnE5wpvX6TOU+QJk5ndtBLJRxDNdyQixtDVIMIfD
   nMr7C67tRwa1xrZhJ/9A6RvhQN9/uQXVui4JG9+I61C/Im7H627/gfJns
   Q==;
X-CSE-ConnectionGUID: sTQS4xpbRMOJJzdpkwkaMA==
X-CSE-MsgGUID: MxxYlEYhTWiWvBlert3YJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3177724"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3177724"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 04:02:55 -0800
X-CSE-ConnectionGUID: W83PTiHRSkCMjADCXyLB1Q==
X-CSE-MsgGUID: SNDVA9AWQ8GhoMJkGnzIug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8537390"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Nov 2026 04:02:51 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRTVx-000000011Fj-0fhu;
	Thu, 12 Nov 2026 12:02:49 +0000
Date: Thu, 12 Nov 2026 20:02:04 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Cercueil <paul.cercueil@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: Re: [PATCH v2 6/6] spi: cadence-xspi: Add workaround for old Marvell
 firmwares
Message-ID: <202611121914.Tdw8zp6W-lkp@intel.com>
References: <20261111103541.100848-7-paul.cercueil@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111103541.100848-7-paul.cercueil@bootlin.com>

Hi Paul,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v7.4-rc2 next-20261110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/spi-cadence-xspi-Properly-handle-errors-in-transfer_one_message/20261111-113536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20261111103541.100848-7-paul.cercueil%40bootlin.com
patch subject: [PATCH v2 6/6] spi: cadence-xspi: Add workaround for old Marvell firmwares
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20261112/202611121914.Tdw8zp6W-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611121914.Tdw8zp6W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611121914.Tdw8zp6W-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-cadence-xspi.c:1234:58: error: array has incomplete element type 'const struct acpi_platform_list'
    1234 | static const struct acpi_platform_list mrvl_platform_list[] = {
         |                                                          ^
   drivers/spi/spi-cadence-xspi.c:1234:21: note: forward declaration of 'struct acpi_platform_list'
    1234 | static const struct acpi_platform_list mrvl_platform_list[] = {
         |                     ^
>> drivers/spi/spi-cadence-xspi.c:1239:11: error: use of undeclared identifier 'all_versions'
    1239 |                 .pred = all_versions,
         |                         ^
>> drivers/spi/spi-cadence-xspi.c:1249:10: error: call to undeclared function 'acpi_match_platform_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1249 |                 return acpi_match_platform_list(mrvl_platform_list) >= 0;
         |                        ^
   3 errors generated.


vim +1234 drivers/spi/spi-cadence-xspi.c

  1233	
> 1234	static const struct acpi_platform_list mrvl_platform_list[] = {
  1235		{
  1236			.oem_id = "MRVL  ",
  1237			.oem_table_id = "CN10K",
  1238			.table = ACPI_SIG_DSDT,
> 1239			.pred = all_versions,
  1240		},
  1241		{ }
  1242	};
  1243	
  1244	static inline bool cdns_is_marvell(struct device *dev)
  1245	{
  1246		const char *compatible;
  1247	
  1248		if (has_acpi_companion(dev))
> 1249			return acpi_match_platform_list(mrvl_platform_list) >= 0;
  1250	
  1251		if (of_machine_read_compatible(&compatible, 0) < 0)
  1252			return false; /* shouldn't actually happen */
  1253	
  1254		return strstarts(compatible, "marvell,");
  1255	}
  1256	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
