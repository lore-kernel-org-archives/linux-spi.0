Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1A3CE483
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290317; cv=none; b=rfrFphwyk0kO5yWA1N/+9W6XXzQoUIpPKF0SuhMzVuDlsVPcq4qMNmaZlx0ZXX5MCmN+IL1j/dvBJ+UYqS5CiypzQxRVPq7o3+H1l5hl+5gqKZ8S61ajoBEPJp2ligRsJ5AvXdrBKFDhAZNc1Yr46iUoX18uMyT0yO1J4h12k80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290317; c=relaxed/simple;
	bh=n2Px9KvrBSca+8wbbFZSgIYdPNKBUj7GDb8kCwrntFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5Un0e3px9/UFarDWgnAwASNgSMuf8UTtD2fo6SE2K498OUhIlVscUL52LeYo4BMT/HpFKE8WKe9yESD5r99gIgd1vXusj7UCMV3lGNvAvDphlQqtASBAqx2EaS2fUTdi3nn4bZxMePtUb3Bjk3pvj1ghJCXXymuAx0wnXYSfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6BhqKuv; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6BhqKuv"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12776bebe9fso705952c88.1
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290311; x=1774895111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+l2i6CJ0UesVmQ48tC67wDfEsqc0p6X8zxC51ds3A4=;
        b=C6BhqKuvTpMhqlgVXLg6kGG0gezlJsDbJftPaxV/tEZBZA6D9EC2wRDTvqtCMVxwz4
         /8ZOvMrwAa3W5fYzMgFaX3I6Ptx0VKBRK4Lgpt8ILJokWwtxMfTBzc3/PzPXg70Oj4np
         jpl5Jmo0t7/5kzqB3fsutAMjgJ1YqE19eixjvR7p/ri4XkpXb+LFuk8M8KLyDG6+2rqI
         tb8Hveoxujn0S2XUx8RQ18UNQBRNT7oS0go8XLXN5G5pAoMBFsg952vDwr6+W4olLNAq
         zg9N/rTnW/muM4oDXZA9ksnKerCiBQ8d0Y181a4ort6rAdjU48nIksLnZXq4bqI32XqA
         3OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290311; x=1774895111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+l2i6CJ0UesVmQ48tC67wDfEsqc0p6X8zxC51ds3A4=;
        b=cOPZgtgvOhWggjUvNDzqXGAp9SAD+mYcsE4E/+mVBjLbcVFVzYphg7qJIJ2xrkHiZu
         3UBCHc1/L6tcYviWKrMDNlHNajddrhzGCggKlCcI0MGy8FlqIqt8UD7ofN/bfFefWCdP
         xu6TXVYODS9EOK5RLoRj4eVcMlNe9TmVDXs2/ZQlSv5Q5UxE0I4Arv0sV9+TyYjWe+p5
         iQgzRmiFEyxm9/Idzm3MOivJPmAMS4UfdzSD7w0Mjg1C9MkdmBai9d6vh4Z4s1CfmvQq
         iNgbwaOFPH+Zy95xAjwoU8k6MqEYaXFknMazW4Z/uiaItho/uGwWZFaFstX+m5n/voIx
         0htQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtM3VxJrkztcb0OqjtfCBmYFwlvwolAbw/6Yy/ikMwa9UUlvJf1nAeg5IRnSnu0XysyO2jwY3VBkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4Fkx6YOs9wFvRwRVN2R7G4+UtHSnn2yySJ5+SnIuX5QxNQ3I
	wcNfOP+oEGfjk0lGrT12WXRBz/g69B/k3C7DDgXnjKqvhfJm62wiTery
X-Gm-Gg: ATEYQzxuf7/wIDZl9aD2Sa7zQwZxDchys4YMDr8wT99vDk+BakorQJhG7GVNw4zY34d
	kK5IO5rgYEJlgH14ulZ/dHbXiEoXa5uB29Stk/gHa121S35oFnOwLQ8TVe5s2uWJmB2fTRqJTDN
	mEqmuo5vsQP6BvvhFGZYsQY0sc4PWVMQ5dVihlg9M4rYWAeE3SL0JiCJ/+iovy0v9XjLSnjxeAI
	zVoSd/69MUdUGisWc0wV9x5O3EB1WXGS1EhT8TiFUuiUcozinhZvxbdgQJhLrQCDemcW1AaJjT1
	TT2uRL6G3Y1nKjfn6rlyH+pWM86hdD55FmxbAPTRw+2a45BqmYgOF8GFhwFT3Bx1C3JARs6SmMu
	klTp/S+atQ/6/xS/nBznyDk+2hjjfuDfL96bU5qJ4TvH8a7U+/ug9HVMfLCJtRZFxgg23cuuqNi
	+wDP9e6jHULNewhCSw3fAjAQk3YF9II7An/YzY/NNYJpTlCXHFZCNMeALyTVIrU8eK47zeOG1W1
	dU=
X-Received: by 2002:a05:7023:b14:b0:128:e2a9:d97b with SMTP id a92af1059eb24-12a726dd9b5mr6179340c88.42.1774290310889;
        Mon, 23 Mar 2026 11:25:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31bef1sm16253302eec.26.2026.03.23.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:25:10 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:25:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 03/10] spi: switch to using class_find_device_by_fwnode()
Message-ID: <acGEk-63oVK_fBeh@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
 <098e1856-feee-4f4b-8059-85a53967f6b3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098e1856-feee-4f4b-8059-85a53967f6b3@sirena.org.uk>

On Mon, Mar 23, 2026 at 05:16:04PM +0000, Mark Brown wrote:
> On Sun, Mar 22, 2026 at 06:54:21PM -0700, Dmitry Torokhov wrote:
> > In preparation to class_find_device_by_of_node() going away switch to
> > using class_find_device_by_fwnode().
> 
> >  struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
> >  {
> > +	struct fwnode_handle *fwnode = of_fwnode_handle(node);
> >  	struct device *dev;
> >  
> > -	dev = class_find_device_by_of_node(&spi_controller_class, node);
> > +	dev = class_find_device_by_fwnode(&spi_controller_class, fwnode);
> >  	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
> > -		dev = class_find_device_by_of_node(&spi_target_class, node);
> > +		dev = class_find_device_by_fwnode(&spi_target_class, fwnode);
> >  	if (!dev)
> >  		return NULL;
> 
> Actually, no - this just looks weird.  We're in the middle of an OF
> specific function but we're having to jump up to fwnode for no apparent
> reason.  If we actually decide to get rid of the OF specific function
> then I guess but I'm really not convinced this is an improvement in
> isolation.

Yes, I want to remove OF-specific APIs from the driver core. I also have
drafts for bus_find_device_by_fwnode and others.

I can make a followup series introducing spi_find_controller_by_fwnode()
and removing this OF-specific variant.

Thanks.

-- 
Dmitry
