Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA63D1713;
	Wed, 19 Aug 2026 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122790; cv=none; b=tJrxn9FfTMsyvSg1LAnH/ueLFxsRcwlFS2U4Gw2lpT/K5nuyTKwwfLbYokIe+ydQb4+fgJnffoav26m9hqPChPK1aWdvRz7n7ETXXUkgQumtNtdtYxXCXORYNGPIz6yAbI/YI1+sHAUWbMjBmG4GmjwlUZ+RT0TZ4q08LDe8zGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122790; c=relaxed/simple;
	bh=Zq0LIl3X1GXeosM0Ww6mQUH64W1Y5Tpeo0Aj4mQOkq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6TrmB/Nr1AB6iov05YWLqxzu4nGlbwfBvjkTY2cG0kycA9HA7/S6fTFoKqf3/Wx2yDEyqSc2SuZmUsYwT9HrrYU5Box4S5u6c0POTguAt5Zb/ZG01wEza74/t4l+RHe3a0De2SfH0AtwVHRS02zGw6n1JX8GJBNKZ8iP9dbiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQy2DIEj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQy2DIEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787122789; x=1818658789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Zq0LIl3X1GXeosM0Ww6mQUH64W1Y5Tpeo0Aj4mQOkq0=;
  b=iQy2DIEj921AT6+IFZU/ot4t/FvmVld0HHV1b+WTIAfJHvQqIRPGM3n4
   bTPER8VlQXH0o2cX7b2UzVmKCP5PMmBnjfOjoRW5IsFFZZjgIqDwZjO8A
   y8wkiykZLZjuWnsqFBzmW5Ii4aNIegzPFI5g61DNX5Gws9ZVWuC330lrq
   xW6JGi69PHcO29tzkYLGs8fbPi2CqUkxlFyibtJQS6Bf98yiItJrKPIAd
   NQi2hFVZc0173h0Ad8lETIMQSNQ9i0nBRhRpLEm82OfD6VCY3ZdyhWqBD
   b1WaynLz0nzvQKqBwQRmeuWNWHaYzIx8RrOkEUyt7VeUsRLIcNtT83OEl
   w==;
X-CSE-ConnectionGUID: Zkb0EocOQwugjnHH1yTtbw==
X-CSE-MsgGUID: TdQGkbEuTvWqL1oLdSfauA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87829881"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87829881"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:59:48 -0700
X-CSE-ConnectionGUID: 0jWk03TaQia1j/dC9F8JbQ==
X-CSE-MsgGUID: PlZP7AneSuGtRGH6BzMshg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="268966789"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:59:45 -0700
Date: Wed, 19 Aug 2026 09:59:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 3/6] spi: expand device name to include all CS lines
 for multi-CS devices
Message-ID: <aoVUXxzM77ueTWBV@ashevche-desk.local>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <5719698587a0a7658a3980168eef0731a5e7506a.1786973376.git.Jonathan.Santos@analog.com>
 <aoP_cbcqHEA5L7iK@ashevche-desk.local>
 <178706966052.3163.11425556311922813200.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178706966052.3163.11425556311922813200.b4-reply@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 05:14:20PM +0100, Nuno Sá wrote:
> On 2026-08-18 09:45:05+03:00, Andy Shevchenko wrote:
> > On Mon, Aug 17, 2026 at 08:32:57PM -0300, Jonathan Santos wrote:

...

> > > -	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
> > > -		     spi_get_chipselect(spi, 0));
> > > +	cs_len = scnprintf(cs_str, sizeof(cs_str), "%u", spi_get_chipselect(spi, 0));
> > > +	for (unsigned int idx = 1; idx < spi->num_chipselect; idx++)
> > > +		cs_len += scnprintf(cs_str + cs_len, sizeof(cs_str) - cs_len,
> > > +				    "+%u", spi_get_chipselect(spi, idx));
> > 
> > So, if this won't support sparse CS list, I would just go with a standard range:
> > 
> > 	dev_set_name(&spi->dev, "%s.%u-%u", dev_name(&spi->controller->dev),
> > 		     spi_get_chipselect(spi, 0), spi_get_chipselect(spi, 0) + spi->num_chipselect - 1);
> 
> I don't think there's anything forcing cs to be contiguous. So cs4-0 does
> not mean we have 0,1,2,3 and 4 which I think the above implies.
> 
> Moreover, i also don't think is guaranteed that `spi_get_chipselect(spi,
> 0) + spi->num_chipselect - 1)` yields a valid cs. IOW, in theory
> 
> spi_get_chipselect(spi, spi->num_chipselect - 1) might be different
> than spi_get_chipselect(spi, 0) + spi->num_chipselect - 1

So, I would expect then two things:
- following the KISS and make sure we operate on the sequential CS ranges.
- definitely add some test cases, now it's a time (I consider NAKing any
version without test cases of this rather complex mapping logic)

> > (yes, need a variation for num_chipselect == 1, but I leave the rest for you)
> > 
> > Note, I do not see that we are expecting to see the sparse CS list here. It
> > would make too complex logic to follow. So, range approach is KISS in my opinion.

-- 
With Best Regards,
Andy Shevchenko


