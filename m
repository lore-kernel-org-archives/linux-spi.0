Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7D37A48A
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643778; cv=none; b=r9q9rf4g3tZ+4j/PHBicf2+bF84XSFMHahiHCeVnHQhflZsE6/9koKDRcMbAyt3/srBPZgGZTR5j1b3dr3aJalatzWSi6QLJRjVfsJlncTMy40upIzwsO6/TMIzgYTJUbGEgIaWyXao22KCteHJ+XU1+XWtWh8pwIdW8oH74q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643778; c=relaxed/simple;
	bh=Bc/6F3bdD7m7nfmC9RaBxgjtd+2jzlmNfSBetD5HbHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CiP/w/b7m/jGdkCE9tVSLHZJmf9YI4tjWrCXb9ATdon81IK/Sj+H9JiKVsYERLl7WBEeSeZ8TI76QkxpBTApCAIIxorSdEMhClAOz1SeEoxQhxMyW4jVTdHbHqHpSYZCVVqSHq/yOT9VVNPcEMczXJToqOZfIREN+VytKyMx0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vlHbg9XW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vlHbg9XW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 61EA61A2CA1;
	Wed,  4 Mar 2026 17:02:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F80D5FF5C;
	Wed,  4 Mar 2026 17:02:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3E6F10369809;
	Wed,  4 Mar 2026 18:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772643772; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sODLPMYGQLwK7VG/qzqpYRuey9+fGjObXaGpaoPYVxA=;
	b=vlHbg9XWQISpg0A5b+4H8VkG3UaKYlL6eZtxbiRBCiQMh896b3mlEYG3TF7Hhr6tlPSWA9
	FBSKD1XiHVdbgZVsS09NT1gkvPZV+DJQ/4fUrSfrcJQNMuqK1b5DytMGsmtMfcz02oi4lM
	32ATO7UCJauYy4JyH/CY4wGJeMsaGh90VRzR9S70sNp7fEO5FpWtSvjQLG8kC0nTfrIJIE
	pCnuwBqOoqMgEI1Gh9aGAjdGQdzm0nW+TduPjXdiYymjFumKBWPvaTSEFnuQZ+Pd5mCGDI
	7lD6Tm/SlVbPRxng5/dkphat4okLKT1+AjNC4plqD4bTIm6OrDYl28cptnGKXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,  Ron Economos <re@w6rz.net>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org,  wsa+renesas@sang-engineering.com
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
In-Reply-To: <20260228-defuse-extenuate-cf2a90ae66ea@spud> (Conor Dooley's
	message of "Sat, 28 Feb 2026 15:39:01 +0000")
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
	<aaL2WVO_7bl6vNp5@sirena.co.uk>
	<20260228-ragweed-theater-b02967937353@spud>
	<20260228-defuse-extenuate-cf2a90ae66ea@spud>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 04 Mar 2026 18:02:47 +0100
Message-ID: <87tsuvh6iw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 28/02/2026 at 15:39:01 GMT, Conor Dooley <conor@kernel.org> wrote:

> On Sat, Feb 28, 2026 at 02:23:00PM +0000, Conor Dooley wrote:
>> On Sat, Feb 28, 2026 at 02:06:17PM +0000, Mark Brown wrote:
>> > On Sat, Feb 28, 2026 at 05:54:06AM -0800, Ron Economos wrote:
>> >=20
>> > > I'm getting an SPI failure with Linux v7.0-rc1 on the VisionFive 2 R=
ISC-V board.
>> >=20
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI i=
s still busy after 500ms timeout.
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: detect=
ed FIFO depth (1) different from config (256)
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI i=
s still busy after 500ms timeout.
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI i=
s still busy after 500ms timeout.
>> > > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: operation failed =
with -110
>> > > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: probe with driver=
 spi-nor failed with error -110
>> >=20
>> > FWIW confirmed on my system:
>> >=20
>> >    https://lava.sirena.org.uk/scheduler/job/2504026#L715
>> >=20
>> > (which I didn't notice as that was just buildroot and not running
>> > kselftest-dt...).
>>=20
>> This probably constitutes random speculation, but I am curious if
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/=
dts/starfive/jh7110.dtsi
>> index 6e56e9d20bb06..390fa87edbaf8 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -873,9 +873,9 @@ qspi: spi@13010000 {
>>  			      <0x0 0x21000000 0x0 0x400000>;
>>  			interrupts =3D <25>;
>>  			clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>,
>> -				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
>> -				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
>> -			clock-names =3D "ref", "ahb", "apb";
>> +				 <&syscrg JH7110_SYSCLK_QSPI_APB>,
>> +				 <&syscrg JH7110_SYSCLK_QSPI_AHB>;
>> +			clock-names =3D "ref", "apb", "ahb";
>>  			resets =3D <&syscrg JH7110_SYSRST_QSPI_APB>,
>>  				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
>>  				 <&syscrg JH7110_SYSRST_QSPI_REF>;
>> has any impact. Going from jh7110 specific code to bulk apis is an
>> ordering change, right?
>
> According to Ron, it had no impact.

The other change that could be "it" is the change of order between reset
handling and clock. That would be quite messy if that was the error but
I cannot find another explanation. Ron, can you please try to revert
this patch locally and then move the clk_prepare_enable() of the APB and
AHB clocks earlier, right after the ref clock is also enabled? If the
platform fails to boot, there is maybe a weird internal relationship
with the resets.

Otherwise can you compare the clk_get_rate() on all three clocks in both
cases?

Thank you,
Miqu=C3=A8l
