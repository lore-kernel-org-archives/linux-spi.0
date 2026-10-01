Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A8352020;
	Thu,  1 Oct 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839245; cv=none; b=iy4h2AK41w1yCujjhq6BlkSY44LHvVxDreiNCaOjB5Vu8j7xaJsh2aWMRDDyTNG7Pfw3S/155PG8/sQiYRiBUBT04fPbiV5tISOS8pU3WmEtTzMnN+1yVifyU4NsWi+FUkm4TAFs5FBCjjgDR/Nj8O2Ckc1jqfDlzAniME9/kwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839245; c=relaxed/simple;
	bh=U5oEqkdeg9YvpX/JVhCgWCo74NzUlC5YA5Ynfjw7rP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt3hSlGLq2D5ETB/Znum3pQO7drSWYZjphO7dQOVN+BiVIqtt/JIf4M1QrRt9RR2Bt1lB16I1t5GsW95FkNUNGSyIGLlVWCfbSwFwqdN6supN/mnpbj9XrkU/YyIF+MnVgbGIbwJDaGX+lKrnRlshhfc77lkMDVhoWpaVdh7tDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxzGljNc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxzGljNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790839238; x=1822375238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5oEqkdeg9YvpX/JVhCgWCo74NzUlC5YA5Ynfjw7rP4=;
  b=fxzGljNcaoC3/Y2wrkSRSOldQ/La2Kxez1zD04gHRxq+O7DHaJaToV01
   g8qtiWToB8tSzqpORcHV2JsilyJR9+M4IH0ChxQ05IFoOWO3SockQW0n4
   rnT+7aGJ7jvGEuwxqoaLkqs499DPJp4RQFpzVMOyzTR6acaFXKcsFEB4i
   Vbz64RZYdgVEF8l1PF9gpeL93V/s2ZGj7I+Nnt/D/xbTZpzX9v7jUwWLV
   J7xPfjuKTgfbZCmA1Y3KQPiZFgXNSiBhy6Maj1OXP7YLl0+NYM40iMM7H
   lGMSU+2VRdIdu5c0eKb2lrL2J6rauVji43pDx3ETiY7saj5iWDZGTq/WE
   A==;
X-CSE-ConnectionGUID: GZ9nzamXS9GtJFOGiK6GgQ==
X-CSE-MsgGUID: zCeKZmbASO+iWV8FpnqjTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="95396581"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="95396581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 00:20:32 -0700
X-CSE-ConnectionGUID: R8cZksT4SGyr7eFGfnLaAQ==
X-CSE-MsgGUID: bpltgbzmR/6D/vwvT0LK8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="302171307"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 00:20:30 -0700
Date: Thu, 1 Oct 2026 10:20:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v17 5/6] spi: pxa2xx-pci: restore LPSS private register
 state across S3 resume
Message-ID: <ar4Ju6oGkWGCOlct@ashevche-desk.local>
References: <20260930160629.1822-1-fourdollars@debian.org>
 <20260930160629.1822-6-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930160629.1822-6-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 12:06:28AM +0800, Shih-Yuan Lee wrote:
> On platforms where Intel LPSS SPI is enumerated as a bare PCI device
> (such as the Apple MacBook8,1 on Lynxpoint-LP), the LPSS power island
> loses power during system sleep and powers up with the controller held
> in reset. Because the device lacks ACPI companion objects or MFD
> binding, neither drivers/acpi/x86/lpss.c nor drivers/mfd/intel-lpss.c
> restore the private register context across S3 resume.
> 
> This causes memory-mapped I/O reads on resume to return ~0, resulting
> in PCIe Completion Timeouts, missing interrupts, and dead
> keyboard/touchpad.
> 
> Restore LPSS private registers and deassert functional, APB, and iDMA
> resets in the PCI glue layer:
> 1. In suspend, quiesce the controller queue via spi_controller_suspend()
>    so no transfers remain in flight and chip select is deasserted.
>    Then save the LPSS private registers (LPSS_PRIV_REG_COUNT 9 covering
>    up to offset 0x20 including reg_cs_ctrl at 0x18). Ensure the clock is
>    active for reading MMIO registers using pm_runtime_resume_and_get(),
>    balanced by pm_runtime_put_noidle(), before calling
>    pm_runtime_force_suspend().
> 2. In resume, restore LPSS private registers and deassert functional,
>    APB, and iDMA resets via pxa2xx_spi_pci_lpss_restore_ctx() before
>    calling pm_runtime_force_resume(). Because the controller clock
>    remains gated (clk_enabled is false) during this restoration, any
>    interrupt arriving on a shared line bails out early in ssp_int()
>    without accessing registers on a controller held in reset. Once
>    resets are deasserted and private registers are restored, call
>    pm_runtime_force_resume() to enable the clock and mark the device
>    active, and restart the queue with spi_controller_resume().
> 3. In probe, call pci_d3cold_disable() for Lynxpoint-LP (is_lpt) to
>    ensure the PCI device cannot enter D3cold during runtime PM,
>    guaranteeing that LPSS private registers are retained during S0 idle
>    periods and only require restoration across S3 system sleep. Set
>    DPM_FLAG_NO_DIRECT_COMPLETE to prevent PCI subsystem direct-complete
>    bypassing system sleep callbacks.
> 4. Scope LPSS context restoration specifically to Lynxpoint-LP
>    (PCI_DEVICE_ID_INTEL_LPT*) devices to avoid perturbing other LPSS
>    PCI platforms (BYT, BSW) or non-LPSS platforms.
> 
> Export lpss_ssp_setup() and core runtime PM ops so the PCI glue layer
> can invoke them around private register restoration.

No, as I told earlier please find a way how to not add a code duplication.

> Assisted-by: Antigravity:gemini-3.8-flash sparse

Assisted-by: LLM

-- 
With Best Regards,
Andy Shevchenko


