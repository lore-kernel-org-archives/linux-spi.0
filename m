Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC73D3013;
	Fri, 27 Mar 2026 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601634; cv=none; b=oQ1ASg8ikdAODNFYt4XuYqlbHZJvSvVUxu811lrD+8FtR2eAuBWLYGrMnnKcJDLFdji85jOSPXtWrZsO0B26nq/a/V81uVtgIZWbxzkHMuWpqny/3QKxA10CiwboMgy60kiAAuzQfbCvriyWIxn9y/pNCP6RDRsmfrygAAWToAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601634; c=relaxed/simple;
	bh=MH/P33h9zbfFh+HqlkKZ4x5A/x4zeLXxShDi0/yMofs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBlgSYmnfJmaZJKpeVof9zudLLGmpWruRJfJyj2YUBUJ/iTU9Y5xpT9L44W/kcHh1AFUdaWOG0DCb/FgvcRNpFsbXIZVmrJN4GXqzl0KeV/vAqaP7y1seMIpOPbFSs8GhM5Cm7UoasMCRsP/lDTkfo6bLcvFIikoyHBhxIw7HVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/d9aVqe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/d9aVqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774601633; x=1806137633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MH/P33h9zbfFh+HqlkKZ4x5A/x4zeLXxShDi0/yMofs=;
  b=f/d9aVqee1BgwEld6kpY900Zs/NyaR59QYlhtuAHP/Yyqo01BAM4RUMj
   Kk9GFkEjkchlAiTZ4GrNwgpiPH98M9QXzIezTDamDk5k9cZdJrSUvyMN1
   27f2LVivrQ+wFsb9+Nu9iYUp1Olfj6OUazmlj2aQxu+T4l42F3Uk1xMtF
   H7+1hCaq39G+nl26lhwFk1dTyd5Lpgjwa/7meaj8ZlbS79bJaEgvVmp7x
   U3GsDtykUvf6LCTKGgIgWRxu9QJWsH5rXhbpmUkhst7elrJOEC4PzgvSu
   RkbwHAptv8897M/TyJXgrinv7PU1QCWN2AW8tcbEK1cITyTzHRzvRFJ28
   w==;
X-CSE-ConnectionGUID: lDJ8wKJSSPeqQfLMcDMQBw==
X-CSE-MsgGUID: kqk5S0F/Tk6Dzqz4upYGqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75386515"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75386515"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:53:52 -0700
X-CSE-ConnectionGUID: VgU8NFf5Tqu+gal3mBLTTQ==
X-CSE-MsgGUID: lPqyRkcXSIG4IJ8tJYdz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="230185674"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:53:51 -0700
Date: Fri, 27 Mar 2026 10:53:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: fix use-after-free on managed registration failure
Message-ID: <acZFnCmcA1UK0xRw@ashevche-desk.local>
References: <20260325145319.1132072-1-johan@kernel.org>
 <acT9-MoL5zfss8Hp@ashevche-desk.local>
 <acWGuheUdu4Bdb8S@ashevche-desk.local>
 <e8588793-02ad-4339-bca7-fe55db697e89@sirena.org.uk>
 <acYvqDTmQljmzXcg@ashevche-desk.local>
 <acZED01B-WdJbr2D@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acZED01B-WdJbr2D@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 27, 2026 at 09:47:11AM +0100, Johan Hovold wrote:
> On Fri, Mar 27, 2026 at 09:20:08AM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 26, 2026 at 07:25:14PM +0000, Mark Brown wrote:
> > > On Thu, Mar 26, 2026 at 09:19:22PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Mar 26, 2026 at 11:35:56AM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Mar 25, 2026 at 03:53:19PM +0100, Johan Hovold wrote:

...

> > > > > > An alternative would be a partial revert of the offending commit, but
> > > > > > it is better to handle this explicitly until the API has been fixed
> > > > > > (e.g. see 5e844cc37a5c ("spi: Introduce device-managed SPI controller
> > > > > > allocation")).
> > > 
> > > > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > > Seems Mark dropped the original change, so this is not needed.
> > > 
> > > Not intentionally?
> > 
> > I don't know, but it allows to start from fixing the users to avoid regressions.
> > I'm fine with the current state of affairs.
> 
> The offending commit is already in mainline and hasn't been reverted in
> Mark's tree. This fix has been merged there though so nothing more is
> needed for now.

Ah, I only looked into Linux Next (without looking into the base, which is
v7.0-rc5 as of today). Thanks for clarification.

-- 
With Best Regards,
Andy Shevchenko


