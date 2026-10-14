Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBA2D5925;
	Wed, 14 Oct 2026 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952552; cv=none; b=CP+NVGRtPPG2jo+qWkSDlIMIflSbnvlq3GMOlpKfiDjDGfHxIFAZixcu9pn8jSMJz1V2odgIauowenbfFbQXaC8NQQ3R04P9pY3qoXpQbEsTS3aS4WDKKBP0qaFP9a8wAj1137N8vR0ODRoQ69bs0PcBuZls3uIj9lmBEWvHtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952552; c=relaxed/simple;
	bh=pMlBj2ILgeBLo6fHWLARYlBU7xZmcvyiXmnblEaanbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh+y7V5ObQELUHT9RZ0CMccb3lEcjxeUrSZlGycE5uiUjoKdGtTWlFWoSPe4FoCMnqVIw0jsBi7NbR76CxkAmFyaYHw5y/jFui2gh9axsT3qfoZU5b7/it97PU8MiTkWPNsxiJXBCTvO9H7QvSVwrPME1fIUd79PuPP9OIgroNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifph30Mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifph30Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976461F000FF;
	Wed, 14 Oct 2026 04:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791952551;
	bh=aM15iasVAaO8/dnmMDbDPGswnKSHbH05MS7HL7GcvB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ifph30Mr6lPJrqiUxT1WLYwxV3g5dNCZMD6ECuRrQrwqE/b6V/1ieE2dAk9qgp4Dk
	 wd1tet5O6wNJY2w6UmAlbBTG+z9qA7WLn10+z+f33+gxOPtOGo3LOvMChu1UCgCMyb
	 0+mSMvfKmvulojax18CG17b/+rRdBhAuVUvxKv5fnvUGZOnDNz/cjUh0MrM9YESaFk
	 RHhVEIUiRvn9Ow5BjvQxanQ8sfux9aDum2niUsQcQaXhJ2Gvxsgxb2BJgHUbRTqpBW
	 tcC8UWJWVBeNqivTZyi3ux/ggz76vJELqQpMBUpBR3C7BID25FfgKRHXB+gakkoIpG
	 3kilHcJw8Kp6g==
Date: Wed, 14 Oct 2026 12:15:51 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Fix missing smp_mb() in dw_spi_exec_mem_op
Message-ID: <as8B9-ypMid1IV9E@xhacker>
References: <20261010151529.30590-1-jszhang@kernel.org>
 <f4fe920a-7b2b-4c6d-bf41-a7935e6e5574@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4fe920a-7b2b-4c6d-bf41-a7935e6e5574@sirena.org.uk>

On Tue, Oct 13, 2026 at 11:10:09PM +0100, Mark Brown wrote:
> On Sat, Oct 10, 2026 at 11:15:29PM +0800, Jisheng Zhang wrote:
> 
> > Similar as commit bfda044533b2 ("spi: dw: use "smp_mb()" to avoid
> > sending spi data error"), we also need the smp_mb() in
> > dw_spi_exec_mem_op() after setting up the members in "dws" to ensure
> > the data change is visible for all CPUs.
> 
> Which other CPUs are we worried about here?  Unlike the regular SPI path
> which can use DMA and interrupts for the exec_op() stuff we only do PIO
> and have interrupts masked during the actual transfer.  If the task
> migrates I'd expect that to have all the required barriers, but
> otherwise it all looks single threaded.

You are right. This patch isn't needed. Thanks for the explaination. 
