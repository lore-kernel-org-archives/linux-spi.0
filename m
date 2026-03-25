Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FD35AC01;
	Wed, 25 Mar 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450772; cv=none; b=sObK+10fyDd5XUtLzPJwUVC+FX3q19D+eMMgiGla5RgBPJfwHjQ0fTGdV+5f2XqV3NQjMRl1mscYWZ4xV+Ux8wFHqsH4jxpXE3vifGW2fgz2Z897/4DS4ay7VXQVD6bjscg0QwCuWB1+TduQYnP8zeIhKvFNMESQ/dKCwsS6+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450772; c=relaxed/simple;
	bh=KCkWd/xMRx6rzuvXVv3hey3PBUpx72W7YfUSbzda5Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF3mNNfCQH8BnOvwOXyr2mlLPz1rk2LWVEORwZpP2PGrQwLNGujFZQQ/U0BRsiz5pIC1KpH0vl5iXBq/G3iL8ObtlfxB6oJUlt9Io8ut6N0+5A2IgD6o19KTvtyljxVTu3m54kEPhfT/vYl/OS1acL82qZ3ECRyzXtcoZQeGro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehEQTFuJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehEQTFuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D26C4CEF7;
	Wed, 25 Mar 2026 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450771;
	bh=KCkWd/xMRx6rzuvXVv3hey3PBUpx72W7YfUSbzda5Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehEQTFuJnnLWbqEwFAITcJBzCoevF4Vddnxla6NTYyNjFEITWP+3azXx41VrpZ7+w
	 UcX2Tu74yzsAXMkJJ3NyAK65vGu0GF72nbZXW2wyhTgE/GA+KuXSiRnwIDF6ovtJdU
	 0j2Tdb9dYO59D/4pFdjwiqVjBUxQTlFnY7HzMmHAQ5qpwTRgtL9rzNmWh6SiwUgB7Z
	 6NFQ9KuChEDAu6ahmTIxEO67Ira3uKdNE/Cmh9NWtTKfbB9uxQLcPCO80a8hIQuN9m
	 HeouqavL3nrhvgB0+BEKhe6j3LZM5oXJ49WyUXWIXITICGdxdsYcc13YIcKQcbezuR
	 pVAvE0DgYmjzw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w5Phh-00000004kdz-2PU8;
	Wed, 25 Mar 2026 15:59:29 +0100
Date: Wed, 25 Mar 2026 15:59:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Message-ID: <acP4UXadtVIEF4mu@hovoldconsulting.com>
References: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
 <20260324145548.139952-1-ustc.gu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324145548.139952-1-ustc.gu@gmail.com>

On Tue, Mar 24, 2026 at 10:55:48PM +0800, Felix Gu wrote:
> >  /**
> > @@ -3398,22 +3395,14 @@ static void devm_spi_unregister(struct device *dev, void *res)
> >  int devm_spi_register_controller(struct device *dev,
> >  				 struct spi_controller *ctlr)
> >  {
> > -	struct spi_controller **ptr;
> >  	int ret;
> >  
> > -	ptr = devres_alloc(devm_spi_unregister, sizeof(*ptr), GFP_KERNEL);
> > -	if (!ptr)
> > -		return -ENOMEM;
> > -
> >  	ret = spi_register_controller(ctlr);
> > -	if (!ret) {
> > -		*ptr = ctlr;
> > -		devres_add(dev, ptr);
> > -	} else {
> > -		devres_free(ptr);
> > -	}
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(dev, devm_spi_unregister_controller, ctlr);
> >  
> > -	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(devm_spi_register_controller);

> It seems has a potential corner case in this commit.
> 
> The issue is that devm_add_action_or_reset() triggers its callback 
> immediately if the internal devres allocation fails. This creates the 
> following sequence:
> 1. spi_register_controller(ctlr) succeeds.
> 2. devm_add_action_or_reset() is called but fails.
> 3. The "reset" triggers devm_spi_unregister_controller(ctlr) immediately.
> 4. This calls spi_unregister_controller(ctlr).
> 5. For controllers allocated via spi_alloc_host() (where 
>    ctlr->devm_allocated is false), spi_unregister_controller() calls 
>    put_device(&ctlr->dev).
> 6. This drops the reference count to zero and frees the ctlr structure.
> 
> However, the driver still holds the ctlr pointer and will typically 
> attempt its own cleanup, leading to a use-after-free or double-free.

Indeed, you're right. I stumbled over this change as well recently an
flagged it as something that's likely broken, but when I had another
quick look at it I somehow convinced myself that my instinct had been
wrong.

I just sent a patch to fix this here:

	https://lore.kernel.org/all/20260325145319.1132072-1-johan@kernel.org/

I think handling this explicitly is preferred over reverting as
otherwise someone will just send the same conversion again later.

Johan
