Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620B233946;
	Wed, 20 May 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280579; cv=none; b=HeRSXaSPMiJzePenSt+IqItWlGJb05982YgImGChIbqv3jqYDjZNB+H+ZMNVuQl9BOj+fBQgpBJe4sehXdJ8bmMCjKrXiC7Jyrzv3Oh6qE3LMhP4POxz6THNMit5JapXv2TEtIbNvJ9O4xqYjaPt7I5E8LpvQQeUM4R+6GegbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280579; c=relaxed/simple;
	bh=nt8lCm2RpzOX/pBw+tRqEoSwrBELMRMCqGwCuE3SdTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jojHL6KtKBggvl6h+q3qTXF9i8eUsk2/Z698xeTgCodFLa/pcsi4vtFeEnI1yspMI2fTrH+b9yo2a7gGmYh+tO4SVVv3y+H9m8Xj9L6YKiziIUoZvaAq48DCzxuZymueYRgs/Tt+veOPr5seb0pbNbDAo08M8UBnWTRATvF/rHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpBHBZ8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpBHBZ8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC211F000E9;
	Wed, 20 May 2026 12:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280577;
	bh=RQPKtJS8Fb1xlnROffPpHMMEw16wTiSxp/gZlJ/z1B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EpBHBZ8/rYrJ1TwrxBe8JqYMbiirC3CAteLgOHOAOKonYznKJvDKeVYBeK2cwX/d/
	 Qegb0BXj2nIOtBYO4Jdx2/M2hXNvtenPbxosboqUgmJbSv39UJeIn0eUwDNS3kIA04
	 ZYpOlBblWAw25NFtyvge6fdpFZD3915VNN66q9b8R0+2kxXg/hovy4FU6PQ3Hc+KA5
	 BHKjC92f+FShK0pi50qlPA16TivsTEmhLrTD679vn1NWnFeOTdaRdaZxUk+sa2Z9bR
	 vACDnhg0RmRLkFfdkSzfzuqJQC9134o+olpxus7m1PN8NaTehQKEisxA2iD+LU/VPJ
	 lKf+t/zYorADA==
Date: Wed, 20 May 2026 20:17:07 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: cdns,xspi: add sdma-io-width
Message-ID: <ag2mQzz0tBQBmc4O@xhacker>
References: <20260511031732.3199-1-jszhang@kernel.org>
 <20260511031732.3199-2-jszhang@kernel.org>
 <20260515-expert-devious-cricket-faff56@quoll>
 <agz0kDsQBaeQPPQ4@xhacker>
 <21d30826-bfe6-44cd-8c89-c1986f539e48@kernel.org>
 <ag2fjCX0DuSVxubv@xhacker>
 <14719378-7bf5-4688-81e9-bccedf618d18@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14719378-7bf5-4688-81e9-bccedf618d18@kernel.org>

On Wed, May 20, 2026 at 02:16:21PM +0200, Krzysztof Kozlowski wrote:
> On 20/05/2026 13:48, Jisheng Zhang wrote:
> > On Wed, May 20, 2026 at 09:09:55AM +0200, Krzysztof Kozlowski wrote:
> >> On 20/05/2026 01:38, Jisheng Zhang wrote:
> >>> On Fri, May 15, 2026 at 10:00:50AM +0200, Krzysztof Kozlowski wrote:
> >>>> On Mon, May 11, 2026 at 11:17:31AM +0800, Jisheng Zhang wrote:
> >>>>> The cdns xspi controller SDMA data port may support wider I/O width.
> >>>>> Wider I/O width can benefit performance. A simple test with QSPI nor
> >>>>> flash on one arm64 platform:
> >>>>>
> >>>>> 1 byte io width (default):
> >>>>>  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
> >>>>>  1000+0 records in
> >>>>>  1000+0 records out
> >>>>>  8192000 bytes (7.8MB) copied, 1.368735 seconds, 5.7MB/s
> >>>>>
> >>>>> 4 bytes io width:
> >>>>>  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
> >>>>>  1000+0 records in
> >>>>>  1000+0 records out
> >>>>>  8192000 bytes (7.8MB) copied, 1.088787 seconds, 7.2MB/s
> >>>>>
> >>>>> Improved by 26.3%!
> >>>>>
> >>>>> Add dt binding for sdma-io-width.
> >>>>>
> >>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 6 ++++++
> >>>>>  1 file changed, 6 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> >>>>> index 38a5795589de..1fd4b6dfd417 100644
> >>>>> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> >>>>> @@ -40,6 +40,12 @@ properties:
> >>>>>    interrupts:
> >>>>>      maxItems: 1
> >>>>>  
> >>>>> +  sdma-io-width:
> >>>>> +    description: Slave DMA data port I/O width (in bytes)
> >>>>
> >>>> Waht is SDMA? What is Slave DMA? The same?
> >>>>
> >>>> Why this cannot be deduced from the compatible? DMA is fixed per
> >>>> platform and SDMA do not sound like SPI device (so slave in older
> >>>> terminology) property.
> >>>
> >>> in cdns xspi, sdma == slave dma. It can be read by any master, such
> >>> as DMA engine or CPU. Its purpose and usage is similar as the data
> >>> reg in other spi controllers, e.g the DW_SPI_DR in dw spi. 
> >>
> >> You did not really answer the questions.
> >>
> > 
> > If you mean "Why this cannot be deduced from the compatible?", I think
> > the slave dma port is part of the cdns xspi, so its io width belongs
> > to xSPI device property.
> > From another side, we have seen such property in other drivers such as
> > the reg-io-width for the dw spi DW_SPI_DR port io width.
> 
> So you mean it depends on SPI device? Then why spi-peripheral-props is

Nope, it depends on the spi controller itself.

> not applicable here?
> 
> If this is not bus width, but DMA-something, is not really then SPI
> device dependent, but rather DMA controller limitation, so either

The "sdma" name is a bit misleading but that's from the hw. It's
a data io port in fact. Any SPI controller has this data io reg or
port. It's not DMA controller at all. IMHO, what io width
may be supported is determined by the setting during IP configuration. 

So from this point of view, is it SPI controller property?

> deducible from compatible or something else is missing here.
> 
> Argument that some drivers do that is obviously wrong, so I am jumping
> there.
> 
> Best regards,
> Krzysztof
