Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1F33A9F5;
	Wed, 22 Apr 2026 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840480; cv=none; b=OLqCZp4uc6/X67ULTfQ+try07b4mFcAvtHAo/qkKFN5H2DNrL9LXjqmVd93xrpNipVx9dn/uFfX19bZ/qSbviLh9QhmtzJuUEXhVbFMdvrC3MWNh8R70OUu5IfRLezPhzzmTkyy8D9V06oyOOdFvqZT5aY28XJkWD4EKWtq/mJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840480; c=relaxed/simple;
	bh=eafGCTKjIPYyjzVPLcBhsv3fs5JULzlGRXa2ggj2ADc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovcpu7Si8BLu3wmf2xY/bPW0k1A/hsGIi1zQEpfxlysKb7ae4U4rX4bibpHmCoZz/ss2qDrurDF1dAIhrhl3vuZn6tyUHHNFT/GsgiBR6RWNlR4Eqo7E8LCNpAb7H08UqXqlJa/f6MPnHXO3jcXpgpeKjZ0BJvwHj3zcHc00+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFFmWLEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFFmWLEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8896C19425;
	Wed, 22 Apr 2026 06:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776840479;
	bh=eafGCTKjIPYyjzVPLcBhsv3fs5JULzlGRXa2ggj2ADc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFFmWLEPo3JBEQA9nL2BIMeF8phH2+YvY/dfIQZX+fwscHeztzRQNTRBaA8H7wqyQ
	 W/AGcAGqUg5PS5efpyKwzdQCv9Y5RKFtO+GYnymMSlB281Lu1r6nAsYX4AEz/kEpyp
	 wdx1GUjlwa83p2SGeqvMaQyRG3889fjjA+ZKsJ10XyFUThtIHyehROR3fbcDpB4oFB
	 cfKBNkPKC8982qsrRFwNJ+abUUBnfhvkSJWfn4pGmSCePzDN4KHi/yCpStrVXunvlx
	 WKWhoKammaKmnRHP6LalIrpw2+4cTwsFWepYkjmsO9tY3oPg8RbUTl1Wnha2o0zVfs
	 b9ELcISU0YDLw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFRNN-00000006aGN-1txm;
	Wed, 22 Apr 2026 08:47:57 +0200
Date: Wed, 22 Apr 2026 08:47:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: imx: fix runtime pm leak on probe deferral
Message-ID: <aehvHZMjwMNmru0x@hovoldconsulting.com>
References: <20260421125632.1537235-1-johan@kernel.org>
 <aehBYJ-R3bXB0RDo@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aehBYJ-R3bXB0RDo@lizhi-Precision-Tower-5810>

On Tue, Apr 21, 2026 at 11:32:48PM -0400, Frank Li wrote:
> On Tue, Apr 21, 2026 at 02:56:32PM +0200, Johan Hovold wrote:
> > Make sure to balance the runtime PM usage count before returning on
> > probe failure (e.g. probe deferral) so that the controller can be
> > suspended when a driver is later bound.
> >
> > Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
> > Cc: stable@vger.kernel.org	# 5.10
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/spi/spi-imx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index 4747899e0646..e5c907c45b87 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -2373,6 +2373,7 @@ static int spi_imx_probe(struct platform_device *pdev)
> >  out_runtime_pm_put:
> >  	pm_runtime_dont_use_autosuspend(spi_imx->dev);
> >  	pm_runtime_disable(spi_imx->dev);
> > +	pm_runtime_put_noidle(spi_imx->dev);
> 
> use devm_pm_runtime_get_noresume() and  devm_pm_runtime_enable() to
> fix this problem

No. The first helper you mentioned was only added a year ago and does
not even solve the issue without rewriting larger parts of the driver.

So that would need to be a separate change in any case.

Johan
