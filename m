Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D301586DB;
	Wed, 20 Nov 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093378; cv=none; b=UCQt8WIrp7DenC1+kK9UP/R8rYtgPHzZ2JXVF41vwHWlJ5kYmCNJcsLKjWYHj6js+5uSxOAywBENfAULXVTGjy+6FNnyg+0oze19VkzjYQ4gTWCdWb8175dPa81Bk7pKh/jxmrvl1IN7yIPcz8F0/sBUs/NNHbijAoyMUp/mIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093378; c=relaxed/simple;
	bh=dQuf6/yyA3NgGkcae5ZJw5+p5TYlDDaDSEx2Pobd1Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaLjkOH10PHO8U6/KY8o+eGN027QjqU1V2Y5CuaBaT8M1NWvo2171EYBNIil9P/CoPH0UKZC9y1yTZpQGKjjqmeGczXfykvVvcEVO/c0fjqzkSuWmluxBo3yACV4irmoxUTti0D+yFJbDY3ECMM1NeO4rzaa2i/TsiyLkc9jY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1tDgbU-00069z-00; Wed, 20 Nov 2024 10:02:28 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id EFA44C0110; Wed, 20 Nov 2024 10:02:16 +0100 (CET)
Date: Wed, 20 Nov 2024 10:02:16 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] mips: dts: realtek: Add SPI NAND controller
Message-ID: <Zz2lmMdaz6MFjrm6@alpha.franken.de>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
 <20241015225434.3970360-3-chris.packham@alliedtelesis.co.nz>
 <3c6f90bc-2223-447d-9094-81011a2815b0@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6f90bc-2223-447d-9094-81011a2815b0@alliedtelesis.co.nz>

On Wed, Nov 20, 2024 at 02:41:15AM +0000, Chris Packham wrote:
> Hi Thomas,
> 
> On 16/10/24 11:54, Chris Packham wrote:
> > Add the SPI-NAND controller on the RTL9300 family of devices. This
> > supports serial/dual/quad data width and DMA for read/program
> > operations.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> Has this one fallen through the cracks?
> 
> I see you picked up a couple of my other changes for 6.13 but this seems 
> to be missing from mips/linux.

hmm, I thought I saw some unresolved problems with the other patches...
But if this is all good, I'll add it to my second pull request.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
