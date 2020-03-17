From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 11/28] ARM: dts: berlin*: Fix up the SDHCI node names
Date: Tue, 17 Mar 2020 14:34:56 +0100
Message-ID: <20200317133456.GM24270@lunn.ch>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-12-lkundrak@v3.sk>
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
In-Reply-To: <20200317093922.20785-12-lkundrak@v3.sk>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 17, 2020 at 10:39:05AM +0100, Lubomir Rintel wrote:
> The node name preferred by mmc-controller.yaml binding spec is "mmc":
> 
>   berlin2-sony-nsz-gs7.dt.yaml: sdhci@ab0000: $nodename:0:
>       'sdhci@ab0000' does not match '^mmc(@.*)?$'
>   berlin2-sony-nsz-gs7.dt.yaml: sdhci@ab0800: $nodename:0:
>       'sdhci@ab0800' does not match '^mmc(@.*)?$'
>   berlin2-sony-nsz-gs7.dt.yaml: sdhci@ab1000: $nodename:0:
>       'sdhci@ab1000' does not match '^mmc(@.*)?$'
>   berlin2cd-google-chromecast.dt.yaml: sdhci@ab0000: $nodename:0:
>       'sdhci@ab0000' does not match '^mmc(@.*)?$'
>   berlin2cd-valve-steamlink.dt.yaml: sdhci@ab0000: $nodename:0:
>       'sdhci@ab0000' does not match '^mmc(@.*)?$'
>   berlin2q-marvell-dmp.dt.yaml: sdhci@ab0000: $nodename:0:
>       'sdhci@ab0000' does not match '^mmc(@.*)?$'
>   berlin2q-marvell-dmp.dt.yaml: sdhci@ab0800: $nodename:0:
>       'sdhci@ab0800' does not match '^mmc(@.*)?$'
>   berlin2q-marvell-dmp.dt.yaml: sdhci@ab1000: $nodename:0:
>       'sdhci@ab1000' does not match '^mmc(@.*)?$'
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
