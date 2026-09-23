Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AA4779B1;
	Wed, 23 Sep 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154596; cv=pass; b=fk4DXxUm3Bkhi0yyxfg89FSr8JdsdkbeVfAl4+t9RfNw7FfmhSSBGLusUgRgmxIkKFpbi+TnULtpwhSYFdDC2KN3aI7i64xsBBuhtZzQwFOmj8rzHDlim14/NYx/loCY2AB13Xbng7K9Ee4ValYBlx9gaiyXjF7UUVATYpKxdFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154596; c=relaxed/simple;
	bh=Ay+AP1nlhEN6S/d+NGvT1HJhIsdKCEgutvSmj8PfSUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQNLt94G9tDM6UQ7GAuXkEeCzLFUR+AjwRPWI49Z20nECrMAHwa9eAozo51RvSLF7yxVps1OaolGZWghy2VfgJ18MstnygC7Hs4a8JuaSTuQEd54hlJEA0vDzNl4xGeL6imamqBs6/A5to1oNP5TEi+pzDVXkx2QbSG1S2YLL3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NDqmVgdK; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NDqmVgdK"
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 35B01200153;
	Wed, 23 Sep 2026 11:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790154584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsBsyrCOcL2emivXxD65PQExHl6GMyLi9qH3EWr/0SA=;
	b=NDqmVgdKws+3lRoAeW+4DNZnNmTsOhvfDpjPraSmGTfyqrkWtZj430yYqi25XceRLCu9gV
	bhhhYjZ+yw8mwyJRBm/LHJupPe4cHdMuNlryjlqQkHHJE3Nw/Vhf9r+9eBpVIqbkA01aZp
	J6AxcvGu8OLSQ0iWO/n95lucBK482t8XpFqNP2l8n9dRO9P4gUB26T9IYX1U6Ic8OMtboA
	vTvUG9Pq7F6av9+FSyYZtScypVA/Dz9xvund6/lYYGhbJICR5JGT9XQPFRghdNw6rrlavj
	morKroTWYknG90aSy+YvOdC78iUZVcVsd0TrLnpoxpipCLN0+Is7fKAKmwqBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790154584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsBsyrCOcL2emivXxD65PQExHl6GMyLi9qH3EWr/0SA=;
	b=PXrZ8paNPZqBHqmz3c7meRCBj8jfTXYcz/1oYnmkKqmi9D6EsuY3kBkhp7zv5SxClhZe3H
	etgZS36w5Tq4iOlt+7I/s+0acwvaoulKG1YynrDn6MQVTv0T7scXByK+d3cXIlizxukfvR
	xpxE2kMP72Ufhkp3nZZgPkyQsi8N44pxlpvdWgK4WcQ9tQ1TRczJowV7EKoaS7dZH3OCpI
	sKDpyAY3QaumCNqHWIToeqKyZuV5SQ88Lli33uyfizPeZiZODvjLRvAfxqcblwjXd06syR
	p/GXrxknuxNK+CO3wTjrs4k1/DoDoDyKl1Q9SPJfalk+yyAQxhG3egmmhybL9A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790154584; a=rsa-sha256;
	cv=none;
	b=aONw5u2GM/Nr/svamGPUKE8CKj3GpXkPefFTX4saLsZzbCX+VUmMZibYfIoxwAOPzTrDir
	P6gbrKEzOZMy2U4wx0zKpSSA0Z3/6QKWa6v9hPrX9jHIpU2tUIjZ5ZFFDbaTxDoSyM206/
	foQQISJ7bovydz5sat8kr03rBOvY9RyQzXp0A88aEe/sp5KpMRwcDDBgTenjrISFO29Y+9
	s8ZDQTq0NA+L3Ae8MB35DMIsxApuYT2YDd520MYS6wHZsyIJDNiD12XNh1m4dR8jd0SzM8
	yP8VH7XvyuwNqUUuGCJ8ARZ4XJTge87dKLvE/JYa3Y25HNOII8cCejBr6/LUEA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jre@pengutronix.de smtp.mailfrom=jre@pengutronix.de
Message-ID: <4a65c4f5-84fb-4014-955b-b5e8fc14d1de@pengutronix.de>
Date: Wed, 23 Sep 2026 11:09:43 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] spi: spidev_test: send predictable data
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
 <20260918-spi-sun4i-spidev_test-v4-6-5ffacb1a4ebd@pengutronix.de>
 <arJtEvBA-cM7FB0l@sirena.co.uk>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <arJtEvBA-cM7FB0l@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-22 13:57, Mark Brown wrote:
> On Fri, Sep 18, 2026 at 05:22:52PM +0200, Jonas Rebmann wrote:
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> Introduce a flag to test on a predictable byte sequence instead of
>> random bytes. This is useful when comparing multiple runs with the same
>> option set e.g. with an oscilloscope.
> 
>> +		case 'P':
>> +			predictable = 1;
>> +			input_choices++;
>> +			break;
> 
> -z doesn't increment input_choices, seems one of them is wrong.

-z requires -S and -S increments input_choices so -z indirectly
conflicts -p, -i (--input), -t (--no-tx) and -P (--predictable)

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
