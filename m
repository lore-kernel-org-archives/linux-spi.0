From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v8 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Thu, 30 Jan 2020 11:41:52 +0800
Message-ID: <0f079cf6-c146-8941-5bdd-f978ff3455ab@linux.intel.com>
References: <20200129072455.35807-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200129072455.35807-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qszwQ5sJw4G_fM5vKjYu24xs03CuW371gyFE4G0hNJHdXw@mail.gmail.com>
 <abaae0fa-c2b8-bbe0-b64d-0ee4c95c1479@linux.intel.com>
 <CAAh8qsxRPx8KDyqvp=8zcrGCE82YJ_9O9cJXrgKdH7VwXeGQgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Dinh Nguyen <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Tien-Fong Chee <tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAh8qsxRPx8KDyqvp=8zcrGCE82YJ_9O9cJXrgKdH7VwXeGQgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Simon,

On 29/1/2020 8:01 PM, Simon Goldschmidt wrote:
> + some people possibly interested in this for the Altera platforms (see below)
>
> Hi all,
>
> This is about moving the cadence qspi driver (which is used on TI, Altera FPGAs
> and a new Intel SoC) to spi-mem.Vadivel asked me to include some Altera people
> in the loop (see below), as this is the only platform currently untested,
> I think.
>
> Right now, I'm not in the position to test this myself as we're currently stuck
> on an older RT kernel, so I cannot test with HEAD.
>
> Feel free to involve other Intel/Altera if you're interested in that peripheral
> not being broke for socfpga in one of the next releases :-)
>
> On Wed, Jan 29, 2020 at 10:18 AM Ramuthevar, Vadivel MuruganX
> <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> Hi,
>>
>>    Thank you for the query and confirmation.
>>
>> On 29/1/2020 4:31 PM, Simon Goldschmidt wrote:
>>
>> On Wed, Jan 29, 2020 at 8:25 AM Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
>>
>> So it has been tested on LGM and Vignesh gave his ok for TI. Is there anyone
>> in the loop by now checking that this is valid for the 3rd platform using this
>> (Altera)?
>>
>> Or am I wrong in thinking that this driver is meant to replace
>> drivers/mtd/spi-nor/cadence-quadspi.c used on that platform?
>>
>> Absolutely , You are right, this driver is meant to replace to drivers/mtd/spi-nor/cadence-quadspi.c
>> for Intel, TI and Altera SoC's using Cadence-QSPI IP.
>>
>> Meanwhile we have adapted to spi-mem framework (to support spi-nor/nand)and also didn't change the existing
>> functionalities of spi-nor flash operations like hw_init/read/write/erase in drivers/mtd/spi-nor/cadence-quadspi.c,
>> so it works fine (might be in Altera as well).
>>
>> Already I checked that Graham Moore <grmoore-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org> who has submitted the existing driver patches to upstream,
>> His mail-id is bouncing back, then I decided that you are the right person to ask, could you please add them in loop if you know the team
>> (socfpga platform engineers).
> OK, done that. I mainly know them from U-Boot development, so I'm not sure
> who's responsible for the Linux drivers...
Thank you for adding the team and respective members, let's see.

Regards
vadivel
>
> Regards,
> Simon
>
>> Regards
>> Vadivel
>>
>> Regards,
>> Simon
>>
