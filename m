Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF01382F19;
	Mon, 16 Mar 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651480; cv=none; b=DEkIbWu9FGsrl+s2faK6RKkJQusHoDRSNSCQfVHJ3sKklLH54aN3J7ONnQDZjwTZ4d3k4mMeRO0UFHM1nGNen3b1XzVQY7QMLVsoY866JEAJcnWEi5U8/e0uss/P8uAu23PvxsVk8Vt5VNtRARBGeM15Eem771/JgKBfCr6I7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651480; c=relaxed/simple;
	bh=ZxsI3XQxON47nNiV9zmlJuSvAruAO15iYIHb6gCgR0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1F40bfrOTgKXDi0xami20G6yag/fD4O7b0B02soz0q6vCcbaiy38Llui63YAX4IcqxltSpwq0O+d/yGBzZzDKWmYEFjxopW9W4WkOwdXG2HVHDVSgxiSjph2jVjRhfY6YztLE9LfyJqAKt6940PaNXsqiPm4A3lW7yNnbVZjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=iXmIBcqU; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="iXmIBcqU"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 1F42D1FAAD;
	Mon, 16 Mar 2026 09:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1773651476;
	bh=5R8Z9Bm5xjSYnQuak4C93SINyY64xeZH1KNKR5DjkHc=; h=From:To:Subject;
	b=iXmIBcqUiLMFqcUu29xFNzqVO2Abxkv2Zv6NnbA6W9PCZCgj/ZHFV3lRlE87lhT1D
	 L2/4mkUsCsZFJFP1NfU717T4AGvQOahH31MMPETzVvpmYG5NuPfAG3jXl8zIpGappG
	 rAHopOTDKMPJjhQylONV451JeL1mrriO7zSa0ayPMLSNyrr8PATB73ESjt5vThH66M
	 xTTQjM01cMTrB4WnHY2Gk4cXgJFFat9HIowhO2jjLoopMZ1tGfRy9iEyhJ1eyQBGov
	 7KNjnzst1CkkTFHCBJGAJ3P/RxUdZawyRTlwdMLKq735hWZ9sE4Gs/WZ87R1SL2Jkg
	 bytpv65quvtkw==
Date: Mon, 16 Mar 2026 09:57:51 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: trivial-devices: add
 spi-miso-mosi-loopback
Message-ID: <20260316085751.GA23443@francesco-nb>
References: <20260316073547.11437-1-francesco@dolcini.it>
 <20260316073547.11437-2-francesco@dolcini.it>
 <bbfa2a62-7113-433b-91ad-0693ed6f8e36@kernel.org>
 <cde8671f-bb38-41d8-b27f-c54aa7242899@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde8671f-bb38-41d8-b27f-c54aa7242899@kernel.org>

Hello Krzysztof,
thanks for taking the time to answer this

On Mon, Mar 16, 2026 at 09:36:42AM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2026 09:35, Krzysztof Kozlowski wrote:
> > On 16/03/2026 08:35, Francesco Dolcini wrote:
> >> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>
> >> Add a compatible to describe a single wire loopback between SPI MISO and
> >> MOSI signals.
> >>
> >> Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
> >> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >> ---
> >>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> >> index a482aeadcd44..2cb973c157f6 100644
> >> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >> @@ -432,6 +432,8 @@ properties:
> >>            - socionext,uniphier-smpctrl
> >>              # SparkFun Qwiic Joystick (COM-15168) with i2c interface
> >>            - sparkfun,qwiic-joystick
> >> +            # Single wire loopback between SPI MISO and MOSI signals
> >> +          - spi-miso-mosi-loopback
> > 
> > If you decided to go against my approach, then at least document it in
> > proper place - incomplete-devices - so this won't be ever used in DTS.
> >
> 
> ... and then you will notice existing linux,spi-loopback-test, so
> explain the differences and why spi-loopback-test cannot be used for
> your loopback test.

Yes, this spi-loopback-test will work.

I was not aware of it (no-one mentioned it in the email thread I opened)
and I misread your answer as an alternative suggestion, and not as a nack.

There is still an open question, I can any driver probe/bind to the
actual SPI device? My plan, once this discussion is settled, is to send
patches to add dtso file enabling this test, however, according to
trivial-devices.yaml, I cannot submit such a DT file using
linux,spi-loopback-test as a compatible.

On the actual HW I have a pins header and a wire between MISO/MOSI.

I am clearly missing something obvious, any advise is appreciated.

Thanks,
Francesco

