From: =?UTF-8?B?xJDhurduZyBUcuG6p24gSGnhur91?=
        <dangtranhieu2012@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
Date: Wed, 26 Sep 2018 21:37:39 +0700
Message-ID: <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
 <20180925203701.13605-2-dangtranhieu2012@gmail.com> <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: robh@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>
> DT bindings should be sent to DT list.
>

DT bindings already sent to DT list, included here for completeness
sake. Of course, this is my first patch to the kernel so I might have
completely been wrong about the process. I can create another patch
set to send to correct list if necessary.

> On Tue, Sep 25, 2018 at 3:37 PM Hieu Tran Dang
> <dangtranhieu2012@gmail.com> wrote:
> >
> > This patch add fsl,allow-stalling property documentation for fsl-lpspi
> >
> > Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> > index 4af132606b37..2b012b8cb05e 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> > @@ -6,6 +6,8 @@ Required properties:
> >  - reg : address and length of the lpspi master registers
> >  - interrupts : lpspi interrupt
> >  - clocks : lpspi clock specifier
> > +- fsl,allow-stall : allow stalling of transfers when the transmit FIFO is empty
> > +  or when the receive FIFO is full
>
> This seems odd. That seems like what normal behavior should be.
>
> Rob

Default value of the register is to allow stalling (NOSTALL bit not
set) but the spi-fsl-lpspi driver defaults to setting the NOSTALL bit
in CFGR1. To me, it's more logical to leave the NOSTALL bit off with
fsl,nostall binding to set the bit but as I am not sure if there are
other drivers depending on the NOSTALL bit being set and not wanting
to break other drivers hence introduction of this binding to keep the
current default behavior.
