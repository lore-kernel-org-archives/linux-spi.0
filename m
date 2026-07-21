Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A72D8376;
	Tue, 21 Jul 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666523; cv=none; b=OxnFHaMZEB26VT0sMMnSMayPU8v4vDzwUiI4pZp4MUPovw2jHkvx4GKo0KpCaFFhwXGwY8CyMUA4EmIxNNICBurw9p1EQf+TZdY277vthfqbPxQg/a36LGzd6nyPflSGTbglC9pVj2H/dNer3KwyCmy1uesL3XvXQzRFcQUxb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666523; c=relaxed/simple;
	bh=skSQxPyPM6bJlDc9hM3ypyDg9GlQqaAJt8Rd7J/fRrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2KDPFSwdSMuWkGdI0NuS0Jst5npEUVd02gG4+qjwTovTkUSxQHrA0sbzK5g8pPtxwuS23s/wlwGVx+cM1ZP4TfdwpTLNPInrNoG7Ri4RZkcnG3wvw98UDDNwoPrw6tFoWyL98Y6y7487jmrh9H62YdPA/J5sQPRmgdz/GI1g+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRz05PKB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRz05PKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784666523; x=1816202523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=skSQxPyPM6bJlDc9hM3ypyDg9GlQqaAJt8Rd7J/fRrM=;
  b=eRz05PKB/XNHGSd99DqTtx6aAwOrk3QfOwVda4mRl2G0x1iXI3BCGO77
   /4POFwf9o9JNFul5uKilP8fIjw+LXeLxIHdOAnRVPuBqSRLHDgDuYdMEk
   vHHyFb6T+8O7I0Hzb4ZRo9VNHL80yAcM7x4ibv0wtyyRru8qYwZkj232M
   X1iJd4SkT8i9GH8/v5pHOkCXEBmp4H8WkFa1uH7vthacXbBgd6si9CUxW
   EScSXSiC5iwLanI1HWqx6yRi9K/cTHcU2QNf1PznVHQASVpp27GJMnXlh
   dcMVH/yRFCTsNsusDjj+ouYQYNwc44zT/WeyqLEkrFZyhHk1BqxEYtNam
   Q==;
X-CSE-ConnectionGUID: pisXMLLyRKexLStIiRwSew==
X-CSE-MsgGUID: x4vMJg56Q26Z9seBtxMPbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96798226"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96798226"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:42:03 -0700
X-CSE-ConnectionGUID: xcyV9Z45RoqNUi+xXhBnVw==
X-CSE-MsgGUID: O43iy8aXT3eVMe6FOM7Brg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="258537927"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:41:59 -0700
Date: Tue, 21 Jul 2026 23:41:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Mark Brown <broonie@debian.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <al_ZlTkEUHj-X1YS@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
 <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
 <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
 <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 22, 2026 at 12:09:44AM +0800, Shih-Yuan Lee (FourDollars) wrote:
> On Tue, Jul 21, 2026 at 11:26 PM Shih-Yuan Lee (FourDollars)
> <fourdollars@debian.org> wrote:

> I just tested the Initrd ACPI Table Override on the machine. Here is
> what I found.
> 
> I patched the _PRT table in the DSDT to remap device 00:15.0 (Pin 0
> and Pin 1) from GSI 20 to GSI 21 to match the SPI controller's
> interrupt line, 

I'm lost here. Why SPI controller and DMA controller has to share an interrupt
line?

> umped the OEM Revision from 0x00080001 to 0x00080002
> so the kernel would accept the override, and prepended it to the
> initramfs.
> 
> The override was successfully applied:
> 
>   ACPI: Table Upgrade: override [DSDT-APPLE - MacBook]
>   ACPI: DSDT ... 007EB5 (v03 APPLE  MacBook  00080002 INTL 20251212)
> 
> After rebooting, the DMA controller loaded without errors and both
> dw:dmac168 and the SPI controller 0000:00:15.4 now correctly share IRQ
> 21:
> 
>   21: 0  0  0  0  IR-IO-APIC  21-fasteoi  dw:dmac168, 0000:00:15.4
> 
> However, SPI transfers still timed out with -ETIMEDOUT (-110) and the
> IRQ 21 counter remained at zero — no interrupts were actually received
> from the DMA hardware, despite the corrected ACPI routing.
> 
> This confirms the root cause is not a software IRQ routing issue but
> rather that the DMA controller's interrupt line is physically
> non-functional on this motherboard. macOS also does not use DMA for
> this device, which is consistent with that conclusion.
> 
> It is also worth noting that Apple may have intentionally mapped the
> DMA controller to GSI 20 — an otherwise unused interrupt — precisely
> because the interrupt line is not physically connected.

It's impossible. The interrupt line from DMA controller is an IOAPIC RTE that
is programmed by BIOS, there is no "physical wire" in traditional meaning.
In any case this link is done on the SoC level. Apple can't burn that out
of the die. They even can't fuse out that (of my knowledge LPSS is always
present IP, the fuse works against the full controller, not parts like
disabling interrupt message or "line").

> On macOS and
> Windows, no DMA driver is ever loaded for this device, so the bogus
> GSI 20 entry is harmless. It effectively acts as a silent signal to
> the OS that interrupt-driven DMA should not be used on this platform.

Maybe because they didn't get how it's supposed to work.

> Since the DMA interrupt line is physically unconnected, no completion
> interrupt ever fires, causing all SPI transfers to time out with
> -ETIMEDOUT (-110) and ultimately deadlocking the applespi driver.

No, this analysis is wrong. There are up to 3 interrupts that may participate
in the design: DMA controller; SPI controller; and SPI peripheral. The first
two usually use IOAPIC RTEs for the interrupts (and hence represented as
Interrupt() resources in _CRS methods on DSDT, plus CSRT for DMA), and the
last one often is GpioInt() and has nothing to do with DMA at all.

> Therefore, forcing PIO mode via a DMI quirk in spi-pxa2xx-pci remains
> the only viable out-of-the-box solution for this platform.

-- 
With Best Regards,
Andy Shevchenko


