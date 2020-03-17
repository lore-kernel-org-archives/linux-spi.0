From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 13/28] dt-bindings: serial: move Marvell compatible
 string to 8250 binding doc
Date: Tue, 17 Mar 2020 14:48:05 +0100
Message-ID: <20200317134805.GO24270@lunn.ch>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-14-lkundrak@v3.sk>
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
In-Reply-To: <20200317093922.20785-14-lkundrak@v3.sk>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 17, 2020 at 10:39:07AM +0100, Lubomir Rintel wrote:
> These ports are compatible with NS8250 and handled by the same driver.
> Get rid of the extra document that fails to document the properties that
> are actually supported.

Hi Lubmir

This is needs a bit closer examination. By the PXA maintainers. It
appears there are two serial drivers, the 8250 and a PXA specific
driver.

	Andrew
