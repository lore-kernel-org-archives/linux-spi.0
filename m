From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 1/3] dt-bindings: spi: Add DT bindings for Synquacer
Date: Wed, 17 Jan 2018 15:30:53 +0530
Message-ID: <CABb+yY1QK16pNC4ajM+0M+R5yy28FNx+LYTuMQWj2c2ur9nC+Q@mail.gmail.com>
References: <1516021530-19236-1-git-send-email-jassisinghbrar@gmail.com>
 <1516021559-19327-1-git-send-email-jassisinghbrar@gmail.com>
 <CAL_JsqKM2OhdhFZfd_fhBkYiFE9Fdr38Xn7TKorwJo_-+f9xUg@mail.gmail.com>
 <CABb+yY3HEX6qMWxmirMnbwe3P5NwmUHGcuYypo-UzbUyUOi5UQ@mail.gmail.com> <CAL_JsqK16GXU0WQ2Ft2-_dHOH_y08inMjF8vHE4mhK0Zo9=JMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqK16GXU0WQ2Ft2-_dHOH_y08inMjF8vHE4mhK0Zo9=JMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 15, 2018 at 10:47 PM, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jan 15, 2018 at 9:53 AM, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Mon, Jan 15, 2018 at 8:45 PM, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> On Mon, Jan 15, 2018 at 7:05 AM,  <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>
>>>> This patch adds documentation for Device-Tree bindings for the
>>>> Socionext Synquacer spi driver.
>>>>
>>>> Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>> ---
>>>>  .../devicetree/bindings/spi/spi-synquacer.txt      | 24 ++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-synquacer.txt b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
>>>> new file mode 100644
>>>> index 0000000..d013cfd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
>>>> @@ -0,0 +1,24 @@
>>>> +* Socionext Synquacer HS-SPI bindings
>>>> +
>>>> +Required Properties:
>>>> +- compatible: should be "socionext,synquacer-spi"
>>>> +- reg: physical base address of the controller and length of memory mapped
>>>> +       region.
>>>> +- clocks: Must contain an entry for rate source clock(s).
>>>> +- clock-names: Shall be "iHCLK" or "iPCLK". iHCLK is preferred over iPCLK
>>>
>>> Huh? The clock binding should reflect all clocks connected to a block,
>>> not a selection of which one you want to use.
>>>
>> Both the clocks are internal to the block and derived from the same source.
>> Instead of defining a new "use-ipclk" property, the driver uses the
>> clock-names to choose the appropriate divider.
>> I am open to any better option.
>
> If one is preferred, then why not always use it? Or how does one
> decide which clock to use?
>
So I got my native speaker friend to interpret the Japanese datasheet.

The iHCLK clocks the whole block and can also be the source for
internal dividers. An external, optional, source iPCLK is also
provided for producing lower (Fpclk < Fhclk) rates from the dividers.
That is, iHCLK is always needed, while iPCLK can be provided if that
is to be fed to the dividers.

So the dt bindings should define one required clock (iHCLK) and
another optional clock (iPCLK). The driver would use iPCLK if
provided, otherwise the default iHCLK.

Will update DT and driver for next submission.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
