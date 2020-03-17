From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 00/28] DT: Improve validation for Marvell SoCs
Date: Tue, 17 Mar 2020 14:46:09 +0100
Message-ID: <20200317134609.GN24270@lunn.ch>
References: <20200317093922.20785-1-lkundrak@v3.sk>
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
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 17, 2020 at 10:38:54AM +0100, Lubomir Rintel wrote:
> Hello World,

Yah, that is an issue here. Marvell have a few different SoC families,
each with there own maintainers. Gregory and I tend to look after
'mvebu', aka orion5x, kirkwood, dove, berlin and a few others. All the
others are 'Somebody elses' problem'.

How do you think this patchset should get merged? Are we going to
split it up, just nominate one maintainer to merge the lot, or go
direct to arm-soc?

       Andrew
