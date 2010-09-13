From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 5/5] spi: amba_pl022: Remove unused fields from pl022_config_chip
Date: Mon, 13 Sep 2010 15:22:16 +0200
Message-ID: <AANLkTimNnA=tNCE7pLiibwB66R86dNmCDpCuQMkTvw9J@mail.gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
	<1284135579-13578-6-git-send-email-wellsk40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, sameo@linux.intel.com,
	rabin.vincent@stericsson.com, srinidhi.kasagar@stericsson.com,
	linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
	u.kleine-koenig@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, tj@kernel.org,
	grant.likely@secretlab.ca, Lukasz.Baj@tieto.com,
	quentinyang05@gmail.com
To: wellsk40@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284135579-13578-6-git-send-email-wellsk40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/9/10  <wellsk40@gmail.com>:

> From: Kevin Wells <wellsk40@gmail.com>
>
> Some of the fields in the pl022_config_chip structure are no
> longer needed with the spi->mode updates. These fields have been
> removed.

I think you have to do a more thorough patch:

drivers/spi/amba-pl022.c: In function 'verify_controller_parameters':
drivers/spi/amba-pl022.c:1598: error: 'struct pl022_config_chip' has
no member named 'lbm'
drivers/spi/amba-pl022.c:1599: error: 'struct pl022_config_chip' has
no member named 'lbm'
drivers/spi/amba-pl022.c:1629: error: 'struct pl022_config_chip' has
no member named 'endian_rx'
(... etc)

Yours,
Linus Walleij
