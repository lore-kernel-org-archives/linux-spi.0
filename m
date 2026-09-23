Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C041684A;
	Wed, 23 Sep 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160519; cv=pass; b=ixaL5zWITJIZcHhrRZ686yya8GBP57mjPXxlzd6/fypBwzjge4l9KEnmT6VoVwguplfRJGUb/ajD4kBJTxutXZJs8d8bI6WovDr85Jn9HHThXGqnJxf/7hchDSb2v3zB5JBCDWPMM5K0nUygUlbJrRu00mJr0cquS750Xt5QNbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160519; c=relaxed/simple;
	bh=6USXCJ+TFK5HPKJBb2vd1CUZCECFTg5/Q5Y1jGN9nIY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gjn2WBlEH4UQXUrPVeh5+IFo9UlWeHbluuDXy62mgUpwCybVeVyR+7Cl4Z1TZ77H486IkmMRTXxe25Ih+37inFO1F2Nd+5kJKMzvrj+ZU0JJQLQ+r5Ulfgqkj1Js2/wWRE3aHgcWgYXSNG+s33I4rKsKNTjfN5toxJqhwtrGvwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=FE9Wr6vB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="FE9Wr6vB"
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B34B720026F;
	Wed, 23 Sep 2026 12:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790160502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfi1sq/lUmbingAlK5XjuIYG1I+OGynmIw4U0E/U+wE=;
	b=FE9Wr6vBX+Q3QoL3NGRTmQBEpaej1nHtiDBEBEvP3fZTB7/LBdvHN9FxvMBdjJ+G5GTLCF
	cheU8gpViJ6yYHRc53hyT5EBoGcQYZ/Mo5g1tXmGPwSWO6P8rjDKdlEAD8UMyTTKs/XcJN
	wxiw+aUvKVBRKm0EPa+8VY2pn0R8OpcY6f7C6pzceEDo0VSQwi4YtGlyBA2Q65dmQXVYEb
	cWNFa8pWnQftC/KbCjQmc4u4SZG4xvjjrynDzK0tTBib0cqXVtm9Yb/pY7rfw3+f4v3YpH
	VZgZgV1tLEpr6uzczYJ2XTr007chNumNK+nnFgseGw8jFi/LaEukjoQlneZLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790160502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfi1sq/lUmbingAlK5XjuIYG1I+OGynmIw4U0E/U+wE=;
	b=FJEEgVijFXKjF/Ai6roXDlMl1YmMaKg1Nyu9+wyccbTUpmvUUeeA8umg3jzE4iQKsqMWwq
	s0MVE+R6JjYaHk9Y7vcHGDc3vRapifqRlRPbhqgHU7RqaIs8FVhMaDVx1FVRo4VAL/DB9G
	HZsDKcanNgT+2vvLjonlTFPY/5Z3rTCALkPtF5jQN99S9xmt6gbLUUAVqgL/qUmuDd9QRM
	Ax8Dxc7qSJOo5KO+TmyP3qzpzyllU2zYkE/TTFu6rBtRoopH4XTq2nrxZrpguyDnOkw0Br
	ZU6SygYjSQnYqTXGPg4eUdpxk7ipBZGzVaxWVFLA3pbrrpCuHhjX00Vp9xNW5A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790160502; a=rsa-sha256;
	cv=none;
	b=aaZOsF3jM6PxoO5Z1oz+/4occeCp5okG5mKb+L/ylfdQnCfjxIWS5MflNk2+L28hQAeWvB
	jg2gvDrF29h5QGp6cPSB5qNdO9OHvmsVjKwyI0mVDfmyyCiJUBoobIWPyQdosxtKKOUfER
	1/Y63l/Lt4vUfn4Ta56U4uRIWk0kzIyFG8PqHa6j79cM7divJ45eYiJ6iANnM9BqH8F3QF
	FKmuYpaRARRQI4272+CJxH+Zjvj9Af9uIrfyrJVApdcPCeVm6SjjoEsypUoFPfeWgkhEcz
	NW7s6a/OlrjxXMAi4D5e5SYD316n4cX47Ac7NdCC+4fp3fuK6/vsj3dfA65TZg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jre@pengutronix.de smtp.mailfrom=jre@pengutronix.de
Message-ID: <a086f141-6f71-475c-93e2-9a40372fba08@pengutronix.de>
Date: Wed, 23 Sep 2026 12:48:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] spi: spidev_test: send predictable data
From: Jonas Rebmann <jre@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
 <20260918-spi-sun4i-spidev_test-v4-6-5ffacb1a4ebd@pengutronix.de>
 <arJtEvBA-cM7FB0l@sirena.co.uk>
 <4a65c4f5-84fb-4014-955b-b5e8fc14d1de@pengutronix.de>
Content-Language: en-US
In-Reply-To: <4a65c4f5-84fb-4014-955b-b5e8fc14d1de@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-23 11:09, Jonas Rebmann wrote:
> On 2026-09-22 13:57, Mark Brown wrote:
>> On Fri, Sep 18, 2026 at 05:22:52PM +0200, Jonas Rebmann wrote:
>>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>>
>>> Introduce a flag to test on a predictable byte sequence instead of
>>> random bytes. This is useful when comparing multiple runs with the same
>>> option set e.g. with an oscilloscope.
>>
>>> +		case 'P':
>>> +			predictable = 1;
>>> +			input_choices++;
>>> +			break;
>>
>> -z doesn't increment input_choices, seems one of them is wrong.
> 
> -z requires -S and -S increments input_choices so -z indirectly
> conflicts -p, -i (--input), -t (--no-tx) and -P (--predictable)
> 

Ah, now I see it. In v5, input_choices++ is removed for -S. -P requires
-S, and should not conflict with it.

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
