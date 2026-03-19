Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92C3F167F
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943197; cv=none; b=RshCG7DbqN48CEiLltmxmZu2h8um22ZxFswFkPqPoF7s02cKHTQEjZ2aISqCDGdDoIv+Sz253C2s+5sxzMtJU4DVNKXyjPM1xwS2jw7AS7MX3tc/hOsmNLNM9FpLLGZHnCNwtlAjJorPRPZPoXdOTrv1klYxGSBl/z5S2v1LCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943197; c=relaxed/simple;
	bh=1qiYzC4e4C5Osb7cyOfG+hx3gfnhgiG4CgnJdnnYqWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L820vr7GkOfO8qgEZxd0Wbq2KouZIpoEztudZREgUAx2bGXlQvLn26ktiKpIYEFEoR2onI/7s6Q6fswVauOa/zS9bVEkaWUVhzDqb01Mqk2U2wNQytXVh++qdqn5Tw4ixZ32u+IW45HpxbQhdGR9YRZGnL6he172Oh1DsTBuX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZcI4tmRH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZcI4tmRH"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38bf1561215so5762991fa.2
        for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773943194; x=1774547994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=ZcI4tmRHPcVWvRRnp6uZagIkAzjhTGLNnPae/yY1X7Sk+TnsRGmrY6GITMDxfn6py7
         oQQ8i1KgNkb11x2k+PuyfRonxvwwpT3mUqRP+DxKHl2gXV1ZO5dJ80F3bBTBShCdrk5Z
         6pCykLTGvHeV9v1hHe5q/DVmN+MioGigGACjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943194; x=1774547994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=KfxctuxSAn0g2sar7RcLrFdE3oPLtllY31PQE//Xp17BJNDE7bv7qt3po54KaBlL3T
         OF8zXyH0WMcJ9Tj2+6fuFQ9wnic5RdTHqbzhLEbQT3s7dLH6wmPHuTJ38SSJppTasCLR
         DU5GSB96mTQpoPczf+eR3sSPIqvCAYh4/+xLGqK44TyWD64X9lsj6/n66hZDOpXdt+FN
         C/HrbVpp2eeboLwJDxhjrNGNpjMKZvcQdFqPTziyodwbN9N5SHB4/ZQ2ELKLRT5M/NZO
         ItIDDu+GKEYxJdI6JB3Sh04+1JnuOS5gAczHCCCwVzoq+R7set0LqdnrPVm2jTcuu6YZ
         N8/g==
X-Forwarded-Encrypted: i=1; AJvYcCXlsAmSG49bGwAQ4DAwEy4ew5PBb4dPUOjXJg/zTLzZnWV1+M7To+bLzLSGUkCeBCjL98lrFYDkTgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFakZNS1kviwMusci6cs5J3c3cE2Q3Rb+F+TSXzidffSDwpnr
	LRrTCuB10B4PgbgranfVnJOZyX437V7Jl2bpchRH1bZb/1iXai8RJW3o0l4Wosqgsiixx0J73IO
	ZjDNLn8xF
X-Gm-Gg: ATEYQzwzmSYkyVlV51wEkS4u9z+wHoQ/emUIvSjFzf8XBWiFCWTUWXoMIPlcloanzrL
	oLN0UobGVYsYyjund52HVYDKoA2Bq2dpEf64OrUPwUANzf6BDCQQ/og3awpoGy+2oQhJLSxhK/0
	2YJwO57umD4Z/xb1K9XcWWzIqKXOWj6coqhbWgOek6D8v4Y8qkCxVXWPSgJOvKcPoqPtckyeL2r
	u4BbWwNjm1/waJXTHGrMQw7Jp2Rp+BrOWgM3QG54VkiZK52O4nYLXwRZ9PGUAzsHErI7LLrcr1p
	TnMMZcga2p0Hzko48wWu99/3j31HAIQ93l/EWVYKb7hHFGkOYefJGKyAYUAhXXwRiM46Wuu53j2
	HjJIIrg9HIsp68S5RqrhQ0WB4MV5Di7CbuvaY7wXeOVrRHRkXMroDGm2zM3RaOFJDa1SzBFSd5K
	WmzlMnu9sl443nWSfv5YW9x4BjCYoh6EdJDfoR7oHVWHZGYUhR3DkdHHdgrmid+v4RVv0Z8qTIh
	3Go
X-Received: by 2002:a05:651c:551:b0:38a:aba:9c0b with SMTP id 38308e7fff4ca-38bf972d34fmr1409461fa.27.1773943193701;
        Thu, 19 Mar 2026 10:59:53 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf972bbaasm505241fa.6.2026.03.19.10.59.53
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 10:59:53 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38bf1561215so5762881fa.2
        for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 10:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3Y38u6iYbLqtB38+iHpmPRRoNWL7Kh/gU1XON2zz5SUZtoUAqazYRmevvmfuAQf4nOzRsvU/fnzQ=@vger.kernel.org
X-Received: by 2002:a05:6000:18a6:b0:439:beee:43b5 with SMTP id
 ffacd0b85a97d-43b6423d90bmr470716f8f.3.1773942745211; Thu, 19 Mar 2026
 10:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
In-Reply-To: <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Mar 2026 10:52:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
X-Gm-Features: AaiRm51jE-pJGKyYKekSNJEdkSVtbmzl88hjmcc-VHWIT0EUhGVU2WYljuGhtW4
Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Saravana Kannan <saravanak@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kernel.=
org> wrote:
>
> On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > In various places in the kernel, we modify the fwnode "flags" member
> > by doing either:
> >   fwnode->flags |=3D SOME_FLAG;
> >   fwnode->flags &=3D ~SOME_FLAG;
> >
> > This type of modification is not thread-safe. If two threads are both
> > mucking with the flags at the same time then one can clobber the
> > other.
> >
> > While flags are often modified while under the "fwnode_link_lock",
> > this is not universally true.
> >
> > Create some accessor functions for setting, clearing, and testing the
> > FWNODE flags and move all users to these accessor functions. New
> > accessor functions use set_bit() and clear_bit(), which are
> > thread-safe.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > While this patch is not known for sure to fix any specific issues, it
> > seems possible that it could fix some rare problems. I'm currently
> > trying to track down a hard-to-reproduce heisenbug and one (currently
> > unproven) theory I had was that the fwnode flags could be getting
> > messed up like this. Even if turns out not to fix my heisenbug,
> > though, this seems like a worthwhile change to take.
>
> Reviewed-by: Saravana Kannan <saravanak@kernel.org>

Thanks for the review!


> Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> it here, I might be able to take a look at it too (no promises).

I don't _think_ it fixes my bug, but I'm still not 100% sure because
the bug can take a day or so to reproduce and it appears to only
reproduce on official kernels built by the builder. :( This makes it
hard to say anything for certain and also hard for me to inject extra
debug logic.

I did finally capture a ramdump of a device in the bad state and
managed to inspect the state of all the fwnode and fwnode_link
objects.

The problem (simplified) is that I have a pinctrl device:

  max77779_pinctrl {
    pin1: pin1 {
      ...;
    };
    pin2: pin2 {
      ...;
    };
  };

...and then a client of the pinctrl device:

  client1 {
    pinctrl-0 =3D <&pin1>;
    ...
  };

  client2 {
    pinctrl-0 =3D <&pin2>;
    ...
  };

At parse time, we get a link between the "client1" node and the "pin1"
node (and "client2" and "pin2").

In a normal boot (where the bug doesn't reproduce), when
max77779_pinctrl finishes probing, all of the links to its children
(which don't have a "dev" associated with them) get moved to point to
"max77779_pinctrl" (__fw_devlink_pickup_dangling_consumers).

When I detect the bug, the max77779_pinctrl device clearly has
finished probing, but the client devices still point to the child
nodes.

In the debugger, I can inspect things. I can see:
* The fwnodes for "pin1" and "pin2" clearly don't have a "dev" node.
They also don't have "FWNODE_FLAG_NOT_DEVICE" set.
* The fwnode for "max77779_pinctrl" clearly has a dev node (and a bus).
* The fwnodes for "pin1" and "pin2" show zero consumers.
* The fwnodes for "client1" and "client2" _do_ still show suppliers.
* When I look at the fwnode_link between the clients and the pins, the
"supplier" points to the node for the pin.
* When I look at the fwnode_link between the clients and the pins, the
"c_hook" is non-empty.
* When I look at the fwnode_link between the clients and the pins, the
"consumer" points to the node for the client.
* When I look at the fwnode_link between the clients and the pins, the
"s_hook" is an empty list (next =3D=3D prev).

It's a bit baffling because everything looks nice and consistent with
half the link being severed, which doesn't seem possible when looking
at the code. The code seems to always add to a consumer list and
supplier list at the same time and remove at the same time.

I've started to run out of ideas on how it could possibly get into
this state. If you have any, or want me to look at any other data
structures in the ramdump let me know.

-Doug
