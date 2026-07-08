Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798740586A;
	Wed,  8 Jul 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512935; cv=none; b=oCHePdX2OFz16Uc3v6VhtIM+8UOFRvcXgBMeIPlzKOEcIP08H+G9o9ALIur0QF0uSMiZf8U7+/DXCAS1DtIX2Esq39TOjC3djZOW0GMzjqA62QUPgoNooD1y2bz8ivhf1Y/iuNkfOvDxjK8VzLUgF39uKFG4u1rTr/2sgHIr5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512935; c=relaxed/simple;
	bh=+9TsjA/UtL0p2WTsPR2IdZ9vIjI/yRnprHOo3JJjcG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdzrdD8Cc/Hd5aGG7BleUh3WFeBLrN8mPh0AShN1wefw0YTGo1gnYFNjOMqFKxpt9StqHRyeMYx6A6L+JIl47x9FzHlSEZjM9X/wB5CGou7xkBzFoqez1Iz5MNVcJHA3R7TbYPo6LrwUk3GcxR4aSkpkOI+weuUMI4S/7nziDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=On/cfYzp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="On/cfYzp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kGmVgevW1lzA/2QfVWfTwo7t5+ne3+aqr0d698UV17U=; b=On/cfYzp50DBzVI52zwm00XYst
	7U7qQly7PZEiZdyN3sS5ZXdlkN2w0qPh4jT5IJUzx4NVBL5uVK+pGaF1Cn+TZHZRlRgfz9iagb9pM
	+hJ3t7ppBPSsWHNlDxEF59KqBiroo3Me+Ow03hNm5OQj6QXAo7CUmEDGU8NuW0HvI7c+Zt3h63K61
	duS5xJEMZhPtQGEWCVldST3PLagMdjt4I+EWnbtig2aYriOCuAzLvi/KBVhLTvlCxipHnuol5oYso
	aSVz7gIr6QoxIby3ZYxoFHYzW23borielcxP8Bkwm3FhhdHPHa0RQ5TwRqjpMspMiNo6tEXTyxnbK
	qo3W6lTQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whRBZ-002wPb-1i;
	Wed, 08 Jul 2026 12:15:29 +0000
Date: Wed, 8 Jul 2026 05:15:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Suresh Mangipudi <smangipudi@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>, 
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] spi: tegra210-quad: Convert to hard IRQ with
 high-priority workqueue
Message-ID: <ak4-h7tAemS9PmFk@gmail.com>
References: <20260708011257.1712961-1-va@nvidia.com>
 <20260708011257.1712961-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708011257.1712961-2-va@nvidia.com>
X-Debian-User: leitao

On Wed, Jul 08, 2026 at 01:12:55AM +0000, Vishwaroop A wrote:
> +	spin_lock_irqsave(&tqspi->lock, flags);
> +	t = tqspi->curr_xfer;
> +	spin_unlock_irqrestore(&tqspi->lock, flags);
> +	if (!t)

I am still quite confused what tqspi->lock protects. In the code above,
you get the lock, then you dereference tqspi->curr_xfer, and then it
releases the lock, and use t later without any lock.

if tqspi->lock() is protecting curr_xfer, shouldn't you hold it for
longer?
