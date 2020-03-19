From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 13/28] dt-bindings: serial: move Marvell compatible string
 to 8250 binding doc
Date: Thu, 19 Mar 2020 10:11:02 -0600
Message-ID: <CAL_Jsq+wG+DTZ8Vxcw=NR2isABGrkoDiBt-uG9+NF6qdWuU62Q@mail.gmail.com>
References: <20200317093922.20785-1-lkundrak@v3.sk> <20200317093922.20785-14-lkundrak@v3.sk>
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
In-Reply-To: <20200317093922.20785-14-lkundrak-NGH9Lh4a5iE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 17, 2020 at 3:40 AM Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org> wrote:
>
> These ports are compatible with NS8250 and handled by the same driver.
> Get rid of the extra document that fails to document the properties that
> are actually supported.
>
> Signed-off-by: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt        | 2 ++
>  Documentation/devicetree/bindings/serial/mrvl-serial.txt | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

I'd really like to see 8250.txt converted to schema.

Rob
