From: Chuanhong Guo <gch981213@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-binding: spi: add bindings for spi-ar934x
Date: Sat, 8 Feb 2020 17:36:57 +0800
Message-ID: <CAJsYDVJ3RfMh9MrMGsS=9=XayJjkatwnVa6DRjf6KmYp8JS9SQ@mail.gmail.com>
References: <20200206150626.708649-1-gch981213@gmail.com> <20200206150626.708649-3-gch981213@gmail.com>
 <20200206205551.GA15172@bogus> <CAJsYDVKXvAkQawwayX8JVrjvEKPuTyQXE8rw=BRiyVROKrdWrg@mail.gmail.com>
 <7f53a397-0237-4c68-e284-d92adf19c368@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f53a397-0237-4c68-e284-d92adf19c368@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Feb 8, 2020 at 7:54 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 2/6/20 9:55 PM, Chuanhong Guo wrote:
> > It's caused by "clocks = <&pll ATH79_CLK_AHB>" where ATH79_CLK_AHB
> > isn't defined without a include of dt-bindings/clock/ath79-clk.h
> > I'll replace this with a bogus "clocks = <&spi_clock>" instead in v3.
>
> You can include ath79-clk.h in your example, see for instance
> Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml

Oh. But I've already sent v3 out yesterday :(

I think this is just cosmetic changes and doesn't make much difference
so I'd like to keep v3 as-is now and if there are other comments for
me to send a v4 I'll change this one as well.

Regards,
Chuanhong Guo
