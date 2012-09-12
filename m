From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Ack possibility for '[PATCH] SPI: OMAP: remove unnecessary
 includes of plat/clock.h' ?
Date: Wed, 12 Sep 2012 01:09:04 +0100
Message-ID: <CACxGe6u3Pi3S-C6GPw=c_CA6FMT6h3nArV-mJapnmjkGbud2Xw@mail.gmail.com>
References: <alpine.DEB.2.00.1209112333550.9444@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>,
	Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1209112333550.9444@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I'm still under water on patch review due to moving to the uk. Mark
Brown is covering for me on spi.

It is a trivial change though. go ahead and merge it.

g.

On Wed, Sep 12, 2012 at 12:44 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Grant,
>
> was wondering if you might be willing to ack this patch so we can merge it
> via OMAP:
>
>     http://marc.info/?l=linux-omap&m=134740630311140&w=2
>
> Just noticed we have a dependency on that patch for some common clock
> framework conversion patches also...
>
>
> - Paul



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
