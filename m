From: Denis Kuzmenko <linux@solonet.org.ua>
Subject: Re: [PATCH] spi: use gpio_request_one() instead of spi_gpio_alloc()
 helper function
Date: Tue, 06 Dec 2011 03:27:32 +0200
Message-ID: <4EDD6F84.6070901@solonet.org.ua>
References: <1323071447.20963.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
To: Axel Lin <axel.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323071447.20963.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/05/2011 09:50 AM, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/spi/spi-gpio.c |   21 ++++-----------------
>  1 files changed, 4 insertions(+), 17 deletions(-)

Acked-by: Denis Kuzmenko <linux@solonet.org.ua>

-- 
Best regards, Denis Kuzmenko.
