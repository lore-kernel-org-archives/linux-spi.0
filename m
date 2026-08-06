Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09143E7BB7;
	Thu,  6 Aug 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047898; cv=none; b=JifwrPAewT9Tx4EztsndIT1/F6r6yoCazH7zjCAwmt/nErvhM6ho0sJP95bgvLPZKqGwK9bJEIYKj3rPFZlhUbCxYIGfVe4k8TLNvlZOVzqOsJi7y3kMWfmz/4ov5ASlEIsS8Gf8Kcu+4zdQX1Qpx9SMyVoExnQTxgQOJMuGAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047898; c=relaxed/simple;
	bh=CP3wHDYVhQB60zwjDHpFdYkgmzJXwfa0mm+U0jmkRRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9m7iGICl0W/S5ZcMG19Z4qnH3ZYRBd3LJxYm5N0ATAwh2FRYxTk8cQIjDeBAER036/IXUQAIgoUZ7mEYtphNq8T7vrffQL77fefDXecwrWUGE8xj7kgozeEfuAtQ4K7fbxGOswDoYDNFFMcT8n7S3iB+qax2TO0/j7WeUUW8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpPf+E3M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpPf+E3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786047897; x=1817583897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CP3wHDYVhQB60zwjDHpFdYkgmzJXwfa0mm+U0jmkRRM=;
  b=DpPf+E3MKsM9LGGYFWufe9VfXkaKhfeDG+9+bEBSUqJ1iVxSW4dTOSJC
   euItjpHOA5G+KZ7pmeYkD5u9ZZ4CgivFK2RqzvDeSHtle9lOlForUiRng
   ZysIP4Sv8asQpqbwnvhqFA5ddAPE5RrUX0GM7AwvvGbB9r70DVVfIIjPV
   GRUkG/ocNxuGYEqRAVnRRwz3juROnG4FXwtB4GH17wHCo9Pqe4VG68MPf
   Za1RmlB571cxX3FEAXeaIwnuZ7zb3kZ9YIa1n1hTseH8x1R7N0IajMc+v
   KKqs5yI1Wrnov+r3AY4U0RmCsaAzCkZs4G9K+M9yv4nxHvdNu4y+aZ3B7
   A==;
X-CSE-ConnectionGUID: L90d4nIKQbighwtU+F/nyQ==
X-CSE-MsgGUID: SacymGCzRDOZHJCEwGQPaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97303695"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97303695"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:24:56 -0700
X-CSE-ConnectionGUID: xOBKRLieTniids7AZV1SsA==
X-CSE-MsgGUID: 5gh4RNyoSUeuiy0J+nFmkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="258875949"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:24:53 -0700
Date: Thu, 6 Aug 2026 23:24:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 6/7] spi: pxa2xx: restore LPSS private register state
 on S3 resume
Message-ID: <anTtk2ilyFLDeGLi@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-7-fourdollars@debian.org>
 <al5-JasTYF5r8A-j@ashevche-desk.local>
 <CAAT15mM_5t9YuEsEKN8UkJh_AoY_PPVkstVujdBM6QJpq7O0=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAT15mM_5t9YuEsEKN8UkJh_AoY_PPVkstVujdBM6QJpq7O0=g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 26, 2026 at 07:48:27PM +0800, Shih-Yuan Lee (FourDollars) wrote:

...

> > Is this series AI-assisted?

> Yes, I used an LLM assistant to help format and polish the commit messages.
> However, all hardware register analysis (such as inspecting BAR0 +
> 0x204 LPSS Private Resets), DSDT ACPI overrides, schematic
> verifications for logic board 820-00244-A, and physical S3
> suspend/resume hardware testing on MacBook8,1 were performed
> empirically on real hardware.

Check the kernel documentation if you need or may use Assisted-by tag.

...

> > This is an ugly hack.
> >
> > Saving context is done in drivers/acpi/x86/lpss.c (see #1 why this file).
> > If something wrong in the flow it has to be fixed there, not here.
> I checked drivers/acpi/x86/lpss.c and its LPSS_SAVE_CTX mechanism.
> However, on MacBook8,1, the LPSS SPI controller is instantiated as a
> PCI device (00:15.4 / 8086:9ce6) bound to spi-pxa2xx-pci.c, rather
> than an ACPI platform device handled by drivers/acpi/x86/lpss.c. As a
> result, acpi_lpss_restore_ctx() is never invoked for this PCI device.
> 
> Physical hardware S3 testing (rtcwake -m mem) confirms that across S3
> suspend, LPSS_PRIV_RESETS (BAR0 + 0x204) is reset to 0x00000000
> (functional block held in reset) by the PCH, causing all post-resume
> SPI transfers to fail  continuously with -110 timeouts (applespi
> spi-APP000D:00: SPI transfer timed out).
> 
> I understand your point about not doing context saving in spi-pxa2xx.c.
> Would moving the LPSS private register context save/restore into
> spi-pxa2xx-pci.c (the PCI glue driver) be an acceptable approach for
> PCI-enumerated devices?

I see. Can we do something similar to what drivers/pci/pci-mid.c does?
And somehow to unify the core part of the context saving, et cetera
between two ACPI and PCI cases?

-- 
With Best Regards,
Andy Shevchenko


