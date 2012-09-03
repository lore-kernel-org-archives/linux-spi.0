From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi/pl022: Fix chipselects pointer computation
Date: Mon, 3 Sep 2012 11:11:14 +0200
Message-ID: <CACRpkdZ75s-yh5vzevbUPzhGbOj+mBNfJ+i68f5tH67oS4X__A@mail.gmail.com>
References: <1346660069-16049-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: shiraz.linux.kernel@gmail.com, aletes.xgr@gmail.com,
	grant.likely@secretlab.ca, rob.herring@calxeda.com,
	rob@landley.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	gabriel.fernandez@stericsson.com, lee.jones@linaro.org,
	viresh.kumar@linaro.org, sachin.verma@st.co
To: Roland Stigge <stigge@antcom.de>,
	broonie@opensource.wolfsonmicro.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346660069-16049-1-git-send-email-stigge@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 3, 2012 at 10:14 AM, Roland Stigge <stigge@antcom.de> wrote:

> The new chip select handling via GPIO introduced a pointer computation bug:
>
>         (int *) pl022 + sizeof(struct pl022)
>
> doesn't point to the data immediately after the actual struct pl022 (as was
> intended) but to a multiple of bytes after it because of the (int *) type.
>
> Replacing the kludgy pointer arithmetic with managed memory allocation for the
> chip selects.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this! And thanks to Shiraz for spotting the problem,
Mark you could add a:

Reported-by: Shiraz Hashim <shiraz.linux.kernel@gmail.com>

when applying this.

Yours,
Linus Walleij
