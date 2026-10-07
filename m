Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC839989B;
	Wed,  7 Oct 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371299; cv=none; b=HIm9A4c39KzYWU+B4fcLcqMd1qABaH8fCcW0V4kEX5BIJ65uStBBi4uPaWEZTbd9zS6MKN3l1hiuNBCfoNNLxf+V1kcRqFtfH0PsKHCgGwfMHqcu6Jrb7wyVgfBYCS0SHYz5WlfrRXSKXxhTlMOCZIyIzf5wiWtfBwhw2YgZ9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371299; c=relaxed/simple;
	bh=DSbJymk0gWnbHQSC6y3Nu8rY3jbUnmfMMuuFYccMJW4=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:Mime-Version:
	 References:In-Reply-To; b=PPrQ03CU7bsPOc9IwvHhrZQO5rbu4ZtNKanNr+dy6Vuw7/kg2lqttJuCSzNL5b2HW1puem7dRZly/Ce/vvKNDaFqRfYHWq74PqcWbE6jzw1FhoKTqpi5J/6FUMNCuTP+IRdDr/osn1HiUniiY7RCnPeJt+CNstZWBNfPG2jy+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a60E6mMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a60E6mMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A101F0089B;
	Wed,  7 Oct 2026 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371273;
	bh=ljC43KL5RO/8GvoMWGmdRQIkkbtNDJ/LqKDfZGbJnxU=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=a60E6mMcl8fntzCQRmOmBRKfBDeabV70CNYzsGHBciez/NQ3b1bVxhS8JdrdVfqIZ
	 6SoRgXzJ8706+N+BlrYFH1ICCqdXzwH9eeSOrZmpjRT2fIhE5Mwneqru1wRCfOcmqO
	 lwH542in34SmGvSHEXDPKHjRhNjJNwM+7xvmQyiOzOz7+FOrqVQebmTiMAGkP44mIN
	 hOs1V0hmP2Z05+IjPatq7gb6G3jW0V9U3EFlDkUVA8cgjbpw4T29qOsOVf1IwWqn20
	 MunD7vdwxGBy+CBls7DTViSb+F5bVFWkbNJGh9IzJQBwo+8rJscWAbfCel3iWWN/ov
	 vr9mtpfVjS1ag==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 13:07:49 +0200
Message-Id: <DLYK485WJPQ8.349OCC3FOJNFL@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] pinctrl: mcp23s08: reject devices without match data
Cc: "Linus Walleij" <linusw@kernel.org>, "Kim Phillips"
 <kim.phillips@freescale.com>, "jiale yao" <19888972804@163.com>, "Mark
 Brown" <broonie@kernel.org>, <linux-spi@vger.kernel.org>, "Biju Das"
 <biju.das.jz@bp.renesas.com>, "linux-gpio@vger.kernel.org"
 <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, <ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260925133804.2231004-1-yaojiale02@163.com>
 <TY3PR01MB11346E0C01A9337A3AF4D97DC868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com> <34472b57.1961.1a0dd3dff12.Coremail.19888972804@163.com> <TY3PR01MB113461CE3C9EB4A175879F5BD868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com> <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com> <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com> <ar9WM0ZtDJD2H5Ii@ashevche-desk.local> <CAD++jL=eGjhCM8Xa=T08rPSGpH4p5dsajZa569gsObJma3yZ6g@mail.gmail.com> <ar-FDqxMC3F-zkPB@ashevche-desk.local> <CAD++jLnia-GyvS57-q2NOTWrqXWC12-HDbU6qsUiWEqOgTPX_Q@mail.gmail.com> <asILHNE0iDP2jVVR@ashevche-desk.local>
In-Reply-To: <asILHNE0iDP2jVVR@ashevche-desk.local>

On Sun Oct 4, 2026 at 10:15 AM CEST, Andy Shevchenko wrote:
> +Cc: Danilo
> (as you were involved in cleaning this up in the past and being co-mainta=
iner
>  of driver core)
>
> On Sun, Oct 04, 2026 at 01:06:07AM +0200, Linus Walleij wrote:
>> On Fri, Oct 2, 2026 at 12:19=E2=80=AFPM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Fri, Oct 02, 2026 at 11:52:41AM +0200, Linus Walleij wrote:
>> > > On Fri, Oct 2, 2026 at 8:59=E2=80=AFAM Andy Shevchenko
>
> ...
>
>> > > The entire name of the thing feels like debugfs-footgun
>> > > territory for example.
>> >
>> > Yeah, I can't find neither a thing on LWN.net nor in the in-tree docum=
entation.
>> > The only useful piece of information is (in kernel-doc of struct bus_t=
ype):
>> >
>> >   driver_override
>> >     Set to true if this bus supports the driver_override mechanism, wh=
ich
>> >     allows userspace to force a specific driver to bind to a device vi=
a a sysfs
>> >     attribute.
>>=20
>> This whole thing is weird, but OK.
>>=20
>> Since we have a ton of drivers depending on match data we either
>> have to patch them all to bail out if match data is NULL (like this
>> patch does) or, which is equivalent, opt out of driver_override
>> that much is certain.
>>=20
>> What I don't get is what this is intended for. What is the use case?
>> The commit says this is for VFIO. Shouldn't it be opt-in and turned
>> on only for VFIO then?

I think VFIO could use a different (less generic) mechanism that is more
integrated with the corresponding bus to e.g. allow userspace to decide to =
get a
PF bound to a VFIO driver for passthrough.

The existing driver_override is convinient for this case, but ideally we wa=
nt to
express that a driver can only be bound to the corresponding host and VFIO
drivers.

I think the situation for SPI is pretty similar.

Unfortunately, it is a uAPI already, so we can't really get rid of it.

But I agree that we should be more defensive about this and make it a drive=
r
opt-in. Uwe already prepared a patch for this [1].

[1] https://lore.kernel.org/driver-core/0f7446324f6a0c8f0153d6532d92a6eeecd=
6a308.1790612298.git.u.kleine-koenig@baylibre.com/
