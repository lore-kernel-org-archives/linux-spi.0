Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AA390982;
	Mon, 16 Mar 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680168; cv=none; b=s7WIRLvjwPL4+c2RKBDn+YwaCuYe44RgnrZczYvr9qJwVXvnHVUoFu4RKKZqLczm06m+pDjlH1h2rO+otOTuEsibEHAXbxUGzpg18kucBQCuljAwSSvywYthGMgNZXM9xcKTRq61PWwvuDbdvQiHVW6u/6ug0Rl/UwHxmGvQCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680168; c=relaxed/simple;
	bh=HXdFbCFmM0I4exfloxptKO0VbCx6T+9FA4oPkwUoYSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/Uw+oZUDHk5OIwebAzVt7tdvPEeHDs/WSn0ca9GMq3eG7xkeNGP7EI62uEOBH95A5n3sagw7jjzyZaJ6Jd7GbzpCIo0cFGJuDBl3n75uvx6IJbO4mzrw2w68fShjBUzqNibhBOqjWfoRIaFm4btw3hUQHOvhK3OlqWmUUad55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhFuTEhg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhFuTEhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C13C19421;
	Mon, 16 Mar 2026 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773680167;
	bh=HXdFbCFmM0I4exfloxptKO0VbCx6T+9FA4oPkwUoYSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EhFuTEhgOTzf9+BK/w6J7I7fy3Gv4HVJ4rpbms03AocCnKAFr+4UgTCymnaaThQcj
	 Okku9IyAuGxfRrssByDamIcvAxE88GIQ2jufzbFWDv/+CqBHgK/F4riIWsBzjPQXuQ
	 9hGky2ZXxyTqoPcprjL/ZZ6yRBcHUnpzdQ35GrRwE29P27RIEimdX5lPLtibTiPKna
	 AjFZl5HUafkQS0BKIhpYMt2qRnl3GOhE2nJzIJ60R/uvELOh6YUQ0csn6CX/qkablV
	 reSDpLlQElmWYCY1nXfdbXXml+wo7N3k8Opx8rj/t4COP0W38Ew5V5RE8KZTkhCW1K
	 lQpAqV8phiIDg==
Message-ID: <a3796f8b-f94c-4d0d-a0b9-b2970e43e28d@kernel.org>
Date: Mon, 16 Mar 2026 17:56:02 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: trivial-devices: add
 spi-miso-mosi-loopback
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <20260316073547.11437-1-francesco@dolcini.it>
 <20260316073547.11437-2-francesco@dolcini.it>
 <bbfa2a62-7113-433b-91ad-0693ed6f8e36@kernel.org>
 <cde8671f-bb38-41d8-b27f-c54aa7242899@kernel.org>
 <20260316085751.GA23443@francesco-nb>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260316085751.GA23443@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/03/2026 09:57, Francesco Dolcini wrote:
> Hello Krzysztof,
> thanks for taking the time to answer this
> 
> On Mon, Mar 16, 2026 at 09:36:42AM +0100, Krzysztof Kozlowski wrote:
>> On 16/03/2026 09:35, Krzysztof Kozlowski wrote:
>>> On 16/03/2026 08:35, Francesco Dolcini wrote:
>>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>>
>>>> Add a compatible to describe a single wire loopback between SPI MISO and
>>>> MOSI signals.
>>>>
>>>> Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
>>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> index a482aeadcd44..2cb973c157f6 100644
>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> @@ -432,6 +432,8 @@ properties:
>>>>            - socionext,uniphier-smpctrl
>>>>              # SparkFun Qwiic Joystick (COM-15168) with i2c interface
>>>>            - sparkfun,qwiic-joystick
>>>> +            # Single wire loopback between SPI MISO and MOSI signals
>>>> +          - spi-miso-mosi-loopback
>>>
>>> If you decided to go against my approach, then at least document it in
>>> proper place - incomplete-devices - so this won't be ever used in DTS.
>>>
>>
>> ... and then you will notice existing linux,spi-loopback-test, so
>> explain the differences and why spi-loopback-test cannot be used for
>> your loopback test.
> 
> Yes, this spi-loopback-test will work.
> 
> I was not aware of it (no-one mentioned it in the email thread I opened)
> and I misread your answer as an alternative suggestion, and not as a nack.
> 
> There is still an open question, I can any driver probe/bind to the
> actual SPI device? My plan, once this discussion is settled, is to send
> patches to add dtso file enabling this test, however, according to
> trivial-devices.yaml, I cannot submit such a DT file using

I think you meant incomplete-devices and then yes, such DT upstream is
not allowed.

> linux,spi-loopback-test as a compatible.
> 
> On the actual HW I have a pins header and a wire between MISO/MOSI.

pins header, if I understood correctly what you are talking about, is a
connector. Connecting there a jumper to short circuit there is out of
scope, because it is not part of the board. Thus cannot be send upstream
DTS, unless it is really embedded in the design like USB-A dongles which
could not be removed by end user.

Otherwise you could say that every evalkit board can have such device,
because they all have pin headers...

> 
> I am clearly missing something obvious, any advise is appreciated.

Describe your hardware... Nothing in this patchset helps in
understanding it.

Best regards,
Krzysztof
