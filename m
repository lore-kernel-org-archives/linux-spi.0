Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42A39DBC9
	for <linux-spi@vger.kernel.org>; Sat,  3 Oct 2026 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068781; cv=none; b=JhziFkhsdYtvDqXgvl7aDuvWgZwtl2lvlCc/bBYvT4Oygr+Z+B29wb3lf+ORT70L278BUMo1HZYyBfG4eNto8ZtEFJ9DdgbxrPbAzu67rZ3sM9WsRUd4U1RMZy4lV5rmgpBWofFy8gU7EHCKbFMg/fELjirJdx2bIpAx2H7FJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068781; c=relaxed/simple;
	bh=80niw2N7lxvLTbY/N7Pl2CavNQXYd7wRoXm5V/EOgLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYQ4MBSggSK9G0UKbL2hT/DjLTmXrEnXOCW/VrMQRzqZqSnm/OqGRJk5I+ruCBlr9VpHSFhnX6CAw2SzfUHI5XCRRxPmB9pSIr6adVgng72tA5S3sD4+LHVSpJ+ocrj2RKy0qHF8yqAgMzDCOy9bb90ASY33lMAzn3Mi7JdhCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvCy7+T8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvCy7+T8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3A81F0089E
	for <linux-spi@vger.kernel.org>; Sat,  3 Oct 2026 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791068780;
	bh=XoMKQaijiXb6bV9K46MHf7KnOmtPSTWMU1bFRM5nW9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MvCy7+T8JrPxEODCa8NT+EA4IltXRP9i2JW3KPxAZNvqGvv7EwzqOPcDo4V4qowVQ
	 PpSnkxU1DsRHH2kzLL5pzA0FFnc/Uu/O4SEauzB7y9TuwCU/JI0YSBX5zHoUcSS6tF
	 cl9FA6+5viNJA/kkiBYOWxp7TLWecu3A23MBXc0lQdMgZ7A9uxIr7T+JIddwDe45uG
	 Q1zqVdZ1enmjVb+t0GxJ39ncQtHbtbo1mc4Lq5VQ3HFEIBNZNiVsSaTJRYi/E/Ssno
	 NlXMYqbJJdE9h2KBj1x+Z0x/+r8p+22hqoKw10L5nSp6q2LmcUIM8rDU9QtUGYO7dK
	 hwyJHec/XC9BA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a6497365beso11634061fa.1
        for <linux-spi@vger.kernel.org>; Sat, 03 Oct 2026 16:06:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy/eC0fuuJ38kkkQw+/Ypwagp4VFE9P0zUgR2g6R7vkIwpi6tM2R2KUwkHSI1ez0c+X5IRrvDwFvVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBqZs0hSrqwBZK1crEalNbV7Z0QTo07eKHnI0kOtAJYOgoYv4S
	M76BnfKDsHpBl73kTnpVr/I3daICaaP/ZPdK5moNVEys5EcXGovECSQtHeK19TQLaTM38VFx/Bg
	VRvI6lk7EF7T9xKv3ADizV8RG5Nj1fMM=
X-Received: by 2002:a2e:be2a:0:b0:3a7:812b:cfc with SMTP id
 38308e7fff4ca-3a974f44829mr8481631fa.14.1791068778934; Sat, 03 Oct 2026
 16:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925133804.2231004-1-yaojiale02@163.com> <TY3PR01MB11346E0C01A9337A3AF4D97DC868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <34472b57.1961.1a0dd3dff12.Coremail.19888972804@163.com> <TY3PR01MB113461CE3C9EB4A175879F5BD868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com> <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
 <ar9WM0ZtDJD2H5Ii@ashevche-desk.local> <CAD++jL=eGjhCM8Xa=T08rPSGpH4p5dsajZa569gsObJma3yZ6g@mail.gmail.com>
 <ar-FDqxMC3F-zkPB@ashevche-desk.local>
In-Reply-To: <ar-FDqxMC3F-zkPB@ashevche-desk.local>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 4 Oct 2026 01:06:07 +0200
X-Gmail-Original-Message-ID: <CAD++jLnia-GyvS57-q2NOTWrqXWC12-HDbU6qsUiWEqOgTPX_Q@mail.gmail.com>
X-Gm-Features: AclHuK-5AEJyRGaRQgwlbZwH8IWgs02BQM4XCc69kj2X4lPnBZkNjbek4q63et0
Message-ID: <CAD++jLnia-GyvS57-q2NOTWrqXWC12-HDbU6qsUiWEqOgTPX_Q@mail.gmail.com>
Subject: Re: RE: Re:RE: [PATCH] pinctrl: mcp23s08: reject devices without
 match data
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kim Phillips <kim.phillips@freescale.com>
Cc: jiale yao <19888972804@163.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 12:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Oct 02, 2026 at 11:52:41AM +0200, Linus Walleij wrote:
> > On Fri, Oct 2, 2026 at 8:59=E2=80=AFAM Andy Shevchenko

> > The entire name of the thing feels like debugfs-footgun
> > territory for example.
>
> Yeah, I can't find neither a thing on LWN.net nor in the in-tree document=
ation.
> The only useful piece of information is (in kernel-doc of struct bus_type=
):
>
>   driver_override
>     Set to true if this bus supports the driver_override mechanism, which
>     allows userspace to force a specific driver to bind to a device via a=
 sysfs
>     attribute.

This whole thing is weird, but OK.

Since we have a ton of drivers depending on match data we either
have to patch them all to bail out if match data is NULL (like this
patch does) or, which is equivalent, opt out of driver_override
that much is certain.

What I don't get is what this is intended for. What is the use case?
The commit says this is for VFIO. Shouldn't it be opt-in and turned
on only for VFIO then?

Kim Phillips is listed as contract for the platform bus driver_override
so let's ask! Kim: what is this for?

All of the device tree drivers use the platform bus, what's yhe
Unique Selling Point of this for our devices?

Yours,
Linus Walleij
