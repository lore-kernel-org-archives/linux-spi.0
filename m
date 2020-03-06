From: Chuanhong Guo <gch981213@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
Date: Fri, 6 Mar 2020 16:38:57 +0800
Message-ID: <CAJsYDVK62jqkLimdZWbLE2wgEAuVi5HdY231nR_wPj4TiMtX9w@mail.gmail.com>
References: <20200228043636.559915-1-gch981213@gmail.com> <20200228043636.559915-4-gch981213@gmail.com>
 <20200303224706.GA22867@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200303224706.GA22867@bogus>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 4, 2020 at 6:47 AM Rob Herring <robh@kernel.org> wrote:
> > 3. replace binding example with a mt7629 one because this is the
> >    only one I know the interrupt assignment.
>
> That doesn't really matter. It would be less churn without that change
> and examples are just examples.
> [...]
> > -
> > -     flash@0 {
> > -             compatible = "jedec,spi-nor";
> > -             reg = <0>;
> > -     };
>
> Better to leave this in the example IMO.
>
> Rob

I'll revert example changes and add a dummy interrupt binding instead in v3.

-- 
Regards,
Chuanhong Guo
