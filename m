From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Date: Thu, 25 Apr 2019 18:07:16 -0500
Message-ID: <CAL_JsqJDh3Z+iFn6fbkGT+jQ3HG2s4n3PT=LrmB-td++G99q_w@mail.gmail.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP"
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Julien Su <juliensu@mxic.com.tw>,
        Simon Horman <horms@verge.net.au>, zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 24, 2019 at 4:54 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>
> On 4/24/19 11:23 PM, Rob Herring wrote:
> > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> >>
> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >> ---
> >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> new file mode 100644
> >> index 0000000..668b822
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> @@ -0,0 +1,40 @@
> >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> >> +--------------------------------------------------
> >
> > Looks like a SPI flash controller from the example. What makes it an
> > MFD?
>
> It supports both SPI NOR and HyperFlash (CFI-compliant flash with
> different bus interface).

Not sure that really makes it an MFD. Lee probably has an opinion.

In any case, can we get a complete binding that shows both.

Rob
