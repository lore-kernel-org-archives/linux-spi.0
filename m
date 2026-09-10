Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7783D1CC1;
	Thu, 10 Sep 2026 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022207; cv=none; b=MG2QyTG40l8wgBs4OkZ+Cuhm/b4G84q9Kg/6gEgQvhgUmj9WPQr7+n+cpzmP1LC+oVi27qy3ZJhNJ551fGgECHdir1+bhyAEHQRpHZ1MsvGkWVo9bhlAijuA8v1hnMsvO/0QnsgIK/vezwXJEzVFZci5i1X+YkKtE2HE9kkxAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022207; c=relaxed/simple;
	bh=C9LrQvYbhcUmY3hnSwGy2ff+szzkheHG432q5h9iTx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV6jfVZx52QXFKZH4EoOgu74LM/3NffjtBPIs0wAw4hY4kthU3RhHOE/01CLpK5zj80x89vjr4XixlPHfosYak+lbComKET28G1Nzs7KYXncVHBxdbvQpWXalHXkgu1oS7yjayvDsXSLrJl54rhrF3+a5VPbPdCsYgLqJNPSG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8dk8PAL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8dk8PAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789022206; x=1820558206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9LrQvYbhcUmY3hnSwGy2ff+szzkheHG432q5h9iTx0=;
  b=b8dk8PALsHHaWO/UzfxHf+d/RjfsjhjNAi8ks6hQWk2x+FUUkUmyOPO3
   8m+WDD1P68mn/wrJpYJmqPKUyDqVxEtXvtcN+2nL05aUgg+cX7Kc3RtLT
   OdP8djVn9zDjVT7KzcAMRtX9MZGjKU2jpwJGHSOlZGCIJFY0DFtdFoE8V
   v0i1I20exjh2AGW9bdoKXbEv5f/u4ES3ts9l8xN5hxlAONL/03B0Zr/ij
   2Jx8GqMhzi2c6y3xg+WSTbu3MSBUltN+jmMfzhgX+bjZekWFwI9xPTm2n
   7su4ibaSk1LKQmMhgO+pkOm/Dr6eY4t87eOHTrNFsJ0slhGtHbvh0fGUB
   Q==;
X-CSE-ConnectionGUID: zxub2pOpSHC4xcCCCzwbOw==
X-CSE-MsgGUID: VwnR04kmTNuQYm2ZlCJtrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89494616"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89494616"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:36:45 -0700
X-CSE-ConnectionGUID: OKPQWoikQ2yzhCTvDPG/vQ==
X-CSE-MsgGUID: oER9FrfQSm6jW3bind7wiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="269771087"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:36:41 -0700
Date: Thu, 10 Sep 2026 09:36:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Mark Brown <broonie@kernel.org>, Farhad Alemi <falemi@asu.edu>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] UBSAN: shift-out-of-bounds in dln2_spi_probe
Message-ID: <aqJP9pVjpLCcp_XA@ashevche-desk.local>
References: <CA+0ovCioY634b646jDcs2cFmg_1q2UMN4wuTQ1V26Gy+Dm_c+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCioY634b646jDcs2cFmg_1q2UMN4wuTQ1V26Gy+Dm_c+A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 05:33:20PM -0700, Farhad Alemi wrote:

> We are reporting the following crash (reproducer and a proposed patch attached):

Thank you.

Please, submit the patch as a formal fix. You can find the necessary steps in
the Submitting Patches documentation.

> Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
> Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

-- 
With Best Regards,
Andy Shevchenko


