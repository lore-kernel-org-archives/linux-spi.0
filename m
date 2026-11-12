Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454458;
	b=nMlIp/WJu0ahuCFt1G5VFdFJFueJ5CMUSMXNZtq7CkXP6IcmdFRqx5JoQm6KQcukGq+i
	 RY8uKg1ieQxTBdaVtDtew3SMlgRbr1EMbse/W4zs0ZooxTdloP7Mh9wnojdd8A67YiHtT
	 R9m5CbzsA0xjSzGB9BRK0j7SW0ZIrbVpv/d++bZjAeuske7h+Y/QKlbXjRCGhHA6/diaE
	 sjDTTr3KdKUr5O80vBqu9JvLxH+n+cUVTXgz9ijEixDPTm2Heirlufr2F2k8ZkGouza7e
	 gUYYZPFNUHHuifykoJbanOxfWxqfwCIYPlWgu6z3UnL7b52gxWXrJQjzP1A6Uz0bJGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qltfbcsF9HQ3GEp10diTEWN3lrzzyngznvD5CvyLmTs=;
	b=1XIsxlKiBddfrvuEiL8F1pnKSlfPMc8YUM0pQG5tRfUp0njk3ci9Kzq3l12QkffVyefV
	 Tz1O2lusxnv0hNA4mIYKSSTLTvDBUHHYrHUq3qZcsqWPW0O9clunClMr5JHHoiMl48/13
	 /lK2rOh5Dkw3Ev3NtachqPbg5+LDXm77ucQdlJNfUuQT+8PtIC1VuMjDx6/EFMy6IuCIo
	 0+BelrovxH3u3tFBPDM9fdCVKxH7Z1YjEISdt45K5GvYHz7gPvweZpDsvxW6cksvsx6ko
	 J5oX5nC7R8qBJ20AWFv0g9aYUm0QectfdbpYO5Rt8F7RKfS84GwE+w0CtfsmEfLncvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="l6I/TPzl";
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D6606A339;
	Thu, 12 Nov 2026 03:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE5D6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l6I/TPzl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794454456; x=1825990456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0y9Vr7K76YEZcGrtRuHpPo2vPqWm4P/EyLiLucbYm8=;
  b=l6I/TPzl7CelkxVyFBqsm7BdvECgDLwEr8kiTkwCyIWzCkSZJmxEdk0w
   LAsnx2dzlnk8MlDZpwWla4VyPDF3FmW7ZKzxLfGBHyliGwEBNjgivG/89
   eKK+DjSPYg99l7GMsNtZKOWn0pHda7f1IhYUtQ1lFuqil2KdWyuK4XCHu
   QGE92hLW4cykSPUVU2/5IBCOtHRUDtOPud0yiQMZm6zqgNhVk3eb0tW0W
   kquUREZurnexj7JymUX73sIEpRL8cpyh0xnObZuplII8HepKlN/Cemhvq
   Qyy9zvDMOs6yabXzWKJDKi4+WO+aUD+e7Yn3ZL78UeQmc8a+Gi++Lxg1W
   g==;
X-CSE-ConnectionGUID: Eave71STREiUmRPr8f0Ibw==
X-CSE-MsgGUID: g2LOUWhlToKMAXezcb6ebg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3112996"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3112996"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 19:34:15 -0800
X-CSE-ConnectionGUID: vcv+fLE/TI2epReFetZjRg==
X-CSE-MsgGUID: Xx7CmS43SUCw/t8jjn4/Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8864236"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2026 18:53:29 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRKwF-000000010JL-0IWR;
	Thu, 12 Nov 2026 02:53:23 +0000
Date: Thu, 12 Nov 2026 10:53:13 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Cercueil <paul.cercueil@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: Re: [PATCH v2 6/6] spi: cadence-xspi: Add workaround for old Marvell
 firmwares
Message-ID: <202611121026.JlDpURlH-lkp@intel.com>
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20261112/202611121026.JlDpURlH-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611121026.JlDpURlH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611121026.JlDpURlH-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/spi/spi-cadence-xspi.c:1234:40: error: array type has incomplete element type 'struct acpi_platform_list'
    1234 | static const struct acpi_platform_list mrvl_platform_list[] = {
         |                                        ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-cadence-xspi.c:1239:25: error: 'all_versions' undeclared here (not in a function)
    1239 |                 .pred = all_versions,
         |                         ^~~~~~~~~~~~
   drivers/spi/spi-cadence-xspi.c: In function 'cdns_is_marvell':
>> drivers/spi/spi-cadence-xspi.c:1249:24: error: implicit declaration of function 'acpi_match_platform_list' [-Werror=implicit-function-declaration]
    1249 |                 return acpi_match_platform_list(mrvl_platform_list) >= 0;
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
   At top level:
>> drivers/spi/spi-cadence-xspi.c:1234:40: warning: 'mrvl_platform_list' defined but not used [-Wunused-variable]
    1234 | static const struct acpi_platform_list mrvl_platform_list[] = {
         |                                        ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
