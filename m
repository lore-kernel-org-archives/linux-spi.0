Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC82391844
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661138; cv=none; b=mBSGWmwvLPOGqtGuvpyS5pQ6Lgy2HOJ9ZtPk0fg06ZKTi+SiBlwN10oRGkuuWRuXfmrDiR6lLtjD8wr6VwYQlOYi4zmzfybg0pwFABBKr1rDAj34GJgj1WV1oFlTm4xmN/a6yUmeh5qaKmab5KB9GPIQNx+Ctw4uAS6t9RmXDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661138; c=relaxed/simple;
	bh=pgh6I6+fJOk4/p27IgK8nfTWbSsmU/X8YFHAX/MuscQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaKnSEt7KqaAtZY2OB5RTPt+LmFiuDopPxVBLvDa84EMHeL980HDKTCIXAYgzF24GqaTfl4ClQ4MlyA8HgdIOV/weY3KQ0E/svFB+zTzGgt0ofd2s/dlRwNVIIKlmvlDFFN8Zbyto4EFj9UVD7eqQJImqdh0LqwtwW1gKy0pZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=jH6mBeqf; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="jH6mBeqf"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id xteQvakOgJ9SZxu8YvfoqF; Wed, 04 Mar 2026 21:52:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id xu8XvrI6nhoT4xu8XvJexd; Wed, 04 Mar 2026 21:52:09 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=69a8a989
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7vwVE5O1G3EA:10 a=qNABUOcEAAAA:8
 a=VwQbUJbxAAAA:8 a=890x73CVXr3K7iC5YPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Ytm653ucTKQjCvbzLygB:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AlPN44MPH2LF1tFFZ08jvAcXbS/jHkMFXGLwv6GykQk=; b=jH6mBeqfuHAtMEi4J8gM2Yx4rV
	hkNIzTGPP7TSiJByVtQhT+tCeAB7nDZ0UKrnhXXLxT/d429D0hlKiWdvUcqwBmiXYo3QBRO6TMODj
	XwuynUU3vWmlfQYVsYRTlpUurSi1EATGoIqyszTFO0ElolZqS3IMf9y5UNBUPRAUDbO0m0XEc5F+V
	sFqu2CX6HFYiG8HHZ8Kk0HbRPko0JxNcn6Ro3mGXhllt6BKQXLM0go7082qOI1gkBgoQUK3lwoqqb
	ogH/XCFRMxh8OcVhwgRbQ5wDEfx5er76Hnh8P3I95wVL15nJ+18XxYzYZKR19Eapeclp/WqCOZoo9
	XNywlfuA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:49388 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vxu8X-00000001U4z-1Nyl;
	Wed, 04 Mar 2026 14:52:09 -0700
Message-ID: <96e93ca0-ea10-4071-99ca-98f7219833d7@w6rz.net>
Date: Wed, 4 Mar 2026 13:52:08 -0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
To: Miquel Raynal <miquel.raynal@bootlin.com>, Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wsa+renesas@sang-engineering.com
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
 <aaL2WVO_7bl6vNp5@sirena.co.uk> <20260228-ragweed-theater-b02967937353@spud>
 <20260228-defuse-extenuate-cf2a90ae66ea@spud> <87tsuvh6iw.fsf@bootlin.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <87tsuvh6iw.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1vxu8X-00000001U4z-1Nyl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:49388
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB0meS8HM9qBOVWvvCn/G03L7QYWjixD0Jd1B4hyYYCxNhpRQ5EgSTfJoAwa4lXMJWvuvjnOB8wjLTuAeT6iNBnieh1wmt5AMRXGekDTcbNGRtJ1S4Y9
 ZVnozwj1oZ9wxoJgD5fT6D1TgMxHHW6bm24NG58QUH7B/pWGBVNRFwhEhqJ/WyPZJxJp9EBKGig29PLcEOspXpBFbAZUSa4QvBQ=

On 3/4/26 09:02, Miquel Raynal wrote:
> On 28/02/2026 at 15:39:01 GMT, Conor Dooley <conor@kernel.org> wrote:
>
>> On Sat, Feb 28, 2026 at 02:23:00PM +0000, Conor Dooley wrote:
>>> On Sat, Feb 28, 2026 at 02:06:17PM +0000, Mark Brown wrote:
>>>> On Sat, Feb 28, 2026 at 05:54:06AM -0800, Ron Economos wrote:
>>>>
>>>>> I'm getting an SPI failure with Linux v7.0-rc1 on the VisionFive 2 RISC-V board.
>>>>> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
>>>>> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: detected FIFO depth (1) different from config (256)
>>>>> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
>>>>> Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
>>>>> Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: operation failed with -110
>>>>> Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: probe with driver spi-nor failed with error -110
>>>> FWIW confirmed on my system:
>>>>
>>>>     https://lava.sirena.org.uk/scheduler/job/2504026#L715
>>>>
>>>> (which I didn't notice as that was just buildroot and not running
>>>> kselftest-dt...).
>>> This probably constitutes random speculation, but I am curious if
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> index 6e56e9d20bb06..390fa87edbaf8 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> @@ -873,9 +873,9 @@ qspi: spi@13010000 {
>>>   			      <0x0 0x21000000 0x0 0x400000>;
>>>   			interrupts = <25>;
>>>   			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>,
>>> -				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
>>> -				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
>>> -			clock-names = "ref", "ahb", "apb";
>>> +				 <&syscrg JH7110_SYSCLK_QSPI_APB>,
>>> +				 <&syscrg JH7110_SYSCLK_QSPI_AHB>;
>>> +			clock-names = "ref", "apb", "ahb";
>>>   			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
>>>   				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
>>>   				 <&syscrg JH7110_SYSRST_QSPI_REF>;
>>> has any impact. Going from jh7110 specific code to bulk apis is an
>>> ordering change, right?
>> According to Ron, it had no impact.
> The other change that could be "it" is the change of order between reset
> handling and clock. That would be quite messy if that was the error but
> I cannot find another explanation. Ron, can you please try to revert
> this patch locally and then move the clk_prepare_enable() of the APB and
> AHB clocks earlier, right after the ref clock is also enabled? If the
> platform fails to boot, there is maybe a weird internal relationship
> with the resets.
>
> Otherwise can you compare the clk_get_rate() on all three clocks in both
> cases?
>
> Thank you,
> Miquèl

I'm happy to help you debug this, but you have to send me a patch to the reverted file. I have no idea where the ref clock is enabled.

