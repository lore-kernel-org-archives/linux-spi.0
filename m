Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6433345A;
	Wed, 20 May 2026 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278854; cv=none; b=UbCB+tFnTSruKuPAFytOYOfK+uERkiLYiYk5LVXMpe5lcES56h3GQANqk4tvhJ5CSU844DKLLMjTldN09M9qd8Ud8JMKeowcC+eSI2v9Iep5po3wUD4nHnmltSjdTXeMSmTKb741dvmDUBtg/tlNu/OCER1giABh0gE1chyX2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278854; c=relaxed/simple;
	bh=anG98z+M4CGyffWaMQ47XSmDrV+He60zSFe5IokcnZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnlEWBHlB9pJ1VzVVf8GtV0tdMdpxhn4AdLiGOmvjtY+RSUrP+Whnik6pT6PG737Zqr4mIkrwCMR83alD/Yg9TSNOZdYYk6dH6cLvzvOQuIZM42NerUL55zJQNXGd4LMM3Aw6+sWrb5eRhclXF54jCK1hYVcMOGM5T8Q5TAWxfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjYUyx5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjYUyx5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ABB1F000E9;
	Wed, 20 May 2026 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779278853;
	bh=PL2Gy1SLLd7c7uyjJl89vc1E1IyawnW8r2RzziHU6Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjYUyx5P0LUi9EaMNlyMOFaCQIPPJKZrhI/WRQAyFzEqHADbYdGzZIv870jCcsiZ3
	 4hLg/vXO3cILluY1QfvPjM/RfNvtAJeuJGixKMaIev5zZQTLpvIgoTD2WrEsyIY7cW
	 O0oNlic10CWPWyCxbbGiqYisTChnrSisObIq2jmqReYDSrhaHdlKcHlFq2UChGMr4p
	 VlqYcoPpeDMIeOsonVW5S493uxxKNlnl/uDfDx3KuoAkeQfvsjOfk+RFNPXOj3EOWw
	 LnCcqRDphXc0RkiErVBOCYbiw3B7VUucFKpUARR86Xn/MZ6C2hUt9MBv26PDBWDVLp
	 x8o1pZ0v1WWNw==
Date: Wed, 20 May 2026 19:48:28 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: cdns,xspi: add sdma-io-width
Message-ID: <ag2fjCX0DuSVxubv@xhacker>
References: <20260511031732.3199-1-jszhang@kernel.org>
 <20260511031732.3199-2-jszhang@kernel.org>
 <20260515-expert-devious-cricket-faff56@quoll>
 <agz0kDsQBaeQPPQ4@xhacker>
 <21d30826-bfe6-44cd-8c89-c1986f539e48@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d30826-bfe6-44cd-8c89-c1986f539e48@kernel.org>

On Wed, May 20, 2026 at 09:09:55AM +0200, Krzysztof Kozlowski wrote:
> On 20/05/2026 01:38, Jisheng Zhang wrote:
> > On Fri, May 15, 2026 at 10:00:50AM +0200, Krzysztof Kozlowski wrote:
> >> On Mon, May 11, 2026 at 11:17:31AM +0800, Jisheng Zhang wrote:
> >>> The cdns xspi controller SDMA data port may support wider I/O width.
> >>> Wider I/O width can benefit performance. A simple test with QSPI nor
> >>> flash on one arm64 platform:
> >>>
> >>> 1 byte io width (default):
> >>>  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
> >>>  1000+0 records in
> >>>  1000+0 records out
> >>>  8192000 bytes (7.8MB) copied, 1.368735 seconds, 5.7MB/s
> >>>
> >>> 4 bytes io width:
> >>>  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
> >>>  1000+0 records in
> >>>  1000+0 records out
> >>>  8192000 bytes (7.8MB) copied, 1.088787 seconds, 7.2MB/s
> >>>
> >>> Improved by 26.3%!
> >>>
> >>> Add dt binding for sdma-io-width.
> >>>
> >>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> >>> index 38a5795589de..1fd4b6dfd417 100644
> >>> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> >>> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> >>> @@ -40,6 +40,12 @@ properties:
> >>>    interrupts:
> >>>      maxItems: 1
> >>>  
> >>> +  sdma-io-width:
> >>> +    description: Slave DMA data port I/O width (in bytes)
> >>
> >> Waht is SDMA? What is Slave DMA? The same?
> >>
> >> Why this cannot be deduced from the compatible? DMA is fixed per
> >> platform and SDMA do not sound like SPI device (so slave in older
> >> terminology) property.
> > 
> > in cdns xspi, sdma == slave dma. It can be read by any master, such
> > as DMA engine or CPU. Its purpose and usage is similar as the data
> > reg in other spi controllers, e.g the DW_SPI_DR in dw spi. 
> 
> You did not really answer the questions.
> 

If you mean "Why this cannot be deduced from the compatible?", I think
the slave dma port is part of the cdns xspi, so its io width belongs
to xSPI device property.
From another side, we have seen such property in other drivers such as
the reg-io-width for the dw spi DW_SPI_DR port io width.

Thanks
