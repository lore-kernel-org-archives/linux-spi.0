Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDC32B9B9;
	Wed, 21 Jan 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984831; cv=none; b=q8myEVX0DCf40TUDh6yh2JhsAafzzngUEoFEhmsfnSvJGozh8n6IrvR4VQ6PQYuXQW8DOPdkVCiP9k39CT8OagDFIdqFx135xxvio9NujkfuhBsFqf0S8v2lpT0yagSz/nHjrv0Va9FxNNoVxKhqIoX+0lqdPqF4IHgBpFu21WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984831; c=relaxed/simple;
	bh=QIWNhkI3vNpRRJeiND+NuOqGf5F4BCHhNEQazA0NT4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao4Xfmw4lbBXOqdrCyoX1QvseOFk+z/G7GWA25ESMq9iogDLk1OtGGG6q/G3JPL9zCfDnAcGa92057ojWqayKGOiyN+im4lKL+FsYVX4tA7/dQG7Iap5ZpWcq4MGIhLPKL/Qx6dnS4OGvscMpXb1+qUDYnhfREnyDHKpaXTIFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bD5wum9q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bD5wum9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768984829; x=1800520829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QIWNhkI3vNpRRJeiND+NuOqGf5F4BCHhNEQazA0NT4s=;
  b=bD5wum9q9eB6LF4XhHzSkhc/4wl5a/SFCzFdNEgxWYHrwOUWxT27OhFN
   9rIYT4LqQnWp5b3XEBb8SzcVh0Y7aL/hmxbtSeC0DRk85w/3kcMS6JKd2
   xtHb1IrSqi+YA3AJIiZZwUM9cbv9ctq4m4d2vPThQrq+0JaIEZBkuHl9P
   8KCKOii6txypIRkhYJOYGo9XqPpFSxwjOuUp3sT64aVevxGOWmqh7cqDv
   lBTJaj6ihwKaph+MFGlEikQGWYqCDlf9C6pWuJ20eQizCoVv4lV79ftNz
   WV0SxLCJrNT95oJm3KlldrJOOx9bZGWIHGI9SFOuyL3LJg4l0iEkE7OAf
   w==;
X-CSE-ConnectionGUID: DmMDsh4PQLmMYSpGYjlEkQ==
X-CSE-MsgGUID: JLIXZwy4RIO+bGNb0KFEeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81316360"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="81316360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:40:28 -0800
X-CSE-ConnectionGUID: cPftjnRsTHem2pg/uuQD2g==
X-CSE-MsgGUID: SbSHcbw/R06YH6NTRflvTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="205527668"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:40:25 -0800
Date: Wed, 21 Jan 2026 10:40:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Mark Brown <broonie@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <aXCQ9jcpheMub8u3@smile.fi.intel.com>
References: <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
 <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
 <BF71A04E-7FFB-42D1-8C8D-6FD13415EED5@nexthop.ai>
 <c3fc04a4-4b09-4c6a-a0f1-e5aa92a22976@sirena.org.uk>
 <80A8F67E-7A01-4F9F-9D84-29722678A2CE@nexthop.ai>
 <817bcc43-7f10-4329-8924-6c375eb73ff2@sirena.org.uk>
 <aW_zjaRLtewa_NV1@smile.fi.intel.com>
 <aW_1zlEdaPNwiXuI@smile.fi.intel.com>
 <6ad4387f-08b7-40e2-a2eb-1346d8af6ea3@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ad4387f-08b7-40e2-a2eb-1346d8af6ea3@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 09:11:04AM +0100, Michal Simek wrote:
> On 1/20/26 22:38, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 11:28:50PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 20, 2026 at 09:04:58PM +0000, Mark Brown wrote:
> > > > On Tue, Jan 20, 2026 at 11:11:44AM -0800, Abdurrahman Hussain wrote:
> > > > > > On Jan 20, 2026, at 10:45 AM, Mark Brown <broonie@kernel.org> wrote:
> > > > > > On Mon, Jan 19, 2026 at 04:20:06PM -0800, Abdurrahman Hussain wrote:
> > > > 
> > > > Let me once more renew my plea:
> > > > 
> > > > > > To repeat once again:
> > > > 
> > > > > > | Please fix your mail client to word wrap within paragraphs at something
> > > > > > | substantially less than 80 columns.  Doing this makes your messages much
> > > > > > | easier to read and reply to.
> > > > 
> > > > > > To drivers that are used on ACPI systems, yes.  Many devices wouldn't be
> > > > > > used on ACPI systems, or would be expected to be exposed differently
> > > > > > (for example, hidden behind AML).
> > > > 
> > > > > This is not for a normal off the shelf server. In our case we are building an embedded
> > > > > switch with an AMD CPU and Xilinx FPGAs that happens to use EDK2 based BIOS and ACPI.
> > > > 
> > > > Sure, AFAICT it's mostly a PCI card with a bunch of stuff on it from a
> > > > software point of view.
> > > > 
> > > > > > > I am just trying to get this 2-line small change merged so we can start using the standard spi-xilinx driver today. I am not trying to boil the ocean.
> > > > 
> > > > > > I mean, adding a HID wouldn't take substantially more code.
> > > > 
> > > > > We could, but we don’t own the Xilinx IP blocks. Are we not justified in using PRP0001
> > > > > hack until the driver owner adds the HIDs? Wasn’t PRP0001 created as an escape hatch for
> > > > > these kind of scenarios?
> > > > 
> > > > No, it's more there for the cases where embedded ACPI systems need to
> > > > import non-trivial DT bindings so they can avoid having to respecify
> > > > things that ACPI really doesn't cope with or for local hacks.  See
> > > > Andy's reply earlier in the thread:
> > > > 
> > > >     https://lore.kernel.org/r/aW9JihlsjnJ-uBul@black.igk.intel.com
> > > > 
> > > > AFAICT for ACPI the HID assigment is a bit of a free for all in practice
> > > > - board vendors generally seem perfectly happy to just pick something if
> > > > the silicon vendor didn't do something.  Just look at all the parts with
> > > > INTxxxx IDs!  That said Michal is on the thread so hopefully that's not
> > > 
> > > INTxxxx was a (historical) mistake, but look at the correct one INTCxxxx
> > > which has listed several components Intel doesn't own. Because ACPI HID
> > > it's not only about the component in use, it's also about integration of
> > > that component in the platform environment. Hence it might require (platform)
> > > specific quirks.
> > 
> > Btw, you can look at the MIPI I3C HCI case. MIPI as an owner allocated generic
> > ID (which is usually represented as _CID in ACPI), AMD allocated their own one
> > _HID (compatible with _CID) exactly for the purpose of having platform quirks.
> > 
> > TL;DR: if you are 100% sure you have no HW integration issues, requirements, etc
> > and everything works as is, you can use Xilinx allocated id (assuming it will come)
> > for the given IP and use it directly as _HID, otherwise use that as _CID and
> > allocate your own for _HID.
> 
> I got in touch with respective AMD team about ACPI ID allocation. I also
> don't think it is going to be a problem to get unique one. And I expect
> device properties should pretty much match DT property names to be able to
> use the same device_property_read* helper function to read them. Andy:
> Correct?

Yes, the main issue I see is the enumeration by PRP0001 instead of by ACPI
_HID. Also note, whatever ACPI has supported in _CRS (resources) should be
used that way (memory, interrupts, DMA channels, etc).

> I am still trying to wrap my head around all these possible solutions for
> this problem or if we can solve it in a more generic way.
> 
> I can't see any problem with patches which are switching from
> of_property_read* to device_property_read.

Technically there is no issue with that, indeed.

> If driver also works without IRQ
> I think it is fine to make irq optional (which is 2/3 patch in this series).
> The patch 1/3 is the same as mine I sent in past
> https://lore.kernel.org/all/a527f5adffc6efe4c1ad2ccc40e1e095d73efe74.1749027112.git.michal.simek@amd.com/
> and it was rejected by Rob.

I think Rob is correct. But what's the problem to describe IRQ natively in _CRS
in ACPI via Interrupt() or GpioInt() resource? You mean there is no actual wire
connection to it?

> Andrew: thanks for sharing link to pcie driver with DT which is one solution
> which requires writing one PCIe driver and that's pretty much it.
> Obviously enable DT on x86 but that's not a problem for product based on
> embedded x86. But it can be a problem for standard distributions.
> 
> Then this ACPI way where it is not clear to me yet how to get information
> about clocks. The i2c Abdurrahman's patch is making clk optional
> https://lore.kernel.org/r/20260115002846.25389-1-abdurrahman@nexthop.ai
> But input_clk is used in reinit code that's why maybe it is working for the
> first time but in case of error not sure if driver really works properly.
> On PCIe clock for spi/i2c is likely only one and ACPI device property can be
> created to pass that information and call devm_clk_get_enabled() only in DT
> case.

On ACPI the clock are usually managed by firmware, but in new specification
we also have ClockInput() resource. I dunno if there is still a gap between
ACPICA and CCF to integrate that.

> And then you have DFL (drivers/fpga/dfl*) and aux bus
> (drivers/misc/keba/cp500.c) which pretty much targets similar setup.

-- 
With Best Regards,
Andy Shevchenko


