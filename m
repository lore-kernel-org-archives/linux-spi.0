Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE175809;
	Sun, 22 Mar 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774173674; cv=none; b=P/macuITlWVxgzZyRL4hAq+ssFFyAJdUE3FY9wA/j/n+721fiNBZ0Iz+s6OQa2s3bVwMqRVO7IjCuoP1IFYit9qegh/Pm47a5safdvlmfkBZsa6LTpOP6ZzYh3shfVxvMtlr2GXrklCzFHxrduE6k9T/cTcul6fHEgr5im4kgMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774173674; c=relaxed/simple;
	bh=izHFzYTNZF34lEla+82zrFLjgApuyM2q+I2Q/Xn97EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLDuwvCPdfvEIMwCyE+kSzgGKmoVLycB89MANblpoWdtuZ4rTBTYbviW+YYb8YGD/tZbOvcLOba+UAVoZKf7ZcZe/QpkqzdFzuFd69hY4BFKQ1VGlZqgRTE+ytvvB7jy6WMmegrMbLv6QDmB5af5gt3pcuRxjPpy63xtAhXlt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE4XY1so; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE4XY1so"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892ACC19424;
	Sun, 22 Mar 2026 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774173673;
	bh=izHFzYTNZF34lEla+82zrFLjgApuyM2q+I2Q/Xn97EE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NE4XY1souswN6Vh6RquKpO8B5zhT7O1nYa+mWIZpNXzzpT6PiTF0Qr33BU+JLOl/A
	 To/J1x7YctGVvVAbyz/+7AB5M4qtpAG7ubwEQRVmq+hnmXGCH7L4z56nApxrgVdHNs
	 fszQbqe8j+A7uL/5sOiKPnSPDmcZY2n/WWXYYnUeMyfgZVPXxoBhvVyHDyv8cC/jS0
	 KoWDamXstMz6KXy5U51UYycKQWSSIip+H21l5d9CgKgGIWjMyVs+oQKoR1dtBcnrnP
	 IqVN/Y/GuItLZ8RA5gwxDvGIkcbRut7lwNtRo4gdQzPXP841ibDO2SRnSo6cn7gkG2
	 MXedQvMswMhwA==
Message-ID: <d10e6de6-780e-42b1-9c53-915c73719b53@kernel.org>
Date: Sun, 22 Mar 2026 11:01:09 +0100
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
 <a3796f8b-f94c-4d0d-a0b9-b2970e43e28d@kernel.org>
 <abqzVJTb4TNxa8pZ@gaggiata.pivistrello.it>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <abqzVJTb4TNxa8pZ@gaggiata.pivistrello.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2026 15:14, Francesco Dolcini wrote:
> 
>>> linux,spi-loopback-test as a compatible.
>>>
>>> On the actual HW I have a pins header and a wire between MISO/MOSI.
>>
>> pins header, if I understood correctly what you are talking about, is a
>> connector. Connecting there a jumper to short circuit there is out of
>> scope, because it is not part of the board. Thus cannot be send upstream
>> DTS, unless it is really embedded in the design like USB-A dongles which
>> could not be removed by end user.
>>
>> Otherwise you could say that every evalkit board can have such device,
>> because they all have pin headers...
>>
>>>
>>> I am clearly missing something obvious, any advise is appreciated.
>>
>> Describe your hardware... Nothing in this patchset helps in
>> understanding it.
> 
> Let me describe the need first, and after that I'll describe the HW.
> 
> The need we have is to have a way, with Linux mainline kernel, to test the SPI
> functionality (subsystem, driver and the actual HW). So far this was
> done using the spidev out-of-tree and with a loopback between the SPI MOSI and
> MISO signals.
> 
> We have a variety of HW that have various signals available on some sort of
> connector or pins headers [1].
> 
> This https://docs.toradex.com/112710-mallow-carrier-board_back.png is just one
> example, I know you are familiar with this kind of HW, I am writing it here the
> link just for completness and for everyone else.

Looks like a specific device (hat), not a jumper connecting two pins on
the header.

> 
> So yes, your understanding is correct.
> 
> About the HW, we have various test boards, that plugs into this connector(s),
> as test fixture, and, with traces on the PCB, they do connect together the SPI
> MISO and MOSI signals.
> 
> Here a couple of picture as an example, of the "Aquila Lava HAT",
> https://gist.github.com/dolcini/33c332f0b2174a9d495baf7c79341abf
I don't think this is anyhow different than all existing cases of people
submitting spidev patches.

You can have only two choices:
1. Connector. You cannot send bindings for spidev or loopback claiming
it is a connector.

2. Actual device plugged there. You need specific compatible for this
actual device. The compatible cannot be used for anything else.

Best regards,
Krzysztof
