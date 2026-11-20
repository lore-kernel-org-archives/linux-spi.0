Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133297;
	b=RgUA7DMl4FgNISyctYWTC7BgpGqB7AKaI/zAcAQCQnbozgO0/rgu/PTk/r5DkXTGpFos
	 qz9KQPtdSf95Mithl2rhQH4qwFms+nSVNU8L9gb0l5p0tpdKfiSuTaqayDhYiLggwVhoN
	 LMUqUUfiffqukG6jAZDIXzDTx5zzVr0GyInfPP+JUguW+vJIdaOLj9CBHB6CLqTgY8gmM
	 UWcrFHqQiwQD//iZMqugiS1ssm65CIBqLkHhvSZ+BP2Za98gLXGwSXp7Nzh+VTW0vmwfN
	 +nafQtburl/GA4bibcdN/ipi3Xu+1pf9Hw9ze7rKeMN6GU9cIjKdbEoFgkQGe6SW3EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133297;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=b/g74qMtoOYxc7Pya8FrP+3iZShwKhK74ftkzCJ06eg=;
	b=igDciBVQ9mmSx06a2UHLrFBl5qUIq9qEEe2qNRMMu181+NeB0F3IK2EWrcoLY7NK+UfH
	 +WCL9iko3xydh+4P2yE1MCgHApRstFqW7yjkvcA/GGfsXRvWpP1l1qnO4oObI9Mv6hOXU
	 667Bx0GK1F2bbzLQxQ0G3K/RSFo+RpFz/DkIdeZqfBQsi8QTaL+9cLJVOhRKZ3llnU4g5
	 waV61S9GGNzeXJH/2jwyqj8YYjBeRbdc2+Pje1RCuencstccrGcLlAam9Xy7Tdy5C+gew
	 DGt7Y69hdkOpbVL39uqj7exoKeiTgZq83eichI7WbScD4JQeXEv6dH3IdW0bxM12Cxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="IQ/8rYQR";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EA606A751;
	Fri, 20 Nov 2026 00:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98EA606A751
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IQ/8rYQR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795133296; x=1826669296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=czbi8KQUhlERCyVBpADFpCmrXg1np/Fs2dXzoXuG06A=;
  b=IQ/8rYQRCt+cGVGoFVzvEYdbapPbS6SkHSUlI/kY+uGuN0VB6QuStKVh
   TXc7hVQ6HWgx8mfHlTbmTRaLYJExgD5Lh0VZW7qZrrUXasCuwjZtLkIFf
   N5P7Kl0k9hQwlm/9cFRcRk2R3Z02u9kWpATEY9HiQSOUkmygVkNjQJkml
   V9CgiqGxerL5q432NhFGWPB48umavoJBvLi8/1BgCTzOuvVGHK5NIGMgJ
   rIO3XQy+TL+z72xT+kD7zNpYQNnitouNjI90SHoKSPKntFu+tafR77phS
   skzX+RF3mD+ZqmUPMP6OJQwZAUpy72vX6gE0pf1gu7m5AiWOpDC4AGdi1
   w==;
X-CSE-ConnectionGUID: WTgguF0SQpq1GCmIFS4pxg==
X-CSE-MsgGUID: /fhnXSU9Reimhd8piQjguQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3926050"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3926050"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:08:15 -0800
X-CSE-ConnectionGUID: gNqMkl/1QvKWbPdljZxgxg==
X-CSE-MsgGUID: m+5KbGrpQUqaa5mm7GaWsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10456052"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Nov 2026 16:08:12 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUCAk-00000001Gpz-0KDx;
	Fri, 20 Nov 2026 00:08:10 +0000
Date: Fri, 20 Nov 2026 08:07:07 +0800
From: kernel test robot <lkp@intel.com>
To: Prakriti Sharma <Prakriti.Sharma@synopsys.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
	Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: Re: [PATCH 3/6] spi: dw-g2: Add indirect read and write
Message-ID: <202611200702.anv4vey4-lkp@intel.com>
References: <20261119100513.433044-4-prakriti@synopsys.com>
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
In-Reply-To: <20261119100513.433044-4-prakriti@synopsys.com>

Hi Prakriti,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next linus/master v7.4-rc3 next-20261116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prakriti-Sharma/dt-bindings-spi-Add-Synopsys-DWC-SSI-v2-02a-binding/20261119-153508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20261119100513.433044-4-prakriti%40synopsys.com
patch subject: [PATCH 3/6] spi: dw-g2: Add indirect read and write
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20261120/202611200702.anv4vey4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261120/202611200702.anv4vey4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611200702.anv4vey4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-dw-g2-core.c: In function 'dw_spi_g2_build_ctrlr0':
   drivers/spi/spi-dw-g2-core.c:226:13: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     226 |             FIELD_PREP(DW_SPI_G2_CTRLR0_DFS_MASK, DW_SPI_G2_DFS_ENCODE(dfs));
         |             ^~~~~~~~~~
   drivers/spi/spi-dw-g2-core.c: In function 'dw_spi_g2_indirect_read':
>> drivers/spi/spi-dw-g2-core.c:624:13: warning: variable 'tx_entries' set but not used [-Wunused-but-set-variable=]
     624 |         u32 tx_entries;
         |             ^~~~~~~~~~


vim +/tx_entries +624 drivers/spi/spi-dw-g2-core.c

   612	
   613	/**
   614	 * dw_spi_g2_indirect_read - Execute indirect read operation
   615	 * @dws: Driver state
   616	 * @op: SPI memory operation
   617	 *
   618	 * Reads data from flash using RO (receive-only) mode.
   619	 * Return: 0 on success, negative error code on failure
   620	 */
   621	static int dw_spi_g2_indirect_read(struct dw_spi_g2 *dws,
   622					   const struct spi_mem_op *op)
   623	{
 > 624		u32 tx_entries;
   625		u8 dummy_buf = 0;
   626		int ret;
   627	
   628		if (!op->data.nbytes) {
   629			dev_err(dws->dev, "Zero-length read not allowed\n");
   630			return -EINVAL;
   631		}
   632	
   633		if (!op->data.buf.in) {
   634			dev_err(dws->dev, "RX buffer is NULL\n");
   635			return -EINVAL;
   636		}
   637	
   638		ret = dw_spi_g2_indirect_read_setup(dws, op);
   639		if (ret)
   640			return ret;
   641	
   642		dw_spi_g2_target_enable(dws, dws->cs);
   643		dw_spi_g2_enable(dws, true);
   644	
   645		tx_entries = 0;
   646	
   647		/* Write instruction */
   648		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, op->cmd.opcode);
   649		tx_entries++;
   650	
   651		/* Write address as a packed 32-bit value (one FIFO entry) */
   652		if (op->addr.nbytes) {
   653			dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, (u32)op->addr.val);
   654			tx_entries++;
   655		}
   656	
   657		/* Assert CS - controller begins: sends TX FIFO, then receives */
   658		dw_spi_g2_cs_assert(dws, dws->cs);
   659	
   660		/* Receive data via polling */
   661		ret = dw_spi_g2_xfer_fifo(dws, &dummy_buf, 0,
   662					  op->data.buf.in, op->data.nbytes);
   663		dw_spi_g2_transfer_end(dws);
   664		dw_spi_g2_controller_reset(dws);
   665	
   666		return ret;
   667	}
   668	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
