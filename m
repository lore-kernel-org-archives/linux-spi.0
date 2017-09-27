From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]" to
 the spi tree
Date: Wed, 27 Sep 2017 14:36:01 +0900
Message-ID: <CANqRtoQjvkm4rMXt6jEaVWBeieEzqzT-yw_oARV7sj-SpTxB6g@mail.gmail.com>
References: <1506329660-4064-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <20170925161637.D7471440058@finisterre.ee.mobilebroadband>
 <CAMuHMdVsRwW+10ERyTJAa8XhhkPMn4ruymUwPKot+kmczBwbcA@mail.gmail.com>
 <20170925184545.5k4nke27rgud3uwp@sirena.org.uk> <CAMuHMdUv-5COUuzJOWx=BTb5oJ7tFOi1BpocuJ7+VuCZ3fEuPg@mail.gmail.com>
 <20170926173009.xdw6mtvcyixpenr7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170926173009.xdw6mtvcyixpenr7@sirena.org.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark, Geert, everyone,

On Wed, Sep 27, 2017 at 2:30 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 25, 2017 at 09:15:53PM +0200, Geert Uytterhoeven wrote:
>
>> My rebuttal is threefold:
>>   1. Listing the fallback property is mandatory for new SoCs. We only keep
>>      the per-SoC compatible values in the driver for older SoCs that predate
>>      the introduction of fallback properties.
>
> So good practice is always good practice, but I'd argue that it's not
> bad practice to also explicitly enumerate all the documented compatibles
> in the driver.  Being liberal in what you accept and all that.
>
>>   2. Some harm is involved, in the form of increased kernel image size.
>
> Is this really a meaningful impact?
>
>>   3. When updating DT bindings for new SoCs, we usually add "No driver
>>      update is needed" to the patch description to clarify. Unfortunately
>>      that was missed here.
>
> That's basically the same good practice thing, it's just documenting
> what you're trying to do here with not putting things in code but
> writing things in changelogs doesn't make them so!

My opinion that good practice is to document the per-driver supported
hardware by explicitly listing the per-SoC compat strings in the DT
binding document.

Then exactly which compat strings the driver matches on is really part
of the software implementation and it will most likely vary over time.

So my view is that only updating the DT binding document should be
enough in most cases when fall-back compat strings are used. I guess
other people see it differently?

Is it too much detail to let the MAINTAINERS file point out both
driver files and the DT binding files?

Cheers,

/ magnus
