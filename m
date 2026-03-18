Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9F39E184;
	Wed, 18 Mar 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843291; cv=none; b=JdICSZS+7SStxrbZFY99116ywpeIVM4jal3txCSajDbS8WKmAudThPunNzpwUHs2tUbsXFEF6qpSuaQ7ldyJ8yFlGx4A2n6lV+mywe/bEcwgmbszb2DWPQqGgmLRyDiZzJOwg9TE6fITqlhqRSVGv5tLOITGfOr4qFNN4LLUchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843291; c=relaxed/simple;
	bh=nJnO+nHuROOt9bxV9p3sgb3U2PCwDvkJeUITLSMqKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpub/KjE4M5kW0M3rJkzHhdEq7lcNAjxawPQBHbQ98xbnX9pD3qcTvAp+fJFa6HkVRtAPOCYnENG4E4gTa1wxzrzudfZq7ST27iQFaYlpGjzZAlFhXztncno+iuhFATJ9Z4Ywt3zV1uXK2vBr9FQRgyKTXLyBSyUBKf/+oaoOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GOtre5dG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GOtre5dG"
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1980F1FE0B;
	Wed, 18 Mar 2026 15:14:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1773843285;
	bh=/QtY4uteqozq4VaY4eoX3FFr3qESdHtk+Hmcb4iQwaI=;
	h=Received:From:To:Subject;
	b=GOtre5dGnJrY9U5IdpK1yadwta1I09F+su2N7ZRC8P3d17Ss2b/WASyhNhoGr+85Y
	 DIDTXmEFebQ+nnFl66jeXJzgTkLhx8GyvfLvEqybnvNph4cE/U+SUCdAxBsW47slGr
	 fhHM/WW0eBSKwpfIEsZKQ+wsl3i0aWvbzPVaZTtOTTUp59Oa/e3SPr/L9x/QQ+0Vrf
	 Bir/NCXjMyNX4Ga0sg3zPFpd65TEVnDZxDu+Y+mSjXT6a+Q2QWWC+Uw15VgVl+EkeT
	 fpC68UUYICrWHHxbGT/A9wDkOnrX13X6mnN2IXwyS5BtRjGEyF1SXePtVnG0ZXOe3P
	 ytclV43URu6AA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id B96497F86A; Wed, 18 Mar 2026 15:14:44 +0100 (CET)
Date: Wed, 18 Mar 2026 15:14:44 +0100
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
Message-ID: <abqzVJTb4TNxa8pZ@gaggiata.pivistrello.it>
References: <20260316073547.11437-1-francesco@dolcini.it>
 <20260316073547.11437-2-francesco@dolcini.it>
 <bbfa2a62-7113-433b-91ad-0693ed6f8e36@kernel.org>
 <cde8671f-bb38-41d8-b27f-c54aa7242899@kernel.org>
 <20260316085751.GA23443@francesco-nb>
 <a3796f8b-f94c-4d0d-a0b9-b2970e43e28d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3796f8b-f94c-4d0d-a0b9-b2970e43e28d@kernel.org>

Hello Krzysztof,

On Mon, Mar 16, 2026 at 05:56:02PM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2026 09:57, Francesco Dolcini wrote:
> > Hello Krzysztof,
> > thanks for taking the time to answer this
> > 
> > On Mon, Mar 16, 2026 at 09:36:42AM +0100, Krzysztof Kozlowski wrote:
> >> On 16/03/2026 09:35, Krzysztof Kozlowski wrote:
> >>> On 16/03/2026 08:35, Francesco Dolcini wrote:
> >>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>>>
> >>>> Add a compatible to describe a single wire loopback between SPI MISO and
> >>>> MOSI signals.
> >>>>
> >>>> Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
> >>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>>> index a482aeadcd44..2cb973c157f6 100644
> >>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>>> @@ -432,6 +432,8 @@ properties:
> >>>>            - socionext,uniphier-smpctrl
> >>>>              # SparkFun Qwiic Joystick (COM-15168) with i2c interface
> >>>>            - sparkfun,qwiic-joystick
> >>>> +            # Single wire loopback between SPI MISO and MOSI signals
> >>>> +          - spi-miso-mosi-loopback
> >>>
> >>> If you decided to go against my approach, then at least document it in
> >>> proper place - incomplete-devices - so this won't be ever used in DTS.
> >>>
> >>
> >> ... and then you will notice existing linux,spi-loopback-test, so
> >> explain the differences and why spi-loopback-test cannot be used for
> >> your loopback test.
> > 
> > Yes, this spi-loopback-test will work.
> > 
> > I was not aware of it (no-one mentioned it in the email thread I opened)
> > and I misread your answer as an alternative suggestion, and not as a nack.
> > 
> > There is still an open question, I can any driver probe/bind to the
> > actual SPI device? My plan, once this discussion is settled, is to send
> > patches to add dtso file enabling this test, however, according to
> > trivial-devices.yaml, I cannot submit such a DT file using
> 
> I think you meant incomplete-devices and then yes, such DT upstream is
> not allowed.

yes, thanks for correcting me.

> > linux,spi-loopback-test as a compatible.
> > 
> > On the actual HW I have a pins header and a wire between MISO/MOSI.
> 
> pins header, if I understood correctly what you are talking about, is a
> connector. Connecting there a jumper to short circuit there is out of
> scope, because it is not part of the board. Thus cannot be send upstream
> DTS, unless it is really embedded in the design like USB-A dongles which
> could not be removed by end user.
> 
> Otherwise you could say that every evalkit board can have such device,
> because they all have pin headers...
> 
> > 
> > I am clearly missing something obvious, any advise is appreciated.
> 
> Describe your hardware... Nothing in this patchset helps in
> understanding it.

Let me describe the need first, and after that I'll describe the HW.

The need we have is to have a way, with Linux mainline kernel, to test the SPI
functionality (subsystem, driver and the actual HW). So far this was
done using the spidev out-of-tree and with a loopback between the SPI MOSI and
MISO signals.

We have a variety of HW that have various signals available on some sort of
connector or pins headers [1].

This https://docs.toradex.com/112710-mallow-carrier-board_back.png is just one
example, I know you are familiar with this kind of HW, I am writing it here the
link just for completness and for everyone else.

So yes, your understanding is correct.

About the HW, we have various test boards, that plugs into this connector(s),
as test fixture, and, with traces on the PCB, they do connect together the SPI
MISO and MOSI signals.

Here a couple of picture as an example, of the "Aquila Lava HAT",
https://gist.github.com/dolcini/33c332f0b2174a9d495baf7c79341abf

Francesco

[1] https://en.wikipedia.org/wiki/Pin_header

