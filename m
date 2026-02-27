Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CD413223
	for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201485; cv=none; b=ddavUmmlhW4VMpx3NPCRqeYBYYaYp8EdUZWVNPr2/MBKioVCNU4+6tJTsD7VHt0VqEgMDANjWz1LoYCqXFBM7h7D297My1KPOJ2Ad0zsmqQC+b7tcNJwfeyZCb2y2DBF9r6wFLp4zXVfXqjRrx8RdJJyDXqfVm1ajqNeBhSs5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201485; c=relaxed/simple;
	bh=ShiqjwbVycNVDc/NOYYT7WllWbuKawKGkYhqIEShcUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWVz/YDhdJTkpb1VRZD/J7cY/ZJ4ppmpLpF4GvvYVhNDfh0ezcFoaRsXNIaRwCKGP7WqvEX205Jo/tL8xeeIOQIxRcWLoFKa/sBB1qLM76rZEq2hS6A98P97OjpOJI5kWrnt/BH4ddqYtu9Z1X5CfZiFLaDbMNgo/KqEq2vbu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjbJPicf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjbJPicf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8EAC19423
	for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201485;
	bh=ShiqjwbVycNVDc/NOYYT7WllWbuKawKGkYhqIEShcUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LjbJPicfTZrG9zq8p4ZRfbl4/SDr6MDB6YvJK4CvrYw1xUGm6WBB3Nlf+dW6mJ8k6
	 C/bdfYk7bAk/NlfGd0Dxz+YYbkiP2EYCqqciKRSzEEH4cWEQjiF/U4KxLeuFfhbOpG
	 pvyzHOhLfFUoR3mw+K2CQ++41PQhfSTcEfBpu8SGJvHDBIr+og5048RDwRgPFYsrDs
	 AQ9jb8ol1NxeqlFLk0Gf78MhmMITIqOqE6oCCCX9yNgkei8f8wOjbB9D9a/xOMzAzN
	 Se9NdmBS8ezQmEeeazWkRAdkqNtkpWyWlnuR1eMpHAbKlk84UkbbLQiwmOM5gPWUQF
	 TLsPeldJWa1Vw==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7927261a3acso17414367b3.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 06:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUr9LbR222KhB/9uXyRFBqOg5gvZprHBPEstw5/C/dJM4NmSe1FhLKDZim6SjXEEa7JErq24JNpzhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/xH+bRQ+xTKnv1X1uZcejZvIvrwreNjZRiXpO3LAUVMmDdjF
	BabhWPasP28XTyM46+4NMuh9rNEGSyi2HOZA90Se8fv8Q0tKS3kUGLplyrI9YX4Rl+OVSTOg7q5
	30ENEVv8VAwhpdXZ7ouRAi4RQ3U03tQU=
X-Received: by 2002:a05:690c:60c4:b0:798:6666:26bd with SMTP id
 00721157ae682-7988557f476mr30565677b3.37.1772201484696; Fri, 27 Feb 2026
 06:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-10-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-10-herve.codina@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Feb 2026 15:11:13 +0100
X-Gmail-Original-Message-ID: <CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
X-Gm-Features: AaiRm51ZxE6GtTyodhFmvZhWZO__2ijK76G9lNPmnmTqvkqKfSl89e994OIKOE4
Message-ID: <CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
Subject: Re: [PATCH v5 09/28] pinctrl: cs42l43: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
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

On Fri, Feb 27, 2026 at 2:57=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:

> The code set directly fwnode->dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Tell me if I should apply this directly to the pinctrl tree, right
now I'm under the impression that all patches need to go in
together?

Yours,
Linus Walleij
