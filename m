Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2A490C04;
	Fri, 21 Aug 2026 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322772; cv=none; b=NybRQVcZfSZIHBJtO8nysOXXTWjjnyfYeDbazIGWAyCPueQMrmtQ+bY1TRiviITEVLYRcSXM3MfCubYaXAjcGFOU5mTAOn1kIX++u2R1q0+A7v/tQpJ/yq0xIdovETB25G638pJ3x+XS//SP+q5EAu+IR/FU7IBujC8VNL7NNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322772; c=relaxed/simple;
	bh=iRcnbV9hGlYZnFs8Eki+aLdR6g96W2/IRR/orOloAbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqP9BVIau4TWzI2HrH8LTx83XPHg9quwGF8rig3l5zM0avonfLYWtdSn3LoIVF/w2XGunAstjYfLsNtLu6jL2fF34hewyV4kV5fxUOH3zz8P5Mnaz/DnGrShC+COQv4qdZBT1gd7g85ArX2yQgJi6bKclR1drSQT40SmBkuRGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrroXicb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrroXicb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26BE1F00A3D;
	Fri, 21 Aug 2026 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787322762;
	bh=2mvKsLAIPDQ1FWM9H+6uBW4IbmAbbqkqN6qLfzHxG/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RrroXicbwpkt8uCkxYjuc4NpSqZYxB5p4sCUGOrRNJ8D4/FX2pqDQEGotsUCw79JD
	 hW6/8rVPDbgazoAUWHxM3bUx1SK8hdZdQiH1PqsWidFTguOR6S41WzRxRc2HIRaKbg
	 yK06MNxaGHV98nzqHO/AW8c75iiG7C6RDYBtTDcZYKCGaeoCzJubzkAvIPLeqT0lQG
	 zhdiaI97pZOHhjipxIHbrzvlre+Wk6sUQEWoSWALb8vLDzBqp9LaYA/B5a32y00usn
	 imxOkiR9iV96x/OJCIzp8u9hGa9Z9RqOO/ZDbbSJOqg2fpxg0TJ39smV8awqDaROJB
	 aOBpFcczDTPnw==
Date: Fri, 21 Aug 2026 09:32:42 -0500
From: Rob Herring <robh@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, krzk+dt@kernel.org,
	conor+dt@kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4] spi: dt-bindings: microchip,pic32mzda-spi: Convert to
 DT schema
Message-ID: <20260821143242.GA3830037-robh@kernel.org>
References: <20260814083221.34606-1-challauday369@gmail.com>
 <e7efc91b-9d8f-4344-982b-c2b5014985b6@sirena.org.uk>
 <20260814190759.GA2496807-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814190759.GA2496807-robh@kernel.org>

On Fri, Aug 14, 2026 at 02:07:59PM -0500, Rob Herring wrote:
> On Fri, Aug 14, 2026 at 03:54:55PM +0100, Mark Brown wrote:
> > On Fri, Aug 14, 2026 at 02:02:21PM +0530, Udaya Kiran Challa wrote:
> > > Convert Microchip PIC32 SPI controller devicetree binding
> > > from legacy text format to DT schema.
> > 
> > > +maintainers:
> > > +  - Mark Brown <broonie@kernel.org>
> > 
> > Try again!  :P  I think the DT people had some default they used for
> > cases like this, but ICBW?
> 
> I'm the default, but really I wonder if pic32 could just be dropped. No 
> commits from a Microchip person since 2016 on arch/mips/pic32 or 
> arch/mips/boot/dts/pic32. Almost all generic cleanups otherwise. These 
> chips appear to max out at 32MB (SiP) or 128MB DDR2. 
> 
> Perhaps I should send some AI patches against it...
> 
> There's this[1], but no updates in 5 years.
> 
> Arnd, Thomas, any thoughts on this platform?

Thomas agreed to be maintainer on IRC.

Rob
