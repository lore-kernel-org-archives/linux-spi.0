Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B033A9639;
	Tue, 19 May 2026 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235083; cv=none; b=IZLYd3ikoCyDTo6zHCjkrGN8c6GWrmZQNXzNJAxEMhIAGIR7+99x1PH1B86K9IKtBmCrUzB4rq+m/MM6hf/+oeP4tWJpm9Op/UHaqJsSt4UOK2swW+dGaJ27TDFqm0zX+MTOM6HM/GiNqjICjsI//jZDvfbTUjezHinHRKjN9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235083; c=relaxed/simple;
	bh=UZB2gJv7Eua3b6/ty7CAgxdUlu6EnBC5uRJW0JSUq2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRyIqNJsc/QrGlwJVPfrnGnkDDdAAZDhthXV+tiBapbtafu9sx7/dHIdAOp+2y1eXL8dAWfh3Fbb6uBhgnmGBYo9DDBiHHAQ7xaAO7fgxlsbcNJocCbpDl3yPIbewORPO6fkSJyImUx0MJUQctbxtgMB6sAGGq4GqrjOpmASGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKZRsj3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKZRsj3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1D41F000E9;
	Tue, 19 May 2026 23:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779235081;
	bh=biegBtBAJyaxEtr+wkxtFAFUiqS6ZZ0rr/349L/9430=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hKZRsj3Yq8Q4RT9ZRobhmqCflSngVRGEXwhq2TTwTCoKjcujnymtd813UZsyZymYT
	 Bg8Ie6wdejrCJnvvQxIVWel8jUvipcOVC4EEYAG4gvy71TMMULGwWTEBlapBRVxfzd
	 w6MkbnNZVGTv0TyOzmcUVX5EJa62PcmwlrkV7aepb/ObIftPJ3wukOuzHXGcH8GfsD
	 mMMDWh+RNlsQCcbLB+3va1ZgrAqJDXBrlA6H0oQ4ZAWNOqhaqmYScC5PVo97PbujTQ
	 OKDxZJYf+uXd7WjMN48kqVKmKufOsiw7YUMuPj9oQBaSu9JXql9YsWvAToRc5qTT80
	 NJd479zVhs92A==
Date: Wed, 20 May 2026 07:38:56 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: cdns,xspi: add sdma-io-width
Message-ID: <agz0kDsQBaeQPPQ4@xhacker>
References: <20260511031732.3199-1-jszhang@kernel.org>
 <20260511031732.3199-2-jszhang@kernel.org>
 <20260515-expert-devious-cricket-faff56@quoll>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-expert-devious-cricket-faff56@quoll>

On Fri, May 15, 2026 at 10:00:50AM +0200, Krzysztof Kozlowski wrote:
> On Mon, May 11, 2026 at 11:17:31AM +0800, Jisheng Zhang wrote:
> > The cdns xspi controller SDMA data port may support wider I/O width.
> > Wider I/O width can benefit performance. A simple test with QSPI nor
> > flash on one arm64 platform:
> > 
> > 1 byte io width (default):
> >  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
> >  1000+0 records in
> >  1000+0 records out
> >  8192000 bytes (7.8MB) copied, 1.368735 seconds, 5.7MB/s
> > 
> > 4 bytes io width:
> >  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
> >  1000+0 records in
> >  1000+0 records out
> >  8192000 bytes (7.8MB) copied, 1.088787 seconds, 7.2MB/s
> > 
> > Improved by 26.3%!
> > 
> > Add dt binding for sdma-io-width.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > index 38a5795589de..1fd4b6dfd417 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > @@ -40,6 +40,12 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >  
> > +  sdma-io-width:
> > +    description: Slave DMA data port I/O width (in bytes)
> 
> Waht is SDMA? What is Slave DMA? The same?
> 
> Why this cannot be deduced from the compatible? DMA is fixed per
> platform and SDMA do not sound like SPI device (so slave in older
> terminology) property.

in cdns xspi, sdma == slave dma. It can be read by any master, such
as DMA engine or CPU. Its purpose and usage is similar as the data
reg in other spi controllers, e.g the DW_SPI_DR in dw spi. 
> 
> Anyway, there is generic property reg-io-width if this is for MMIO,
> bus-width and spi-tx/rx-bus-width.

Indeed, spi dw driver uses reg-io-width to specify the io width which
is for accessing DW_SPI_DR. But I have one question: the "sdma" name
is from cdns xspi HW, I'm not sure whether reg-io-width is better. If
you prefer reg-io-width, I will do it in v2

Thanks
