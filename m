From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4] MXS: Implement DMA support into mxs-i2c
Date: Sun, 16 Sep 2012 11:44:25 -0300
Message-ID: <CAOMZO5AFHHOH7qwEfuxKfKCNdc4jwPk3Z8m8PxLKrwSKs=4tKw@mail.gmail.com>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
	<CAOMZO5CSvP3nXNq4VLYALh+U9OZRnjtgXqTr7zsKdeHpUdJ4cQ@mail.gmail.com>
	<20120916104436.GC933@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120916104436.GC933-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Wolfram,

On Sun, Sep 16, 2012 at 7:44 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

>> Tested-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> Thanks, may I ask what your tests were?

I used i2c-tools to read/write to an i2c at24 eeprom connected to my mx28evk.

Regards,

Fabio Estevam
