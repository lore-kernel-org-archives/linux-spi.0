From: Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
Date: Fri, 28 Feb 2020 15:16:08 +0530
Message-ID: <20200228094606.fyxtlutq2aajfyyo@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <CAMuHMdUGN8Yu6Tx0=OoLKzyOZ08fvjF6pEWi3ye02pr3Cgj=cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>, Sekhar Nori <nsekhar@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGN8Yu6Tx0=OoLKzyOZ08fvjF6pEWi3ye02pr3Cgj=cg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On 27/02/20 05:29PM, Geert Uytterhoeven wrote:
> Hi Pratyush,
> 
> On Wed, Feb 26, 2020 at 10:37 AM Pratyush Yadav <p.yadav@ti.com> wrote:
> > Allow spi devices to express DTR receive and transmit capabilities via
> > the properties "spi-rx-dtr" and "spi-tx-dtr".
> >
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > @@ -120,6 +120,11 @@ patternProperties:
> >          description:
> >            Delay, in microseconds, after a read transfer.
> >
> > +      spi-rx-dtr:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Device supports receiving in DTR mode.
> 
> Please explain "DTR" in the document, at least once, e.g.
> 
>     Double Transfer Rate (DTR).

Will do.
 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
Pratyush Yadav
Texas Instruments India

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
