Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932946;
	b=wiYCRVG9hy+3n+sqhxcdDAP8F8w/XMwxMaFSIn2qRTbf54RqkRME9wCreXrRA7eJlSmW
	 EtphLakMjns3Gnh+ef1RHwmz+IeXyfHibXriOw7tJ8c9JJa1aWAm7dw1CmnyMQJnHQJ6i
	 ++f4La4qv7tRMbRzgbW+PN9Hm6Qo4QfCrgWwZrtnphdlpyamqbpCwpE2W1GZc/lGXtZ18
	 CNeqzugX+ztbhFcuBbk7mMNdSSIRhHIFlqBTSWZ/nLsSmD7c5EWQRqGzoeVr5nO+ZyUty
	 ep0brjW+TcaraA+b/f/+RxhtgYBJrleoj/evEipvdQzsSU60QuMoCeGrFr6a0TPnT/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932946;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CF8lS9H/c3zvRH+a3DJEmtDKcArebc2vYl0zflxy/ns=;
	b=tWmN9H9ZMcpFRqENcQGqH6jomfUIxzw025/kJ/AUnO6cEIPiCsU7jhlPXScU+QkZaLEK
	 8VJQyga84fcpskdcufTu/2L2yxANRqjwI9/HPnCTCxKKekMVrgXBHsv/07IhA5Dj+pXUZ
	 y/DcdpcpthRq+S/D31PIR0p4bdBbS/B81cWWrJSRG1tfkJ7XvbpCFI4rnFlqO8E+Cpt0w
	 LkHcM3IRxumkB/NU1OR4bPwmKWlvopZxMlGSrjnz5zEGp6x+S+lGPR2WX1BWaVEshb5kX
	 GyLjgOg6WUIq1CZ5ywmJRA+uvjbKLDJ2gKwFWI4b3bx7hI0GS4mpLTQ5gjrv0O0/lfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OmBQAb/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B936606A31C;
	Tue, 17 Nov 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmBQAb/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80A31F000C8;
	Tue, 17 Nov 2026 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794932945;
	bh=CF8lS9H/c3zvRH+a3DJEmtDKcArebc2vYl0zflxy/ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OmBQAb/DWCQkVAtZlfBCt9BCEJMsIcgunR8wdVWUMBAcc8ijQdJtg7kdarEWoa0Au
	 ELjgSrXFd5VmzMHcRwPT0ZEzwqlDfVz0Dl2DUGMiHvKTOZRYu5GNumGmEen7aKTkvv
	 h5Zc0xVqu7D4VfrUlKXM76tOpmM5BEHIBJ+8pgHmJcTkzrMDjc2Tq20kwN4GdObfxE
	 nwe9DiyVZQufVJDy2Pf79EIMBPM3pkRN3NLK+oy7fDK7Xvqh+Mky3hm3UTBObWqRji
	 dT6nyOB0cvmj1SgeGGwlxvLersy4TDpatNsrJ6JlA8FCs5h0XmY1T5ScSCcQ8vophr
	 +KRw7Xlo/GXuQ==
Date: Wed, 18 Nov 2026 00:08:51 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [broonie-spi:for-7.5 2/6] drivers/spi/spi-cadence-xspi.c:438:43:
 sparse: sparse: unsigned value that used to be signed checked against zero?
Message-ID: <avx8E8akqQw5ByZJ@xhacker>
References: <202611170617.CCFgmq6H-lkp@intel.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202611170617.CCFgmq6H-lkp@intel.com>

On Tue, Nov 17, 2026 at 06:23:56AM +0100, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5
> head:   9b2d7c8736a6fd27ceda93bd67529758c139e24f
> commit: b7d724ff0f4ab6b5d3392938076f5914ecec12fd [2/6] spi: cadence-xspi: Support dmaengine for sdma io copy
> config: m68k-randconfig-r2308-20261117 (https://download.01.org/0day-ci/archive/20261117/202611170617.CCFgmq6H-lkp@intel.com/config)

This is NOMMU.

> compiler: m68k-linux-gcc (GCC) 10.5.0
> sparse: v0.6.5-rc1-21-g84ec0658
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170617.CCFgmq6H-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611170617.CCFgmq6H-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/spi/spi-cadence-xspi.c:438:43: sparse: sparse: unsigned value that used to be signed checked against zero?
>    drivers/spi/spi-cadence-xspi.c:430:59: sparse: signed value source

All virt_addr_valid() users have the same issue, for example, I can
reproduce the same sparse warning with exsiting cadence qspi driver + arm nommu

The correct fix should be fixing the arch nommu code. But I doubt patching
nommu arch code deserves the effort.

> 
> vim +438 drivers/spi/spi-cadence-xspi.c
> 
>    422	
>    423	/* -EAGAIN means no DMA was issued, so the caller can use the CPU path. */
>    424	static int cdns_xspi_dma_transfer(struct cdns_xspi_dev *cdns_xspi,
>    425					  size_t len, bool read)
>    426	{
>    427		struct dma_chan *chan = cdns_xspi->dma_chan;
>    428		dma_addr_t port_addr = cdns_xspi->dma_addr;
>    429		enum dma_data_direction dir = read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>    430		void *buf = read ? cdns_xspi->in_buffer : (void *)cdns_xspi->out_buffer;
>    431		struct dma_async_tx_descriptor *desc;
>    432		struct device *dma_dev;
>    433		dma_addr_t buf_addr;
>    434		dma_cookie_t cookie;
>    435		int ret = -EAGAIN;
>    436	
>    437		if (!chan || len < cdns_xspi->dma_data_width ||
>  > 438		    len > cdns_xspi->sdmasize || !virt_addr_valid(buf))
>    439			return -EAGAIN;
>    440	
>    441		dma_dev = dmaengine_get_dma_device(chan);
>    442		buf_addr = dma_map_single(dma_dev, buf, len, dir);
>    443		if (dma_mapping_error(dma_dev, buf_addr))
>    444			return -EAGAIN;
>    445		if (!is_dma_copy_aligned(chan->device, port_addr, buf_addr, len))
>    446			goto unmap;
>    447	
>    448		desc = dmaengine_prep_dma_memcpy(chan, read ? buf_addr : port_addr,
>    449						 read ? port_addr : buf_addr, len,
>    450						 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>    451		if (!desc)
>    452			goto unmap;
>    453	
>    454		reinit_completion(&cdns_xspi->dma_complete);
>    455		cdns_xspi->dma_error = false;
>    456		desc->callback_result = cdns_xspi_dma_callback;
>    457		desc->callback_param = cdns_xspi;
>    458		cookie = dmaengine_submit(desc);
>    459		if (dma_submit_error(cookie)) {
>    460			dmaengine_terminate_sync(chan);
>    461			goto unmap;
>    462		}
>    463		dma_async_issue_pending(chan);
>    464	
>    465		if (!wait_for_completion_timeout(&cdns_xspi->dma_complete,
>    466						msecs_to_jiffies(CDNS_XSPI_DMA_TIMEOUT_MS))) {
>    467			dmaengine_terminate_sync(chan);
>    468			dev_err(cdns_xspi->dev, "SDMA %s DMA timeout\n", read ? "read" : "write");
>    469			ret = -ETIMEDOUT;
>    470		} else if (cdns_xspi->dma_error) {
>    471			dmaengine_terminate_sync(chan);
>    472			ret = -EIO;
>    473		} else {
>    474			ret = 0;
>    475		}
>    476	
>    477	unmap:
>    478		dma_unmap_single(dma_dev, buf_addr, len, dir);
>    479		return ret;
>    480	}
>    481	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
