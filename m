Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113E22A817;
	Tue, 21 Apr 2026 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765574; cv=none; b=kxpDqY2eVpMyEFTi9mkxZDP8ZEkyP9BkQZPHwyw70s8qdl7NmPOdoqWLrGPU567en18J70Hdy000Xem+xy+WmtbIKPEYy6sMJY8S1DMEVj0BV9QIOfmaQszxIqCMWlLotgJBP+VpPkuZM7RN5kOuD+q5iHDbc31E4F3BwEcCUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765574; c=relaxed/simple;
	bh=sKtyrteZJgvCCnklzRYFosHDZvmfn64hrzbTWMyPfKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5lDMVsPbOyNyUNVBU5dOlQsPEFM6sRcQuUUohdWuNM5K+JNQ3vaYV7CqVRyrYvuVioLGLVlY8CFAQH2iPjjZ/29j0mTKvKFTzogxFXGRW4hmSdfB3P0Piu8LINHojvgflRz/MQpKO/2dqNcjIyRn6CbWw7w9+IZPfM/CdTnHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=IGWus0wE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="IGWus0wE"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id D23AD1FE08;
	Tue, 21 Apr 2026 11:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1776765570;
	bh=+IwY92cjmE5SgCVBWShBef7TAkSiabbLUQr08gqaxMQ=; h=From:To:Subject;
	b=IGWus0wEXK5yY8NRhVXDviJuFDsNdfWcu5O/qUU4ZgI1lixIK4Exfk6NK3ZsfEpKB
	 aQH1SWCPm2OMzPL7OwbFP6ySm9VZEzQq9PZcux8z0q2pJ/lhlVtYOmQ+2JJzOTD/pa
	 hSoJqEDzgoN0zBcgLuO7/3+n64xMW/DXpRG7+CyVZHSTjY/IgFdgrNGSSx5Ykc1PAa
	 +f8aR9orQN+HUKcZGn/6+RSLN47IDX0i1iQr+K7178s8W/y/rxcvdAgmyUrFLGlkFH
	 dHO6ebUiJxO/Y+/K2yTw+uPdlIi01xDkuzZvyPeXy90bIHjMxGWxIVO6UCFJvpMxg1
	 xim5hDhpvjrYw==
Date: Tue, 21 Apr 2026 11:59:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: trivial-devices: add
 toradex,lava-hat-spi
Message-ID: <20260421095928.GB23508@francesco-nb>
References: <20260420114537.78160-1-francesco@dolcini.it>
 <20260420114537.78160-2-francesco@dolcini.it>
 <20260420-task-navy-370ea247fe1d@spud>
 <005d96ea-b250-4af8-9c5b-d145bae892e5@kernel.org>
 <20260421083843.GA23508@francesco-nb>
 <eb1ae818-eb9c-4225-9969-ebbb05304697@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb1ae818-eb9c-4225-9969-ebbb05304697@kernel.org>

On Tue, Apr 21, 2026 at 10:46:55AM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2026 10:38, Francesco Dolcini wrote:
> > On Mon, Apr 20, 2026 at 06:10:08PM +0200, Krzysztof Kozlowski wrote:
> >> On 20/04/2026 18:02, Conor Dooley wrote:
> >>> On Mon, Apr 20, 2026 at 01:45:35PM +0200, Francesco Dolcini wrote:
> >>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>>>
> >>>> Add a compatible string for the SPI loopback device present on the
> >>>> Toradex LAVA HAT test fixture.
> >>>>
> >>>> The Toradex LAVA HAT is a board used for automated hardware-in-the-loop
> >>>> (HIL) testing, it provides several test-related functionalities, and
> >>>> exists in multiple variants depending on the board it is mated with. The
> >>>> SPI function is implemented with a loopback on the MISO/MOSI signals.
> >>>>
> >>>> As the device can be fully described using only "compatible" and "reg",
> >>>> it is appropriate to list it under trivial-devices.yaml rather than
> >>>> introducing a dedicated binding.
> >>>>
> >>>> The SPI implementation is identical across all Toradex LAVA HAT
> >>>> variants, so a single compatible string is sufficient.
> >>>>
> >>>> Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
> >>>> Link: https://lore.kernel.org/all/20260316073547.11437-3-francesco@dolcini.it/
> >>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>>
> >>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >>> pw-bot: not-applicable
> >>
> >>
> >> Heh, let's wait. That's a test device, so it won't be ever used in any
> >> final product, right? So not in final DTS?
> > 
> > It will be used in various DT overlay, that I plan to send for
> > inclusion in mainline Linux kernel once we have a way forward. So yes,
> > there will be DTB files using it.
> 
> Then you need to document it properly and post the DTS.

Ok, I will.

I can also post the DTS in the next version. In general, my
understanding is that so far when sending a patch to add new compatible
you wanted to see a user of it, whatever is a driver or a DTS file.
Given we have a driver change for this in this series, I assumed it was
ok to not send also a DT file.

> Toradex LAVA hat is way too generic. No, single compatible string is not
> sufficient, please read writing bindings.
> 
> Please define exact model and variants.
> 
> > 
> > The need is to be able to test SPI with a mainline Linux kernel, so I am
> > looking for a solution that works in mainline Linux.
> 
> incomplete devices do not stop you from that.

Do this sentence means that I can send a DT file for inclusion in the
Linux kernel using a compatible documented in incomplete-devices?

> But you don't get exceptions because you want to mainline your DTS. Your
> need detailed hardware description and precise compatible per each exact
> hat ("exists in multiple variants").

Let me get into more details here, before sending a new patch version.

We have various LAVA HAT devices, the difference is that they provide
different features and a different layout, based on the actual carrier
board they are mated with.

We have an "Aquila LAVA HAT", that can be mated with the "Aquila
Development Board", and a "Verdin LAVA HAT", that can be mated with a
"Verdin Dahlia Board".

As an example, you can find the Verdin Dahlia DTS here,
ti/k3-am625-verdin-wifi-dahlia.dts, that can be mated with the "Verdin
LAVA HAT".

The SPI device on both "Aquila LAVA HAT" and "Verdin LAVA HAT", is the
same, no differences. On the Aquila variant we
have two instances of it, while on the Verdin we have only one instance
of it.

So, would we need a compatible like this? 

compatible = "toradex,aquila-lava-hat-spi", "toradex,lava-hat-spi";

or

compatible = "toradex,verdin-lava-hat-spi", "toradex,lava-hat-spi";

The actual implementation on both the HW devices is the same, so the
driver can just probe on "toradex,lava-hat-spi".

Thanks
Francesco

