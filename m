Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA544C6C
	for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886908; cv=none; b=QDnkSKpdFyoMlzayE7rA6JYmPmhZsu0jDUiRqLqq/wyoLjXrkx2AQIDMotAOrKl/DyxJCzfZGaE+ijaLw3JWDO6vxSBIExdQwJ40eZ9/nEDlkeXTt1iHP2UHgIO2JkOeCEtuT+iYLgqSGeXASgzmw0KuD78ozsRzf44WeEcG4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886908; c=relaxed/simple;
	bh=1jDHS3//SVF2/A/vC8oT6/lwq+kdzpM3dPjKRF+cWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HK/p89CDWkMB0VmAL40A52E16mP7q1v7GQE62RvylK9eY1Iil4/IsmiQxd9EqiM6EjQJrhWNXW88+NQgWiCqjrQYxMMHG0ytccfHyIXCc4s3CQPnjA04TFR42QfJ3mErWSPd0KgEMCHckoLTq8WMq9lH1CsAs9hyH6PhnWWH9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zpdr0WDS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zpdr0WDS"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba61a0a2d26so666355166b.2
        for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776886905; x=1777491705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=Zpdr0WDSPH2UORAAse2MbJK2x0kgjcL1DTTLEk5qDBJ0u+JD+xOc5hw0c7D46BkXQp
         iK/DmyryrYrayZ63JiynMG50VRHnTZXu8wmDAul1rsv1P0zb0v8tGrQOfhqKTjUG7foQ
         liivjnj1HbWqAa3gn2bt/QAhMlB4Yv4WdJIbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886905; x=1777491705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=CT0HMLprxoPYXbSzH7xtBi0WncHt2OJQB5xInifKsYfhIQVFxPqz1Fdof6KQXrUGHi
         9xFXFq41x4zlo0GkThAHQNlKA7ierGMLPSjVN2ugKKai6XVLhiVoUAhn/HjlHI9bh+oo
         oqLDWoUNtAM9T64i4gRBe8Nrw72iR9jgFGqDKLuEAWybTCfh3OtsMfvDroz+6UWOzgok
         R4T3dEyp8d7BLtm6Y+lsVKtY7vQs3Etpff1mKm+vvszIF/gxKz5lKHJzt1y1HoYKysUp
         Df9S+8YINyAQNUizz8fX8oEUoiC47iVRGohNDy7L4vxa4Yr9PxrlGY43mHZ4cpuPrV0r
         FNqA==
X-Forwarded-Encrypted: i=1; AFNElJ+r/fF8+JJ1b3Sh46GK3txVD1zXnaOAOgr5SPXHEsWyK8VBRqeQ/5H6s/ZGyljbCejvGvR/Fa4ktZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPW9iUSbS2uLEcGdzLFOHz8WrkFFe/TmMqMrechzbHnXzA/sSE
	/2A+pG0ZMJMfS6ndlc+zgubynnU7Lt8ilv+MgpqyA2AXBRPbBAxDuqNMiLNccZqki+O5QUf2svk
	FLJcpzcNu
X-Gm-Gg: AeBDiesIQCZIzpCnV1IRVjk3sB2gMTrYOz4sl0qg+cOsJUhEzmFGe2usQ2HteJy3otr
	5Qe77CDYwfsf/neqLuH4uytA1zSnYV2exLq+TyzyjaumexQ+UhgzcSvsY9NZeFwTXisrwuDlGiN
	qoMWplhgRGm29MSz68HpveDrnxwBlFLJtFgX5kgQnMAHBvJtk9C6jLw3dqOgUt6G8TqJx95b+9k
	B5AftRXL5qRkYKV8OxR87KPpaaR9mEilx20y4NIbj/PrKWFXjAVO7x5JrzZEYnKFLBDn9MNn7eB
	u3AKFOZJK4FtPFC+Jfs3jEWTzp7V8fBr4nZcwnuHJ4ZrqWw8kpoEaaSSNZSjIYLCkJwshDWNdKY
	X1TRGTNgNo0ws9v5kVonJPthhN8mgyXnj1njv1XON1qahsUz4ZKVjRpoY8vj8/L+qZKt8AKOPET
	WWivrZF1D/u79aXBsVOoAH+fgrFRQhgydyiTb7ytvFhKC9ufBYWzPyLkSLoOXyyCl6bg1P/MlG
X-Received: by 2002:a17:907:c588:b0:baa:8895:735d with SMTP id a640c23a62f3a-baa88957edcmr334544766b.0.1776886904729;
        Wed, 22 Apr 2026 12:41:44 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4519f0602sm588708666b.20.2026.04.22.12.41.44
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:41:44 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b941762394aso807501066b.1
        for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 12:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ru1T4BfqEoNuWEcRSjVFQY0rX7f9vR6bTFO12EjsYcZXAxM4jEzMHnszh42GsGmhggeOD0PQSl0o=@vger.kernel.org
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr122645615e9.27.1776886533988; Wed, 22 Apr 2026
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com> <aekg_IELc65BFrWp@ashevche-desk.local>
In-Reply-To: <aekg_IELc65BFrWp@ashevche-desk.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 12:35:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
X-Gm-Features: AQROBzBA2DSdR2HBaIYSKp4MrG-iWYSiPDxUw6OYCOPyJYNxN20LzPXgyZNheJI
Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Herve Codina <herve.codina@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com>=
 wrote:
>
> ...
>
> > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > >
> > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > of fwnode "flags" thread safe"), this must be changed to:
> > >
> > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > >
> > > With this change my DT overlays are working again.
> > >
> > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > from bit masks to bit numbers was probably not such a good idea,
> > > as it fails to catch missing conversions...
> >
> > Crud, I should have thought about that. :( Do you think it's worth it
> > to do a rename at this point to catch future problems?
>
> You can try locally with allyesconfig / allmodconfig and see the outcome.
> If there are missed cases, and their amount reasonably low, I won't bothe=
r
> in this case.

I believe I caught all of them at the time of my CL, but the problem
is in-flight stuff, right? I think the problem Geert is pointing out
isn't something I missed in my original patch but rather an
interaction between my patch and this in-flight patch.

> But for the future it's kinda rule of thumb to rename when
> semantics changed.

Noted. I've certainly done that before, but I didn't think about it in
this case.

-Doug
