Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EB47D950;
	Tue, 20 Jan 2026 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937688; cv=none; b=mnzFeIANH+Sa+sEW2E2C4eOyqUB1xtn6heUEW5FGuwaflhKAlRS3Z0E9DJWadSRgrNdTB05WjV6BcN727IW1DYDSdz0f6breOAHG8WUry4d9w28fEAxUX44FUMvNoAZxjcUWCRYPrYJTQvaEuN7E9XFqP91iMlVPJDIShP1H0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937688; c=relaxed/simple;
	bh=2OP2gYd8gP3arfac+WIk0FTl7PjIcKNcOVBnLH+gvvo=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om1TYaOk4ODMHB8AWNKjdboWuf+6ZuZzdz7croguQeyX25j0ewvFpp0Droysbn5nTaV5wK04w6DZdiz9WIPzyd3xe0txoLcTdXpETOmk1rBx6F0MLaHpTQxf4cJbKpcqhING0SDBRCTf9R2LeK4DXxrdf2zO6srpEC6KxFLiqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiJWCWap; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiJWCWap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937686; x=1800473686;
  h=date:from:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=2OP2gYd8gP3arfac+WIk0FTl7PjIcKNcOVBnLH+gvvo=;
  b=iiJWCWapBswZj8i9bG5FkW8SIDfhfcqB+CfrO6G53kP2uVV7Msud2Tyz
   n3pukLjqUWrfUFmxSLvIdJ4cgGbxaTmIZ2WbyW1GHpCtvUhwe9wjQBOoP
   ZubYYfn1epl/rCQ1QZn8JX5mVNWBle0cvJNn6Xs7w7Et1W2UCsN7XCaNh
   265X8oPUzX2re5tEjPZdz9dpLGupLxLPvIhce+QrvBzNttSPnvhWAPztn
   IkPhTR5KrBHZm4phfF0pbRchD1oyGeeDS/sHQeWoG+rHCnj1Z8AUZuItE
   JVE6v6dUL/giIMnngK6zIhuy98uz3WWjmNbnJBWbfmEIEf82jC6TvGPfY
   w==;
X-CSE-ConnectionGUID: TU6BaaNXSR6ih28DNdz/5g==
X-CSE-MsgGUID: FB8xs1a0Rau+9pcGiGZ0Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81532122"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81532122"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:46 -0800
X-CSE-ConnectionGUID: u5dlNYZSRJm5gQg+qwh5qQ==
X-CSE-MsgGUID: YbCma+iYTcqDUDNpphyrSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206630531"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jan 2026 11:34:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8632295; Tue, 20 Jan 2026 20:34:42 +0100 (CET)
Date: Tue, 20 Jan 2026 20:34:42 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <aW_Y0h7RNsN12H7H@black.igk.intel.com>
References: <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <aW9JihlsjnJ-uBul@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9JihlsjnJ-uBul@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Rafael

On Tue, Jan 20, 2026 at 10:23:22AM +0100, Andy Shevchenko wrote:
> On Mon, Jan 19, 2026 at 07:56:57PM +0000, Mark Brown wrote:
> > On Mon, Jan 19, 2026 at 08:17:46PM +0100, Michal Simek wrote:
> > > On 1/19/26 20:01, Mark Brown wrote:
> > > > On Mon, Jan 19, 2026 at 07:52:35PM +0100, Michal Simek wrote:
> 
> > > > > Is it a better way to use auxiliary bus as was recommended by Greg in past
> > > > > on drivers/misc/keba/cp500.c review?
> > > > > https://lore.kernel.org/linux-i2c/2024060203-impeding-curing-e6cd@gregkh/
> > 
> > > > The driver there appears to be doing runtime enumeration based on some
> > > > EEPROMs on the system and creating platform devices based on what it
> > > > finds there so it's a bit of a different thing, the aux bus suggestion
> > > > is about what the code that does with the data it got from the EEPROM.
> > > > This patch is for something described directly by firmware so there's no
> > > > way we'd create an aux device, that's purely in kernel.
> > 
> > > I don't thing it is actually eeprom because in fpga you can place at certain
> > > location just memory (or RO memory) to describe what it is inside.
> > 
> > The table of per module I2C EEPROM devices (there's a whole pile flagged
> > as optional) sure does look like it, and it's a very standard way to
> > implement hardware enumeration of non-enumerable systems.
> > 
> > > If you know it I think you have multiple options how to wire existing drivers.
> > 
> > > 1. ACPI - which is what this series is trying to do
> > 
> > Is it?  It just looks like random cleanups.  We've got a change to make
> > interrupts optional and this change to device properties - the cover
> > letter just says it's a transition to device property but there's no
> > indiciation why it's being done.  The cover letter for the series just
> > says it's switching to device properties with no further explanation.
> > It looks like a "that's the newer API" thing than something that's been
> > thought through.
> > 
> > None of this looks like something intended to add ACPI bindings,
> > it's not clear to me how we'd even get the device instantiated on a
> > normal ACPI system.  There's no ACPI IDs defined (and there aren't any
> > existing ones), just a conversion of the property parsing code.
> 
> For the matter of this change, the only thing that can be preferred in ACPI is
> to have the real ID, id est ACPI _HID (allocated by the vendor, namely Xilix).
> So, ideally at the end it should be enumerated by ACPI ID table with properly
> allocated HID and not with the compatible line.
> 
> The compatible line is for prototyping and DIY (discrete components, like
> small temperature sensors, when allocating proper ACPI ID is a big deal
> for a vendor).
> 
> The set of _DSD properties is okay to be shared even in that case.
> 
> TL;DR: We prefer ACPI HID to be properly allocated and used, or explained
> why it can't be feasible (which I don't believe the case for Xilinx).
> 
> > > 2. DT - on x86 not sure if feasible
> > 
> > No, x86 decided not to use DT and shoehorn everything into APCI (and the
> > x86 SoCs put their platform devices behind fake PCI that looks like PCI
> > to the OS).
> 
> There are three platforms in the past that used DT on x86.
> Latest one was dated ca. 2017 (SpreadTrum SoC with x86 core in it).
> 
> DT on x86 is a real thing, but very niche.
> 
> > > 3. platform drivers - as described above by Greg not an option on PCIe
> > > 4. aux bus - for example keba drivers
> > > 5. dfl - drivers/fpga/dfl* - used for accelerators.
> > 
> > These are orthogonal to the above, they're Linux internal things not a
> > concept the firmware has.  You have firmware descriptions of things that
> > can be mapped onto platform devices but that's a separate thing.
> > 
> > > Pretty much all current Xilinx drivers for soft IPs (spi, i2c, uarts,
> > > watchdogs, etc) are platform drivers (more OF drivers because platform data
> > > are mostly not used).
> > 
> > > It means I think would be good to get any recommendation which way to go.
> > 
> > You should use whatever firmware interface is sensible for the platform,
> > if that's x86 that's always ACPI.  For other architectures there's a
> > split with servers using ACPI and more embedded platforms using DT.
> > 
> > > > I have no idea what the hardware this series targets is (other than that
> > > > it's using a FPGA) or if there's even a motivation for the change other
> > > > than code inspection.
> > 
> > > I think all these cases are very similar. You have x86 with pcie root port
> > > which is connected directly (or via pcie slot) to fpga. In fpga you have
> > > pcie endpoint HW which connects other IPs sitting on AXI.
> > 
> > What are "all these cases"?  For something connected via PCI I would
> > expect a PCI driver that knows via some mechanism what's connected to it
> > and then instantiates the IPs, probably as aux devices.  I would not
> > expect to see the contents of the PCI device described in firmware at
> > all, that's a big goal with using PCI.  If something is not connected
> > via PCI that's obviously not going to fly but it sounds like you're only
> > interested in PCI cases here.

-- 
With Best Regards,
Andy Shevchenko


