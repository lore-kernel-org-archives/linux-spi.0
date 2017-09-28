From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]" to
 the spi tree
Date: Thu, 28 Sep 2017 14:41:47 +0900
Message-ID: <CANqRtoQ7Q2xw5Z+mdhk8pJhx_d_PQFr-==4_YTWPK9sFfLKFuw@mail.gmail.com>
References: <CANqRtoQjvkm4rMXt6jEaVWBeieEzqzT-yw_oARV7sj-SpTxB6g@mail.gmail.com>
 <20170927170145.lseodaywmmuqvmcj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170927170145.lseodaywmmuqvmcj-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Thu, Sep 28, 2017 at 2:01 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Sep 27, 2017 at 02:36:01PM +0900, Magnus Damm wrote:
>> On Wed, Sep 27, 2017 at 2:30 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Mon, Sep 25, 2017 at 09:15:53PM +0200, Geert Uytterhoeven wrote:
>
>> >>   3. When updating DT bindings for new SoCs, we usually add "No driver
>> >>      update is needed" to the patch description to clarify. Unfortunately
>> >>      that was missed here.
>
>> > That's basically the same good practice thing, it's just documenting
>> > what you're trying to do here with not putting things in code but
>> > writing things in changelogs doesn't make them so!
>
>> My opinion that good practice is to document the per-driver supported
>> hardware by explicitly listing the per-SoC compat strings in the DT
>> binding document.
>
>> Then exactly which compat strings the driver matches on is really part
>> of the software implementation and it will most likely vary over time.
>
>> So my view is that only updating the DT binding document should be
>> enough in most cases when fall-back compat strings are used. I guess
>> other people see it differently?
>
>> Is it too much detail to let the MAINTAINERS file point out both
>> driver files and the DT binding files?
>
> It's supposed to do that already.  All I'm saying here is that the patch
> doesn't seem like something that needs actively reverting since it's a
> perfectly valid and even potentially useful change to make.

Thanks for clarifying the inclusion of DT bindings in the MAINTAINER
file. To escape any sort of conflict I will happily let you and Geert
discuss what is potentially useful or not! =)

Nevertheless I agree that reverting this rather harmless change seems
a bit overly aggressive.

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
