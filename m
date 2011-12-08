From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] spi: use gpio_request_one() instead of spi_gpio_alloc()
 helper function
Date: Thu, 8 Dec 2011 09:36:23 +0800
Message-ID: <CAF+7xWmnYsjM-mcx=2pvKavE6RAnLFv2Ey0N1+0_n46G3Km27w@mail.gmail.com>
References: <1323071447.20963.3.camel@phoenix> <20111207212109.GA1314@pengutronix.de>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Linus Walleij <linus.walleij@linaro.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111207212109.GA1314@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2011/12/8 Wolfram Sang <w.sang@pengutronix.de>:
> On Mon, Dec 05, 2011 at 03:50:47PM +0800, Axel Lin wrote:
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> This will make the driver depend on GPIOLIB, currently it depends only
> on GENERIC_GPIO. That needs to be addressed and made sure it won't cause
> a regression for the in-kernel users.
>
Ah. You are right.
GPIOLIB can be optional or not available at all in some
architecture/configurations.
Thanks for your review.

Axel
