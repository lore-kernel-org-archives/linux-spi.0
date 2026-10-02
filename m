Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F863890E8;
	Fri,  2 Oct 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924346; cv=none; b=gGO3MKiWuaxhFLMqYEr0htaoNHpNvqm/oUCXoPvKjNJSD2cBZexELe2NOdV8qbKY0cR1340QC8VU6JXPLwqkqR4KvQQog3k8kEmIpPBzbl0HyyNvYxjahc9Co8b+cL/cv+gcFJjNMD6dRvpbA0hdb63n90FKEVkG9gbKVWf/qvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924346; c=relaxed/simple;
	bh=0p2dYkNz3QJUNsMem7hywOA61ffdHZzHCh09JIGkum4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2tz8nH7wgoRxm3d2qhOF8YNWnjDVhvceJJ5eqZvrqoH909aUg49bAX3qE5VTH5yc/XU+ApaN5Kt17KctkZp/JPVW14GbqH+POQNKY3i8kAQZUBEdF9GuCNLyoRZw5LoY6B2/iRI565V1zLtzo481ArjIs76Y8jin36YaP80+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/b9a7p1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/b9a7p1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790924345; x=1822460345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0p2dYkNz3QJUNsMem7hywOA61ffdHZzHCh09JIGkum4=;
  b=g/b9a7p1vVt8nyQr40FDA/CAAk1vnMnIZYzZbs18tZ75u0fyZ9kI/yhK
   HthGHvq2bta4Zy+YWxnSf+D7MdvF1TtW57fkTj3U46ax4SgJoFcIe/i2M
   k2LyLdiqYMl/J5TCgtTvUvaZUHtGDDS7uj70KqO2DF0T1T0fQ+KYj0T2O
   lK50BdnJmnFi6C0g86kUfD8vR/29zAuboIymoq0exkCpwbsZcVt6DN33s
   OJB/9YWZpvF7o8a1oOnlb8bJg042Di7BumzUTGojkpWbUcGWBoZess0QG
   bjSzp6i0e1TCbt5qd18QxNtsEg4m6O2mbRttfOYwsl/2IdGzVCY5ceIAq
   Q==;
X-CSE-ConnectionGUID: U4iz59QAToiZuZXAUKlBtg==
X-CSE-MsgGUID: mahBURTkTYaXykHEv0raCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91710506"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="91710506"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:59:04 -0700
X-CSE-ConnectionGUID: 1RUgbOiSRhC2S0aBJyw4BQ==
X-CSE-MsgGUID: pA1OVCHDSn2dn0+VEwNobQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="272595585"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:59:02 -0700
Date: Fri, 2 Oct 2026 09:58:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: jiale yao <19888972804@163.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: Re:RE: [PATCH] pinctrl: mcp23s08: reject devices without
 match data
Message-ID: <ar9WM0ZtDJD2H5Ii@ashevche-desk.local>
References: <20260925133804.2231004-1-yaojiale02@163.com>
 <TY3PR01MB11346E0C01A9337A3AF4D97DC868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <34472b57.1961.1a0dd3dff12.Coremail.19888972804@163.com>
 <TY3PR01MB113461CE3C9EB4A175879F5BD868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com>
 <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 10:07:29PM +0200, Linus Walleij wrote:
> On Mon, Sep 28, 2026 at 9:25 AM jiale yao <19888972804@163.com> wrote:
> 
> > I reproduced this deterministically with KASAN on arm64 QEMU.
> > The SPI device has an unmatched compatible and a valid microchip,spi-present-mask property, and is then bound with:
> >
> > echo mcp23s08 > /sys/bus/spi/devices/spi0.0/driver_override
> > echo spi0.0 > /sys/bus/spi/drivers/mcp23s08/bind
> 
> [KASAN splat from spi_get_device_match_data() returning NULL]
> 
> But hey look in the driver:
> 
> static const struct spi_device_id mcp23s08_ids[] = {
>         { "mcp23s08", (kernel_ulong_t)&mcp23s08_spi },
>         { "mcp23s17", (kernel_ulong_t)&mcp23s17_spi },
>         { "mcp23s18", (kernel_ulong_t)&mcp23s18_spi },
>         { }
> };
> MODULE_DEVICE_TABLE(spi, mcp23s08_ids);
> 
> Why doesn't the override find the right data from the match table?
> 
> This looks more like a bug in the SPI bus implementation,
> surely the bus should match a driver_overrid and return a
> valid match data from spi_get_device_match_data()?
> 
> I think this is just papering over the real issue, you need
> to dig into the SPI bus implementation and see why this isn't
> working.

I believe this is the whole design of driver_override like this...
There is an attempt to allow drivers to forbid that feature.

-- 
With Best Regards,
Andy Shevchenko


