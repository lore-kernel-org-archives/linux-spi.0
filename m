From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/28] spi: dt-bindings: spi-controller: Slaves have no
 address cells
Date: Thu, 19 Mar 2020 10:51:39 -0600
Message-ID: <CAL_JsqKMHyDeToZfHpkXEQySoUk=pM+B3+VrpkY4WO2hrJP6SQ@mail.gmail.com>
References: <20200317093922.20785-1-lkundrak@v3.sk> <20200317093922.20785-13-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
        Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>,
        Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        devicetree-u79uwXL29TZNg+MwTxZMZA@public.gmane.org
To: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317093922.20785-13-lkundrak-NGH9Lh4a5iE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 17, 2020 at 3:40 AM Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org> wrote:
>
> SPI controllers in slave mode have a single child node that has no
> address. Enforce #address-cells of zero instead of one.

Geert has fixed this making 'spi-slave' and '#address-cells' mutually exclusive.

https://lore.kernel.org/linux-devicetree/20200306085038.8111-2-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org/

Rob
