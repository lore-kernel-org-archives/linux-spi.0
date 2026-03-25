Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008D3DEFE2;
	Wed, 25 Mar 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451026; cv=none; b=fGeNwR6PA0VIyFqw+M684bDLJ9XzBt4m9A8s9ekWojQtcwSt+yXxTy/L7pm96JOcZOd1W8vxtSmYzMkc1Ct027C8ETiLNIggCGWM5nFcTWwcT4ry3Mpsdc0aSceFFpDB6EYlovxqkIPnHRuATrAdAhwxc2j0VWq5BPJyjoSXYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451026; c=relaxed/simple;
	bh=szUY7ce718hY4kynrafrnhbG0xsCzopEqVjmUCSRZno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndUNX70H5FoDYcZFbYuiKLYqsDK5/yJXZ69wCmtLLh5CTDCLrarWTvwroFHbn+tPQBBOAJtzl9tc0hL8eAN6noBy4V/VgEaYaFy5QK5suYeNCouEb94IM6tmPsKkgg31UcYNmPp0sI+RyW/FXx1/ivrrjGKOj8jnBDOVnuyZ6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQbADYeh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQbADYeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA22C4CEF7;
	Wed, 25 Mar 2026 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774451025;
	bh=szUY7ce718hY4kynrafrnhbG0xsCzopEqVjmUCSRZno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQbADYeh4zU0XEmMWdFcUlsDdl/J3QfABPbn+wpM7hYgY5GAyWUnJaKT+4zYYj/Ah
	 RJnYgVqC6K3d7vZHqPps8CrdAogDs1hTEHSR2/R9xiIY/Dff67zwcWPRl3cQ52aI7U
	 yUIh4YPuHqymscRHFaPwSwdVy4FQbBIgvzvTj7UqpdMoOVqX+ov6ENMhXxLbtglf/m
	 VBCOoi7XrSmhjDUZcyjYe8BatyhzNUFmlurN//kOmIcO7mOwZLCX9bm10wjypvSAnA
	 P74k42yA6S0RgoJwvuSps5PcT8JRf5LYS/U33RBQCglzTGIbrXP1pF5NAWkn6vZyO6
	 UDoYIvEPhGvXw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w5Pln-00000004kiX-12Lx;
	Wed, 25 Mar 2026 16:03:43 +0100
Date: Wed, 25 Mar 2026 16:03:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Message-ID: <acP5T-pwlOfPdlQ0@hovoldconsulting.com>
References: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
 <20260324145548.139952-1-ustc.gu@gmail.com>
 <acOw2lGiQbPr-MGf@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acOw2lGiQbPr-MGf@ashevche-desk.local>

On Wed, Mar 25, 2026 at 11:54:34AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 24, 2026 at 10:55:48PM +0800, Felix Gu wrote:

> You mean buggy driver? Any real example of the use case?
> 
> In the 5. you implied something like
> 
> 	ret = spi_alloc_host();
> 	...
> 	ret = devm_spi_register_controller()
> 
> ?

We have some 50 spi driver using a non-managed controller allocation
with managed registration. This was the only way to use these interfaces
before managed allocation was added much later.

> But this is against the rule how devm must be used.

SPI is "special"... But yeah, we should eventually fix the API to avoid
inconsistencies like this.

Johan
