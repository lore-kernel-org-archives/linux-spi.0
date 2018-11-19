From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
Date: Mon, 19 Nov 2018 15:10:09 +0100
Message-ID: <20181119151009.490413d9@bbrezillon>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
        <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
        <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 19 Nov 2018 14:49:31 +0100
Marek Vasut <marek.vasut@gmail.com> wrote:

> On 11/19/2018 11:01 AM, Mason Yang wrote:
> > Document the bindings used by the Renesas R-Car D3 RPC controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > new file mode 100644
> > index 0000000..8286cc8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > @@ -0,0 +1,33 @@
> > +Renesas R-Car D3 RPC controller Device Tree Bindings
> > +----------------------------------------------------
> > +
> > +Required properties:
> > +- compatible: should be "renesas,rpc-r8a77995"
> > +- #address-cells: should be 1
> > +- #size-cells: should be 0
> > +- reg: should contain 2 entries, one for the registers and one for the direct
> > +       mapping area
> > +- reg-names: should contain "rpc_regs" and "dirmap"
> > +- interrupts: interrupt line connected to the RPC SPI controller  
> 
> Do you also plan to support the RPC HF mode ? And if so, how would that
> look in the bindings ?

Not sure this approach is still accepted, but that's how we solved the
problem for the flexcom block [1].

[1]https://elixir.bootlin.com/linux/v4.20-rc3/source/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
