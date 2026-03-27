Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E73A0B2B;
	Fri, 27 Mar 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601234; cv=none; b=mCgW7Uk52e6vUbGxEvZdu829t6LiLeGA8F02jR+V2IrO8wtEswvcFGgXS8hmNjeu/9X2MRjjosYm/Jv1ndIjDZBsiMEwSHDEjTs4agRqRYWIIqBbUT5rp+JusnzgOIm0lba/Ki3B/HzrgrTEJVU7ZkH2Ffid3RknFGbGWL2qgCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601234; c=relaxed/simple;
	bh=4JHx6Pfb841d1S0iLq9h0/DCGHUYYizzvP1r82cQ7Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYW4RbdgNaAbJ4HxERP8dlXWVXstcs00Y6+FvFhG5p6EOGFuXRHo18H/+as7FTcnaeIudphEEFX4/sUx2RTQsY2PnD8pes7z2Rwy3YrqM4PxafLbozBoV+tIxuT1ILhmkweOYqx0wIiofPZ3y/1BaG/j+e6LjGx30VEKDONbRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTsJcyMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTsJcyMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9632C19423;
	Fri, 27 Mar 2026 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774601234;
	bh=4JHx6Pfb841d1S0iLq9h0/DCGHUYYizzvP1r82cQ7Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTsJcyMZwkWeESFRgzJuyoOdVqelABwB4m4ioNn48uKKdMld86GIpU74mpJFZYtnD
	 YMj6bDKDXk0/R3Mlg0aqrJiQ+Jjd/G6eEAMS6b8vqujm5EqHrMvZMLMHDTYncpGGRu
	 6jxFVb/QPzDC/IWkWKd1KdCXMFhB4Zm7+u7cUM1goMi9PX4x1as8poMbX6DtLwiJP5
	 FF+h/3IyXgzNnBSBXPlHxAbjKrbn8LOulhMkAZNgfStDz3/1mCNIGA/JEk219Kz5zA
	 cWr6aXGUaSjpX2Z14+w0+d0P2Xku5tqHi53/ZU6qCkGRQNrl9WDWc554yYZerWpCuv
	 /ACvsS/CEQwdw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w62qV-00000005KZz-2Tdm;
	Fri, 27 Mar 2026 09:47:11 +0100
Date: Fri, 27 Mar 2026 09:47:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: fix use-after-free on managed registration failure
Message-ID: <acZED01B-WdJbr2D@hovoldconsulting.com>
References: <20260325145319.1132072-1-johan@kernel.org>
 <acT9-MoL5zfss8Hp@ashevche-desk.local>
 <acWGuheUdu4Bdb8S@ashevche-desk.local>
 <e8588793-02ad-4339-bca7-fe55db697e89@sirena.org.uk>
 <acYvqDTmQljmzXcg@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acYvqDTmQljmzXcg@ashevche-desk.local>

On Fri, Mar 27, 2026 at 09:20:08AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 26, 2026 at 07:25:14PM +0000, Mark Brown wrote:
> > On Thu, Mar 26, 2026 at 09:19:22PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 26, 2026 at 11:35:56AM +0200, Andy Shevchenko wrote:
> > > > On Wed, Mar 25, 2026 at 03:53:19PM +0100, Johan Hovold wrote:
> 
> ...
> 
> > > > > An alternative would be a partial revert of the offending commit, but
> > > > > it is better to handle this explicitly until the API has been fixed
> > > > > (e.g. see 5e844cc37a5c ("spi: Introduce device-managed SPI controller
> > > > > allocation")).
> > 
> > > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > > Seems Mark dropped the original change, so this is not needed.
> > 
> > Not intentionally?
> 
> I don't know, but it allows to start from fixing the users to avoid regressions.
> I'm fine with the current state of affairs.

The offending commit is already in mainline and hasn't been reverted in
Mark's tree. This fix has been merged there though so nothing more is
needed for now.

Johan
