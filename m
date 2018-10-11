From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP
 SPI Controller
Date: Thu, 11 Oct 2018 19:59:15 +0200
Message-ID: <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
         <20181010170936.316862-2-lkundrak@v3.sk>
         <20181011142719.GE25351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011142719.GE25351@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:
> On Wed, Oct 10, 2018 at 07:09:26PM +0200, Lubomir Rintel wrote:
> > This is the SPI controller found on Marvel MMP2 and perhaps more
> > platforms.
> 
> *Way* more.
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

Thanks for the response.

I'm a little confused here. Why I chose this subject line is because I
did this:

  git log --no-merges Documentation/devicetree/bindings/

to figure out what's the typical subject for the DT binding changes.

I also believed that's the right way to get Rob Herring's and Mark
Rutland's attention. Do the device tree binding documentation typically
go in with the associated drivers, or via their tree ("OPEN FIRMWARE
AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?

Lubo
