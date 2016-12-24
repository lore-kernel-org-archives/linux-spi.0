From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] mtd: m25p80: consider max message size in
 m25p80_read
Date: Sun, 25 Dec 2016 00:47:09 +0100
Message-ID: <a7de8f14-220b-6511-d3b9-3d0858f2565a@gmail.com>
References: <6c95366c-7fcc-ef4c-033a-f9f6e152a669@gmail.com>
 <20160816164204.GV9347@sirena.org.uk>
 <b65240ff-7e28-5ecb-0670-abfca871246b@gmail.com>
 <2e31fbe7-bbc7-8fed-ccbf-dd9ae4d220e1@atmel.com>
 <e7513817-c6d1-948d-19ff-617debfa1399@gmail.com>
 <CAOMqctTaPoMR=_dEF_j-WU178_i2tOp2sTfZJSDWWkohVxZn8A@mail.gmail.com>
 <1bd5f31a-a32e-12ce-10af-1a17955f5ab6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1bd5f31a-a32e-12ce-10af-1a17955f5ab6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 24.12.2016 um 11:20 schrieb Marek Vasut:
> On 12/23/2016 10:04 PM, Michal Suchanek wrote:
>> Hello,
> 
> Hi,
> 
>> On 23 December 2016 at 19:53, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> On 12/23/2016 04:33 PM, Cyrille Pitchen wrote:
>>>> Le 17/08/2016 à 21:09, Heiner Kallweit a écrit :
>>>>> Consider a message size limit when calculating the maximum amount
>>>>> of data that can be read.
>>>>>
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>
>>>> Applied to git://github.com/spi-nor/linux.git
>>>
>>> Is that the concensus now that we should fix controller crappiness on
>>> driver level ? Or did I miss the point of this patch ?
>>>
>>
>> In general most controllers do have some limit on the amount of data
>> they can transfer at once.
> 
> My observations suggest otherwise.
> 
>> For some you can apply workaround at controller driver level and for
>> some it's not practical.
>>
>> Also for some the limit is lower so it is more likely hit.
>>
>> I guess you can call controllers that have both of these limitations
>> crappy but that's what's in the silicone out there.
>>
>> If you have better solution to the problem please share it in detail.
> 
> I don't have a solution, but I am quite sure that if we now set a
> precedent that each and every device driver should take care of each and
> every controller's quirk, we have a lot of unpleasant work ahead
> of us and it will be quite the maintanance burden. The separations
> between device driver and controller driver has been weakened and I
> don't think that's good.
> 
The controller driver API has been extended to allow exposing certain
types of controller limits (max tranfer size, max message size)
to upper layers. And controller drivers rely on upper layers
considering this information.
W/o this patch certain combinations of protocol and controller drivers
(e.g. m25p80 + fsl-espi) don't work for big transfer / message sizes.

The (most likely more ugly) alternative is controller drivers
implementing protocol-specific hacks to deal with messages exceeding
controller limits. One example was the fsl-espi drivers before the
recent refactoring. It assumed all big messages to be m25p80.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
