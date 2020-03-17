From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 07/28] ARM: dts: pxa*: Fix up encoding of the /rtc
 interrupts property
Date: Tue, 17 Mar 2020 14:29:36 +0100
Message-ID: <20200317132936.GH24270@lunn.ch>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-8-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.k
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-8-lkundrak@v3.sk>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 17, 2020 at 10:39:01AM +0100, Lubomir Rintel wrote:
> This way the device tree validator learns that each cell of the property
> constitutes a separate item. Otherwise it gets unnecessairly upset:
> 
>   pxa168-aspenite.dt.yaml: rtc@d4010000: interrupts: [[5, 6]] is too short
>   pxa910-dkb.dt.yaml: rtc@d4010000: interrupts: [[5, 6]] is too short
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
