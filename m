Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241231E825;
	Wed, 22 Apr 2026 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872495; cv=none; b=OD4A3PYZIe8m7UGhpmU20i9oLjwfWY16AEuiOS2gCZ80ajRTfuVIAxGtfplJojP+6A1SClnWBZ0B8qhT1TTwBgQxejooWpET1XJFBKoY9Tt2Wdz24lZaedGoqaspR4qN2TK5CtG39oX+U5G50UmYLmBLiHDCB8SBVxkbOKAeZ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872495; c=relaxed/simple;
	bh=DUjp6j1DzJ1ELLLh3AsE8Qf1QAg02KsFHP9apbJ3tj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNV9+T2/vS2hEAsu6dgdwDmLqNMpIfb6WsWU9+CUolz9kgRfdHQR+NFbq+ujpqI4rbEBj8mPYoqOhyQKNS8Zq8yCLNll+Ba/wxlTQOuxz5d9huaYYDiO0E+OaOXx//Pq2B8FDJOfstb3VDUJQysP4HpujVJvwrdbpwSZcOYoLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8VWgegS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8VWgegS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4671BC19425;
	Wed, 22 Apr 2026 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776872495;
	bh=DUjp6j1DzJ1ELLLh3AsE8Qf1QAg02KsFHP9apbJ3tj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8VWgegS35Bm3PuVgvSLg9ikp7WOp9JMKV+tjrrGYpm6Cf9L0lOPTHMyDjuSQ1Ab7
	 9hnTmnjpSnZ5fVabtYhORmMiS+XLwunqq7EudTqW3ZBMCdeKmtWsBCx9cjb+ZmF7iA
	 wHFHyKMrFHhUUIma88S7CqqYxPOAGxz2iLe14Ey/OLpA1NMy+LNKRvWYijN15sE3x7
	 K+4WL2aRlUvUTlY3mxX0tGwMVoX7z9xvMPlppjovfasyY7gyMJP73TWzg6hRfb3xi1
	 Aq8T90WXLBDulyqFXUR3+28eVMBR5ss4/np2NFEr9AF62bCvI/KtNow+jqozBfIc4T
	 cMu54uaQIRl0A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFZhk-00000008mQG-3jzr;
	Wed, 22 Apr 2026 17:41:32 +0200
Date: Wed, 22 Apr 2026 17:41:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: mpc52xx: fix use-after-free on registration failure
Message-ID: <aejsLE_vnchmCKtN@hovoldconsulting.com>
References: <20260421125800.1537361-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125800.1537361-1-johan@kernel.org>

On Tue, Apr 21, 2026 at 02:58:00PM +0200, Johan Hovold wrote:
> Make sure to disable and free the interrupts in case controller
> registration fails to avoid a potential use-after-free and resource
> leak.
> 
> This issue was flagged by Sashiko when reviewing a controller
> deregistration fix.
> 
> Fixes: 42bbb70980f3 ("powerpc/5200: Add mpc5200-spi (non-PSC) device driver")
> Cc: stable@vger.kernel.org	# 2.6.33
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=3
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

This one will need another spin to address some further pre-existing
issues flagged by Sashiko.

Johan
