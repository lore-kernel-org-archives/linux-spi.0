Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234146;
	b=H+DRwm1pz66yfQpw8boMMDVtsYAPVFrhBEiYWPlRWXIOGEs7ERyAiCurvrrlnjV8HUw+
	 SqqAnXEBCL3DJIWYDJs/DPdMTlRCZ2uzggBbqHdNFeiRV6kWeFgx0yjScw/C7HEHJbQGR
	 BZ8evCPUC4mP3JVzhG9wDSeRjf+MvG1zmBuutu1WWFAB1dvfE2VJEICA4BUQ7OHEkR+9t
	 6W2ONqKvvmXYRevkzyzIWaehywPHRCrWwfmI1iNRN/7K6hlxRzg+DB+z8JwKvR+WsK2cy
	 LkGYHXe/pFnPdn+cE7cyflTI4OkP3xZsl6x6N6h3p37WXGz2NxaOVUgM/GcHu4dr40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234146;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/FFBn2dwDGy30bW7pC/STm/BnbsRXnLnjWa4elBrin8=;
	b=b9olKtnTgKRYfPsJ/+A0Am+8/SqUsmJdXcD3mXuYmJ5UzOv3R6gqADnnNku0qP2OS98D
	 eEjoF8RCr6g+V+objmZ1CFXKPeOz7JZI/38Gri7cH8RVV3JfeHx8C6iYLfZqHPKVbXJGF
	 lnZcsNsYWw6K8Orw35Li4j3XWvBqZMp0A4yF0qhi0OXBE/Gh9HYCa6DBd2cCMnMELhkkP
	 l3CsZxynRWYXj8usyZ21OhO9mVDDoJugDl0WvpWneK7MLRbdkTy3VAy9Id5kM04L+tpNA
	 x/bnxGwl7UwmhD1TXguMHtF6GS/JOP4THhuo/mqh+UuUpnIcisvpwzHzUcXKkpEFRiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L9LS0HyT;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379C606A322;
	Mon,  9 Nov 2026 14:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1379C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L9LS0HyT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794234146; x=1825770146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uW9ERfhz0aj5tIVSlWOPP4t3UQtEwRMzJ695iyFthtI=;
  b=L9LS0HyTUt46KxaHQDSp/V/exEoVr+X0KkW24tjdUqgJnh1JClxcG8KN
   L+EJwjjaG913P7qg07SidnKqnf/JT73xhOYkydLJRZxxos44v8TtLSXe4
   jkKrOajmi/bK/sLkcFQl43n/raNE7vPcP5vaRK9/EGWZgTSzv4n6M2IAi
   E+wa6XlE84k0IaabK8LugEDY1HDrZGFp1QMHw5ChZUeEOCVQxkqv7fEjm
   BI3BL//aZUHkA6smRYu3WnZjxIX9ST9huRE0TgoCbVUh2xD4MJwmLk6Dl
   IjcZeUKcDQKMtjgeIi+fUJjDeQkYtN152bqO03WZMsdFmxG/H+losROR6
   g==;
X-CSE-ConnectionGUID: GuutUR7TQKGPA+zLoa61BQ==
X-CSE-MsgGUID: dKo6eP5lQaSVB3OaF55vQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2856000"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2856000"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:22:25 -0800
X-CSE-ConnectionGUID: EpUVzpEKSPmngmecXdcaQA==
X-CSE-MsgGUID: ejVI2dVDRpWefpIhL+z+0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="9624422"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 09 Nov 2026 06:22:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A794299; Mon, 09 Nov 2026 15:22:22 +0100 (CET)
Date: Mon, 9 Nov 2026 15:22:22 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Mauro Lima <mauro.lima@eclypsium.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pratyush Yadav <p.yadav@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: intel: only check locked opmenu for SW sequencer
 operations
Message-ID: <20261109142222.GT176724@black.igk.intel.com>
References: <20261108203728.25735-1-rosenp@gmail.com>
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
In-Reply-To: <20261108203728.25735-1-rosenp@gmail.com>

Hi,

On Sun, Nov 08, 2026 at 12:37:28PM -0800, Rosen Penev wrote:
> On controllers that use the software sequencer for register access (LPT
> and BYT), intel_spi_supports_mem_op() rejects any operation whose opcode
> is not in the BIOS-locked OPMENU. However the check is applied to every
> operation, including normal data reads and writes which are always
> executed by the hardware sequencer and never consult the OPMENU.
> 
> On a Dell Precision M4800 (Lynx Point) the BIOS locks OPMENU to
> {02, 3b, 20, 05, 9f, 9f, 00, 00}, which lacks both READ (0x03) and
> FAST_READ (0x0b). As a result every read op is rejected and spi-nor
> fails to probe both flash components:
> 
>   intel-spi intel-spi: 0x3 not supported
>   intel-spi intel-spi: 0xb not supported
>   spi-nor spi0.0: can't select read settings supported by both the SPI controller and memory.
>   spi-nor spi0.0: probe with driver spi-nor failed with error -22
> 
> Only enforce the OPMENU check for operations that actually go through
> the software sequencer: register reads/writes when swseq_reg is set and
> erase when swseq_erase is set.
> 
> Write Enable (0x06) and Write Disable (0x04) are excluded as well, even
> though they are register writes. WREN is never issued from the OPMENU:
> intel_spi_write_reg() verifies it is in PREOP_OPTYPE and uses it as the
> atomic preopcode of the next cycle. WRDI is not sent to the flash at
> all. Rejecting them whenever they are missing from the OPMENU, as on the
> M4800 where 0x06 is only in PREOP_OPTYPE, makes every program and erase
> fail with -EOPNOTSUPP.
> 
> With this both flash chips (W25Q64 and W25Q32) probe and read back
> correctly.
> 
> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
